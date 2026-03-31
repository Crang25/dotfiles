/* See LICENSE file for copyright and license details. */

static const unsigned int borderpx = 4;
static const unsigned int gappx = 18;
static const unsigned int snap = 24;
static const unsigned int systraypinning = 0;
static const unsigned int systrayonleft = 0;
static const unsigned int systrayspacing = 2;
static const int systraypinningfailfirst = 1;
static const int showsystray = 1;
static const int showbar = 1;
static const int topbar = 1;

static const char *fonts[] = {
	"JetBrainsMono Nerd Font:size=15:antialias=true:autohint=true",
	"Hack Nerd Font:size=15:antialias=true:autohint=true",
};
static const char dmenufont[] = "JetBrainsMono Nerd Font:size=16";
static char dmenumon[2] = "0";
static const char *dmenucmd[] = {
	"dmenu_run",
	"-m", dmenumon,
	"-fn", dmenufont,
	"-nb", "#282828",
	"-nf", "#ebdbb2",
	"-sb", "#79740e",
	"-sf", "#fbf1c7",
	NULL
};
static const char *termcmd[] = { "kitty", NULL };
static const char col_gray1[] = "#282828";
static const char col_gray2[] = "#504945";
static const char col_gray3[] = "#ebdbb2";
static const char col_gray4[] = "#fbf1c7";
static const char col_accent[] = "#79740e";

static const char *colors[][3] = {
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel] = { col_gray4, col_accent, col_accent },
};

static const char *tags[] = {
	" ",     // 1
	" ",   // 2
	" ",     // 3
	" ",  // 4
	" ",     // 5
	" ",       // 6
	" ",    // 7
	" ",     // 8
	" ",     // 9
};

static const Rule rules[] = {
	{ "Slack", NULL, NULL, 1 << 0, 0, -1 },
	{ "slack", NULL, NULL, 1 << 0, 0, -1 },
	{ "Google-chrome", NULL, NULL, 1 << 1, 0, -1 },
	{ "google-chrome", NULL, NULL, 1 << 1, 0, -1 },
	{ "jetbrains-toolbox", NULL, NULL, 1 << 2, 0, -1 },
	{ "Jetbrains-toolbox", NULL, NULL, 1 << 2, 0, -1 },
	{ "Firefox", NULL, NULL, 1 << 3, 0, -1 },
	{ "firefox", NULL, NULL, 1 << 3, 0, -1 },
	{ "jetbrains-webstorm", NULL, NULL, 1 << 2, 0, -1 },
	{ "Pavucontrol", NULL, NULL, 0, 1, -1 },
};

static const float mfact = 0.55;
static const int nmaster = 1;
static const int resizehints = 0;
static const int lockfullscreen = 1;

static const Layout layouts[] = {
	{ "[]=", tile },
	{ "[M]", monocle },
	{ "><>", NULL },
};

#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,          KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,            KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask,KEY,      toggletag,      {.ui = 1 << TAG} },

static const Key keys[] = {
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_s,      togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_space,  setlayout,      {0} },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY|ControlMask,           XK_q,      quit,           {0} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
};

static const Button buttons[] = {
	{ ClkLtSymbol,   0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,   0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,   0,              Button2,        zoom,           {0} },
	{ ClkClientWin,  MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,  MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,  MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,     0,              Button1,        view,           {0} },
	{ ClkTagBar,     0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,     MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,     MODKEY,         Button3,        toggletag,      {0} },
};
