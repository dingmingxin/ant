local ecs = ...
local world = ecs.world
local w = world.w

local animodule = require "hierarchy".animation
local math3d 	= require "math3d"

local mathpkg	= import_package "ant.math"
local mc		= mathpkg.constant

-- skinning system
local skinning_sys = ecs.system "skinning_system"
local r2l_mat<const> = mc.R2L_MAT
function skinning_sys:skin_mesh()
	for e in w:select "meshskin:in scene:in" do
		local skin = e.meshskin.skin
		local skinning_matrices = e.meshskin.skinning_matrices
		local pr = e.meshskin.pose.pose_result
		if pr then
			local wm = e.scene.worldmat
			if wm == mc.NULL then
				error("Invalid meshskin entity")
			end
			local m = math3d.mul(wm, r2l_mat)
			animodule.build_skinning_matrices(skinning_matrices, pr, skin.inverse_bind_pose, skin.joint_remap, m)
		end
	end
end