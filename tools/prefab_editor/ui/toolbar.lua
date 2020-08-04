local imgui     = require "imgui"
local uiconfig  = require "ui.config"
local uiutils   = require "ui.utils"

local m = {}
local world
local asset_mgr

local status = {
    GizmoMode = "select",
    GizmoSpace = "worldspace"
}

local localSpace = {}

function m.show(rhwi)
    local sw, sh = rhwi.screen_size()
    local icons = require "common.icons"(asset_mgr)
    imgui.windows.SetNextWindowPos(0, uiconfig.WidgetStartY)
    imgui.windows.SetNextWindowSize(sw, uiconfig.ToolBarHeight)
    imgui.windows.PushStyleVar(imgui.enum.StyleVar.WindowRounding, 0)
    imgui.windows.PushStyleVar(imgui.enum.StyleVar.WindowBorderSize, 0)
    imgui.windows.PushStyleColor(imgui.enum.StyleCol.WindowBg, 0.25, 0.25, 0.25, 1)
    for _ in uiutils.imgui_windows("Controll", imgui.flags.Window { "NoTitleBar", "NoResize", "NoScrollbar", "NoMove", "NoDocking" }) do
        uiutils.imguiBeginToolbar()
        -- if imguiToolbar(icons.ICON_UNDO, "Undo", false) then
        --     print("undo")
        --     world:pub { "GizmoMode", "undo" }
        -- end
        -- imgui.cursor.SameLine()
        -- if imguiToolbar(icons.ICON_REDO, "Redo", false) then
        --     print("redo")
        --     world:pub { "GizmoMode", "redo" }
        -- end
        -- imgui.cursor.SameLine()
        if uiutils.imguiToolbar(icons.ICON_SELECT, "Select", status.GizmoMode == "select") then
            status.GizmoMode = "select"
            world:pub { "GizmoMode", "select" }
        end
        imgui.cursor.SameLine()
        if uiutils.imguiToolbar(icons.ICON_MOVE, "Move", status.GizmoMode == "move") then
            status.GizmoMode = "move"
            world:pub { "GizmoMode", "move" }
        end
        imgui.cursor.SameLine()
        if uiutils.imguiToolbar(icons.ICON_ROTATE, "Rotate", status.GizmoMode == "rotate") then
            status.GizmoMode = "rotate"
            world:pub { "GizmoMode", "rotate" }
        end
        imgui.cursor.SameLine()
        if uiutils.imguiToolbar(icons.ICON_SCALE, "Scale", status.GizmoMode == "scale") then
            status.GizmoMode = "scale"
            world:pub { "GizmoMode", "scale" }
        end
        imgui.cursor.SameLine()
        if imgui.widget.Checkbox("LocalSpace", localSpace) then
            world:pub { "GizmoMode", "localspace", localSpace[1]}
        end
        -- if imguiToolbar(icons.ICON_WORLD, "WorldSpace", status.GizmoSpace == "worldspace") then
        --     status.GizmoSpace = "worldspace"
        --     world:pub { "GizmoMode", "worldspace"}
        -- end
        -- imgui.cursor.SameLine()
        -- if imguiToolbar(icons.ICON_LOCAL, "LocalSpace", status.GizmoSpace == "localspace") then
        --     status.GizmoSpace = "localspace"
        --     world:pub { "GizmoMode", "localspace"}
        -- end
        uiutils.imguiEndToolbar()
    end
    imgui.windows.PopStyleColor()
    imgui.windows.PopStyleVar(2)
end

return function(w, am)
    world = w
    asset_mgr = am
    return m
end