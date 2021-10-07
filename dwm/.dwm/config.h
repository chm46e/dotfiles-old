/* appearance */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int default_border = 0;  // to switch back to default border after dynamic border resizing via keybinds
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 10;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;       /* vert inner gap between windows */
static const unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 10;       /* vert outer gap between windows and screen edge */
static       int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const unsigned int systraypinning = 2;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails,display systray on the 1st monitor,False: display systray on last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 0;        /* 0 means no bar */
enum showtab_modes { showtab_never, showtab_auto, showtab_nmodes, showtab_always };
static const int showtab            = showtab_auto;
static const int toptab             = True;
static const int topbar             = 1;        /* 0 means bottom bar */
static const int horizpadbar        = 5;
static const int vertpadbar         = 11;
static const int vertpadtab         = 33;
static const int horizpadtabi       = 15;
static const int horizpadtabo       = 15;
static const int scalepreview       = 4;
static       int tag_preview        = 1;        /* 1 means enable, 0 is off */
static const int corner_radius      = 5;
static const int wincornerrounding  = 0;        /* 1 means enable, 0 is off */
static const int focusonwheel       = 0;

static const char *fonts[]          = { "JetBrainsMono Nerd Font:style:medium:size=10",
                                        "Material Design Icons-Regular:size=10",
                                      };
static const char dmenufont[]       = "monospace:size=10";
static const int colorfultag        = 1;  /* 0 means use SchemeSel for selected non vacant tag */

// theme
#include "themes/onedark.h"

static const char *colors[][3]      = {
    /*               fg         bg         border   */
    [SchemeNorm]       = { gray3, black, gray2 },
    [SchemeSel]        = { gray4, blue,  blue  },
    [TabSel]           = { blue, gray2,  black  },
    [TabNorm]          = { gray3, black, black },
    [SchemeTag]        = { gray3, black, black },
    [SchemeTag1]       = { blue,  black, black },
    [SchemeTag2]       = { red,   black, black },
    [SchemeTag3]       = { orange, black,black },
    [SchemeTag4]       = { green, black, black },
    [SchemeTag5]       = { pink,  black, black },
    [SchemeLayout]     = { green, black, black },
    [SchemeBtnPrev]    = { green, black, black },
    [SchemeBtnNext]    = { yellow, black, black },
    [SchemeBtnClose]   = { red, black, black },
};

/* tagging */
static char *tags[] = {"", "", "", "", ""};

static const int tagschemes[] = { SchemeTag1, SchemeTag2, SchemeTag3,
                                  SchemeTag4, SchemeTag5
                                };

static const unsigned int ulinepad	= 5;	/* horizontal padding between the underline and tag */
static const unsigned int ulinestroke	= 2;	/* thickness / height of the underline */
static const unsigned int ulinevoffset	= 0;	/* how far above the bottom of the bar the line should appear */
static const int ulineall 		= 0;	/* 1 to show underline on all tags, 0 for just the active ones */

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
       	/* class      instance    title       tags mask     iscentered   isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            0,           1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           0,           -1 },
    { "eww",      NULL,       NULL,       0,            0,           1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include <layouts/functions.h>

static const Layout layouts[] = {
    { "[]=",      tile },    /* first entry is default */
    { "|M|",      centeredmaster },
    { ":::",      gaplessgrid },
    { "><>",      NULL },
    { "TTT",      bstack },
    { "|+|",      tatami },
    { "[\\]",     dwindle },
    { "###",      nrowgrid },
    { "HHH",      grid },
    { "[M]",      monocle },
    //{ "[@]",      spiral },
    //{ ">M>",      centeredfloatingmaster },
    //{ "===",      bstackhoriz },
    //{ "H[]",      deck },
    //{ "---",      horizgrid },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define CTRLKEY ControlMask
#define SHIFTKEY ShiftMask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|SHIFTKEY,              KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|CTRLKEY,               KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      setlayout,      {.v = &layouts[TAG]} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char chandler[] = {"/home/wolfy/.dwm/src/sh/shortcuts/handler.sh"};

static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *layoutmenu_cmd = "/home/wolfy/.dwm/src/sh/layoutmenu.sh";

static const char *rofi_c[] = {chandler, "rofi", NULL};
static const char *webl_c[] = {chandler, "webl", NULL};
static const char *macro_c[] = {chandler, "macro", NULL};
static const char *wifi_c[] = {chandler, "wifi", NULL};
static const char *bt_c[] = {chandler, "bt", NULL};
static const char *term_c[] = {chandler, "term", NULL};
static const char *atom_c[] = {chandler, "atom", NULL};
static const char *filem_c[] = {chandler, "filem", NULL};
static const char *discord_c[] = {chandler, "discord", NULL};
static const char *htop_c[] = {chandler, "htop", NULL};
static const char *fsgui_c[] = {chandler, "fsgui", NULL};
static const char *fsfull_c[] = {chandler, "fsfull", NULL};
static const char *browser_c[] = {chandler, "browser", NULL};
static const char *altbrowser_c[] = {chandler, "altbrowser", NULL};
static const char *chlayout_c[] = {chandler, "chlayout", NULL};
static const char *voli_c[] = {chandler, "voli", NULL};
static const char *vold_c[] = {chandler, "vold", NULL};
static const char *volmute_c[] = {chandler, "volmute", NULL};
static const char *mici_c[] = {chandler, "mici", NULL};
static const char *micd_c[] = {chandler, "micd", NULL};
static const char *micmute_c[] = {chandler, "micmute", NULL};
static const char *bri_c[] = {chandler, "bri", NULL};
static const char *brd_c[] = {chandler, "brd", NULL};
static const char *mnext_c[] = {chandler, "mnext", NULL};
static const char *mlast_c[] = {chandler, "mlast", NULL};
static const char *mtoggle_c[] = {chandler, "mtoggle", NULL};

static Key keys[] = {
    /* modifier                     key        function        argument */
    { MODKEY,                       XK_l,      spawn,          {.v = rofi_c}},
    { MODKEY,                       XK_u,      spawn,          {.v = webl_c}},
    { MODKEY,                       XK_i,      spawn,          {.v = macro_c}},
    { MODKEY,                       XK_o,      spawn,          {.v = wifi_c}},
    { MODKEY,                       XK_p,      spawn,          {.v = bt_c}},
    { MODKEY,                       XK_t,      spawn,          {.v = term_c}},
    { MODKEY,                       XK_s,      spawn,          {.v = atom_c}},
    { MODKEY,                       XK_f,      spawn,          {.v = filem_c}},
    { MODKEY,                       XK_d,      spawn,          {.v = discord_c}},
    { CTRLKEY|SHIFTKEY,             XK_Escape, spawn,          {.v = htop_c}},
    { 0,                            XK_Print,  spawn,          {.v = fsgui_c}},
    { ALTKEY,                       XK_Print,  spawn,          {.v = fsfull_c}},
    { MODKEY,                       XK_b,      spawn,          {.v = browser_c}},
    { MODKEY|SHIFTKEY,              XK_b,      spawn,          {.v = altbrowser_c}},
    { MODKEY,                       XK_space,  spawn,          {.v = chlayout_c}},
    { 0,                            XK_F12,    spawn,          {.v = voli_c}},
    { 0,                            XK_F11,    spawn,          {.v = vold_c}},
    { 0,                            XK_F10,    spawn,          {.v = volmute_c}},
    { ALTKEY,                       XK_F12,    spawn,          {.v = mici_c}},
    { ALTKEY,                       XK_F11,    spawn,          {.v = micd_c}},
    { ALTKEY,                       XK_F10,    spawn,          {.v = micmute_c}},
    { SHIFTKEY,                     XK_F12,    spawn,          {.v = bri_c}},
    { SHIFTKEY,                     XK_F11,    spawn,          {.v = brd_c}},
    { 0,                            XK_F9,     spawn,          {.v = mnext_c}},
    { 0,                            XK_F7,     spawn,          {.v = mlast_c}},
    { 0,                            XK_F8,     spawn,          {.v = mtoggle_c}},

    { MODKEY,                       XK_c,      killclient,     {0}},
    { MODKEY|SHIFTKEY,              XK_q,      quit,           {.i = 0}},
    { MODKEY|CTRLKEY,               XK_q,      quit,           {.i = 1}},
    { MODKEY|SHIFTKEY,       		XK_l,      cyclelayout,    {.i = 0}},
    { MODKEY,                       XK_Left,   focusstack,     {.i = +1 }},
    { MODKEY,                       XK_Right,  focusstack,     {.i = -1 }},
    { MODKEY|SHIFTKEY,              XK_Left,   setmfact,       {.f = -0.05}},
    { MODKEY|SHIFTKEY,              XK_Right,  setmfact,       {.f = +0.05}},
    { MODKEY|ALTKEY,                XK_Left,   incrgaps,       {.i = -1 }},
    { MODKEY|ALTKEY,                XK_Right,  incrgaps,       {.i = +1 }},
    { MODKEY,                       XK_g,      togglegaps,     {0}},
    { MODKEY|SHIFTKEY,              XK_g,      defaultgaps,    {0}},
    { MODKEY,                       XK_Tab,    view,           {0}},
    { MODKEY|ALTKEY,                XK_f,      togglefloating, {0}},
    { MODKEY|SHIFTKEY,              XK_f,      togglefullscr,  {0}},
    { MODKEY,                       XK_z,      zoom,           {0}},
    { MODKEY,                       XK_Up,     focusmon,       {.i = -1 }},
    { MODKEY,                       XK_Down,   focusmon,       {.i = +1 }},
    { MODKEY|SHIFTKEY,              XK_Up,     tagmon,         {.i = -1 }},
    { MODKEY|SHIFTKEY,              XK_Down,   tagmon,         {.i = +1 }},
    { MODKEY,                       XK_h,      hidewin,        {0}},
    { MODKEY|SHIFTKEY,              XK_h,      restorewin,     {0}},

    //{ MODKEY|ControlMask,                       XK_w,      tabmode,        { -1 } },
    /*{ MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = +0.25} },
    { MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = -0.25} },
    { MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} },
    { MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
    { MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },*/


    /*{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
    { MODKEY|ShiftMask,             XK_f,      setlayout,      {.v = &layouts[1]} },
    { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
    { MODKEY|ControlMask,           XK_g,      setlayout,      {.v = &layouts[10]} },
    { MODKEY|ControlMask|ShiftMask, XK_t,      setlayout,      {.v = &layouts[13]} },*/

    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    TAGKEYS(                        XK_6,                      5)
    TAGKEYS(                        XK_7,                      6)
    TAGKEYS(                        XK_8,                      7)
    TAGKEYS(                        XK_9,                      8)
    TAGKEYS(                        XK_0,                      9)
    //{ MODKEY,                       XK_Return, spawn,   SHCMD("~/.local/bin/./st_settings && st")},

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        cyclelayout,    {.v = 0} },
    { ClkLtSymbol,          0,              Button3,        layoutmenu,     {0} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button2,        spawn,          {.v = term_c } },

		/* Keep movemouse? */
    /* { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} }, */

		/* placemouse options, choose which feels more natural:
		 *    0 - tiled position is relative to mouse cursor
		 *    1 - tiled postiion is relative to window center
		 *    2 - mouse pointer warps to window center
		 *
		 * The moveorplace uses movemouse or placemouse depending on the floating state
		 * of the selected client. Set up individual keybindings for the two if you want
		 * to control these separately (i.e. to retain the feature to move a tiled window
		 * into a floating position).
		 */
	{ ClkClientWin,         MODKEY,         Button1,        moveorplace,    {.i = 0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkClientWin,         ControlMask,    Button1,        dragmfact,      {0} },
    { ClkClientWin,         ControlMask,    Button3,        dragcfact,      {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
    { ClkTabBar,            0,              Button1,        focuswin,       {0} },
    { ClkTabBar,            0,              Button1,        focuswin,       {0} },
    { ClkTabPrev,           0,              Button1,        movestack,      { .i = -1 } },
    { ClkTabNext,           0,              Button1,        movestack,      { .i = +1 } },
    { ClkTabClose,          0,              Button1,        killclient,     {0} },
};
