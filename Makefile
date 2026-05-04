CC ?= gcc
CFLAGS = -O2 -shared -fPIC
LUA_INCLUDE ?= /usr/include/lua5.1

all: csrc/crypto.so csrc/lzw.so

csrc/crypto.so: csrc/crypto.c
	$(CC) $(CFLAGS) -I$(LUA_INCLUDE) -o $@ $< -llua5.1

csrc/lzw.so: csrc/lzw.c
	$(CC) $(CFLAGS) -I$(LUA_INCLUDE) -o $@ $< -llua5.1

clean:
	rm -f csrc/*.so csrc/*.o

.PHONY: all clean
