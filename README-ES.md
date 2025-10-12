<div align="center">
  <img src="https://user-images.githubusercontent.com/292349/213446185-2db63fd5-8c84-459c-9f04-e286382d6e80.png">
</div>

<hr>

<h4 align="center">
  <a href="https://lazyvim.github.io/installation">Instalar</a>
  ·
  <a href="https://lazyvim.github.io/configuration">Configurar</a>
  ·
  <a href="https://lazyvim.github.io">Documentación</a>
</h4>

<div align="center"><p>
    <a href="https://github.com/LazyVim/LazyVim/releases/latest">
      <img alt="Última versión" src="https://img.shields.io/github/v/release/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41&include_prerelease&sort=semver" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/pulse">
      <img alt="Último commit" src="https://img.shields.io/github/last-commit/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/LazyVim/LazyVim/blob/main/LICENSE">
      <img alt="Licencia" src="https://img.shields.io/github/license/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/stargazers">
      <img alt="Estrellas" src="https://img.shields.io/github/stars/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/issues">
      <img alt="Problemas" src="https://img.shields.io/github/issues/LazyVim/LazyVim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim">
      <img alt="Tamaño del repositorio" src="https://img.shields.io/github/repo-size/LazyVim/LazyVim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://twitter.com/intent/follow?screen_name=folke">
      <img alt="seguir en Twitter" src="https://img.shields.io/twitter/follow/folke?style=for-the-badge&logo=twitter&color=8aadf3&logoColor=D9E0EE&labelColor=302D41" />
    </a>
</div>

LazyVim es una configuración de Neovim impulsada por [💤 lazy.nvim](https://github.com/folke/lazy.nvim) que facilita la personalización y extensión de tu configuración. En lugar de tener que elegir entre comenzar desde cero o usar una distribución predefinida, LazyVim ofrece lo mejor de ambos mundos: la flexibilidad para ajustar tu configuración según sea necesario, junto con la conveniencia de una configuración preconfigurada.

![image](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

![image](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

## ✨ Características

- 🔥 Convierte tu Neovim en un IDE completo
- 💤 Personaliza y extiende fácilmente tu configuración con [lazy.nvim](https://github.com/folke/lazy.nvim)
- 🚀 Extremadamente rápido
- 🧹 Ajustes predeterminados sensatos para opciones, autocmds y combinaciones de teclas
- 📦 Viene con una gran cantidad de plugins preconfigurados y listos para usar

## ⚡️ Requisitos

- Neovim >= **0.11.2** (debe ser compilado con **LuaJIT**)
- Git >= **2.19.0** (para soporte de clones parciales)
- una [Fuente Nerd](https://www.nerdfonts.com/) **_(opcional)_**
- un compilador **C** para `nvim-treesitter`. Consulta [aquí](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

## 🚀 Empezando

Puedes encontrar una plantilla de inicio para **LazyVim** [aquí](https://github.com/LazyVim/starter)

<details><summary>Probarlo con Docker</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit fzf curl neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<details><summary>Instalar el <a href="https://github.com/LazyVim/starter">LazyVim Starter</a></summary>

- Haz una copia de seguridad de tus archivos actuales de Neovim:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Clona el starter

  ```sh
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ```

- Elimina la carpeta `.git`, para que puedas agregarla a tu propio repositorio más tarde

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- ¡Inicia Neovim!

  ```sh
  nvim
  ```

  Consulta los comentarios en los archivos sobre cómo personalizar **LazyVim**.

</details>

---

Hay un excelente video creado por [@elijahmanor](https://github.com/elijahmanor) con una guía para empezar.

[![Ver el video](https://img.youtube.com/vi/N93cTbtLCIM/hqdefault.jpg)](https://www.youtube.com/watch?v=N93cTbtLCIM)

[@dusty-phillips](https://github.com/dusty-phillips) escribió un libro completo llamado
[LazyVim para Desarrolladores Ambiciosos](https://lazyvim-ambitious-devs.phillips.codes)
disponible de forma gratuita en línea.

## 📂 Estructura de Archivos

Los archivos dentro de la configuración se cargarán automáticamente en el momento adecuado,
por lo que no necesitas requerir esos archivos manualmente.
**LazyVim** viene con un conjunto de archivos de configuración predeterminados que se cargarán
**_antes_** que los tuyos. Consulta [aquí](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)

Puedes agregar tus especificaciones de plugins personalizadas en `lua/plugins/`. Todos los archivos allí
serán cargados automáticamente por [lazy.nvim](https://github.com/folke/lazy.nvim)

<pre>
~/.config/nvim
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       ├── spec1.lua
│       ├── **
│       └── spec2.lua
└── init.lua
</pre>

## ⚙️ Configuración

Consulta la [documentación](https://lazyvim.github.io)
