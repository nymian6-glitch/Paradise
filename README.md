# Aegis - LuaU Obfuscator

Based on [Prometheus](https://github.com/prometheus-lua/Prometheus) by Elias Oelschner.

High-security, high-performance LuaU obfuscator combining AST-level transformations with an optimized custom bytecode VM.

## Features

- **Hybrid Architecture**: AST transformations for security + custom bytecode VM for performance
- **Custom VM**: Fully custom opcodes, super operators, opcode mutations, binary-search dispatch
- **Strong Protection**:
  - String encryption (PRNG-based)
  - Constant array extraction with encoding
  - Anti-tamper checks
  - Number-to-expression conversion
  - Control flow flattening via VM
- **Performance Optimizations**:
  - Super operators (merge multiple instructions into one)
  - Opcode mutations (randomize register order)
  - Binary search VM dispatch
  - LZW bytecode compression
  - C modules for crypto and compression
- **LuaU Native**: Built specifically for Roblox's LuaU

## Requirements

- LuaJIT or Lua 5.1
- GCC or Clang (for C modules, optional)

## Quick Start

```bash
# Basic obfuscation
lua cli.lua --preset Medium input.lua

# Strong obfuscation
lua cli.lua --preset Strong input.lua

# Custom pipeline
lua cli.lua --steps EncryptStrings,Vmify,ConstantArray input.lua
```

## Presets

| Preset | Protection | Performance Impact |
|--------|-----------|-------------------|
| Minify | None (name mangling only) | None |
| Weak | Basic VM | Low |
| Medium | VM + String Encryption + Anti-Tamper | Moderate |
| Strong | Double VM + All protections | High |

## Architecture

```
Source LuaU Code
      |
  [Lexer] -> Tokens
      |
  [Parser] -> AST
      |
  [AST Steps] -> Transformed AST
      |  (EncryptStrings, ConstantArray, AntiTamper, NumbersToExpressions)
      |
  [VM Compiler] -> Custom Bytecode
      |  (Super Operators, Mutations, Optimized Dispatch)
      |
  [Emitter] -> Obfuscated LuaU with embedded VM
```

## Building C Modules (Optional)

```bash
make
```

## License

Based on Prometheus by Elias Oelschner, https://github.com/prometheus-lua/Prometheus
