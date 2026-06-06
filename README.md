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
        ├── mini-pick.lua         # + integra vim.ui.select
        ├── mini-completion.lua
        ├── mini-snippets.lua
        ├── mini-surround.lua
        ├── mini-diff.lua
        ├── mini-notify.lua
        ├── mini-cmdline.lua
        ├── mini-animate.lua
        ├── mini-icons.lua
        ├── mini-ai.lua           # Text objects (argumento, función…)
        ├── mini-pairs.lua        # Auto-cierre de pares
        ├── mini-move.lua         # Mover líneas/bloques
        ├── mini-splitjoin.lua    # Partir/unir colecciones (gS)
        ├── conform.lua
        ├── harpoon.lua
        ├── copilot.lua
        ├── copilot-chat.lua
        ├── smart-splits.lua
        ├── render-markdown.lua
        ├── snacks.lua            # Solo módulo input (vim.ui.input)
        ├── dap.lua               # Debug (DAP) + attach a Docker
        └── neotest.lua           # Testing (Jest, Vitest, Go, Python)
```

---

## 🔌 Plugins incluidos

| Plugin | Propósito |
|--------|-----------|
| [`rose-pine/neovim`](https://github.com/rose-pine/neovim) | Colorscheme activo |
| [`vim-moonfly-colors`](https://github.com/bluz71/vim-moonfly-colors) | Colorscheme alternativo |
| [`mini.nvim`](https://github.com/nvim-mini/mini.nvim) | Suite modular: files, pick, completion, snippets, surround, diff, notify, cmdline, animate, icons, **ai, pairs, move, splitjoin** |
| [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) | Resaltado de sintaxis (rama `main`) |
| [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) | Configuración de servidores LSP |
| [`mason.nvim`](https://github.com/mason-org/mason.nvim) + [`mason-tool-installer`](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Instalación automática de LSP/formatters |
| [`conform.nvim`](https://github.com/stevearc/conform.nvim) | Formateo al guardar |
| [`harpoon`](https://github.com/ThePrimeagen/harpoon) (rama `harpoon2`) | Navegación rápida entre archivos marcados |
| [`vim-fugitive`](https://github.com/tpope/vim-fugitive) | Integración con Git |
| [`copilot.lua`](https://github.com/zbirenbaum/copilot.lua) | Sugerencias de GitHub Copilot |
| [`CopilotChat.nvim`](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Chat IA dentro del editor |
| [`smart-splits.nvim`](https://github.com/mrjones2014/smart-splits.nvim) | Movimiento y redimensionado de splits |
| [`render-markdown.nvim`](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Renderiza archivos Markdown bonitos dentro del buffer |
| [`friendly-snippets`](https://github.com/rafamadriz/friendly-snippets) | Colección de snippets |
| [`snacks.nvim`](https://github.com/folke/snacks.nvim) | Solo el módulo `input`: ventana flotante para `vim.ui.input` (p. ej. renombrar) |
| [`nvim-dap`](https://github.com/mfussenegger/nvim-dap) + [`dap-ui`](https://github.com/rcarriga/nvim-dap-ui) + [`dap-virtual-text`](https://github.com/theHamsta/nvim-dap-virtual-text) | Depuración (breakpoints, step, inspección) con valores inline |
| [`neotest`](https://github.com/nvim-neotest/neotest) + adaptadores [`jest`](https://github.com/nvim-neotest/neotest-jest) · [`vitest`](https://github.com/marilari88/neotest-vitest) · [`golang`](https://github.com/fredrikaverpil/neotest-golang) · [`python`](https://github.com/nvim-neotest/neotest-python) | Ejecutar y depurar tests dentro del editor |
| [`plenary.nvim`](https://github.com/nvim-lua/plenary.nvim) + [`nvim-nio`](https://github.com/nvim-neotest/nvim-nio) | Dependencias comunes (Harpoon, neotest, dap-ui…) |

---

## 🌐 Lenguajes soportados (LSP / Treesitter)

**Servidores LSP** (autoinstalados con Mason):

`lua_ls` · `marksman` · `gopls` · `rust_analyzer` · `ts_ls` (TypeScript/JavaScript) · `pyright`

**Formateadores:** `prettierd`/`prettier` (JS/TS) · `ruff` (Python)

**Adaptadores de depuración** (autoinstalados con Mason): `delve` (Go) · `debugpy` (Python) · `js-debug-adapter` (Node/NestJS)

**Parsers de Treesitter:** go, rust, typescript, javascript, tsx, python, html, css, json, bash, http, dockerfile, markdown, markdown_inline

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

### Edición (mini.ai · move · splitjoin · pairs)

| Tecla | Modo | Acción |
|-------|------|--------|
| `dia` / `cia` | Normal | Borrar / cambiar el **argumento** bajo el cursor |
| `daf` / `cif` | Normal | Borrar / cambiar la **llamada a función** |
| `vit` | Normal | Seleccionar dentro de una **tag** |
| `gS` | Normal | Alternar entre una línea y multilínea (objetos, arrays, args) |
| `<A-h/j/k/l>` | Normal / Visual | Mover la línea o selección (en macOS, tecla Option) |

> Auto-cierre de paréntesis, corchetes, llaves y comillas con `mini.pairs`.

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
| `vrn` | Renombrar símbolo (LSP rename) |
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

### Debug (nvim-dap) — prefijo `,D`

> Se usa **`,D` (mayúscula)** para no chocar con `,d` (borrar sin copiar).

| Tecla | Acción |
|-------|--------|
| `<leader>Db` | Alternar breakpoint |
| `<leader>DB` | Breakpoint condicional |
| `<leader>Dc` | Continuar / **iniciar** (elige configuración) |
| `<leader>Dn` | Step over |
| `<leader>Di` | Step into |
| `<leader>Do` | Step out |
| `<leader>Dt` | Terminar sesión |
| `<leader>Dr` | Abrir REPL |
| `<leader>Dv` | Alternar panel de debug (UI) |
| `<leader>De` | Evaluar expresión bajo el cursor (también en Visual) |

**Depurar contra Docker.** Como los proyectos corren en contenedores, las configuraciones
`Attach Docker` se conectan a un puerto de debug que el contenedor debe exponer. Ajusta
`CONTAINER_WORKDIR` en [`lua/plugins/dap.lua`](lua/plugins/dap.lua) al `WORKDIR` de tu imagen.

| Lenguaje | Arranca así dentro del contenedor | Puerto |
|----------|-----------------------------------|--------|
| **Go** | `dlv debug --headless --listen=:2345 --api-version=2 --accept-multiclient` | 2345 |
| **Python** | `python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m tu_modulo` | 5678 |
| **NestJS** | `node --inspect=0.0.0.0:9229 dist/main` (o `nest start --debug 0.0.0.0:9229`) | 9229 |

### Testing (neotest) — prefijo `,t`

Detecta automáticamente el runner según el proyecto: **Jest**, **Vitest**, **Go** y **pytest**.
Los tests se ejecutan en el host (necesitas los runtimes instalados localmente).

| Tecla | Acción |
|-------|--------|
| `<leader>tn` | Ejecutar el test más cercano |
| `<leader>tf` | Ejecutar todos los del archivo |
| `<leader>td` | Depurar el test más cercano (vía DAP) |
| `<leader>ts` | Alternar panel resumen |
| `<leader>to` | Ver la salida del test |
| `<leader>tw` | Modo watch del archivo |

> 💡 **Jest vs Vitest:** Vitest usa por convención `*.test.ts`; Jest de NestJS usa `*.spec.ts`.
> neotest solo encuentra lo que encuentra el runner del proyecto: si `npx jest <archivo>` o
> `npx vitest run <archivo>` no lo halla desde la terminal, revisa la config del proyecto
> (`testRegex`/`roots`/`testMatch`).

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
