<div align="center">
  <img src="https://user-images.githubusercontent.com/292349/213446185-2db63fd5-8c84-459c-9f04-e286382d6e80.png">
</div>

<hr>

<h4 align="center">
  <a href="https://lazyvim.github.io/installation">Install</a>
  ·
  <a href="https://lazyvim.github.io/configuration">Configure</a>
  ·
  <a href="https://lazyvim.github.io">Docs</a>
</h4>

<div align="center"><p>
    <a href="https://github.com/LazyVim/LazyVim/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41&include_prerelease&sort=semver" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/LazyVim/LazyVim/blob/main/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/LazyVim/LazyVim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/LazyVim/LazyVim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://twitter.com/intent/follow?screen_name=folke">
      <img alt="follow on Twitter" src="https://img.shields.io/twitter/follow/folke?style=for-the-badge&logo=twitter&color=8aadf3&logoColor=D9E0EE&labelColor=302D41" />
    </a>
</div>

LazyVim ist ein Neovim setup aufgebaut auf [💤 lazy.nvim](https://github.com/folke/lazy.nvim). 
Es erleichter das Anpassen und erweitern von Ihrer Konfiguration.
Anstatt von vorne anzufangen oder eine vorgefertigte Distro zu verwenden, gibt LazyVim das beste aus 
beiden Welten - die Flexibilität Ihre Konfiguration zu verändern und einzustellen wie Sie es wollen
und die Einfachheit von einem vorgefertigten Setup.

![image](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

![image](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

## ✨ Features

- 🔥 Transformiere dein Neovim in eine komplette IDE
- 💤 Passe deine Konfiguration einfach an und erweitere diese mit [lazy.nvim](https://github.com/folke/lazy.nvim)
- 🚀 Extrem schnell
- 🧹 Logische Voreinstellungen für optionen, autocmds und keymaps
- 📦 Kommt mit einem Haufen vor Konfigurierten, ready to use Plugins

## ⚡️ Vorraussetzungen

- Neovim >= **0.8.0** (gebraucht um mit **LuaJIT** zu bauen)
- Git >= **2.19.0** (um Teil-Klone zu unterstützen)
- eine [Nerd Font](https://www.nerdfonts.com/) **_(optional)_**

## 🚀 Einstieg

Sie können eine Startvorlage für **LazyVim** [hier](https://github.com/LazyVim/starter) finden

<details><summary>Versuchen Sie's mit Docker</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<details><summary>Installieren von <a href="https://github.com/LazyVim/starter">LazyVim Starter</a></summary>

- Neovim Files sichern:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Den Starter Klonen:

  ```sh
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ```

- Den `.git` Folder löschen, um die Konfiguration zu einer eigenen distro hinzuzufügen:

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Neovim starten!

  ```sh
  nvim
  ```

  Refer to the comments in the files on how to customize **LazyVim**.

</details>

## 📂 File Structure

The files under config will be automatically loaded at the appropriate time,
so you don't need to require those files manually.
**LazyVim** comes with a set of default config files that will be loaded
**_before_** your own. See [here](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)

You can add your custom plugin specs under `lua/plugins/`. All files there
will be automatically loaded by [lazy.nvim](https://github.com/folke/lazy.nvim)

<pre>
~/.config/nvim
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       ├── spec1.lua
│       ├── **
│       └── spec2.lua
└── init.toml
</pre>

## ⚙️ Configuration

Refer to the [docs](https://lazyvim.github.io)
