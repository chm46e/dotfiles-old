include config.mk

SRC = $(wildcard src/*.c) $(wildcard src/**/*.c) $(wildcard src/**/**/*.c) $(wildcard src/**/**/**/*.c)

# no-compile file paths (exclude from compiling)
EXC = $(wildcard src/layouts/*.c) $(wildcard src/layouts/include/*.c) $(wildcard src/*_nc.c) $(wildcard src/**/*_nc.c) $(wildcard src/**/**/*_nc.c) $(wildcard src/**/**/**/*_nc.c)
SRC := $(filter-out $(EXC), $(SRC))

OBJ = ${SRC:.c=.o}

all: dwm

.c.o:
	$(CC) -o $@ -c $(CFLAGS) $<

${OBJ}: config.h config.mk

config.h:
	cp config.def.h $@

dwm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f dwm ${OBJ} dwm-${VERSION}.tar.gz config.h

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f dwm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwm
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm\
		${DESTDIR}${MANPREFIX}/man1/dwm.1

.PHONY: all clean install uninstall
