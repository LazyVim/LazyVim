<div align="center">
  <img src="https://user-images.githubusercontent.com/292349/213446185-2db63fd5-8c84-459c-9f04-e286382d6e80.png">
</div>

<hr>

<h4 align="center">
  <a href="https://lazyvim.github.io/installation">安装</a>
  ·
  <a href="https://lazyvim.github.io/configuration">配置</a>
  ·
  <a href="https://lazyvim.github.io">文档</a>
</h4>

<div align="center"><p>
    <a href="https://github.com/LazyVim/LazyVim/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41&include_prerelease&sort=semver" /></a>
    <a href="https://github.com/LazyVim/LazyVim/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/></a>
    <a href="https://github.com/LazyVim/LazyVim/blob/main/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" /></a>
    <a href="https://github.com/LazyVim/LazyVim/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" /></a>
    <a href="https://github.com/LazyVim/LazyVim/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/LazyVim/LazyVim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" /></a>
    <a href="https://github.com/LazyVim/LazyVim">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/LazyVim/LazyVim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" /></a>
    <a href="https://twitter.com/intent/follow?screen_name=folke">
      <img alt="follow on Twitter" src="https://img.shields.io/twitter/follow/folke?style=for-the-badge&logo=twitter&color=8aadf3&logoColor=D9E0EE&labelColor=302D41" /></a>
</div>

LazyVim 是一个基于 [💤 lazy.nvim](https://github.com/folke/lazy.nvim) 的 Neovim 配置方案，让定制和扩展变得简单直观。
您不必再在“从零配置”和“使用预制发行版”之间做选择，LazyVim
提供了一个两全其美的方式——既可以享受默认配置带来的便利，又能根据个人需求来灵活调整各项设置。

![image](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

![image](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

## ✨ 特性

- 🔥 将你的 Neovim 打造为一个功能完备的 IDE
- 💤 使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 轻松自定义和扩展您的设置
- 🚀 快如闪电
- 🧹 选项、自动命令和键盘映射的合理预设
- 📦 内置大量精心优化的预配置插件，开箱即用

## ⚡️ 环境要求

- Neovim >= **0.11.2** (需要用 **LuaJIT** 构建)
- Git >= **2.19.0** (用于部分克隆支持)
- 一个 [Nerd Font](https://www.nerdfonts.com/) 字体 **_(可选)_**
- 一个用于 `nvim-treesitter` 的 **C** 编译器。看 [这里](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

## 🚀 开始使用

您可以在 [此处](https://github.com/LazyVim/starter) 找到 **LazyVim** 的初始模板

<details><summary>在 Docker 中尝鲜</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit fzf curl neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<details><summary> 安装 <a href="https://github.com/LazyVim/starter">LazyVim Starter</a></summary>

- 备份您当前的 Neovim 文件

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- 克隆 starter

  ```sh
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ```

- 删除 `.git` 文件夹，以便稍后将其添加到您自己的仓库

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- 启动 Neovim!

  ```sh
  nvim
  ```

  请参阅文件中有关如何自定义 **LazyVim** 的注释。

</details>

---

[@elijahmanor](https://github.com/elijahmanor) 制作了一个很棒的视频，可以带领你快速入门。

[![查看这个视频](https://img.youtube.com/vi/N93cTbtLCIM/hqdefault.jpg)](https://www.youtube.com/watch?v=N93cTbtLCIM)

[@dusty-phillips](https://github.com/dusty-phillips) 为 LazyVim 编写了一本全面的书籍
[《LazyVim for Ambitious Developers》](https://lazyvim-ambitious-devs.phillips.codes)
，可在线上免费阅读。

## 📂 文件结构

config 下的文件会在适当的时候被自动加载，所以你不需要手动引入这些文件。

**LazyVim** 带有一组默认配置文件，这些文件会在您的配置**之前**被加载。
请看[这里](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)

您可以在 `lua/plugins/` 下添加自定义插件配置。
[lazy.nvim](https://github.com/folke/lazy.nvim) 会自动加载此目录中的全部文件。

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

## ⚙️ 设置

请参阅[官方文档](https://lazyvim.github.io/)
