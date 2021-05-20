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
  * [Packages and Utilities](#packages-and-utilities)
  * [Installation](#installation)
  * [Dot files](#dot-files)
    * [.vimrc](#vimrc)
    * [.tmux.conf](#tmuxconf)
* [Usage](#usage)
* [Contact](#contact)

<!-- GETTING STARTED -->

## Getting Started

이 문서는 CLI 환경에서 좀 더 효율적으로 작업을 수행할 수 있도록 여러 검증된 유틸리티들을 설치/설정하는 과정들을 설명한다. 

비록 Ubuntu 20.04 및 Ubuntu 20.04 Docker Container, WSL2 Ubuntu 20.04에서 정상 동작하는 것을 확인하기는 하였으나, 어디까지나 이 문서는 가이드라인을 제시할 뿐, 실제 설치나 셋팅 과정에서 만나는 여러 오류 상황들은 각자가 해결해야 한다는 것을 주지하기 바란다.
<br/>  

### Prerequisites

이 문서는 Debian 혹은 Debian 계통의 리눅스 배포판(e.g., Ubuntu)을 사용할 것을 가정하고 작성되었다. 일부 필수 명령어나 유틸리티의 설치는 `install.sh`을 통해 내부적으로 apt 또는 apt-get 명령어를 활용하여 이루어진다. 
> `acl`, `build-essential`, `ca-certificates`, `curl`, `git`, `libtool`, `lsb-release`, `make`, `openssl`, `pkg-config`, `sudo`, `unzip`, `vim`, `wget`, `zip` 등이 기본적으로 설치가 된다.

또한, 설치 중에 `Python`, `GO`나 `Rust` 등의 다른 프로그래밍 언어 및 개발 라이브러리가 필요한 경우가 있다. `install.sh`가 정상적으로 실행된다면 필요한 최소한의 패키지들은 알아서 설치가 된다.
> `python3-dev`, `python3-pip`, `virtualenv`, `cargo`, `golang-go` 등이 설치되며, 필요한 의존성 패키지들 역시 apt 또는 apt-get에 의해 같이 설치된다.

<br/>

### Pacakges and Utilities

`common_configs` 내 `install.sh`를 실행할 경우 다음의 패키지 또는 유틸리티들이 기본적으로 설치가 된다.
> `autojump`, `cscope`, `exuberant-ctags`, `fontconfig`, `jq`, `tmux`, `ncdu`, `htop`, `bmon`, `httpie`
<br/>

다음의 패키지들은 인터랙티브하게 `y` 또는 `n`을 입력하여 원하는 패키지만 설치할 수 있다.
> `bat`, `fd`, `fzf`, `ripgrep`, `marker`, `cheat`, `bit`, `exa`, `loop`, `yank`, `nnn`, `tokei`, `bpytop`, `tldr`, `lazydocker`
<br/>

또한, 다음의 개발자용 폰트들이 `~/.local/share/fonts/dev_fonts` 경로에 설치된다.
> [Nerd Font](https://github.com/ryanoasis/nerd-fonts) 프로젝트 중 다음과 같은 일부만 선정하였다.

- AnonymousPro
- BitstreamVeraSansMono
- DejaVuSansMono
- Hack *(추천)*
- Hermit
- IBMPlexMono
- Incosolata, InconsolataGo, InconsolataLGC
- JetBrainsMono
- Meslo
- SourceCodePro
- Terminus
- Ubuntu, UbuntuMono

<br/><br/>  

### Installation

1. 각종 유틸리티 다운을 위한 임시 디렉토리를 하나 만든다. 이 문서에서는 `~/workspace`라고 가정하겠다. 앞으로의 이루어지는 대부분의 과정은 `~` 및 `~/workspace` 이하에서 이루어진다.

**NOTE:** 사실 `install.sh` 파일만 있으면 내부적으로 알아서 이 프로젝트를 `git clone`을 하기 때문에 전체 repo를 받아올 필요는 없으나, 편의상 다음과 같이 진행하도록 한다.
<br/>
```sh
$ cd ~
$ mkdir -p ~/workspace
$ cd ~/workspace
$ git clone http://192.168.112.182/knowledge-base/technicalreport/common_configs.git
```
<br/><br/>  

2. ./install.sh 를 실행하면 인터랙티브하게 설치가 진행된다. 콘솔에 다음과 같은 출력이 나타날 수 있으며, 내용은 사용자의 PC 환경에 따라 다를 수 있다. 내부적으로 `sudo`의 사용이나 `chsh` 명령어 호출 부분에서 계정 암호를 요구하면 입력해주면 된다.

```
$ ./install.sh


0. Check if user is non-root and don't have sudo privilege.


1. Check if your environment is supported.
L:137- Your environement:  Ubuntu 20.04 is supported.


2. Install some fundamental packages.
[sudo] password for rc_devel: {계정 암호 입력}

...
acl build-essential ca-certificates curl git libtool lsb-release make openssl pkg-config sudo unzip vim wget zip 등이 설치된다.
...


3. Install additional packages.

...
autojump cscope exuberant-ctags fontconfig fonts-powerline jq tmux python3-dev python3-pip virtualenv cargo golang-go 등이 설치된다.
...

```
<br/><br/>
4번 과정에서는 Robocare VCS 서버에 대한 계정과 암호 입력이 필요하다.

```
4. Setup common_configs.
 Cloning common_configs from Robocare VCS...
L:87- The given path: /home/rc_devel/tmp-20210519-Cw67fyMzs5
Cloning into 'common_configs'...
Username for 'http://192.168.112.182': {GitLab VCS 계정 입력}
Password for 'http://root@192.168.112.182': {GitLab VCS 계정 암호 입력}
remote: Enumerating objects: 679, done.
remote: Counting objects: 100% (679/679), done.
remote: Compressing objects: 100% (236/236), done.
remote: Total 789 (delta 461), reused 649 (delta 442), pack-reused 110
Receiving objects: 100% (789/789), 95.72 MiB | 14.58 MiB/s, done.
Resolving deltas: 100% (496/496), done.
Updating files: 100% (459/459), done.


5. Install common utilities...

...
ncdu htop bmon httpie 등의 패키지가 설치된다.
...

```
<br/><br/>
5번 과정 중에 여러 유틸리티나 명령어들을 설치할 것인지 스킵할 것인지 인터랙티브하게 진행된다. 입력은 대소문자 구분 없이 `y` 또는 `n`만 가능하며, `yes`, `no` 등은 허용하지 않는다.

일부 유틸리티(e.g., `fzf`, `bit` 등)은 설치 중에 자신만의 인터랙티브한 설정을 물어보는 경우가 있으니, 콘솔 출력을 잘 읽어보고 본인의 기호에 맞도록 `y` 또는 `n`을 입력해주면 된다.

```
 Do you want to install <bat>? y

 Install <bat>...

...
```
<br/><br/>
6번 과정 중에 여러 개발자용 폰트들이 설치가 된다. 설치 위치는 `~/.local/share/fonts/dev_fonts`이며, 원하지 않는 폰트가 있다면 `install.sh` 과정이 다 끝난 후 해당 폴더에 가서 삭제해주고 `fc-cache -fv` 명령을 주도록 한다.

```
6. Install several useful fonts for S/W development...
L:87- The given path: /home/rc_devel/.local/share/fonts/dev_fonts
/usr/share/fonts: caching, new cache contents: 0 fonts, 2 dirs
/usr/share/fonts/opentype: caching, new cache contents: 1 fonts, 0 dirs
/usr/share/fonts/truetype: caching, new cache contents: 0 fonts, 1 dirs
/usr/share/fonts/truetype/dejavu: caching, new cache contents: 6 fonts, 0 dirs
/usr/local/share/fonts: caching, new cache contents: 0 fonts, 0 dirs
/home/rc_devel/.local/share/fonts: caching, new cache contents: 0 fonts, 1 dirs
/home/rc_devel/.local/share/fonts/dev_fonts: caching, new cache contents: 0 fonts, 15 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/AnonymousPro: caching, new cache contents: 4 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/BitstreamVeraSansMono: caching, new cache contents: 16 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/DejaVuSansMono: caching, new cache contents: 16 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/Hack: caching, new cache contents: 16 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/Hermit: caching, new cache contents: 12 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/IBMPlexMono: caching, new cache contents: 64 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/Inconsolata: caching, new cache contents: 20 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/InconsolataGo: caching, new cache contents: 8 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/InconsolataLGC: caching, new cache contents: 16 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/JetBrainsMono: caching, new cache contents: 48 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/Meslo: caching, new cache contents: 96 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/SourceCodePro: caching, new cache contents: 56 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/Terminus: caching, new cache contents: 16 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/Ubuntu: caching, new cache contents: 36 fonts, 0 dirs
/home/rc_devel/.local/share/fonts/dev_fonts/UbuntuMono: caching, new cache contents: 16 fonts, 0 dirs
/home/rc_devel/.fonts: skipping, no such directory
/usr/share/fonts/opentype: skipping, looped directory detected
/usr/share/fonts/truetype: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts: skipping, looped directory detected
/usr/share/fonts/truetype/dejavu: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/AnonymousPro: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/BitstreamVeraSansMono: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/DejaVuSansMono: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/Hack: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/Hermit: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/IBMPlexMono: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/Inconsolata: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/InconsolataGo: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/InconsolataLGC: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/JetBrainsMono: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/Meslo: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/SourceCodePro: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/Terminus: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/Ubuntu: skipping, looped directory detected
/home/rc_devel/.local/share/fonts/dev_fonts/UbuntuMono: skipping, looped directory detected
/var/cache/fontconfig: not cleaning unwritable cache directory
/home/rc_devel/.cache/fontconfig: cleaning cache directory
/home/rc_devel/.fontconfig: not cleaning non-existent cache directory
fc-cache: succeeded
```
<br/><br/>
7번 과정에서는 BASH를 기본 쉘로 설치할 것인지, ZSH를 기본 쉘로 설치할 것인지 선택에 따라 다른 패키지가 설치된다. 본 가이드에서는 ZSH을 기본 선택했다고 가정한다. ZSH을 선택했을 경우 [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) 및 [powerlevel10k](https://github.com/romkatv/powerlevel10k) 플러그인, [zplug](https://github.com/zplug/zplug)가 기본적으로 설치가 된다.

**NOTE:** 여기서 말하는 Bash는 Debian이나 Ubuntu가 기본으로 제공하는 Bash가 아니라, ZSH에서 [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)와 유사한 역할을 하는 [bash-it](https://github.com/Bash-it/bash-it) 및 관련한 플러그인들을 설치한다.

**NOTE:** 2021.05.20. Bash쪽은 아직 작업이 충분히 이뤄지지 않아 bash-it 설치 외에 다른 플러그인 설치는 하나도 되지 않는다. 플러그인 설치 및 기본적인 튜닝을 원하는 사용자는 직접 작업하기 바람.
<br/><br/>

```
7. Install shell...
1) BASH
2) ZSH
3) Quit
Please enter your shell choice:  2  <- 로봇이 아니라 개발자 PC이면 가급적 ZSH을 권한다.
Reading package lists... Done
Building dependency tree
Reading state information... Done
zsh is already the newest version (5.8-3ubuntu1).
0 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.
--batch: zsh will not be started after installation
Cloning Oh My Zsh...
Cloning into '/home/rc_devel/.oh-my-zsh'...
remote: Enumerating objects: 1210, done.
remote: Counting objects: 100% (1210/1210), done.
remote: Compressing objects: 100% (1175/1175), done.
remote: Total 1210 (delta 20), reused 1096 (delta 15), pack-reused 0
Receiving objects: 100% (1210/1210), 843.85 KiB | 1.63 MiB/s, done.
Resolving deltas: 100% (20/20), done.
Looking for an existing zsh config...
Found ~/.zshrc. Backing up to ~/.zshrc.pre-oh-my-zsh
Using the Oh My Zsh template file and adding it to ~/.zshrc
Time to change your default shell to zsh!
Password: {계정 암호 입력}

         __                                     __
  ____  / /_     ____ ___  __  __   ____  _____/ /_
 / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \
/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / /
\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/
                        /____/                       ....is now installed!


Please look over the ~/.zshrc file to select plugins, themes, and options.

p.s. Follow us at https://twitter.com/ohmyzsh.

p.p.s. Get stickers and t-shirts at https://shop.planetargon.com.



Update your default shell...
Password: {계정 암호 입력}
Cloning into '/home/rc_devel/.oh-my-zsh/custom/themes/powerlevel10k'...
remote: Enumerating objects: 92, done.
remote: Counting objects: 100% (92/92), done.
remote: Compressing objects: 100% (78/78), done.
remote: Total 92 (delta 16), reused 59 (delta 10), pack-reused 0
Unpacking objects: 100% (92/92), 351.81 KiB | 1.04 MiB/s, done.
 L:87- The given path: /home/rc_devel

```
<br/><br/>

3. 상기 설치 과정이 끝나면 [powerlevel10k](https://github.com/romkatv/powerlevel10k) 플러그인이 제공하는 별도의 인터랙티브 과정이 연이어 제공된다.

**NOTE:** 사용자의 PC환경이나 폰트에 따라 설정은 달라질 수 있다. 나중에 `p10k configure` 명령어를 통해 다시 본인의 기호에 맞게 설정할 수 있으니 한 번에 원하는 설정이 안 나온다고 해서 시간을 너무 쓰지 않아도 된다.

```
    This is Powerlevel10k configuration wizard. It will ask you a few questions and
                                 configure your prompt.

                    Does this look like a diamond (rotated square)?
                      reference: https://graphemica.com/%E2%97%86

                                     --->    <---

(y)  Yes.

(n)  No.

(q)  Quit and do nothing.

Choice [ynq]:

```
<br/>

```
New config: ~/.p10k.zsh.
Backup of ~/.zshrc: /tmp/.zshrc.CQmPWeHdOS.

See ~/.zshrc changes:

  diff /tmp/.zshrc.CQmPWeHdOS ~/.zshrc

File feature requests and bug reports at https://github.com/romkatv/powerlevel10k/issues
```
<br/>

4. 여기까지 무사히 진행이 되었다면, 이제 `update_zshrc.sh`을 실행해주도록 한다.

```
~/workspace/common_configs devel ?1 ......................................................................... 17:31:01
> ./update_zshrc.sh
./update_zshrc.sh: line 8: git_current_branch: command not found
./update_zshrc.sh: line 8: git_current_branch: command not found
```
<br/>

이후, 다음과 같이 `exit` 명령을 반복해서 일단 터미널을 껐다가 켠다.

```
> exit


99. Clean up intermediary files and folders...


 ! DONE !


rc_devel@0f40cfd9b1d2> exit

# exit
```
<br/>

5. 다시 터미널을 새로 열면 ZSH으로 변경된 것을 볼 수 있다. 그리고 `update_zshrc.sh`에 의해 설치된 `.zshrc` 설정 파일에 의해 [zplug](https://github.com/zplug/zplug) 설치를 시도한다.

```
/home/rc_devel/.zshrc:source:160: no such file or directory: /home/rc_devel/.zplug/init.zsh
/home/rc_devel/.zshrc:163: command not found: zplug
Install? [y/N]:
```
<br/>

만약 `y` 입력을 했음에도 zplug가 제대로 설치되지 않았다면 다음과 같이 작업하여 수동 설치해주도록 한다.

```
$ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```
<br/>

만약 위 명령으로도 zplug가 설치가 되지 않았다면 다음과 같이 작업하여 수동 설치해주도록 한다.

```
$ export ZPLUG_HOME=${HOME}/.zplug
$ git clone https://github.com/zplug/zplug $ZPLUG_HOME

$ cd ${HOME}/.zplug
$ chmod +x init.zsh
$ ./init.zsh

$ source ~/.zshrc
```
<br/>

자동이든 수동이든 zplug가 설치가 되었다면 `source ~/.zshrc` 명령 수행 때 zplug install 또는 zplug update가 수행된다.

이 때, 종종 터미널이 먹통이 되는 경우가 있는데, 터미널을 강제 종료해주고 새로 연 후 `zplug update` 명령을 주면 문제없이 플러그인들이 설치가 된다.

설치가 되는 ZSH 플러그인은 다음과 같다.
> `autojump`, `zsh-completions`, `docker-aliases`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-history-substring-search`, `command-not-found`, `k`


**NOTE:** 만약 zplug가 plugin을 업데이트하는데 에러나 알 수 없는 경고가 뜬다면 gawk를 설치해주면 해결되는 경우가 있다.
> 참고: https://github.com/zplug/zplug/issues/359#issuecomment-349534715
  

<br/><br/>

### Dot files



#### .vimrc

1. 기존에 이미 생성해둔 `.vimrc` 파일의 백업이 필요하면 미리 백업해둔다.
<br/>

2. `cp common_configs/_vimrc ~/.vimrc`를 실행하여 .vimrc를 덮어써준다. 이 플러그인은 vim을 소스 코드 분석 등 개발 작업에도 유용하게 쓸 수 있도록 몇 가지 플러그인의 설치를 가정한다. `ctags`, `cscope`은 상기 과정에서 이미 설치가 되었을 것이며, vim 튜닝 과정을 통해 `Nerdtree`, `Taglist`, `SrcExpl`와 같은 vim 플러그인을 설치할 것이다.
<br/>

3. vim용 플러그인 [bundle](https://github.com/VundleVim/Vundle.vim)을 설치해준다. 위에 언급한 `Nerdtree`, `Taglist`, `SrcExpl`와 같은 vim 플러그인을 쉽게 설치하고 관리하려면 필수다.
```sh
$ git clone https://github.com/VundleVim/Vundle.vim.git
$ mkdir -p ~/.vim/bundle
$ mv Vundle.vim ~/.vim/bundle
```
<br/>

4. vim을 실행해보면 아직 플러그인 설치가 마저 되어 있지 않다. 다음 명령어를 입력하여 플러그인 설치를 해주도록 한다.
```
:PluginInstall
```
<br/>

5. 사용자의 선호에 맞게 `.vimrc`를 수정해준다.


#### .tmux.conf

1. 기존에 이미 생성해둔 `.tmux.conf` 파일의 백업이 필요하면 미리 백업해둔다.
<br/>

2. `cp common_configs/_tmux.conf ~/.tmux.conf`를 실행하여 .tmux.conf를 덮어써준다.
<br/>

3. 사용자의 선호에 맞게 `.tmux.conf`를 수정해준다.
<br/><br/>


#### TODO
- 각 유틸리티나 커맨드마다 해당 사이트 링크 부여할 것
- 각 유틸리티나 커맨드마다 어떤 용도이며, 어떤 점이 유용한지 간략하게 설명 추가할 것
- 네트워크, 시스템 관리/모니터링 유틸리티 추가할 것
- dotdrop 반영 검토: https://github.com/deadc0de6/dotdrop 
- fzf preview 등 `fzf` 커스터마이징할 것, johngrib 님 dotfiles 참고(https://tinyurl.com/yfhjbhtw)
- git 관련 alias 커스터마이징할 것
- cookiecutter, bump2version 반영 검토
- `bash-it` 인스톨 과정 추가, 플러그인 추가
- `update_zshrc.sh` 스크립트 보완, 버그 출력 이슈 해결
- `update_bashrc.sh` 스크립트 작성 및 보강
- `update_vimrc.sh` 스크립트로 자동화
- `update_tmux.sh` 스크립트로 자동화
- 키보드 단축키 등 사용 설명서 추가
- ctags 파일 생성 및 업데이트하는 스크립트 작성
- cscope 설치, 설정, 레퍼런스 파일 생성 및 업데이트하는 스크립트 작성
<br/><br/>

<!-- USAGE EXAMPLES -->
## Usage

... 2021/05/20, 작업 중...
<br/>

#### TODO

- 키보드 단축키 등 사용 설명서 추가
- bat, fd, fzf, ripgrep, marker, cheat, bit, exa, loop, yank, nnn, tokei, bpytop, tldr, lazydocker 사용법 또는 잘 정리된 링크 레퍼런스 추가
- ctags, cscope 사용법 또는 잘 정리된 링크 레퍼런스 추가
- 참고한 웹 자료들, 링크들 정리
<br/><br/>


<!-- CONTACT -->
## Contact

Jaeha Kim- lithium81@gmail.com

<br/>

Project Link: [https://github.com/lithium81/common_configs](https://github.com/lithium81/common_configs)

<br/><br/>


## Contributors

Moonwon Jung- mw_jung@robocare.co.kr
<br/>
