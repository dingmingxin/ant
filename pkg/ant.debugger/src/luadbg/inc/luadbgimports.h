/* clang-format off */
#pragma once

#define luadbgL_addgsub luaL_addgsub
#define luadbgL_addlstring luaL_addlstring
#define luadbgL_addstring luaL_addstring
#define luadbgL_addvalue luaL_addvalue
#define luadbgL_argerror luaL_argerror
#define luadbgL_buffinit luaL_buffinit
#define luadbgL_buffinitsize luaL_buffinitsize
#define luadbgL_callmeta luaL_callmeta
#define luadbgL_checkany luaL_checkany
#define luadbgL_checkinteger luaL_checkinteger
#define luadbgL_checklstring luaL_checklstring
#define luadbgL_checknumber luaL_checknumber
#define luadbgL_checkoption luaL_checkoption
#define luadbgL_checkstack luaL_checkstack
#define luadbgL_checktype luaL_checktype
#define luadbgL_checkudata luaL_checkudata
#define luadbgL_checkversion_ luaL_checkversion_
#define luadbgL_error luaL_error
#define luadbgL_execresult luaL_execresult
#define luadbgL_fileresult luaL_fileresult
#define luadbgL_getmetafield luaL_getmetafield
#define luadbgL_getsubtable luaL_getsubtable
#define luadbgL_gsub luaL_gsub
#define luadbgL_len luaL_len
#define luadbgL_loadbufferx luaL_loadbufferx
#define luadbgL_loadfilex luaL_loadfilex
#define luadbgL_loadstring luaL_loadstring
#define luadbgL_newmetatable luaL_newmetatable
#define luadbgL_newstate luaL_newstate
#define luadbgL_openlibs luaL_openlibs
#define luadbgL_optinteger luaL_optinteger
#define luadbgL_optlstring luaL_optlstring
#define luadbgL_optnumber luaL_optnumber
#define luadbgL_prepbuffsize luaL_prepbuffsize
#define luadbgL_pushresult luaL_pushresult
#define luadbgL_pushresultsize luaL_pushresultsize
#define luadbgL_ref luaL_ref
#define luadbgL_requiref luaL_requiref
#define luadbgL_setfuncs luaL_setfuncs
#define luadbgL_setmetatable luaL_setmetatable
#define luadbgL_testudata luaL_testudata
#define luadbgL_tolstring luaL_tolstring
#define luadbgL_traceback luaL_traceback
#define luadbgL_typeerror luaL_typeerror
#define luadbgL_unref luaL_unref
#define luadbgL_where luaL_where
#define luadbg_absindex lua_absindex
#define luadbg_arith lua_arith
#define luadbg_atpanic lua_atpanic
#define luadbg_callk lua_callk
#define luadbg_checkstack lua_checkstack
#define luadbg_close lua_close
#define luadbg_closeslot lua_closeslot
#define luadbg_closethread lua_closethread
#define luadbg_compare lua_compare
#define luadbg_concat lua_concat
#define luadbg_copy lua_copy
#define luadbg_createtable lua_createtable
#define luadbg_dump lua_dump
#define luadbg_error lua_error
#define luadbg_gc lua_gc
#define luadbg_getallocf lua_getallocf
#define luadbg_getfield lua_getfield
#define luadbg_getglobal lua_getglobal
#define luadbg_gethook lua_gethook
#define luadbg_gethookcount lua_gethookcount
#define luadbg_gethookmask lua_gethookmask
#define luadbg_geti lua_geti
#define luadbg_getinfo lua_getinfo
#define luadbg_getiuservalue lua_getiuservalue
#define luadbg_getlocal lua_getlocal
#define luadbg_getmetatable lua_getmetatable
#define luadbg_getstack lua_getstack
#define luadbg_gettable lua_gettable
#define luadbg_gettop lua_gettop
#define luadbg_getupvalue lua_getupvalue
#define luadbg_iscfunction lua_iscfunction
#define luadbg_isinteger lua_isinteger
#define luadbg_isnumber lua_isnumber
#define luadbg_isstring lua_isstring
#define luadbg_isuserdata lua_isuserdata
#define luadbg_isyieldable lua_isyieldable
#define luadbg_len lua_len
#define luadbg_load lua_load
#define luadbg_newstate lua_newstate
#define luadbg_newthread lua_newthread
#define luadbg_newuserdatauv lua_newuserdatauv
#define luadbg_next lua_next
#define luadbg_pcallk lua_pcallk
#define luadbg_pushboolean lua_pushboolean
#define luadbg_pushcclosure lua_pushcclosure
#define luadbg_pushfstring lua_pushfstring
#define luadbg_pushinteger lua_pushinteger
#define luadbg_pushlightuserdata lua_pushlightuserdata
#define luadbg_pushlstring lua_pushlstring
#define luadbg_pushnil lua_pushnil
#define luadbg_pushnumber lua_pushnumber
#define luadbg_pushstring lua_pushstring
#define luadbg_pushthread lua_pushthread
#define luadbg_pushvalue lua_pushvalue
#define luadbg_pushvfstring lua_pushvfstring
#define luadbg_rawequal lua_rawequal
#define luadbg_rawget lua_rawget
#define luadbg_rawgeti lua_rawgeti
#define luadbg_rawgetp lua_rawgetp
#define luadbg_rawlen lua_rawlen
#define luadbg_rawset lua_rawset
#define luadbg_rawseti lua_rawseti
#define luadbg_rawsetp lua_rawsetp
#define luadbg_resetthread lua_resetthread
#define luadbg_resume lua_resume
#define luadbg_rotate lua_rotate
#define luadbg_setallocf lua_setallocf
#define luadbg_setcstacklimit lua_setcstacklimit
#define luadbg_setfield lua_setfield
#define luadbg_setglobal lua_setglobal
#define luadbg_sethook lua_sethook
#define luadbg_seti lua_seti
#define luadbg_setiuservalue lua_setiuservalue
#define luadbg_setlocal lua_setlocal
#define luadbg_setmetatable lua_setmetatable
#define luadbg_settable lua_settable
#define luadbg_settop lua_settop
#define luadbg_setupvalue lua_setupvalue
#define luadbg_setwarnf lua_setwarnf
#define luadbg_status lua_status
#define luadbg_stringtonumber lua_stringtonumber
#define luadbg_toboolean lua_toboolean
#define luadbg_tocfunction lua_tocfunction
#define luadbg_toclose lua_toclose
#define luadbg_tointegerx lua_tointegerx
#define luadbg_tolstring lua_tolstring
#define luadbg_tonumberx lua_tonumberx
#define luadbg_topointer lua_topointer
#define luadbg_tothread lua_tothread
#define luadbg_touserdata lua_touserdata
#define luadbg_type lua_type
#define luadbg_typename lua_typename
#define luadbg_upvalueid lua_upvalueid
#define luadbg_upvaluejoin lua_upvaluejoin
#define luadbg_version lua_version
#define luadbg_warning lua_warning
#define luadbg_xmove lua_xmove
#define luadbg_yieldk lua_yieldk

#define luadbg_State lua_State
#define luadbg_Integer lua_Integer
#define luadbg_Number lua_Number
#define luadbg_CFunction lua_CFunction
#define luadbgL_Stream luaL_Stream
#define luadbgL_Buffer luaL_Buffer
#define luadbgL_Reg luaL_Reg

#define LUADBG_COPYRIGHT LUA_COPYRIGHT
#define LUADBG_AUTHORS LUA_AUTHORS
#define LUADBG_VERSION_MAJOR_N LUA_VERSION_MAJOR_N
#define LUADBG_VERSION_MINOR_N LUA_VERSION_MINOR_N
#define LUADBG_VERSION_RELEASE_N LUA_VERSION_RELEASE_N
#define LUADBG_VERSION_NUM LUA_VERSION_NUM
#define LUADBG_VERSION_RELEASE_NUM LUA_VERSION_RELEASE_NUM
#define LUADBG_SIGNATURE LUA_SIGNATURE
#define LUADBG_MULTRET LUA_MULTRET
#define LUADBG_REGISTRYINDEX LUA_REGISTRYINDEX
#define luadbg_upvalueindex lua_upvalueindex
#define LUADBG_OK LUA_OK
#define LUADBG_YIELD LUA_YIELD
#define LUADBG_ERRRUN LUA_ERRRUN
#define LUADBG_ERRSYNTAX LUA_ERRSYNTAX
#define LUADBG_ERRMEM LUA_ERRMEM
#define LUADBG_ERRERR LUA_ERRERR
#define LUADBG_TNONE LUA_TNONE
#define LUADBG_TNIL LUA_TNIL
#define LUADBG_TBOOLEAN LUA_TBOOLEAN
#define LUADBG_TLIGHTUSERDATA LUA_TLIGHTUSERDATA
#define LUADBG_TNUMBER LUA_TNUMBER
#define LUADBG_TSTRING LUA_TSTRING
#define LUADBG_TTABLE LUA_TTABLE
#define LUADBG_TFUNCTION LUA_TFUNCTION
#define LUADBG_TUSERDATA LUA_TUSERDATA
#define LUADBG_TTHREAD LUA_TTHREAD
#define LUADBG_NUMTYPES LUA_NUMTYPES
#define LUADBG_MINSTACK LUA_MINSTACK
#define LUADBG_RIDX_MAINTHREAD LUA_RIDX_MAINTHREAD
#define LUADBG_RIDX_GLOBALS LUA_RIDX_GLOBALS
#define LUADBG_RIDX_LAST LUA_RIDX_LAST
#define LUADBG_OPADD LUA_OPADD
#define LUADBG_OPSUB LUA_OPSUB
#define LUADBG_OPMUL LUA_OPMUL
#define LUADBG_OPMOD LUA_OPMOD
#define LUADBG_OPPOW LUA_OPPOW
#define LUADBG_OPDIV LUA_OPDIV
#define LUADBG_OPIDIV LUA_OPIDIV
#define LUADBG_OPBAND LUA_OPBAND
#define LUADBG_OPBOR LUA_OPBOR
#define LUADBG_OPBXOR LUA_OPBXOR
#define LUADBG_OPSHL LUA_OPSHL
#define LUADBG_OPSHR LUA_OPSHR
#define LUADBG_OPUNM LUA_OPUNM
#define LUADBG_OPBNOT LUA_OPBNOT
#define LUADBG_OPEQ LUA_OPEQ
#define LUADBG_OPLT LUA_OPLT
#define LUADBG_OPLE LUA_OPLE
#define luadbg_call lua_call
#define luadbg_pcall lua_pcall
#define luadbg_yield lua_yield
#define LUADBG_GCSTOP LUA_GCSTOP
#define LUADBG_GCRESTART LUA_GCRESTART
#define LUADBG_GCCOLLECT LUA_GCCOLLECT
#define LUADBG_GCCOUNT LUA_GCCOUNT
#define LUADBG_GCCOUNTB LUA_GCCOUNTB
#define LUADBG_GCSTEP LUA_GCSTEP
#define LUADBG_GCSETPAUSE LUA_GCSETPAUSE
#define LUADBG_GCSETSTEPMUL LUA_GCSETSTEPMUL
#define LUADBG_GCISRUNNING LUA_GCISRUNNING
#define LUADBG_GCGEN LUA_GCGEN
#define LUADBG_GCINC LUA_GCINC
#define luadbg_getextraspace lua_getextraspace
#define luadbg_tonumber lua_tonumber
#define luadbg_tointeger lua_tointeger
#define luadbg_pop lua_pop
#define luadbg_newtable lua_newtable
#define luadbg_register lua_register
#define luadbg_pushcfunction lua_pushcfunction
#define luadbg_isfunction lua_isfunction
#define luadbg_istable lua_istable
#define luadbg_islightuserdata lua_islightuserdata
#define luadbg_isnil lua_isnil
#define luadbg_isboolean lua_isboolean
#define luadbg_isthread lua_isthread
#define luadbg_isnone lua_isnone
#define luadbg_isnoneornil lua_isnoneornil
#define luadbg_pushliteral lua_pushliteral
#define luadbg_pushglobaltable lua_pushglobaltable
#define luadbg_tostring lua_tostring
#define luadbg_insert lua_insert
#define luadbg_remove lua_remove
#define luadbg_replace lua_replace
#define luadbg_pushunsigned lua_pushunsigned
#define luadbg_tounsignedx lua_tounsignedx
#define luadbg_tounsigned lua_tounsigned
#define luadbg_newuserdata lua_newuserdata
#define luadbg_getuservalue lua_getuservalue
#define luadbg_setuservalue lua_setuservalue
#define LUADBG_NUMTAGS LUA_NUMTAGS
#define LUADBG_HOOKCALL LUA_HOOKCALL
#define LUADBG_HOOKRET LUA_HOOKRET
#define LUADBG_HOOKLINE LUA_HOOKLINE
#define LUADBG_HOOKCOUNT LUA_HOOKCOUNT
#define LUADBG_HOOKTAILCALL LUA_HOOKTAILCALL
#define LUADBG_HOOKEXCEPTION LUA_HOOKEXCEPTION
#define LUADBG_HOOKTHREAD LUA_HOOKTHREAD
#define LUADBG_MASKCALL LUA_MASKCALL
#define LUADBG_MASKRET LUA_MASKRET
#define LUADBG_MASKLINE LUA_MASKLINE
#define LUADBG_MASKCOUNT LUA_MASKCOUNT
#define LUADBG_MASKEXCEPTION LUA_MASKEXCEPTION
#define LUADBG_MASKTHREAD LUA_MASKTHREAD
#define LUADBGI_TOSTRAUX LUAI_TOSTRAUX
#define LUADBGI_TOSTR LUAI_TOSTR
#define LUADBG_VERSION_MAJOR LUA_VERSION_MAJOR
#define LUADBG_VERSION_MINOR LUA_VERSION_MINOR
#define LUADBG_VERSION_RELEASE LUA_VERSION_RELEASE
#define LUADBG_VERSION LUA_VERSION
#define LUADBG_RELEASE LUA_RELEASE
#define LUADBG_GNAME LUA_GNAME
#define LUADBG_ERRFILE LUA_ERRFILE
#define LUADBG_LOADED_TABLE LUA_LOADED_TABLE
#define LUADBG_PRELOAD_TABLE LUA_PRELOAD_TABLE
#define LUADBGL_NUMSIZES LUAL_NUMSIZES
#define luadbgL_checkversion luaL_checkversion
#define LUADBG_NOREF LUA_NOREF
#define LUADBG_REFNIL LUA_REFNIL
#define luadbgL_loadfile luaL_loadfile
#define luadbgL_newlibtable luaL_newlibtable
#define luadbgL_newlib luaL_newlib
#define luadbgL_argcheck luaL_argcheck
#define luadbgL_argexpected luaL_argexpected
#define luadbgL_checkstring luaL_checkstring
#define luadbgL_optstring luaL_optstring
#define luadbgL_typename luaL_typename
#define luadbgL_dofile luaL_dofile
#define luadbgL_dostring luaL_dostring
#define luadbgL_getmetatable luaL_getmetatable
#define luadbgL_opt luaL_opt
#define luadbgL_loadbuffer luaL_loadbuffer
#define luadbgL_intop luaL_intop
#define luadbgL_pushfail luaL_pushfail
#define luadbg_assert lua_assert
#define luadbg_assert lua_assert
#define luadbgL_bufflen luaL_bufflen
#define luadbgL_buffaddr luaL_buffaddr
#define luadbgL_addchar luaL_addchar
#define luadbgL_addsize luaL_addsize
#define luadbgL_buffsub luaL_buffsub
#define luadbgL_prepbuffer luaL_prepbuffer
#define LUADBG_FILEHANDLE LUA_FILEHANDLE
#define luadbg_writestring lua_writestring
#define luadbg_writeline lua_writeline
#define luadbg_writestringerror lua_writestringerror
#define luadbgL_checkunsigned luaL_checkunsigned
#define luadbgL_optunsigned luaL_optunsigned
#define luadbgL_checkint luaL_checkint
#define luadbgL_optint luaL_optint
#define luadbgL_checklong luaL_checklong
#define luadbgL_optlong luaL_optlong
#define LUADBG_VERSUFFIX LUA_VERSUFFIX
#define LUADBG_COLIBNAME LUA_COLIBNAME
#define LUADBG_TABLIBNAME LUA_TABLIBNAME
#define LUADBG_IOLIBNAME LUA_IOLIBNAME
#define LUADBG_OSLIBNAME LUA_OSLIBNAME
#define LUADBG_STRLIBNAME LUA_STRLIBNAME
#define LUADBG_UTF8LIBNAME LUA_UTF8LIBNAME
#define LUADBG_MATHLIBNAME LUA_MATHLIBNAME
#define LUADBG_DBLIBNAME LUA_DBLIBNAME
#define LUADBG_LOADLIBNAME LUA_LOADLIBNAME
#define LUADBG_DL_DLL LUA_DL_DLL
#define LUADBGI_IS32INT LUAI_IS32INT
#define LUADBG_INT_INT LUA_INT_INT
#define LUADBG_INT_LONG LUA_INT_LONG
#define LUADBG_INT_LONGLONG LUA_INT_LONGLONG
#define LUADBG_FLOAT_FLOAT LUA_FLOAT_FLOAT
#define LUADBG_FLOAT_DOUBLE LUA_FLOAT_DOUBLE
#define LUADBG_FLOAT_LONGDOUBLE LUA_FLOAT_LONGDOUBLE
#define LUADBG_INT_DEFAULT LUA_INT_DEFAULT
#define LUADBG_FLOAT_DEFAULT LUA_FLOAT_DEFAULT
#define LUADBG_32BITS LUA_32BITS
#define LUADBG_C89_NUMBERS LUA_C89_NUMBERS
#define LUADBG_C89_NUMBERS LUA_C89_NUMBERS
#define LUADBG_INT_TYPE LUA_INT_TYPE
#define LUADBG_INT_TYPE LUA_INT_TYPE
#define LUADBG_FLOAT_TYPE LUA_FLOAT_TYPE
#define LUADBG_INT_TYPE LUA_INT_TYPE
#define LUADBG_FLOAT_TYPE LUA_FLOAT_TYPE
#define LUADBG_INT_TYPE LUA_INT_TYPE
#define LUADBG_FLOAT_TYPE LUA_FLOAT_TYPE
#define LUADBG_PATH_SEP LUA_PATH_SEP
#define LUADBG_PATH_MARK LUA_PATH_MARK
#define LUADBG_EXEC_DIR LUA_EXEC_DIR
#define LUADBG_VDIR LUA_VDIR
#define LUADBG_LDIR LUA_LDIR
#define LUADBG_CDIR LUA_CDIR
#define LUADBG_SHRDIR LUA_SHRDIR
#define LUADBG_PATH_DEFAULT LUA_PATH_DEFAULT
#define LUADBG_CPATH_DEFAULT LUA_CPATH_DEFAULT
#define LUADBG_ROOT LUA_ROOT
#define LUADBG_LDIR LUA_LDIR
#define LUADBG_CDIR LUA_CDIR
#define LUADBG_PATH_DEFAULT LUA_PATH_DEFAULT
#define LUADBG_CPATH_DEFAULT LUA_CPATH_DEFAULT
#define LUADBG_DIRSEP LUA_DIRSEP
#define LUADBG_DIRSEP LUA_DIRSEP
#define LUADBG_IGMARK LUA_IGMARK
#define LUADBG_API LUA_API
#define LUADBG_API LUA_API
#define LUADBG_API LUA_API
#define LUADBGLIB_API LUALIB_API
#define LUADBGMOD_API LUAMOD_API
#define LUADBGI_FUNC LUAI_FUNC
#define LUADBGI_FUNC LUAI_FUNC
#define LUADBGI_DDEC LUAI_DDEC
#define LUADBGI_DDEF LUAI_DDEF
#define LUADBG_COMPAT_MATHLIB LUA_COMPAT_MATHLIB
#define LUADBG_COMPAT_APIINTCASTS LUA_COMPAT_APIINTCASTS
#define LUADBG_COMPAT_LT_LE LUA_COMPAT_LT_LE
#define luadbg_strlen lua_strlen
#define luadbg_objlen lua_objlen
#define luadbg_equal lua_equal
#define luadbg_lessthan lua_lessthan
#define luadbg_number2str lua_number2str
#define luadbg_numbertointeger lua_numbertointeger
#define LUADBG_NUMBER LUA_NUMBER
#define LUADBGI_UACNUMBER LUAI_UACNUMBER
#define LUADBG_NUMBER_FRMLEN LUA_NUMBER_FRMLEN
#define LUADBG_NUMBER_FMT LUA_NUMBER_FMT
#define luadbg_str2number lua_str2number
#define LUADBG_NUMBER LUA_NUMBER
#define LUADBGI_UACNUMBER LUAI_UACNUMBER
#define LUADBG_NUMBER_FRMLEN LUA_NUMBER_FRMLEN
#define LUADBG_NUMBER_FMT LUA_NUMBER_FMT
#define luadbg_str2number lua_str2number
#define LUADBG_NUMBER LUA_NUMBER
#define LUADBGI_UACNUMBER LUAI_UACNUMBER
#define LUADBG_NUMBER_FRMLEN LUA_NUMBER_FRMLEN
#define LUADBG_NUMBER_FMT LUA_NUMBER_FMT
#define luadbg_str2number lua_str2number
#define LUADBG_INTEGER_FMT LUA_INTEGER_FMT
#define LUADBGI_UACINT LUAI_UACINT
#define luadbg_integer2str lua_integer2str
#define LUADBG_UNSIGNED LUA_UNSIGNED
#define LUADBG_INTEGER LUA_INTEGER
#define LUADBG_INTEGER_FRMLEN LUA_INTEGER_FRMLEN
#define LUADBG_MAXINTEGER LUA_MAXINTEGER
#define LUADBG_MININTEGER LUA_MININTEGER
#define LUADBG_MAXUNSIGNED LUA_MAXUNSIGNED
#define LUADBG_INTEGER LUA_INTEGER
#define LUADBG_INTEGER_FRMLEN LUA_INTEGER_FRMLEN
#define LUADBG_MAXINTEGER LUA_MAXINTEGER
#define LUADBG_MININTEGER LUA_MININTEGER
#define LUADBG_MAXUNSIGNED LUA_MAXUNSIGNED
#define LUADBG_INTEGER LUA_INTEGER
#define LUADBG_INTEGER_FRMLEN LUA_INTEGER_FRMLEN
#define LUADBG_MAXINTEGER LUA_MAXINTEGER
#define LUADBG_MININTEGER LUA_MININTEGER
#define LUADBG_MAXUNSIGNED LUA_MAXUNSIGNED
#define LUADBG_INTEGER LUA_INTEGER
#define LUADBG_INTEGER_FRMLEN LUA_INTEGER_FRMLEN
#define LUADBG_MAXINTEGER LUA_MAXINTEGER
#define LUADBG_MININTEGER LUA_MININTEGER
#define LUADBG_MAXUNSIGNED LUA_MAXUNSIGNED
#define luadbg_strx2number lua_strx2number
#define luadbg_pointer2str lua_pointer2str
#define luadbg_number2strx lua_number2strx
#define luadbg_str2number lua_str2number
#define LUADBG_KCONTEXT LUA_KCONTEXT
#define LUADBG_KCONTEXT LUA_KCONTEXT
#define luadbg_getlocaledecpoint lua_getlocaledecpoint
#define luadbgi_likely luai_likely
#define luadbgi_unlikely luai_unlikely
#define luadbgi_likely luai_likely
#define luadbgi_unlikely luai_unlikely
#define luadbgi_apicheck luai_apicheck
#define LUADBGI_MAXSTACK LUAI_MAXSTACK
#define LUADBGI_MAXSTACK LUAI_MAXSTACK
#define LUADBG_EXTRASPACE LUA_EXTRASPACE
#define LUADBG_IDSIZE LUA_IDSIZE
#define LUADBGL_BUFFERSIZE LUAL_BUFFERSIZE
#define LUADBGI_MAXALIGN LUAI_MAXALIGN
