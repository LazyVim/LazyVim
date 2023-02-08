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

LazyVim 是由 [💤 lazy.nvim](https://github.com/folke/lazy.nvim) 驱动的一套 Neovim 配置，可以轻松自定义和扩展您的配置。
不必在从头开始或使用预制发行版之间做选择，
LazyVim 提供了两全其美的方式 - 根据需要调整配置的灵活性，以及默认预配置的便利性。

![image](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

![image](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

## ✨ 特性

- 🔥 将你的 Neovim 变成一个成熟的 IDE
- 💤 使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 轻松自定义和扩展您的配置
- 🚀 快如闪电
- 🧹 选项、自动命令和键盘映射的合理预设
- 📦 预配置了大量插件，随时可用

## ⚡️ 要求

- Neovim >= **0.8.0** (需要用 **LuaJIT** 构建)
- Git >= **2.19.0** (用于部分克隆支持)
- 一个 [Nerd Font](https://www.nerdfonts.com/) 字体 **_(可选)_**

## 🚀 入门

您可以在 [此处](https://github.com/LazyVim/starter) 找到 **LazyVim** 的入门模板

<details><summary>在 Docker 中尝试</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit neovim ripgrep alpine-sdk --update
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

- 删除 `.git` 文件夹，以便稍后将其添加到您自己的存储库

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

[@elijahmanor](https://github.com/elijahmanor) 制作了一段很棒的视频，其中包含入门演练。

[![Watch the video](https://img.youtube.com/vi/N93cTbtLCIM/hqdefault.jpg)](https://www.youtube.com/watch?v=N93cTbtLCIM)

## 📂 文件结构

config 下的文件会在适当的时候自动加载，所以你不需要手动引入这些文件。
**LazyVim** 带有一组默认配置文件，这些文件将在您的配置**之前**加载。
看[这里](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)

您可以在 `lua/plugins/` 下添加自定义插件配置(specs)。
[lazy.nvim](https://github.com/folke/lazy.nvim) 会自动加载这些文件。

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

## ⚙️ Configuration

参考[文档](https://lazyvim.github.io/)
