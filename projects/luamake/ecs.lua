local argn = select("#", ...)
if argn < 3 then
    print [[
at least 3 argument:
ecs.lua component.lua component.h package1, package2, ...
package1 and package2 are path to find *.ecs file
    ]]
    return
end
local component_lua, component_h = select(1, ...), select(2, ...)
local packages = {}
for i=3, select('#', ...) do
    packages[i-2] = select(i, ...)
end

local fs = require "bee.filesystem"

local function createEnv(class)
    local function dummy()
        return function ()
            local o = {}
            local mt = {}
            function mt:__index()
                return function ()
                    return o
                end
            end
            return setmetatable(o, mt)
        end
    end
    local function object(object_name)
        local c = {}
        class[object_name] = c
        return function (name)
            local cc = {}
            c[name] = cc

            local o = {}
            local mt = {}
            function mt:__index(key)
                return function (value)
                    if cc[key] then
                        table.insert(cc[key], value)
                    else
                        cc[key] = {value}
                    end
                    return o
                end
            end
            return setmetatable(o, mt)
        end
    end
    return {
        import = function() end,
        pipeline = dummy(),
        system = dummy(),
        policy = dummy(),
        interface = dummy(),
        component = object "component",
    }
end

local function loadComponents()
    local class = {}
    local env = createEnv(class)
    local function eval(filename)
        assert(loadfile(filename:string(), "t", env))()
    end
    for _, pkgpath in ipairs(packages) do
        for file in fs.pairs(pkgpath, "r") do
            if file:equal_extension "ecs" then
                eval(file)
            end
        end
    end

    local components = {}
    for name, info in pairs(class.component) do
        if not info.type then
            components[#components+1] = {name, "tag"}
        else
            local t = info.type[1]
            if t == "lua" then
                components[#components+1] = {name, "lua"}
            elseif t == "c" then
                components[#components+1] = {name, "c", info.field}
            else
                components[#components+1] = {name, t}
            end
        end
    end
    table.sort(components, function (a, b)
        return a[1] < b[1]
    end)
    return components
end

local components = loadComponents()


local out = {}

local function writefile(filename)
    local f <close> = assert(io.open(filename, "w"))
    f:write(table.concat(out, "\n"))
    out = {}
end

local function write(line)
    out[#out+1] = line
end

write "return {"
for _, info in ipairs(components) do
    local name = info[1]
    write(("\t%q,"):format(name))
end
write "}"
write ""
writefile(component_lua)

local TYPENAMES <const> = {
    int = "int32_t",
    int64 = "int64_t",
    dword = "uint32_t",
    word = "uint16_t",
    byte = "uint8_t",
    float = "float",
    userdata = "int64_t",
}

local function typenames(v)
    local ud = v:match "^userdata|(.*)$"
    if ud then
        return ud
    end
    return assert(TYPENAMES[v], ("Invalid %s"):format(v))
end

do
    write "#pragma once"
    write ""
    write "#include \"ecs/select.h\""
    write "#include \"ecs/user.h\""
    write "#include <stdint.h>"
    write ""
    write "namespace ant_ecs {"
    write ""
    write "struct REMOVED {};"
    write ""
    for _, info in ipairs(components) do
        local name, type, fields = info[1], info[2], info[3]
        if type == "c" then
            write(("struct %s {"):format(name))
            for _, field in ipairs(fields) do
                local name, typename = field:match "^([%w_]+):([%w|_]+)$"
                write(("\t%s %s;"):format(typenames(typename), name))
            end
            write("};")
            write ""
        elseif type == "tag" then
            write(("struct %s {};"):format(name))
            write ""
        elseif type == "lua" then
            write(("struct %s {};"):format(name))
            write ""
        else
            write(("using %s = %s;"):format(name, typenames(type)))
            write ""
        end
    end
    write "}"
    write ""
    write "struct ant_ecs_component_id {"
    write "\tinline static int id = 0x80000000;"
    write "\tinline static int gen() {"
    write "\t\treturn id++;"
    write "\t}"
    write "};"
    write ""
    write "namespace ecs = ant_ecs;"
    write ""

    write "namespace ecs_api {"
    write ""
    write "#define ECS_COMPONENT(NAME) \\"
    write "template <> struct component<ecs::NAME> { \\"
    write "\tstatic inline const int id = ant_ecs_component_id::gen(); \\"
    write "\tstatic inline constexpr char name[] = #NAME; \\"
    write "\tstatic inline constexpr bool tag = false; \\"
    write "};"
    write ""
    write "#define ECS_TAG(NAME) \\"
    write "template <> struct component<ecs::NAME> { \\"
    write "\tstatic inline const int id = ant_ecs_component_id::gen(); \\"
    write "\tstatic inline constexpr char name[] = #NAME; \\"
    write "\tstatic inline constexpr bool tag = true; \\"
    write "};"
    write ""
    write("ECS_TAG(REMOVED)")
    for _, c in ipairs(components) do
        if c[2] == "tag" then
            write("ECS_TAG("..c[1]..")")
        else
            write("ECS_COMPONENT("..c[1]..")")
        end
    end
    write ""
    write "#undef ECS_COMPONENT"
    write "#undef ECS_TAG"
    write ""
    write "}"
    write ""

    writefile(component_h .. "/component.hpp")
end
