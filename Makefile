# Build a custom module for Postgres.
#
# To install this gets put into our shared-lib in the
# shared_preload_libraries list in postgresql.conf

CFLAGS=-fPIC -I${PG_LB_PATH}
LDFLAGS=-shared

PG_INSTALL_DIR=${PG_INSTALL_PATH}

TARGET=remote_planner.so

OBJS=hook.o outfuncs.o

all: $(OBJS)
	gcc $(LDFLAGS) -o ${TARGET} $(OBJS)

clean:
	rm -f ${TARGET} ${OBJS}

install: all
	cp -f ${TARGET} ${PG_INSTALL_DIR}/lib

%.o:%.c
	gcc -g -c $(CFLAGS) $< -o $@
