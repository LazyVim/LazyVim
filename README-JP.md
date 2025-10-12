<div align="center">
  <img src="https://user-images.githubusercontent.com/292349/213446185-2db63fd5-8c84-459c-9f04-e286382d6e80.png">
</div>

<hr>

<h4 align="center">
  <a href="https://lazyvim.github.io/installation">インストール</a>
  ·
  <a href="https://lazyvim.github.io/configuration">設定</a>
  ·
  <a href="https://lazyvim.github.io">ドキュメント</a>
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

LazyVimは、設定の拡張と変更を容易にするために[💤 lazy.nvim](https://github.com/folke/lazy.nvim)によって提供されるNeovimセットアップです。
LazyVimは、ゼロから始めるか、あらかじめ作成されたディストリビューションを使用するかの選択を迫ることなく、
必要に応じて設定を調整する柔軟性と、事前に設定されたセットアップの利便性を両方叶える最高の世界を提供します。

![image](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

![image](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

## ✨ 機能

- 🔥 Neovimを本格的なIDEへと変身させます
- 💤 [lazy.nvim](https://github.com/folke/lazy.nvim)で簡単にカスタマイズと拡張が可能
- 🚀 驚くほどの高速さ
- 🧹 Options, autocmds, そしてkeymapsのための合理的なデフォルト設定
- 📦 事前に設定がされ、使用可能なプラグインが豊富についてきます

## ⚡️ 必要要件

- Neovim >= **0.11.2** (**LuaJIT**でビルドされている必要があります)
- Git >= **2.19.0** (部分的なcloneサポートのため)
- [Nerd Font](https://www.nerdfonts.com/) **_(任意)_**
- `nvim-treesitter`用の**C**コンパイラ。詳細は[こちら](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

## 🚀 Getting Started

**lazyvim**のスターターテンプレートは[こちら](https://github.com/lazyvim/starter)。

<details><summary>Dockerで試す</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit fzf curl neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<details><summary><a href="https://github.com/LazyVim/starter">LazyVim Starter</a>をインストール</summary>

- 既存のNeovimファイルのバックアップを作成します。

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- スターターをcloneします。

  ```sh
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ```

- 後ほど自分のリポジトリに加えられるように、`.git`フォルダを削除します。
  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Neovimを起動します!

  ```sh
  nvim
  ```

  **LazyVim**をカスタマイズするために、ファイルのコメントを参照してください。

</details>

---

[@elijahmanor](https://github.com/elijahmanor)氏によって作成された始めるにあたっての概要動画があります。

[![動画を見る](https://img.youtube.com/vi/N93cTbtLCIM/hqdefault.jpg)](https://www.youtube.com/watch?v=N93cTbtLCIM)

## 📂 ファイル構造

config配下にあるファイルは適切なタイミングで自動的にロードされる為、
手動でそれらのファイルをrequireする必要はありません。
LazyVimには、自分で設定したものより先にロードされるデフォルトの設定ファイルが付属しています。詳しくは[こちら](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)。
カスタムプラグインをlua/plugins/の下に追加することができます。lua/plugins/配下の全てのファイルは[lazy.nvim](https://github.com/folke/lazy.nvim)によって自動的にロードされます。

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

## ⚙️ 設定

こちらの[ドキュメント](https://lazyvim.github.io)を参照してください。
