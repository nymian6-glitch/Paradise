/*
 * Aegis LuaU Obfuscator
 * crypto.c -- Fast XOR encryption/decryption C module
 */

#include <stdlib.h>
#include <string.h>

#ifdef USE_LUA
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#else
/* Standalone mode -- just provide the raw functions */
#endif

/* PRNG state */
typedef struct {
    unsigned long long state45;
    unsigned int state8;
    unsigned int paramMul8;
    unsigned int paramMul45;
    unsigned long long paramAdd45;
    unsigned int secretKey8;
    unsigned char prevValues[4];
    int prevCount;
} AegisPRNG;

static unsigned int primitiveRoot257(unsigned int idx) {
    unsigned int g = 1, m = 128, d = 2 * idx + 1;
    do {
        g = (unsigned int)((unsigned long long)g * g * (d >= m ? 3 : 1) % 257);
        d = d % m;
        m = m / 2;
    } while (m >= 1);
    return g;
}

static void prng_init(AegisPRNG *p, unsigned int key8, unsigned int key7, unsigned int key6, unsigned long long key44) {
    p->secretKey8 = key8;
    p->paramMul8 = primitiveRoot257(key7);
    p->paramMul45 = key6 * 4 + 1;
    p->paramAdd45 = key44 * 2 + 1;
    p->state45 = 0;
    p->state8 = 2;
    p->prevCount = 0;
}

static void prng_seed(AegisPRNG *p, unsigned long long seed) {
    p->state45 = seed % 35184372088832ULL;
    p->state8 = (unsigned int)(seed % 255 + 2);
    p->prevCount = 0;
}

static unsigned int prng_random32(AegisPRNG *p) {
    p->state45 = (p->state45 * p->paramMul45 + p->paramAdd45) % 35184372088832ULL;
    do {
        p->state8 = (unsigned int)((unsigned long long)p->state8 * p->paramMul8 % 257);
    } while (p->state8 == 1);
    unsigned int r = p->state8 % 32;
    double n = (double)(p->state45) / (double)(1ULL << (13 - (p->state8 - r) / 32));
    unsigned long long ni = (unsigned long long)n;
    unsigned long long shifted = ni >> r;
    double frac = n - (double)ni;
    return (unsigned int)((unsigned long long)(frac * 4294967296.0) + shifted);
}

static unsigned char prng_nextbyte(AegisPRNG *p) {
    if (p->prevCount == 0) {
        unsigned int rnd = prng_random32(p);
        unsigned int low16 = rnd & 0xFFFF;
        unsigned int high16 = (rnd >> 16) & 0xFFFF;
        p->prevValues[0] = (unsigned char)(low16 & 0xFF);
        p->prevValues[1] = (unsigned char)((low16 >> 8) & 0xFF);
        p->prevValues[2] = (unsigned char)(high16 & 0xFF);
        p->prevValues[3] = (unsigned char)((high16 >> 8) & 0xFF);
        p->prevCount = 4;
    }
    p->prevCount--;
    return p->prevValues[p->prevCount];
}

/* Encrypt a string buffer */
static void aegis_encrypt(AegisPRNG *p, const unsigned char *input, unsigned char *output,
                           size_t len, unsigned long long seed) {
    prng_seed(p, seed);
    unsigned char prev = (unsigned char)p->secretKey8;
    for (size_t i = 0; i < len; i++) {
        unsigned char byte = input[i];
        output[i] = (unsigned char)((byte - (prng_nextbyte(p) + prev)) & 0xFF);
        prev = byte;
    }
}

/* Decrypt a string buffer */
static void aegis_decrypt(AegisPRNG *p, const unsigned char *input, unsigned char *output,
                           size_t len, unsigned long long seed) {
    prng_seed(p, seed);
    unsigned char prev = (unsigned char)p->secretKey8;
    for (size_t i = 0; i < len; i++) {
        prev = (unsigned char)((input[i] + prng_nextbyte(p) + prev) & 0xFF);
        output[i] = prev;
    }
}

#ifdef USE_LUA
/* Lua binding: aegis_crypto.encrypt(str, seed, key8, key7, key6, key44) */
static int l_encrypt(lua_State *L) {
    size_t len;
    const char *input = luaL_checklstring(L, 1, &len);
    unsigned long long seed = (unsigned long long)luaL_checknumber(L, 2);
    unsigned int k8 = (unsigned int)luaL_checkinteger(L, 3);
    unsigned int k7 = (unsigned int)luaL_checkinteger(L, 4);
    unsigned int k6 = (unsigned int)luaL_checkinteger(L, 5);
    unsigned long long k44 = (unsigned long long)luaL_checknumber(L, 6);

    AegisPRNG prng;
    prng_init(&prng, k8, k7, k6, k44);

    char *output = (char *)malloc(len);
    aegis_encrypt(&prng, (const unsigned char *)input, (unsigned char *)output, len, seed);
    lua_pushlstring(L, output, len);
    free(output);
    return 1;
}

static int l_decrypt(lua_State *L) {
    size_t len;
    const char *input = luaL_checklstring(L, 1, &len);
    unsigned long long seed = (unsigned long long)luaL_checknumber(L, 2);
    unsigned int k8 = (unsigned int)luaL_checkinteger(L, 3);
    unsigned int k7 = (unsigned int)luaL_checkinteger(L, 4);
    unsigned int k6 = (unsigned int)luaL_checkinteger(L, 5);
    unsigned long long k44 = (unsigned long long)luaL_checknumber(L, 6);

    AegisPRNG prng;
    prng_init(&prng, k8, k7, k6, k44);

    char *output = (char *)malloc(len);
    aegis_decrypt(&prng, (const unsigned char *)input, (unsigned char *)output, len, seed);
    lua_pushlstring(L, output, len);
    free(output);
    return 1;
}

static const struct luaL_Reg crypto_lib[] = {
    {"encrypt", l_encrypt},
    {"decrypt", l_decrypt},
    {NULL, NULL}
};

int luaopen_aegis_crypto(lua_State *L) {
    luaL_newlib(L, crypto_lib);
    return 1;
}
#endif
