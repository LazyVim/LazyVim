<div align="center">
  <img src="https://user-images.githubusercontent.com/292349/213446185-2db63fd5-8c84-459c-9f04-e286382d6e80.png">
</div>

<hr>

<h4 align="center">
  <a href="https://lazyvim.github.io/installation">Installazione</a>
  ·
  <a href="https://lazyvim.github.io/configuration">Configurazione</a>
  ·
  <a href="https://lazyvim.github.io">Documentazione</a>
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

LazyVim è una configurazione di Neovim basata su [💤 lazy.nvim](https://github.com/folke/lazy.nvim)
che rende semplice personalizzare ed estendere la tua configurazione.
Piuttosto che dover scegliere tra partire da zero o utilizzare una
distribuzione preconfigurata, LazyVim offre il meglio di entrambi i mondi:
la flessibilità di modificare la tua configurazione come necessario,
insieme alla comodità di un setup preconfigurato.

![image](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

![image](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

## ✨ Caratteristiche

- 🔥 Trasforma il tuo Neovim in un IDE completo
- 💤 Personalizza ed estendi facilmente la tua configurazione con [lazy.nvim](https://github.com/folke/lazy.nvim)
- 🚀 Estremamente veloce
- 🧹 Impostazioni di default ottimizzate per opzioni, AutoCmd e scorciatoie da tastiera
- 📦 Distribuito con una vasta gamma di plugin preconfigurati e pronti all'uso

## ⚡️ Requisiti

- Neovim >= **0.11.2** (deve essere compilato con **LuaJIT**)
- Git >= **2.19.0** (per supportare cloni parziali)
- a [Nerd Font](https://www.nerdfonts.com/) **_(opzionale)_**
- un compilatore **C** per `nvim-treesitter`. Leggi [qui](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

## 🚀 Per iniziare

Puoi trovare un template per **LazyVim** [qui](https://github.com/LazyVim/starter)

<details><summary>Provalo con Docker</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit fzf curl neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<details><summary>Installa il <a href="https://github.com/LazyVim/starter">LazyVim Starter</a></summary>

- Fai un backup dei tuoi file di Neovim attuali:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Clona lo Starter

  ```sh
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ```

- Rimuovi la cartella `.git`, così puoi aggiungerla al tuo repo in seguito

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Avvia Neovim!

  ```sh
  nvim
  ```

  Consulta i commenti nei file su come personalizzare **LazyVim**.

</details>

---

Qui un video creato da [@elijahmanor](https://github.com/elijahmanor) con una guida per iniziare.

[![Guarda il video](https://img.youtube.com/vi/N93cTbtLCIM/hqdefault.jpg)](https://www.youtube.com/watch?v=N93cTbtLCIM)

[@dusty-phillips](https://github.com/dusty-phillips) ha scritto un libro comprensivo chiamato
[LazyVim per Sviluppatori Ambiziosi](https://lazyvim-ambitious-devs.phillips.codes)
che è disponibile gratuitamente online.

## 📂 Struttura dei file

I file presenti nella configurazione verranno caricati automaticamente al momento
più opportuno, quindi non è necessario richiamare manualmente quei file.
**LazyVim** ha un set di configurazioni predefinite che verranno caricate
prima delle tue. Vedi [qui](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)

Puoi aggiungere i tuoi plugin personalizzati sotto `lua/plugins/`. Tutti
i file presenti verranno automaticamente caricati da [lazy.nvim](https://github.com/folke/lazy.nvim)

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

## ⚙️ Configurazione

Consulta la [documentazione](https://lazyvim.github.io)
