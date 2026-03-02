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
      <img alt="Último lançamento" src="https://img.shields.io/github/v/release/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41&include_prerelease&sort=semver&label=Vers%C3%A3o%20Atual" /></a>
    <a href="https://github.com/LazyVim/LazyVim/pulse">
      <img alt="Último commit" src="https://img.shields.io/github/last-commit/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41&label=%C3%9Altimo%20Commit"/></a>
    <a href="https://github.com/LazyVim/LazyVim/blob/main/LICENSE">
      <img alt="Licença" src="https://img.shields.io/github/license/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41&label=Licen%C3%A7a" /></a>
    <a href="https://github.com/LazyVim/LazyVim/stargazers">
      <img alt="Estrelas" src="https://img.shields.io/github/stars/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41&label=Estrelas" /></a>
    <a href="https://github.com/LazyVim/LazyVim/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/LazyVim/LazyVim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" /></a>
    <a href="https://github.com/LazyVim/LazyVim">
      <img alt="Tamanho do Repositório" src="https://img.shields.io/github/repo-size/LazyVim/LazyVim?color=%23DDB6F2&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41&label=Tamanho" /></a>
    <a href="https://twitter.com/intent/follow?screen_name=folke">
      <img alt="Siga no Twitter" src="https://img.shields.io/twitter/follow/folke?style=for-the-badge&logo=x&color=8aadf3&logoColor=D9E0EE&labelColor=302D41&label=Siga%20%40Folke" /></a>
</div>

LazyVim é uma configuração do Neovim desenvolvido com [💤 lazy.nvim](https://github.com/folke/lazy.nvim)
que torna fácil customizar e estender a sua configuração.
Em vez de escolher entre começar do zero ou usar
uma distribuição pré-feita, O LazyVim oferece o melhor
dos dois mundos - a flexibilidade de modificar a sua configuração
como necessário, junto com a conveniência de um setup pré-configurado.

![imagem](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

![imagem](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

## ✨ Características

- 🔥 Transforma o seu Neovim em uma IDE completa.
- 💤 Customize e estenda sua configuração facilmente com [lazy.nvim](https://github.com/folke/lazy.nvim)
- 🚀 Super rápido
- 🧹 Configurações comuns para options, autocmds e keymaps
- 📦 Vem com uma variedade de plugins pré-configurados e prontos para usar

## ⚡️ Requisitos

- Neovim >= **0.11.2** (necessário fazer build com **LuaJIT**)
- Git >= **2.19.0** (para suporte parcial de clones)
- uma [Nerd Font](https://www.nerdfonts.com/) **_(opcional)_**
- um compilador de **C** para o `nvim-treesitter`. Veja mais [aqui](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

## 🚀 Como Começar

Encontre uma template iniciante do **LazyVim** para começar, [aqui](https://github.com/LazyVim/starter)

<details><summary>Experimente com o docker</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit fzf curl neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<details><summary>Instale a template <a href="https://github.com/LazyVim/starter">LazyVim Starter</a></summary>

- Faça um backup da sua configuração atual do Neovim:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Clone a template

  ```sh
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ```

- Remova o diretório `.git`, para adicionar seu próprio repositório depois

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Inicie o Neovim!

  ```sh
  nvim
  ```

  Consulte os comentários nos arquivos sobre como customizar o **LazyVim**.

</details>

---

[@dusty-phillips](https://github.com/dusty-phillips) escreveu um ótimo livro chamado
[LazyVim for Ambitious Developers](https://lazyvim-ambitious-devs.phillips.codes)
disponível gratuitamente online.

---

Existe um excelente video criado pelo [@elijahmanor](https://github.com/elijahmanor) com um passo a passo para começar.

[![Veja o video](https://img.youtube.com/vi/N93cTbtLCIM/hqdefault.jpg)](https://www.youtube.com/watch?v=N93cTbtLCIM)

## 📂 Estrutura de arquivos

Os arquivos no diretório **config** serão carregados automaticamente
no momento apropriado, por isso não é necessário requiri-los manualmente.
O **LazyVim** vem com um conjunto de arquivos padrão que serão carregados **_antes_** dos seus.
Veja [aqui](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)

Você pode adicionar suas próprias especificações de plugins em `lua/plugins`. Todos os arquivos
neste diretório serão carregados automaticamente pelo [lazy.nvim](https://github.com/folke/lazy.nvim)

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

Consulte a [documentação](https://lazyvim.github.io)
