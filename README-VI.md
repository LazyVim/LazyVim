<div align="center">
  <img src="https://user-images.githubusercontent.com/292349/213446185-2db63fd5-8c84-459c-9f04-e286382d6e80.png">
</div>

<hr>

<h4 align="center">
  <a href="https://lazyvim.github.io/installation">Cài đặt</a>
  ·
  <a href="https://lazyvim.github.io/configuration">Cấu hình</a>
  ·
  <a href="https://lazyvim.github.io">Tài liệu</a>
</h4>

<div align="center"><p>
    <a href="https://github.com/LazyVim/LazyVim/releases/latest">
      <img alt="Bản phát hành mới nhất" src="https://img.shields.io/github/v/release/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41&include_prerelease&sort=semver" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/pulse">
      <img alt="Commit gần nhất" src="https://img.shields.io/github/last-commit/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/LazyVim/LazyVim/blob/main/LICENSE">
      <img alt="Giấy phép" src="https://img.shields.io/github/license/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/stargazers">
      <img alt="Số sao" src="https://img.shields.io/github/stars/LazyVim/LazyVim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim/issues">
      <img alt="Các vấn đề" src="https://img.shields.io/github/issues/LazyVim/LazyVim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/LazyVim/LazyVim">
      <img alt="Kích thước repo" src="https://img.shields.io/github/repo-size/LazyVim/LazyVim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://twitter.com/intent/follow?screen_name=folke">
      <img alt="Theo dõi trên Twitter" src="https://img.shields.io/twitter/follow/folke?style=for-the-badge&logo=twitter&color=8aadf3&logoColor=D9E0EE&labelColor=302D41" />
    </a>
</div>

LazyVim là một cấu hình Neovim được vận hành bởi [💤 lazy.nvim](https://github.com/folke/lazy.nvim),
giúp bạn dễ dàng tùy biến và mở rộng thiết lập của mình.
Thay vì phải lựa chọn giữa việc bắt đầu từ đầu hoặc dùng một bản distro dựng sẵn,
LazyVim mang lại ưu điểm của cả hai thế giới: sự linh hoạt để tinh chỉnh cấu hình khi cần,
đồng thời vẫn có sự tiện lợi của một bộ thiết lập đã được cấu hình sẵn.

![image](https://user-images.githubusercontent.com/292349/211285846-0b7bb3bf-0462-4029-b64c-4ee1d037fc1c.png)

![image](https://user-images.githubusercontent.com/292349/213447056-92290767-ea16-430c-8727-ce994c93e9cc.png)

## ✨ Tính năng

- 🔥 Biến Neovim của bạn thành một IDE đầy đủ tính năng
- 💤 Dễ dàng tùy biến và mở rộng cấu hình với [lazy.nvim](https://github.com/folke/lazy.nvim)
- 🚀 Cực kỳ nhanh
- 🧹 Các tùy chọn, lệnh tự động và phím tắt mặc định hợp lý
- 📦 Đi kèm nhiều bộ mở rộng đã được cấu hình sẵn và có thể dùng ngay

## ⚡️ Yêu cầu

- Neovim >= **0.11.2** (bản dựng với **LuaJIT**)
- Git >= **2.19.0** (để hỗ trợ sao chép một phần)
- Một [Nerd Font](https://www.nerdfonts.com/) **_(không bắt buộc)_**
- Trình biên dịch **C** cho `nvim-treesitter`. Xem [tại đây](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

## 🚀 Bắt đầu

Bạn có thể tìm mẫu **LazyVim** dành cho người mới [tại đây](https://github.com/LazyVim/starter)

<details><summary>Thử với Docker</summary>

```sh
docker run -w /root -it --rm alpine:edge sh -uelic '
  apk add git lazygit fzf curl neovim ripgrep alpine-sdk --update
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cd ~/.config/nvim
  nvim
'
```

</details>

<details><summary>Cài đặt <a href="https://github.com/LazyVim/starter">LazyVim Starter</a></summary>

- Sao lưu các tệp cấu hình Neovim hiện tại của bạn:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Sao chép bộ mẫu cho người mới

  ```sh
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  ```

- Xóa thư mục `.git` để sau này bạn có thể thêm vào repo riêng của mình

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Khởi động Neovim!

  ```sh
  nvim
  ```

  Hãy xem các chú thích trong các tệp để biết cách tùy chỉnh **LazyVim**.

</details>

---

[@dusty-phillips](https://github.com/dusty-phillips) đã viết một cuốn sách chuyên sâu có tên
[LazyVim for Ambitious Developers](https://lazyvim-ambitious-devs.phillips.codes),
được phát hành miễn phí trực tuyến.

## 📂 Cấu trúc tệp

Các tệp trong thư mục config sẽ được tự động nạp vào thời điểm phù hợp,
vì vậy bạn không cần require các tệp đó thủ công.
**LazyVim** đi kèm một bộ tệp cấu hình mặc định sẽ được nạp
**_trước_** cấu hình của bạn. Xem [tại đây](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/config)

Bạn có thể thêm các bộ mở rộng tùy chỉnh trong `lua/plugins/`. Tất cả tệp ở đó
sẽ được [lazy.nvim](https://github.com/folke/lazy.nvim) tự động nạp

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

## ⚙️ Cấu hình

Tham khảo [tài liệu](https://lazyvim.github.io)
