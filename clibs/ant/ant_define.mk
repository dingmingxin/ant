include $(ANT3RD)/../clibs/bgfx/bgfx_define.mk
include $(ANT3RD)/../clibs/hierarchy/ozz_define.mk
include $(ANT3RD)/../clibs/rp3d/rp3d.mk

ifeq "$(PLAT)" "mingw"
PLAT_LIBS = -lws2_32 -limm32 -lole32 -loleaut32 -lwbemuuid -lpsapi
else
endif

LINKLIBBGFX= -L$(BGFXLIBDIR) $(BGFXLIB)
LINKLIBOZZ= $(OZZRUNTIME) $(OZZOFFLINE) $(OZZGEOMERTY) $(OZZBASE)

LINKLIBANT= $(LINKLIBBGFX) $(LINKLIBOZZ) $(RP3DLIB) -lstdc++ $(PLAT_LIBS)
