/* Key binding functions */
static void defaultgaps(const Arg *arg);
static void incrgaps(const Arg *arg);
static void togglegaps(const Arg *arg);

static void bstack(Monitor *m);
static void centeredmaster(Monitor *m);
static void dwindle(Monitor *m);
static void fibonacci(Monitor *m, int s);
static void gaplessgrid(Monitor *m);
static void grid(Monitor *m);
static void nrowgrid(Monitor *m);
static void tile(Monitor *m);
/* Internals */
static void getgaps(Monitor *m, int *oh, int *ov, int *ih, int *iv, unsigned int *nc);
static void getfacts(Monitor *m, int msize, int ssize, float *mf, float *sf, int *mr, int *sr);
static void setgaps(int oh, int ov, int ih, int iv);

static void movestack(const Arg *arg);
static void tatami(Monitor *m);
