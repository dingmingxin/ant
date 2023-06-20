local ecs       = ...
local world     = ecs.world
local w         = world.w

local bgfx      = require "bgfx"
local math3d    = require "math3d"
local fs        = require "filesystem"
local lfs       = require "filesystem.local"
local datalist  = require "datalist"

local assetmgr  = import_package "ant.asset"
local renderpkg = import_package "ant.render"
local sampler   = renderpkg.sampler
local viewidmgr = renderpkg.viewidmgr

local icompute  = ecs.import.interface "ant.render|icompute"
local iexposure = ecs.import.interface "ant.camera|iexposure"
local imaterial = ecs.import.interface "ant.asset|imaterial"

local setting   = import_package "ant.settings".setting
local irradianceSH_bandnum<const> = setting:get "graphic/ibl/irradiance_bandnum"

local ibl_viewid= viewidmgr.get "ibl"

local thread_group_size<const> = 8

local ibl_sys = ecs.system "ibl_system"

local flags<const> = sampler {
    MIN="LINEAR",
    MAG="LINEAR",
    U="CLAMP",
    V="CLAMP",
    BLIT="BLIT_COMPUTEWRITE",
}

local cubemap_flags<const> = sampler {
    MIN="LINEAR",
    MAG="LINEAR",
    MIP="LINEAR",
    U="CLAMP",
    V="CLAMP",
    W="CLAMP",
    BLIT="BLIT_COMPUTEWRITE",
}

local IBL_INFO = {
    source = {facesize = 0, stage=0, value=nil},
    irradiance   = {
        value = nil,
        size = 0,
    },
    irradianceSH = {
        path = nil
    },
    prefilter    = {
        value = nil,
        size = 0,
        mipmap_count = 0,
    },
    LUT             = {
        value = nil,
        size = 0,
    }
}

local function create_irradiance_entity()
    local size = IBL_INFO.irradiance.size
    local dispatchsize = {
        size / thread_group_size, size / thread_group_size, 6
    }
    icompute.create_compute_entity(
        "irradiance_builder", "/pkg/ant.resources/materials/ibl/build_irradiance.material", dispatchsize)
end

local function create_irradianceSH_entity()
    ecs.create_entity {
        policy = {
            "ant.general|name",
            "ant.render|irradianceSH_builder",
        },
        data = {
            irradianceSH_builder = {},
            name = "irradianceSH_builder",
        }
    }
end


local function create_prefilter_entities()
    local size = IBL_INFO.prefilter.size

    local mipmap_count = IBL_INFO.prefilter.mipmap_count
    local dr = 1 / (mipmap_count-1)
    local r = 0

    local function create_prefilter_compute_entity(dispatchsize, prefilter)
        ecs.create_entity {
            policy = {
                "ant.render|compute_policy",
                "ant.render|prefilter",
                "ant.general|name",
            },
            data = {
                name        = "prefilter_builder",
                material    = "/pkg/ant.resources/materials/ibl/build_prefilter.material",
                dispatch    ={
                    size    = dispatchsize,
                },
                prefilter = prefilter,
                compute     = true,
                prefilter_builder      = true,
            }
        }
    end


    for i=1, mipmap_count do
        local s = size >> (i-1)
        local dispatchsize = {
            math.floor(s / thread_group_size), math.floor(s / thread_group_size), 6
        }

        local prefilter = {
            roughness = r,
            sample_count = s,
            mipidx = i-1,
        }
        create_prefilter_compute_entity(dispatchsize, prefilter)

        r = r + dr
    end
end

local function create_LUT_entity()
    local size = IBL_INFO.LUT.size
    local dispatchsize = {
        size / thread_group_size, size / thread_group_size, 1
    }
   icompute.create_compute_entity(
        "LUT_builder", "/pkg/ant.resources/materials/ibl/build_LUT.material", dispatchsize)
end

local ibl_mb = world:sub{"ibl_changed"}
local exp_mb = world:sub{"exposure_changed"}

local function update_ibl_param(intensity)
    local mq = w:first("main_queue camera_ref:in")
    local camera <close> = w:entity(mq.camera_ref)
    local ev = iexposure.exposure(camera)

    intensity = intensity or 1
    intensity = intensity * IBL_INFO.intensity * ev
    imaterial.system_attribs():update("u_ibl_param", math3d.vector(IBL_INFO.prefilter.mipmap_count, intensity, 0.0 ,0.0))
end

function ibl_sys:data_changed()
    for _, enable in ibl_mb:unpack() do
        update_ibl_param(enable and 1.0 or 0.0)
    end

    for _ in exp_mb:each() do
        update_ibl_param()
    end
end

local sample_count<const> = 512

function ibl_sys:render_preprocess()
    local source_tex = IBL_INFO.source

    for e in w:select "irradianceSH_builder" do
        local function load_Eml()
            local cfgpath = assetmgr.compile(source_tex.tex_name .. "|main.cfg")
            local ff<close> = lfs.open(lfs.path(cfgpath))
            local c = datalist.parse(ff:read "a")

            if nil == c.irradiance_SH then
                error(("source texture:%s, did not build irradiance SH, 'build_irradiance_sh' should add to cubemap texture"):format(source_tex.tex_name))
            end

            local Eml = {}
            for idx, eml in ipairs(c.irradiance_SH) do
                Eml[idx] = math3d.vector(eml)
            end
            return Eml
        end

        local Eml = load_Eml()
        assert((irradianceSH_bandnum == 2 and #Eml == 3) or (irradianceSH_bandnum == 3 and #Eml == 7), "Invalid Eml data")
        imaterial.system_attribs():update("u_irradianceSH", Eml)
        w:remove(e)
    end

    local registered
    for e in w:select "prefilter_builder dispatch:in prefilter:in" do
        local dis = e.dispatch
        local material = dis.material
        local prefilter_stage<const> = 1
        if registered == nil then
            local matobj = material:get_material()
            matobj:set_attrib("s_prefilter", {type='i', mip=0, access='w', stage=prefilter_stage})
            registered = true
        end

        material.s_source = source_tex
        local prefilter = e.prefilter
        material.u_build_ibl_param = math3d.vector(sample_count, 0, IBL_INFO.source.facesize, prefilter.roughness)
        material.s_prefilter = icompute.create_image_property(IBL_INFO.prefilter.value, prefilter_stage, prefilter.mipidx, "w")

        icompute.dispatch(ibl_viewid, dis)
        w:remove(e)
    end

    local LUT_stage<const> = 0
    for e in w:select "LUT_builder dispatch:in" do
        local dis = e.dispatch
        local material = dis.material
        local matobj = material:get_material()
        matobj:set_attrib("s_LUT", icompute.create_image_property(IBL_INFO.LUT.value, LUT_stage, 0, "w"))
        icompute.dispatch(ibl_viewid, dis)

        w:remove(e)
    end
end

local iibl = ecs.interface "iibl"

function iibl.get_ibl()
    return IBL_INFO
end

function iibl.set_ibl_intensity(intensity)
    IBL_INFO.intensity = intensity
    update_ibl_param()
end

local function build_ibl_textures(ibl)
    local function check_destroy(handle)
        if handle then
            bgfx.destroy(handle)
        end
    end

    IBL_INFO.intensity = ibl.intensity

    IBL_INFO.source.value = assert(ibl.source.value)
    IBL_INFO.source.facesize = assert(ibl.source.facesize)
    IBL_INFO.source.tex_name = ibl.source.tex_name

    if ibl.irradiance then
        if ibl.irradiance.size ~= IBL_INFO.irradiance.size then
            IBL_INFO.irradiance.size = ibl.irradiance.size
            check_destroy(IBL_INFO.irradiance.value)

            IBL_INFO.irradiance.value = bgfx.create_texturecube(IBL_INFO.irradiance.size, false, 1, "RGBA16F", flags)
        end
    end

    if ibl.prefilter.size ~= IBL_INFO.prefilter.size then
        IBL_INFO.prefilter.size = ibl.prefilter.size
        check_destroy(IBL_INFO.prefilter.value)
        IBL_INFO.prefilter.value = bgfx.create_texturecube(IBL_INFO.prefilter.size, true, 1, "RGBA16F", cubemap_flags)
        IBL_INFO.prefilter.mipmap_count = math.log(ibl.prefilter.size, 2)+1
    end

    if ibl.LUT.size ~= IBL_INFO.LUT.size then
        IBL_INFO.LUT.size = ibl.LUT.size
        check_destroy(IBL_INFO.LUT.value)
        IBL_INFO.LUT.value = bgfx.create_texture2d(IBL_INFO.LUT.size, IBL_INFO.LUT.size, false, 1, "RG16F", flags)
    end
end


local function create_ibl_entities()
    if irradianceSH_bandnum then
        create_irradianceSH_entity()
    else
        create_irradiance_entity()
    end
    create_prefilter_entities()
    create_LUT_entity()
end

local function update_ibl_texture_info()
    local sa = imaterial.system_attribs()
    if not irradianceSH_bandnum then
        sa:update("s_irradiance", IBL_INFO.irradiance.value)
    end
    sa:update("s_prefilter", IBL_INFO.prefilter.value)
    sa:update("s_LUT",  IBL_INFO.LUT.value)

    update_ibl_param()
end

function iibl.filter_all(ibl)
    build_ibl_textures(ibl)
    create_ibl_entities()

    update_ibl_texture_info()
end