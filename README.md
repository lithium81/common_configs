<!--
*** Helper for setting up a common S/W development environment
-->

<!-- PROJECT SHIELDS -->
<!-- [![Contributors][contributors-shield]][contributors-url]
	[![Forks][forks-shield]][forks-url]
	[![Stargazers][stars-shield]][stars-url]
	[![Issues][issues-shield]][issues-url]
	[![LinkedIn][linkedin-shield]][linkedin-url] 
	[![MIT License][license-shield]][license-url]
-->



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
* [Contact](#contact)

<!-- GETTING STARTED -->

## Getting Started

이 문서는 CLI 환경에서 좀 더 효율적으로 작업을 수행할 수 있도록 여러 검증된 유틸리티들을 설치/설정하는 과정들을 설명한다. 단, 이 문서는 가이드라인을 제시할 뿐, 실제 설치나 셋팅 과정에서 만나는 여러 오류 상황들은 각자가 해결해야 한다는 것을 주지하기 바란다.
<br/>  
  
### Prerequisites

이 문서는 Debian 혹은 Debian 계통의 리눅스 배포판(e.g., Ubuntu)을 사용할 것을 가정하고 작성되었다. 일부 유틸리티의 설치는 apt 또는 apt-get 명령어를 활용하여 이루어진다.

```apt
$ sudo apt-get update
```
<br/>  
  
### Installation

1. 각종 유틸리티 다운을 위한 임시 디렉토리를 하나 만든다. 이 문서에서는 tmp라고 가정하겠다. 앞으로의 이루어지는 대부분의 과정은 tmp에서 이루어진다.
```sh
$ cd ~
$ mkdir tmp
$ cd tmp
```
<br/><br/>  
  
2. zsh, vim, tmux는 apt를 이용하여 설치해준다. git, curl이 없다면 같이 설치해주도록 하자.
```sh
$ sudo apt-get install zsh vim tmux git curl
```
<br/><br/>  
  
3. vim을 소스 코드 분석 등 개발 작업에도 유용하게 쓸 수 있도록 하려면 몇 가지 플러그인 설치가 필수다. 그런 플러그인에는 Nerdtree, Taglist, SrcExpl 등 여러가지가 있는데 이들을 제대로 쓰기 위해서는 ctags와 cscope이 필요하다(최소 ctags는 필요하다)
```sh
$ sudo apt-get install exuberant-ctags cscope
```
<br/><br/>  
  
4. 이 repository에서 미리 작성된 zsh용 설정파일, vim용 설정파일, tmux용 설정파일들을 다운받는다.
```sh
$ git clone https://github.com/lithium81/common_configs.git
```
<br/><br/>  
  
5. (백업이 필요하면 미리 백업해두길 바람) 기본 설정파일 3개를 홈 디렉토리의 실제 설정파일들로 복사해준다. 
```sh
$ cp common_configs/_zshrc ~/.zshrc
$ cp common_configs/_vimrc ~/.vimrc
$ cp common_configs/_tmux.conf ~/.tmux.conf
```
<br/><br/>  
  
6. 기본 shell을 zsh으로 변경해준다.
```sh
$ chsh -s $(which zsh)
```
<br/><br/>  
  
7. oh-my-zsh을 설치해준다.
```sh
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
<br/><br/>  
  
8. 본 가이드라인이 사용하고 있는 zsh테마는 agnoster이다. agnoster 테마는 git 관련 파일 (e.g., <b>.</b>git/ 등)이 디렉토리 내에 존재하면 현재 작업 중인 branch와 상태를 프롬프트에 꾸며주는 기능도 갖고 있는데 이 경우 powerline 폰트가 시스템에 없으면 프롬프트가 깨져 보일 수 있다. 따라서 powerline 폰트를 설치해주도록 한다.
```sh
$ git clone https://github.com/powerline/fonts.git
$ fonts/install.sh
```
<br/><br/>  
  
9. zsh의 유용한 플러그인 중 하나인 autojump는 별도의 파일들이 시스템에 설치되어야 동작한다. autojump를 다음과 같이 설치해준다.
```sh
$ git clone git://github.com/wting/autojump.git
$ cd autojump
$ install.py
$ cd ..
```
<br/><br/>  
다음과 비슷한 문구가 화면에 출력될 것이다. 계정 소유자에 따라 /root 대신 다른 디렉토리 경로가 나올 수 있다. 우리는 zplug에 맞춰서 세팅을 해둔 걸 쓸 예정이므로 아래 지시는 무시해도 좋다. 즉, 수동으로 <b>.</b>zshrc 고쳐줄 필요 없다. 

```
Installing autojump to /root/.autojump ...
creating directory: /root/.autojump/bin
creating directory: /root/.autojump/share/man/man1
creating directory: /root/.autojump/etc/profile.d
creating directory: /root/.autojump/share/autojump
copying file: ./bin/autojump -> /root/.autojump/bin
copying file: ./bin/autojump_argparse.py -> /root/.autojump/bin
copying file: ./bin/autojump_data.py -> /root/.autojump/bin
copying file: ./bin/autojump_match.py -> /root/.autojump/bin
copying file: ./bin/autojump_utils.py -> /root/.autojump/bin
copying file: ./bin/icon.png -> /root/.autojump/share/autojump
copying file: ./docs/autojump.1 -> /root/.autojump/share/man/man1
creating directory: /root/.autojump/etc/profile.d
creating directory: /root/.autojump/share/autojump
creating directory: /root/.autojump/functions
copying file: ./bin/autojump.sh -> /root/.autojump/etc/profile.d
copying file: ./bin/autojump.bash -> /root/.autojump/share/autojump
copying file: ./bin/autojump.fish -> /root/.autojump/share/autojump
copying file: ./bin/autojump.zsh -> /root/.autojump/share/autojump
copying file: ./bin/_j -> /root/.autojump/functions

Please manually add the following line(s) to ~/.zshrc:

	[[ -s /root/.autojump/etc/profile.d/autojump.sh ]] && source /root/.autojump/etc/profile.d/autojump.sh

	autoload -U compinit && compinit -u

Please restart terminal(s) before running autojump.
```
<br/>  
  
10. FZF는 매우 강력한 find 기능을 제공해주는 유틸리티이다. 다음과 같이 설치해준다.
```sh
$ git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
```
<br/><br/>  
  
11. zsh도 이제는 플러그인 매니저(패키지 매니저) 같은 게 있어서 일일이 플러그인을 다운 받고 일일이 <b>.</b>zshrc 설정파일을 수정하는 수고가 많이 줄어들었다. 다음과 같이 zplug를 설치해준다.
```sh
$ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```
<br/><br/>  
  
12. bat은 plaintext만 표시하는 것을 대신하여 syntax highlighting이나 git integration와 같은 부가 기능을 제공해주는 cat alternative이다. 다음과 같이 설치해준다. 아래 0.15.4 버전은 글 작성 당시 기준이니 최신의 버전을 설치하기를 원하면 https://github.com/sharkdp/bat/releases/ 에 방문하여 버전을 확인하고 아래 명령어를 적절히 변경해서 사용하라.
```sh
$ curl -O https://github.com/sharkdp/bat/releases/download/v0.15.4/bat-musl_0.15.4_amd64.deb
$ sudo dpkg -i bat-musl_0.15.4_amd64.deb
```
<br/><br/>  
  
13. ripgrep은 grep의 강화판 alternative이다. fzf와 ripgrep의 조합이면 어지간해서는 못 찾는 것이 거의 없다. 자세한 사용법은 별도의 문서에서 다룬다. ripgrep은 다음과 같이 설치해준다. 아래 11.0.2 버전은 글 작성 당시 기준이니 최신의 버전을 설치하기를 원하면 https://github.com/BurntSushi/ripgrep/releases/ 에 방문하여 버전을 확인하고 아래 명령어를 적절히 변경해서 사용하라.
```sh
$ curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
$ sudo dpkg -i ripgrep_11.0.2_amd64.deb
```
<br/><br/>  
  
14. vim용 플러그인 bundle 설치
```sh
$ git clone https://github.com/VundleVim/Vundle.vim.git
$ mkdir -p ~/.vim/bundle
$ mv Vundle.vim ~/.vim/bundle
```
<br/><br/>  
  
15. 현재 작업 중인 터미널을 일단 닫고, 새 터미널 창을 열면 zsh가 기본 shell로 동작하면서 <b>.</b>zshrc를 읽어들이고, 여기의 설정에 따라 zplug가 미설치된 플러그인들은 알아서 다운로드 받아줄 것이다.
<br/><br/>  
  
16. vim을 실행해보면 아직 플러그인 설치가 마저 되어 있지 않다. 다음 명령어를 입력하여 플러그인 설치를 해주도록 한다.
```
:PluginInstall
```
<br/><br/>  
  

<!-- USAGE EXAMPLES -->
## Usage

... 2020/08/09, 작업 중...

### TODO
* FZF 사용법 또는 잘 정리된 링크
* ripgrep 사용법 또는 잘 정리된 링크
* ctags 사용법 또는 잘 정리된 링크
* cscope 사용법 또는 잘 정리된 링크




<!-- CONTACT -->
## Contact

Jaeha Kim- lithium81@gmail.com

Project Link: [https://github.com/lithium81/common_configs](https://github.com/lithium81/common_configs)

