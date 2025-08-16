# --- Toolchain ---
CC      = sdcc
PRJ     = FanCtrl
FLASH_SIZE = 8192

# --- Dirs ---
OBJ_DIR = obj
SRC_DIR = .
LIBSRC  = lib/src
LIBINC  = lib/inc

# --- Sources (only the .c filenames; lib sources found via VPATH) ---
SRC = main.c
SRC += stm8s_gpio.c
SRC += stm8s_tim4.c
SRC += stm8s_clk.c
SRC += stm8s_wwdg.c

# Let make find sources in lib/src automatically
VPATH = $(SRC_DIR) $(LIBSRC)

# --- Flags ---
INCLUDES = -I. -I$(LIBINC)
CFLAGS   = -mstm8 -DSTM8S003 -DUSE_STDPERIPH_DRIVER $(INCLUDES)

# Objects go to obj/<name>.rel
OBJS = $(patsubst %.c,$(OBJ_DIR)/%.rel,$(SRC))

# --- Default target ---
all: $(OBJ_DIR) $(OBJS)
	$(CC) -mstm8 $(OBJS) -o $(PRJ).ihx
	packihx $(PRJ).ihx > $(PRJ).hex

# --- Compile C to .rel (ensures obj dir exists) ---
$(OBJ_DIR)/%.rel: %.c | $(OBJ_DIR)
	$(CC) -c $(CFLAGS) $< -o $@

# --- Create obj dir if missing ---
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# --- Clean ---
clean:
	rm -f $(OBJ_DIR)/*.*
	rm -f $(PRJ).ihx $(PRJ).hex
