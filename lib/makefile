CC      = gcc -Wall -O2 -I./inc
SDCC    = sdcc -mstm8 -DSTM8S003 -I./inc
SDAR    = sdar
NAME    = lib_sdcc
SOURCES = $(wildcard src/*.c)
OBJS    = $(SOURCES:.c=.rel)

.SUFFIXES : .rel .c

all: $(NAME).lib

$(NAME).lib: $(OBJS)
	$(SDAR) -rc $@ $(OBJS)
.c.rel:
	$(SDCC) -c $< -o $@
clean:
	rm -f ${OBJS:.rel=.map} ${OBJS:.rel=.rst} ${OBJS:.rel=.cdb} ${OBJS:.rel=.asm} ${OBJS:.rel=.lst} ${OBJS:.rel=.sym} $(OBJS) $(NAME).lib