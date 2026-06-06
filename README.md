# 🚀 Configuración minimalista de Neovim

Configuración personal de Neovim, ligera y moderna, construida sobre el gestor de
plugins nativo (`vim.pack`) y el ecosistema [`mini.nvim`](https://github.com/nvim-mini/mini.nvim).
Sin gestores externos ni capas pesadas: solo lo necesario para un flujo de trabajo
rápido y cómodo.

> **Tecla líder (`leader`):** `,`

---

## 📑 Tabla de contenidos

- [Requisitos](#-requisitos)
- [Instalación](#-instalación)
- [Estructura del proyecto](#-estructura-del-proyecto)
- [Plugins incluidos](#-plugins-incluidos)
- [Lenguajes soportados (LSP / Treesitter)](#-lenguajes-soportados-lsp--treesitter)
- [Keymaps](#-keymaps)
- [Comandos personalizados](#-comandos-personalizados)
- [Gestión de plugins](#-gestión-de-plugins)

---

## ✅ Requisitos

| Herramienta | Versión / Notas |
|-------------|-----------------|
| **Neovim**  | `0.12+` (usa APIs nativas como `vim.pack` y `vim._core.ui2`) |
| **Git**     | Necesario para descargar plugins |
| **Node.js** | Requerido por Copilot y los formateadores `prettier`/`prettierd` |
| **ripgrep** (`rg`) | Recomendado para la búsqueda con `mini.pick` (grep) |
| Compilador C (`gcc`/`clang`) | Para compilar los parsers de Treesitter |

> Mason instala automáticamente los servidores LSP y formateadores la primera vez
> que abres Neovim, por lo que no necesitas instalarlos a mano.

---

## 📦 Instalación

> ⚠️ Haz una copia de seguridad de tu configuración actual antes de continuar.

```bash
# 1. Respaldar configuración existente (opcional)
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# 2. Clonar este repositorio
git clone https://github.com/HenCor2019/minimal-vim.git ~/.config/nvim

# 3. Abrir Neovim
nvim
```

En el primer arranque:

1. `vim.pack` descargará automáticamente todos los plugins.
2. **Mason** instalará los servidores LSP y formateadores listados en `lua/lsp.lua`.
3. **Treesitter** compilará los parsers de los lenguajes configurados.

Reinicia Neovim (o usa `,re`) cuando termine la instalación.

> 🤖 **¿Instalación asistida por IA?** Abre un agente (Claude Code u otro) en el repo
> y pídele que siga [`CLAUDE.md`](CLAUDE.md): incluye verificación/instalación de
> prerequisitos por sistema operativo e instalación de plugins en modo headless.

---

## 📂 Estructura del proyecto

```
nvim/
├── init.lua                  # Punto de entrada: carga módulos y colorscheme
├── nvim-pack-lock.json       # Lockfile de versiones de plugins (vim.pack)
└── lua/
    ├── options.lua           # Opciones de Neovim (números, tabs, undo, etc.)
    ├── keymaps.lua           # Atajos de teclado globales
    ├── commands.lua          # Comandos :PackAdd / :PackDel / :PackUpdate
    ├── pack.lua              # Declaración de plugins
    ├── treesitter.lua        # Config + autoinstalación de parsers
    ├── lsp.lua              # Mason + LSP + diagnósticos
    └── plugins/              # Configuración por plugin
        ├── mini-files.lua
        ├── mini-pick.lua
        ├── mini-completion.lua
        ├── mini-snippets.lua
        ├── mini-surround.lua
        ├── mini-diff.lua
        ├── mini-notify.lua
        ├── mini-cmdline.lua
        ├── mini-animate.lua
        ├── conform.lua
        ├── harpoon.lua
        ├── copilot.lua
        ├── copilot-chat.lua
        └── smart-splits.lua
```

---

## 🔌 Plugins incluidos

| Plugin | Propósito |
|--------|-----------|
| [`rose-pine/neovim`](https://github.com/rose-pine/neovim) | Colorscheme activo |
| [`vim-moonfly-colors`](https://github.com/bluz71/vim-moonfly-colors) | Colorscheme alternativo |
| [`mini.nvim`](https://github.com/nvim-mini/mini.nvim) | Suite modular: files, pick, completion, snippets, surround, diff, notify, cmdline, animate |
| [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) | Resaltado de sintaxis (rama `main`) |
| [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) | Configuración de servidores LSP |
| [`mason.nvim`](https://github.com/mason-org/mason.nvim) + [`mason-tool-installer`](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Instalación automática de LSP/formatters |
| [`conform.nvim`](https://github.com/stevearc/conform.nvim) | Formateo al guardar |
| [`harpoon`](https://github.com/ThePrimeagen/harpoon) (rama `harpoon2`) | Navegación rápida entre archivos marcados |
| [`vim-fugitive`](https://github.com/tpope/vim-fugitive) | Integración con Git |
| [`copilot.lua`](https://github.com/zbirenbaum/copilot.lua) | Sugerencias de GitHub Copilot |
| [`CopilotChat.nvim`](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Chat IA dentro del editor |
| [`smart-splits.nvim`](https://github.com/mrjones2014/smart-splits.nvim) | Movimiento y redimensionado de splits |
| [`friendly-snippets`](https://github.com/rafamadriz/friendly-snippets) | Colección de snippets |
| [`plenary.nvim`](https://github.com/nvim-lua/plenary.nvim) | Dependencia común (Harpoon, etc.) |

---

## 🌐 Lenguajes soportados (LSP / Treesitter)

**Servidores LSP** (autoinstalados con Mason):

`lua_ls` · `marksman` · `gopls` · `rust_analyzer` · `ts_ls` (TypeScript/JavaScript) · `pyright`

**Formateadores:** `prettierd`/`prettier` (JS/TS) · `ruff` (Python)

**Parsers de Treesitter:** go, rust, typescript, javascript, tsx, python, html, css, json, bash, http, dockerfile

---

## ⌨️ Keymaps

> Líder = `,`

### General / Edición

| Tecla | Modo | Acción |
|-------|------|--------|
| `p` | Visual | Pegar sobre la selección sin perder el registro |
| `<leader>d` | Normal / Visual | Borrar sin copiar al registro |
| `<C-c>` | Normal | Limpiar resaltado de búsqueda (`:nohl`) |
| `<C-c>` | Insert | Salir a modo Normal (`<Esc>`) |
| `J` / `K` | Visual | Mover líneas seleccionadas abajo / arriba |
| `<` / `>` | Visual | Indentar/desindentar manteniendo la selección |
| `J` | Normal | Unir líneas sin mover el cursor |
| `<C-d>` / `<C-u>` | Normal | Desplazarse media página con el cursor centrado |
| `n` / `N` | Normal | Siguiente/anterior resultado de búsqueda centrado |
| `<leader>s` | Normal | Reemplazar la palabra bajo el cursor en todo el archivo |
| `<leader>X` | Normal | Hacer el archivo ejecutable (`chmod +x`) |
| `<leader>u` | Normal | Abrir el Undotree nativo |
| `<leader>re` | Normal | Reiniciar la configuración (`:restart`) |

### Ventanas / Splits (smart-splits)

| Tecla | Acción |
|-------|--------|
| `<space>` | Alternar entre ventanas |
| `ss` | Split horizontal |
| `sv` | Split vertical |
| `<C-h/j/k/l>` | Mover el cursor entre splits (izq/abajo/arriba/der) |
| `<A-h/j/k/l>` | Redimensionar el split |

### Explorador de archivos (mini.files)

| Tecla | Acción |
|-------|--------|
| `-` | Abrir el explorador |
| `<leader>-` | Abrir el explorador en el archivo actual |
| `<CR>` | Entrar en directorio / abrir archivo |
| `L` | Entrar y abrir en ventana |
| `_` / `H` | Salir del directorio |

### Buscador (mini.pick)

| Tecla | Acción |
|-------|--------|
| `<leader>pp` | Buscar archivos |
| `<leader>ps` | Grep de la palabra bajo el cursor |
| `<leader>vh` | Buscar en la ayuda |
| `<leader>xx` | Lista de diagnósticos |
| `<leader>pk` | Lista de keymaps |

### Harpoon

| Tecla | Acción |
|-------|--------|
| `<leader>a` | Marcar archivo actual |
| `<C-e>` | Abrir el menú rápido de Harpoon |
| `<leader>1`–`<leader>4` | Saltar a los archivos marcados 1–4 |

### LSP

| Tecla | Acción |
|-------|--------|
| `<C-]>` | Ir a la definición |
| `gr` | Ir a las referencias |
| `df` | Mostrar diagnóstico de la línea |
| `<leader>f` | Formatear el buffer (conform) |

### Surround (mini.surround)

| Tecla | Acción |
|-------|--------|
| `sa` | Añadir delimitadores (`saiw` = palabra interior) |
| `sd` | Eliminar delimitadores |
| `sr` | Reemplazar delimitadores |
| `sf` / `sF` | Buscar delimitador (derecha / izquierda) |
| `sh` | Resaltar delimitador |

### Git (fugitive + mini.diff)

| Tecla | Acción |
|-------|--------|
| `<leader>gg` | Fugitive a pantalla completa |
| `<leader>gd` | Ver diff en split |

### GitHub Copilot

| Tecla | Modo | Acción |
|-------|------|--------|
| `<C-l>` | Insert | Aceptar sugerencia |
| `<C-Right>` | Insert | Aceptar palabra |
| `<Esc>` | Insert | Descartar sugerencia |
| `<leader>cc` | Normal / Visual | Alternar CopilotChat |
| `<leader>ce` | Normal / Visual | Explicar el código |
| `<leader>cf` | Normal / Visual | Corregir errores |
| `<leader>cr` | Normal / Visual | Revisar y sugerir mejoras |
| `<leader>cq` | Normal | Pregunta rápida al chat |

---

## 🛠️ Comandos personalizados

| Comando | Descripción |
|---------|-------------|
| `:PackAdd user/repo …` | Añadir uno o varios plugins |
| `:PackDel plugin …` | Eliminar plugins |
| `:PackUpdate [plugin …]` | Actualizar todos los plugins, o solo los indicados |

---

## 🔄 Gestión de plugins

Los plugins se declaran en [`lua/pack.lua`](lua/pack.lua) usando el gestor nativo
`vim.pack`. Las versiones quedan fijadas en `nvim-pack-lock.json`.

```vim
" Actualizar todo
:PackUpdate

" Actualizar solo un plugin
:PackUpdate mini.nvim

" Añadir un plugin nuevo
:PackAdd tpope/vim-commentary

" Eliminar un plugin
:PackDel vim-commentary
```

---

<p align="center">Hecho con ❤️ y Neovim</p>
