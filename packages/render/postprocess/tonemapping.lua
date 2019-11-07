local ecs = ...
local world = ecs.world

local viewidmgr = require "viewid_mgr"
local fbmgr = require "framebuffer_mgr"
local fs = require "filesystem"

local setting = require "setting"

local tm = ecs.system "tonemapping"
tm.depend    "render_system"
tm.depend    "bloom_system"
tm.dependby  "postprocess_system"

function tm:post_init()
    local sd = setting.get()

    local hdrsetting = sd.graphic.hdr

    if hdrsetting.enable then
        local pp_eid = world:first_entity_id "postprocess"
        local main_fbidx = fbmgr.get_fb_idx(viewidmgr.get "main_view")

        local fbsize = world.args.fb_size
        world:add_component(pp_eid, "technique", {
            {
                name = "tonemapping",
                passes = {
                    {
                        name = "main",
                        material = {
                            {
                                ref_path = fs.path "/pkg/ant.resources/depiction/materials/postprocess/tonemapping.material",
                            }
                        },
                        output = {
                            fb_idx = main_fbidx,
                            rb_idx = 1,
                        },
                        viewport = {
                            rect = {x=0, y=0, w=fbsize.w, h=fbsize.h},
                            clear_state = {clear=""},
                        }
                    },

                }
            },
        })
    end
end