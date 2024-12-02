# 🛩️ PaperPlane.nvim

*Fly directly to your PDFs from Neovim!*

**PaperPlane.nvim** is a lightweight Neovim plugin that lets you soar straight to the PDF version of your current file. No more rummaging through folders—just a simple command, and you're airborne! ✈️

## 📦 Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

Add the following to your Neovim configuration:

```lua
{
  'HubertusWeber/PaperPlane.nvim',
  opts = {
      output_directory = '~/Output',    -- Change to your PDF output directory
      command = 'open',                 -- 'open' for macOS, 'xdg-open' for Linux
  },
}
```

### Using packer.nvim

Add the plugin to your plugins.lua or equivalent:

```lua
use {
  'HubertusWeber/PaperPlane.nvim',
  config = function()
    require('paperplane').setup{
      output_directory = '~/Output',    -- Change to your PDF output directory
      command = 'open',                 -- 'open' for macOS, 'xdg-open' for Linux
    }
  end,
}

```

## ⚙️ Configuration

### Default Configuration

```lua
require('paperplane').setup{
  output_directory = '~/Output',
  command = 'open',
}
```

### Options

- **`output_directory`**: *(string)* The directory where your PDFs are stored.
  - **Default**: `'~/Output'`
- **`command`**: *(string)* The system command used to open PDFs.
  - **Default**: `'open'` (for macOS users)
  - **For Linux**: Consider using `'xdg-open'`

## 🚀 Usage

Once installed, you can use the plugin with a simple command:

1. Open a file in Neovim (e.g., `document.tex`).
2. Run the command:

```vim
:OpenPDF
```

3. PaperPlane.nvim will:

   - Replace the file's extension with `.pdf` (e.g., `document.pdf`).
   - Search for `document.pdf` in your `output_directory`.
   - If not found, search in the current file's directory.
   - Open the PDF using the specified `command`.
   - If the PDF isn't found, it'll gently let you know: `PDF not found.`

## 📄 License

This project is released under the BSD Zero-Clause License (see LICENSE.txt) because intellectual property is just artificial scarcity masquerading as innovation. Want to use this code? It was never mine to "own" in the first place! Want to modify it? Ideas belong to everyone! Want to sell it? Go ahead – I won't pretend I have the right to stop you.

## 🙏 Acknowledgements

A heartfelt thank you to the Neovim team for creating the greatest text editor of all time! Your dedication to building this wonderful piece of software has made coding a joy for developers worldwide. 🎉

