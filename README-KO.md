<div align="center">
  <img src="https://user-images.githubusercontent.com/292349/213446185-2db63fd5-8c84-459c-9f04-e286382d6e80.png">
</div>

<hr>

<h4 align="center">
  <a href="https://lazyvim.github.io/installation">설치하기</a>
  ·
  <a href="https://lazyvim.github.io/configuration">설정하기</a>
  ·
  <a href="https://lazyvim.github.io">문서</a>
</h4>

<div align="center"><p>
    <a href="https://github.com/LazyVim/LazyVim/releases/latest">
      <img alt="최신 업데이트" src="https://img.shields.io/github/v/release/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41&include_prerelease&sort=semver" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/pulse">
      <img alt="마지막 커밋" src="https://img.shields.io/github/last-commit/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/LazyVim/LazyVim/blob/main/LICENSE">
      <img alt="라이센스" src="https://img.shields.io/github/license/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/stargazers">
      <img alt="스타" src="https://img.shields.io/github/stars/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/issues">
      <img alt="이슈" src="https://img.shields.io/github/issues/LazyVim/LazyVim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim">
      <img alt="레파지토리 크기" src="https://img.shields.io/github/repo-size/LazyVim/LazyVim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://twitter.com/intent/follow?screen_name=folke">
      <img alt="트위터" src="https://img.shields.io/twitter/follow/folke?style=for-the-badge&logo=twitter&color=8aadf3&logoColor=D9E0EE&labelColor=302D41" />
    </a>
</div>

LazyVim은 [💤 lazy.nvim](https://github.com/folke/lazy.nvim)를 기반으로 작동하는 Neovim 셋업입니다. 더 커스터마이징 가능하고, 설정들을 바꾸는 것을 쉽게 만들기위해 시작되었죠. 그저 처음부터 모든 설정들을 만지고 시작하는 방법, 또는 이미 만들어진 배포용 설정을 사용하는 방법이 있지만, LazyVIM은 이미 잘 설정된 환경과, 필요에 따라 쉽게 바꿀 수 있는 유연성을 모두 포괄합니다. 이를 통해 훨신 쉽고 편리한, 전에는 만나보실 수 없었던 새로운 Nvim의 세계를 경험하실 수 있으실 겁니다.

![image](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

![image](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

## ✨ 기능

- 🔥 Neovim을 완벽한 IDE로 바꾸어보세요.
- 💤 lazy.vim과 함께 쉽게 커스터마이징하고, 확장하세요.
- 🚀 완전히 빠른 속도를 경험해보세요.
- 🧹 기본적으로 만져져있는 옵션, 자동커멘드, 그리고 단축키들을 아무런 추가적인 설정없이 사용해보세요.
- 📦 안정적이고 미리 설정되어져있는 플러그인들과 함게 코딩하세요.

## ⚡️ 요구사항

- **0.11.2**이상의 Neovim (LuaJIT과 함께 개발이 되어져있어야함니다.)
- **2.19.0**이상의 Git (이것은 부분적인 클론기능을 지원하기 위함입니다.)
- [Nerd Font](https://www.nerdfonts.com/) **_(옵션)_**
- `nvim-treesitter`를 위한 **C** 컴파일러. [이 문서](https://github.com/nvim-treesitter/nvim-treesitter#requirements)를 확인해주시기바랍니다.

## 🚀 시작하기

[이 깃헙 레파지토리](https://github.com/LazyVim/starter)에서 스타터 템플릿을 찾으실 수 있습니다.

<details><summary>도커와 함께 시작해보기</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit fzf curl neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<details><summary><a href="https://github.com/LazyVim/starter">LazyVim 스타터</a>와 함께 시작해보기</summary>

- 현재 Neovim 파일들을 미리 백업:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Lazyvim 스타터 깃헙 레파지토리 복제:

  ```sh
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ```

- 나중에 본인의 레파지토리에 저장할 경우를 대비해 .git 폴더 지우기

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Neovim!

  ```sh
  nvim
  ```

  LazyVim를 커스터마이징 하는 법에 대해 다룬 설명을 참조해주시기 바랍니다.

</details>

---

유튜브에 LazyVim시작하기에 대해 [@elijahmanor](https://github.com/elijahmanor)에 의해 만들어진 영상이 있으니, 시청해 보시는 것을 추천드립니다.

[![Watch the video](https://img.youtube.com/vi/N93cTbtLCIM/hqdefault.jpg)](https://www.youtube.com/watch?v=N93cTbtLCIM)

## 📂 파일 구조

config 폴더 안에 있는 모든 파일들은 적절한 시간내에 자동으로 로드가 되기에, 아무 파일도 require를 하지 않아도 됩니다. **LazyVim**은 config폴더 안에 있는 모든 기본 파일들을 당신의 config 파일들 **전**에 불어옵니다. 이것에 대해서는, [이 문서](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)를 확인해 보시기 바랍니다.

추가적인 플러그인을 설치하시거나, 미리 설치되고 설정된 플러그인들을 또 덮어서 설정을 바꾸거나, 지우거나, 추가하고 싶으실 경우에는, 그에 해당하는 lua 파일들을 `lua/plugins` 폴더 안에 추가하시면, lazy.nvim이 자동적으로 그 파일들을 로드 할 것입니다.

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

## ⚙️ 설정

[Lazyvim 공식문서](https://lazyvim.github.io)를 확인해 주시기 바랍니다.

LazyVim 공식문서의 한국어 지원은 현재 번역 중에 있습니다.
