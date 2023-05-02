# spzenhan plugin lua version for Neovim

![Original spzenhan GitHub](https://github.com/kaz399/spzenhan.vim)


## Using it

clone to plugin dir

```
$ git clone https://github.com/norikatsu/spzenhan-lua
```


## Features and structure

- 100% Lua
- Automatically switch IME on Windows OS.
- Automatically turn off IME when entering normal mode of neovim.

### Plugin structure

```
.
├── lua
│   ├── spzenhan-lua
│   │   └── module.lua(nouse)
│   └── spzenhan-lua.lua
├── Makefile
├── plugin
│   └── spzenhan-lua.lua
├── README.md
├── tests
│   ├── minimal_init.lua
│   └── spzenhan-lua
│       └── spzenhan-lua_spec.lua
```
