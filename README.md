# telescope-compiler

A plugin for telescope.nvim to select compiler.

## Installation

### Packer

Add following to the packer config:
```lua
use {
    'cranberry-knight/telescope-compiler.nvim',
    require = 'telescope.nvim',
}
```

## Setup

Add following lines to the telescope config:
```lua
require('telescope').load_extension('compiler')
```

## Use

```
:Telescope compiler
```
