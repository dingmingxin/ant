local thread = require "bee.thread"
if thread.id ~= 0 then
    return
end

local socket = require "bee.socket"
local boot = require "ltask.bootstrap"
local lfs = require "bee.filesystem"
local vfs = require "vfs"

local repopath = lfs.absolute(lfs.path(arg[0])):remove_filename():string()

thread.newchannel "IOreq"

local s, c = socket.pair()
local io_req = thread.channel "IOreq"

local io_initargs = {
    repopath = repopath,
    fd = s:detach(),
}

local vfs_initargs = {
    fd = c:detach()
}

io_req:push(io_initargs)

vfs.iothread = boot.preinit [[
    -- IO thread
    local dbg = dofile "engine/debugger.lua"
    if dbg then
        dbg:event("setThreadName", "Thread: IO")
        dbg:event "wait"
    end
    local fastio = require "fastio"
    local thread = require "bee.thread"
    local io_req = thread.channel "IOreq"
    assert(fastio.loadfile "engine/game/io.lua")(io_req:bpop())
]]

vfs.initfunc("engine/firmware/init_thread.lua", vfs_initargs)
