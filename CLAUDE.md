# CLAUDE.md — Guía para agentes de IA

Este archivo da instrucciones a un agente de IA (Claude Code u otro) para **instalar
y configurar** esta configuración de Neovim en una máquina nueva de forma casi
autónoma. Sigue los pasos en orden.

> Config personal minimalista basada en `vim.pack` (gestor nativo) + `mini.nvim`.
> Tecla líder: `,` — Más detalles para humanos en [`README.md`](README.md).

---

## 0. Resumen de la tarea

Dejar Neovim funcionando con esta config: prerequisitos instalados, repo clonado en
`~/.config/nvim`, y plugins/LSP/parsers descargados. La instalación de plugins ocurre
al arrancar Neovim; usa el modo **headless** para hacerlo sin interacción del usuario.

---

## 1. Verificar / instalar prerequisitos

| Herramienta | Mínimo | Para qué |
|-------------|--------|----------|
| Neovim | `0.12+` | Usa APIs nativas (`vim.pack`, `vim._core.ui2`). **Obligatorio.** |
| Git | cualquiera | Clonar repo y plugins |
| Node.js | LTS | Copilot, `prettier`/`prettierd` |
| ripgrep (`rg`) | cualquiera | Búsqueda/grep en `mini.pick` |
| Compilador C (`gcc`/`clang`) | cualquiera | Compilar parsers de Treesitter |

Comprueba primero qué falta:

```bash
nvim --version | head -1   # debe ser >= 0.12
git --version
node --version
rg --version
cc --version || gcc --version
```

Instala lo que falte según el sistema operativo:

### macOS (Homebrew)
```bash
brew install neovim git node ripgrep
# El compilador C viene con las Command Line Tools de Xcode:
xcode-select --install 2>/dev/null || true
```

### Debian / Ubuntu (apt)
```bash
sudo apt update
sudo apt install -y git nodejs npm ripgrep build-essential
# Neovim 0.12+ NO suele estar en apt estable. Usa una de estas opciones:
#  a) Appimage oficial (recomendado):
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
#  b) o el PPA inestable:  sudo add-apt-repository ppa:neovim-ppa/unstable
```

### Arch Linux (pacman)
```bash
sudo pacman -S --needed neovim git nodejs npm ripgrep base-devel
```

> ⚠️ El punto crítico es **Neovim 0.12+**. Si la versión del repositorio del SO es
> menor, instala el binario oficial (appimage/release) antes de continuar.

---

## 2. Respaldar configuración existente (si la hay)

```bash
[ -e ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak.$(date +%s)
[ -e ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak.$(date +%s)
[ -e ~/.local/state/nvim ] && mv ~/.local/state/nvim ~/.local/state/nvim.bak.$(date +%s)
```

---

## 3. Clonar el repositorio

```bash
git clone https://github.com/HenCor2019/minimal-vim.git ~/.config/nvim
```

> Si ya estás ejecutando dentro del repo clonado, omite este paso.

---

## 4. Instalar plugins, LSP y parsers (headless, sin interacción)

Al primer arranque, `vim.pack` descarga los plugins, **Mason** instala los servidores
LSP/formateadores y **Treesitter** compila los parsers. Para hacerlo sin abrir la UI:

```bash
# Descarga plugins y ejecuta la config completa una vez.
# Espera unos segundos a que terminen las descargas en segundo plano.
nvim --headless "+sleep 60" +qa
```

Si necesitas asegurar que Mason y Treesitter terminaron, ejecuta una segunda pasada:

```bash
nvim --headless "+MasonToolsUpdate" "+sleep 30" +qa
nvim --headless "+lua require('nvim-treesitter').install({'go','rust','typescript','javascript','tsx','python','html','css','json','bash','http','dockerfile'})" "+sleep 30" +qa
```

> Nota: las descargas son asíncronas. Si una pasada headless sale antes de terminar,
> repítela o, como alternativa, pide al usuario que abra `nvim` una vez y espere a que
> Mason/Treesitter finalicen (verá notificaciones).

---

## 5. Verificar la instalación

```bash
# Comprueba que no hay errores de carga de la config:
nvim --headless "+checkhealth" +qa 2>&1 | head -40

# Lista los plugins instalados por vim.pack:
ls ~/.local/share/nvim/site/pack/core/opt/ 2>/dev/null
```

Dentro de Neovim, el usuario puede verificar con:
- `:checkhealth` — estado general
- `:Mason` — servidores LSP/formatters instalados
- `,pk` — lista de keymaps (atajo de este config)

---

## 6. Notas importantes para el agente

- **No edites** archivos bajo `~/.local/share/nvim/` ni `nvim-pack-lock.json` a mano;
  los gestiona `vim.pack`. Para tocar plugins usa los comandos `:PackAdd` / `:PackDel`
  / `:PackUpdate` (definidos en `lua/commands.lua`).
- La **tecla líder es `,`**. Tenlo en cuenta si documentas o pruebas atajos.
- **Copilot** requiere autenticación interactiva (`:Copilot auth` / login del usuario);
  el agente no puede completarla, debe pedírsela al usuario.
- Estructura del proyecto y mapa completo de keymaps: ver [`README.md`](README.md).
- El colorscheme activo es **rose-pine** (definido en `init.lua`).
