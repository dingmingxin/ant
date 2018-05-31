//
//  LuaRender.m
//  fileserver
//
//  Created by ejoy on 2018/5/24.
//  Copyright © 2018年 ejoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LuaRender.h"

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

LUAMOD_API int luaopen_crypt(lua_State *L);
LUAMOD_API int luaopen_lsocket(lua_State *L);
LUAMOD_API int luaopen_bgfx(lua_State *L);
LUAMOD_API int luaopen_bgfx_util(lua_State *L);
LUAMOD_API int luaopen_math3d(lua_State *L);
LUAMOD_API int luaopen_lfs(lua_State *L);
LUAMOD_API int luaopen_lodepng(lua_State *L);

void luaopen_lanes_embedded( lua_State* L, lua_CFunction _luaopen_lanes);

static int default_luaopen_lanes( lua_State* L)
{
    NSString *lanes_lua = [[NSBundle mainBundle] resourcePath];
    lanes_lua = [lanes_lua stringByAppendingString:@"/Common/lanes.lua"];
    int rc = luaL_loadfile( L, [lanes_lua UTF8String]) || lua_pcall( L, 0, 1, 0);
    if( rc != LUA_OK)
    {
        return luaL_error( L, "failed to initialize embedded Lanes");
    }
    return 1;
}

static int custom_on_state_create(lua_State *L)
{
    lua_getglobal(L, "package");
    int top = lua_gettop(L);
    if(lua_istable(L, -1))
    {
        lua_getfield(L, -1, "preload");
        
        top = lua_gettop(L);
        if(lua_istable(L, -1))
        {
            lua_pushcfunction(L, luaopen_lsocket);
            lua_setfield(L, -2, "lsocket");
            //lua_pop(L, 1);
            
            lua_pushcfunction(L, luaopen_crypt);
            lua_setfield(L, -2, "crypt");
            
            lua_pushcfunction(L, luaopen_lfs);
            lua_setfield(L, -2, "lfs");
            lua_pop(L, 1);
        }
        
        top = lua_gettop(L);
        lua_getfield(L, -1, "path");
        if(lua_isstring(L, -1))
        {
            const char* pkg_path = lua_tostring(L, -1);
            lua_pop(L, 1);
            
            NSString* path_string = [NSString stringWithUTF8String:pkg_path];
            path_string = [path_string stringByAppendingString:@";"];
            NSString *app_path = [[NSBundle mainBundle] resourcePath];
            path_string = [app_path stringByAppendingString:@"/Common/?.lua;"];
            path_string = [path_string stringByAppendingString:app_path];
            path_string = [path_string stringByAppendingString:@"/Client/?.lua"];
            lua_pushstring(L, [path_string UTF8String]);
            lua_setfield(L, -2, "path");
        }
    }
    top = lua_gettop(L);
    lua_pop(L, -1);
    
    return 0;
}

lua_State *L = nil;
@implementation LuaRender

- (void) InitScript:(CALayer*)layer size:(CGSize)view_size
{
    L = luaL_newstate();
    luaL_openlibs(L);

    luaL_requiref(L, "crypt", luaopen_crypt, 0);
    luaL_requiref(L, "lsocket", luaopen_lsocket, 0);
    luaL_requiref(L, "bgfx", luaopen_bgfx, 0);
    luaL_requiref(L, "bgfx_util", luaopen_bgfx_util, 0);
    luaL_requiref(L, "math3d", luaopen_math3d, 0);
    luaL_requiref(L, "lfs", luaopen_lfs, 0);
    luaL_requiref(L, "lodepng", luaopen_lodepng, 0);
    luaopen_lanes_embedded(L, default_luaopen_lanes);
    
    custom_on_state_create(L);
    lua_pushcfunction(L, custom_on_state_create);
    lua_setglobal(L, "custom_on_state_create");
    
    float width = view_size.width;
    float height = view_size.height;

    NSString *app_dir = [[NSBundle mainBundle] resourcePath];
    NSString *sandbox_dir = NSHomeDirectory();
    NSLog(app_dir, sandbox_dir);
    
    NSString* file_dir = [app_dir stringByAppendingString:@"/Client/appmain.lua"];
    
    luaL_dofile(L, [file_dir UTF8String]);
    
    lua_getglobal(L, "init");
    if(lua_isfunction(L, -1))
    {
        lua_pushlightuserdata(L, (__bridge void *)(layer));
        lua_pushnumber(L, width);
        lua_pushnumber(L, height);
        lua_pushstring(L, [app_dir UTF8String]);
        lua_pushstring(L, [sandbox_dir UTF8String]);
        
        lua_pcall(L, 5, 0, 0);
    }
    else
    {
        assert(false);
    }
    
}

- (void) Update
{
    lua_getglobal(L, "mainloop");
    if(lua_isfunction(L, -1))
    {
        lua_pcall(L, 0, 0, 0);
    }
}

- (void) Terminate
{
    lua_getglobal(L, "terminate");
    if(lua_isfunction(L, -1))
    {
        lua_pcall(L, 0, 0, 0);
    }
    
    lua_close(L);
}

- (void) SendLog:(NSString *)log_str
{
    lua_getglobal(L, "sendlog");
    if(lua_isfunction(L, -1))
    {
        lua_pushstring(L, [log_str UTF8String]);
        lua_pcall(L, 1, 0, 0);
    }
}

@end
