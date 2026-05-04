/*
 * Aegis LuaU Obfuscator
 * lzw.c -- Fast LZW compression C module
 */

#include <stdlib.h>
#include <string.h>

#ifdef USE_LUA
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#endif

#define LZW_MAX_DICT 65536

typedef struct {
    char *entries[LZW_MAX_DICT];
    int lengths[LZW_MAX_DICT];
    int size;
} LZWDict;

static void dict_init(LZWDict *d) {
    d->size = 256;
    for (int i = 0; i < 256; i++) {
        d->entries[i] = (char *)malloc(1);
        d->entries[i][0] = (char)i;
        d->lengths[i] = 1;
    }
}

static void dict_free(LZWDict *d) {
    for (int i = 0; i < d->size; i++) {
        free(d->entries[i]);
    }
}

static int dict_add(LZWDict *d, const char *s, int len) {
    if (d->size >= LZW_MAX_DICT) return -1;
    int idx = d->size;
    d->entries[idx] = (char *)malloc(len);
    memcpy(d->entries[idx], s, len);
    d->lengths[idx] = len;
    d->size++;
    return idx;
}

/* Find longest matching prefix, returns dict index */
static int dict_find(LZWDict *d, const char *s, int len) {
    int best = -1;
    int bestLen = 0;
    /* For small dict sizes, linear scan is fine; for production, use a trie */
    for (int i = 0; i < d->size; i++) {
        if (d->lengths[i] <= len && d->lengths[i] > bestLen) {
            if (memcmp(d->entries[i], s, d->lengths[i]) == 0) {
                best = i;
                bestLen = d->lengths[i];
            }
        }
    }
    return best;
}

#ifdef USE_LUA
static int l_compress(lua_State *L) {
    size_t inputLen;
    const char *input = luaL_checklstring(L, 1, &inputLen);

    LZWDict dict;
    dict_init(&dict);

    /* Output codes */
    int *codes = (int *)malloc(inputLen * sizeof(int));
    int codeCount = 0;
    size_t pos = 0;

    while (pos < inputLen) {
        int remaining = (int)(inputLen - pos);
        int idx = dict_find(&dict, input + pos, remaining);
        if (idx < 0) break;

        int matchLen = dict.lengths[idx];
        codes[codeCount++] = idx;

        if (pos + matchLen < inputLen) {
            /* Add new entry: match + next char */
            char *newEntry = (char *)malloc(matchLen + 1);
            memcpy(newEntry, input + pos, matchLen);
            newEntry[matchLen] = input[pos + matchLen];
            if (dict.size < LZW_MAX_DICT) {
                dict.entries[dict.size] = newEntry;
                dict.lengths[dict.size] = matchLen + 1;
                dict.size++;
            } else {
                free(newEntry);
            }
        }

        pos += matchLen;
    }

    /* Build output string in base36 format */
    static const char digits[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    char *output = (char *)malloc(codeCount * 12);
    int outLen = 0;

    for (int i = 0; i < codeCount; i++) {
        char numBuf[32];
        int numLen = 0;
        int n = codes[i];
        if (n == 0) {
            numBuf[0] = '0';
            numLen = 1;
        } else {
            while (n > 0) {
                numBuf[numLen++] = digits[n % 36];
                n /= 36;
            }
            /* Reverse */
            for (int j = 0; j < numLen / 2; j++) {
                char tmp = numBuf[j];
                numBuf[j] = numBuf[numLen - 1 - j];
                numBuf[numLen - 1 - j] = tmp;
            }
        }

        /* Length prefix (in base36) */
        char lenBuf[4];
        int ll = 0;
        int nl = numLen;
        if (nl == 0) {
            lenBuf[0] = '0';
            ll = 1;
        } else {
            while (nl > 0) {
                lenBuf[ll++] = digits[nl % 36];
                nl /= 36;
            }
            for (int j = 0; j < ll / 2; j++) {
                char tmp = lenBuf[j];
                lenBuf[j] = lenBuf[ll - 1 - j];
                lenBuf[ll - 1 - j] = tmp;
            }
        }

        memcpy(output + outLen, lenBuf, ll);
        outLen += ll;
        memcpy(output + outLen, numBuf, numLen);
        outLen += numLen;
    }

    lua_pushlstring(L, output, outLen);

    free(output);
    free(codes);
    dict_free(&dict);

    return 1;
}

static const struct luaL_Reg lzw_lib[] = {
    {"compress", l_compress},
    {NULL, NULL}
};

int luaopen_aegis_lzw(lua_State *L) {
    luaL_newlib(L, lzw_lib);
    return 1;
}
#endif
