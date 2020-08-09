<!--
*** Helper for setting up a common S/W development environment
-->

<!-- PROJECT SHIELDS -->
<!-- [![Contributors][contributors-shield]][contributors-url]
	[![Forks][forks-shield]][forks-url]
	[![Stargazers][stars-shield]][stars-url]
	[![Issues][issues-shield]][issues-url]
	[![LinkedIn][linkedin-shield]][linkedin-url] -->
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br>

<p align="center">
  <a href="https://github.com/lithium81/common_configs">
    <img src="images/azmodan.png" alt="Logo" width="512" height="256">
  </a>

  <h3 align="center">공통 개발 환경 구축</h3>

  <p align="center">
    zsh, oh-my-zsh, vim, tmux, fzf, ripgrep, ctags, cscope 등을 활용한 CLI 기본 개발 환경 구축 
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)


<!-- GETTING STARTED -->
## Getting Started

이 문서는 CLI 환경에서 좀 더 효율적으로 작업을 수행할 수 있도록 여러 검증된 유틸리티들을 설치/설정하는 과정들을 설명한다. 단, 이 문서는 가이드라인을 제시할 뿐, 실제 설치나 셋팅 과정에서 만나는 여러 오류 상황들은 각자가 해결해야 한다는 것을 주지하기 바란다.



### Prerequisites

이 문서는 Debian 혹은 Debian 계통의 리눅스 배포판(e.g., Ubuntu)을 사용할 것을 가정하고 작성되었다. 일부 유틸리티의 설치는 apt 또는 apt-get 명령어를 활용하여 이루어진다.

```apt
$ sudo apt-get update
```



### Installation

1. 각종 유틸리티 다운을 위한 임시 디렉토리를 하나 만든다. 이 문서에서는 tmp라고 가정하겠다. 앞으로의 이루어지는 대부분의 과정은 tmp에서 이루어진다.
```sh
$ cd ~
$ mkdir tmp
$ cd tmp
```



2. zsh, vim, tmux는 apt를 이용하여 설치해준다. curl이 없다면 curl도 설치해주도록 하자.
```sh
$ sudo apt-get install zsh vim tmux curl
```



3. vim을 소스 코드 분석 등 개발 작업에도 유용하게 쓸 수 있도록 하려면 몇 가지 플러그인 설치가 필수다. 그런 플러그인에는 Nerdtree, Taglist, SrcExpl 등 여러가지가 있는데 이들을 제대로 쓰기 위해서는 ctags와 cscope이 필요하다(최소 ctags는 필요하다)
```sh
$ sudo apt-get install exuberant-ctags cscope
```



4. 이 repository에서 미리 작성된 zsh용 설정파일, vim용 설정파일, tmux용 설정파일들을 다운받는다.
```sh
$ git clone https://github.com/lithium81/common_configs.git
```



5. (백업이 필요하면 미리 백업해두길 바람) 기본 설정파일 3개를 홈 디렉토리의 실제 설정파일들로 복사해준다. 
```sh
$ cp common_configs/_zshrc ~/.zshrc
$ cp common_configs/_vimrc ~/.vimrc
$ cp common_configs/_tmux.conf ~/.tmux.conf
```



6. 기본 shell을 zsh으로 변경해준다.
```sh
$ chsh -s $(which zsh)
```



7. oh-my-zsh을 설치해준다.
```sh
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```


8. 본 가이드라인이 사용하고 있는 zsh테마는 agnoster이다. agnoster 테마는 git 관련 파일 (e.g., <b>.</b>git/ 등)이 디렉토리 내에 존재하면 현재 작업 중인 branch와 상태를 프롬프트에 꾸며주는 기능도 갖고 있는데 이 경우 powerline 폰트가 시스템에 없으면 프롬프트가 깨져 보일 수 있다. 따라서 powerline 폰트를 설치해주도록 한다.
```sh
$ git clone https://github.com/powerline/fonts.git
$ fonts/install.sh
```


9. zsh의 유용한 플러그인 중 하나인 autojump는 별도의 파일들이 시스템에 설치되어야 동작한다. autojump를 다음과 같이 설치해준다.
```sh
$ git clone git://github.com/wting/autojump.git
$ autojump/install.py
```

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
```sh
git clone https://github.com/your_username_/Project-Name.git
```
3. Install NPM packages
```sh
npm install
```
4. Enter your API in `config.js`
```JS
const API_KEY = 'ENTER YOUR API';
```



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/othneildrew/Best-README-Template/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Img Shields](https://shields.io)
* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Pages](https://pages.github.com)
* [Animate.css](https://daneden.github.io/animate.css)
* [Loaders.css](https://connoratherton.com/loaders)
* [Slick Carousel](https://kenwheeler.github.io/slick)
* [Smooth Scroll](https://github.com/cferdinandi/smooth-scroll)
* [Sticky Kit](http://leafo.net/sticky-kit)
* [JVectorMap](http://jvectormap.com)
* [Font Awesome](https://fontawesome.com)





<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=flat-square
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=flat-square
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=flat-square
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=flat-square
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=flat-square
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/screenshot.png



# common_configs

$ sudo apt-get update


# ~/workspace 디렉토리에서 진행 (이름은 자기 원하는대로 아무거나)
$ mkdir -p ~/workspace
$ cd ~/workspace


# zsh, vim, tmux 설치 (curl 없으면 curl 설치)
$ sudo apt-get install zsh vim tmux curl


# vim용 plugin 동작을 위해 ctags, cscope 설치
$ sudo apt-get install exuberant-ctags, cscope


# git clone common_configs
$ git clone https://github.com/lithium81/common_configs.git
$ cp common_configs/_zshrc ~/.zshrc
$ cp common_configs/_vimrc ~/.vimrc
$ cp common_configs/_tmux.conf ~/.tmux.conf


# 기본 shell을 zsh으로 변경, sudo용 암호 입력 필요
$ chsh -s $(which zsh)


# oh-my-zsh 설치
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# powerline 폰트 설치 (zsh agnoster 테마에서 폰트 깨짐 방지)
$ git clone https://github.com/powerline/fonts.git
$ cd fonts
$ ./install.sh


# autojump 설치
$ git clone git://github.com/wting/autojump.git
$ cd autojump
$ ./install.py


# FZF 설치
$ git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf


# zplug 설치
$ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh


# bat 설치
$ curl -O https://github.com/sharkdp/bat/releases/download/v0.15.4/bat-musl_0.15.4_amd64.deb
$ sudo dpkg -i bat-musl_0.15.4_amd64.deb


# ripgrep 설치
$ curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
$ sudo dpkg -i ripgrep_11.0.2_amd64.deb



# zsh 시작
$ zsh

NOTE: 플러그인 등 인스톨

NOTE: gnome-terminal 사용 중이라면 기본 설정 -> 프로파일 -> 편집 -> 명령을 다음과 같이 변경해줄 것
 1) 로그인 셸로 명령 실행 체크
 2) 셸 대신에 사용자 지정 명령 실행 체크,  /usr/bin/zsh 입력
 3) 명령이 끝날 때: 터미널 끝내기

NOTE: gnome-terminal 사용 중이라면 터미널 프로파일에서 폰트를 powerline 폰트로 변경해줄 것




# vi 시작

NOTE: ':'키를 눌러 커맨드 모드로 들어가서 PluginInstall을 입력하고 엔터, 플러그인 등 인스톨
:PluginInstall [엔터]


