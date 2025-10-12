<div align="center">
  <img src="https://user-images.githubusercontent.com/292349/213446185-2db63fd5-8c84-459c-9f04-e286382d6e80.png">
</div>

<hr>

<h4 align="center">
  <a href="https://lazyvim.github.io/installation">Instalar</a>
  ·
  <a href="https://lazyvim.github.io/configuration">Configurar</a>
  ·
  <a href="https://lazyvim.github.io">Documentação</a>
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

LazyVim é uma configuração de Neovim potenciada por [💤 lazy.nvim](https://github.com/folke/lazy.nvim)
para tornar fácil customizar e extender a tua configuração.
Em vez de ter de escolher entre começar de raiz ou usar
uma distribuição pré-feita, LazyVim oferece o melhor
dos dois mundos - a flexibilidade de alterar a tua configuração
como necessário, junto com a conveniência de um setup pré-configurado.

![imagem](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

![imagem](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

## ✨ Características

- 🔥 Transforma o teu Neovim num IDE completo.
- 💤 Customiza e extende a tua configuração facilmente com [lazy.nvim](https://github.com/folke/lazy.nvim)
- 🚀 Super rápido
- 🧹 Definições comuns para options, autocms e keymaps
- 📦 Contém uma variedade de plugins pré-configurados e preparados a usar

## ⚡️ Requesitos

- Neovim >= **0.11.2** (preciso fazer build com **LuaJIT**)
- Git >= **2.19.0** (para suporte parcial de clones)
- uma [Nerd Font](https://www.nerdfonts.com/) **_(opcional)_**
- um compilador de **C** para `nvim-treesitter`. Mais informações [aqui](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

## 🚀 Como Começar

Podes encontrar uma template **LazyVim** starter para começar, [aqui](https://github.com/LazyVim/starter)

<details><summary>Experimenta com docker</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit fzf curl neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<details><summary>Instala a template <a href="https://github.com/LazyVim/starter">LazyVim Starter</a></summary>

- Faz um backup da tua configuração atual de Neovim:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Clona a template

  ```sh
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ```

- Remove o diretório `.git`, para poderes adicionar ao teu próprio repositório mais tarde

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Inicia o Neovim!

  ```sh
  nvim
  ```

  Consulta os comentários nos ficheiros sobre como customizar **LazyVim**.

</details>

---

Existe um excelente video criado por [@elijahmanor](https://github.com/elijahmanor) com um passo a passo para começar.

[![Vê o video](https://img.youtube.com/vi/N93cTbtLCIM/hqdefault.jpg)](https://www.youtube.com/watch?v=N93cTbtLCIM)

## 📂 Extrutura de ficheiros

Os ficheiros no diretório **config** serão carregados automaticamente
no momento apropriado, por isso não é necessário carregar os plugins manualmente.
**LazyVim** vem com um conjunto de ficheiros
que serão carregados **_antes_** dos teus. Lẽ mais [aqui](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)

Tu podes acrescentar a tua configuração em `lua/plugins`. Todos os ficheiros
neste diretório serão carregados automaticamente por [lazy.nvim](https://github.com/folke/lazy.nvim)

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

## ⚙️ Configuração

Consulta a [documentação](https://lazyvim.github.io)
