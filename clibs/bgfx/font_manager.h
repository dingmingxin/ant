#ifndef lua_bgfx_font_manager_h
#define lua_bgfx_font_manager_h

#include <stb/stb_truetype.h>

#define FONT_MANAGER_TEXSIZE 2048
#define FONT_MANAGER_GLYPHSIZE 32

#define FONT_MANAGER_SLOTLINE (FONT_MANAGER_TEXSIZE/FONT_MANAGER_GLYPHSIZE)
#define FONT_MANAGER_SLOTS (FONT_MANAGER_SLOTLINE*FONT_MANAGER_SLOTLINE)
#define FONT_MANAGER_HASHSLOTS (FONT_MANAGER_SLOTS * 2)
#define FONT_MANAGER_MAXFONT 8

struct font_slot {
	int codepoint_ttf;	// high 8 bits (ttf index)
	short offset_x;
	short offset_y;
	short advance_x;
	short advance_y;
	unsigned short w;
	unsigned short h;
};

struct priority_list {
	int version;
	short prev;
	short next;
};

struct font_manager {
	int version;
	int count;
	short list_head;
	short font_number;
	struct stbtt_fontinfo ttf[FONT_MANAGER_MAXFONT];
	struct font_slot slots[FONT_MANAGER_SLOTS];
	struct priority_list priority[FONT_MANAGER_SLOTS];
	short hash[FONT_MANAGER_HASHSLOTS];
};

struct font_glyph {
	short offset_x;
	short offset_y;
	short advance_x;
	short advance_y;
	unsigned short w;
	unsigned short h;
	unsigned short u;
	unsigned short v;
};

void font_manager_init(struct font_manager *);

// You should keep ttfbuffer alive before font_manager_delete
int font_manager_addfont(struct font_manager *, const void *ttfbuffer);
int font_manager_rebindfont(struct font_manager *, int fontid, const void *ttfbuffer);

// 1 exist in cache. 0 not exist in cache, call font_manager_update. -1 failed.
int font_manager_touch(struct font_manager *, int font, int codepoint, struct font_glyph *glyph);
// buffer size should be [ glyph->w * glyph->h ] ,  NULL succ , otherwise returns error msg
const char * font_manager_update(struct font_manager *, int font, int codepoint, struct font_glyph *glyph, unsigned char *buffer);
void font_manager_flush(struct font_manager *);
void font_manager_scale(struct font_manager *F, struct font_glyph *glyph, int size);

#endif
