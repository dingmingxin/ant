local ecs = ...
local world = ecs.world

local su = require "util"

local mathpkg = import_package "ant.math"
local ms = mathpkg.stack

ecs.tag "hierarchy_tag"

ecs.component_alias("world_srt", "srt")
ecs.component_alias("hierarchy_transform", "transform")

ecs.component_alias("attach", "entityid")

ecs.singleton "hierarchy_transform_result"

local scene_space = ecs.system "scene_space"
scene_space.dependby "primitive_filter_system"
scene_space.singleton "event"
scene_space.singleton "hierarchy_transform_result"

function scene_space:post_init()
	for eid in world:each_new("hierarchy_transform") do
		self.event:new(eid, "hierarchy_transform")
	end

	for eid in world:each_new("transform") do
		self.event:new(eid, "transform")
	end
end

local function mark_children(marked, eid)
	local pid = world[eid].hierarchy_transform.parent
	if pid and marked[pid] then
		marked[eid] = pid
		return true
	end
	marked[eid] = false
	return false
end

local mark_mt = { __index = mark_children }

local function find_children(tree, eid)
	local _ = tree[eid]
end

local function tree_sort(tree)
	local r = {}

	local from = 1
	local to = 1
	-- find leaves
	local leaf = {}
	for eid, pid in pairs(tree) do
		if pid then
			if leaf[pid] then	-- fake leaf
				-- todo remove result
				for i = 1, to-1 do
					if r[i] == pid then
						to = to - 1
						r[i] = r[to]
						break
					end
				end
			end
			leaf[pid] = false
			if leaf[eid] == nil then
				leaf[eid] = true	-- mark leaf
				r[to] = eid
				to = to + 1
			end
		end
	end
	while to > from do
		local lb = from
		from = to
		for i = lb, to-1 do
			local pid = tree[r[i]]
			if pid and tree[pid] and not leaf[pid] then
				r[to] = pid
				to = to + 1
				leaf[pid] = true
			end
		end
	end
	return r
end

local function update_world(trans)
	local srt = ms:push_srt_matrix(trans)
	local base = trans.base 
	if base then
		ms(trans.world, trans.base, srt, "*=")
	else
		ms(trans.world, srt, "=")
	end
end

function scene_space:event_changed()
	local hierarchy_result = self.hierarchy_transform_result

	local tree = setmetatable({}, mark_mt)

	for eid, events in self.event:each("hierarchy_transform") do
		local e = world[eid]
		local trans = e.hierarchy_transform
		su.handle_transform(events, trans)
		find_children(tree, eid)
	end

	if #tree > 0 then
		local result = tree_sort(tree)
		
		for i=#result, 1, -1 do
			local eid = result[i]
			local e = world[eid]
			local t = e.transform
			update_world(e.transform)
			local peid = e.parent 
	
			if peid then
				local parent = world[peid]
				local pt = parent.transform
				ms(t.world, pt.world, t.world, "*=")				
			end

			hierarchy_result[eid] = t.world
		end

	end	
end