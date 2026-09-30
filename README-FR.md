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

LazyVim est une configuration Neovim basée sur [💤 lazy.nvim](https://github.com/folke/lazy.nvim)
facilitant la personnalisation et l'ajout d'extensions.
Plutôt que d'imposer le choix entre partir de rien et utiliser
une distribution toute faite, LazyVim offre le meilleur des deux mondes
: la flexibilité d'une config ajustable selon vos besoins, et le confort
d'une configuration pensée et peaufinée à l'avance.

![image](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

![image](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

## ✨ Fonctionnalités

- 🔥 Transforme Neovim en un environnement de développement complet
- 💤 Customise et étends ta config sans effort grâce à [lazy.nvim](https://github.com/folke/lazy.nvim)
- 🚀 Rapide comme l'éclair !
- 🧹 Configuration par défaut propre et intuitive pour les options, les autocmds, et les keymaps 
- 📦 Livré avec une variété de plugins pre-configurés et prêts à être utilisés

## ⚡️ Pré-requis

- Neovim >= **0.9.0** (doit être compilé avec **LuaJIT**)
- Git >= **2.19.0** (pour supporter le clonage partiel)
- Un [Nerd Font](https://www.nerdfonts.com/) **_(optionel)_**
- Un compileur **C** pour `nvim-treesitter`. Voir [ici](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

## 🚀 Comment commencer

Un template pour **LazyVim** peut être trouvé [ici](https://github.com/LazyVim/starter)

<details><summary>Essayer avec Docker</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit fzf curl neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<details><summary>Installer le <a href="https://github.com/LazyVim/starter">LazyVim Starter</a></summary>

- Sauvegardez votre configuration Neovim :

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Clonez le starter

  ```sh
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ```

- Supprimez le dossier `.git`, afin que vous puissiez l'ajouter à votre repo plus tard

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Lancez Neovim !

  ```sh
  nvim
  ```

  Consultez les commentaires dans les fichiers pour savoir comment personnaliser **LazyVim**.

</details>

---

Il y a une superbe vidéo (en anglais) de [@elijahmanor](https://github.com/elijahmanor)
qui vous guide pas-à-pas pour commencer.

[![Watch the video](https://img.youtube.com/vi/N93cTbtLCIM/hqdefault.jpg)](https://www.youtube.com/watch?v=N93cTbtLCIM)

[@dusty-phillips](https://github.com/dusty-phillips) a écrit un livre exhaustif
sur LazyVim, nommé [LazyVim for Ambitious Developers](https://lazyvim-ambitious-devs.phillips.codes)
disponible gratuitement en ligne.

## 📂 Structure de fichier

Les fichiers dans le dossier config vont être chargés automatiquement en temps voulu,
donc pas besoin de `require` ces fichiers manuellement.
**LazyVim** vient avec un ensemble de fichiers de configuration par défaut qui seront chargés
**_avant_** les vôtres. Voir [ici](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)

Vous pouvez ajouter vos configurations de plugins sous `lua/plugins/`.
Ici, tous les fichiers seront automatiquement chargés par [lazy.nvim](https://github.com/folke/lazy.nvim)

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
└── init.lua
</pre>

## ⚙️ Configuration

Veuillez vous référer à la [documentation](https://lazyvim.github.io)
