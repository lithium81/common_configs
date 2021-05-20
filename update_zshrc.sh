#!/usr/bin/env bash

sed -i 's/^ZSH_THEME="robbyrussell"/#ZSH_THEME="robbyrussell"/' ~/.zshrc

sed -i 's/plugins=(git)/plugins=(git fzf)/' ~/.zshrc


cat <<_EOF_ >> ~/.zshrc


# -------------------------------------------
# unaliases and re-alias
# -------------------------------------------
unalias gl  # alias to git pull
alias gl='git log'
unalias gp  # alias to git push
unalias ggpush  # alias to git push origin $(git_current_branch)
alias gpl='git pull'
alias gps='git push origin $(git_current_branch)'


# -------------------------------------------
# aliases
# -------------------------------------------
# ls
#alias l='ls -CF'
#alias la='ls -A'
#alias ll='ls -alF'

# ls alternative: K
alias kk='k -a'
alias ka='k -A'
alias kd='k -d'

# ls alternative: exa
alias l='exa --icons'
alias la='exa --icons -a'
alias ll='exa --icons -alF'
alias lt='exa --icons -T'

# cat alternative: bat
alias cat='bat'  
alias catp='bat --style=plain'

# tmux
alias tl='tmux ls'

# yank
alias yank='yank-cli'


# -------------------------------------------
# zplug
# -------------------------------------------
source ~/.zplug/init.zsh

# plugins
zplug "zplug/zplug", hook-build:'zplug --self-manage'

# https://github.com/wting/autojump
zplug "plugins/autojump",             from:oh-my-zsh, frozen:1

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found
zplug "plugins/command-not-found",    from:oh-my-zsh

# https://github.com/zsh-users
zplug "zsh-users/zsh-completions",              defer:0
zplug "zsh-users/zsh-autosuggestions",          defer:1, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting",      defer:1, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:2, on:"zsh-users/zsh-syntax-highliting"

# https://github.com/webyneter/docker-aliases
zplug "webyneter/docker-aliases",     use:docker-aliases.plugin.zsh

# https://github.com/supercrabtree/k
zplug "supercrabtree/k"

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi
zplug load

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

# ------------------------------------------
# PATH
# -------------------------------------------
PATH="$PATH":${HOME}/bin:${HOME}/.cargo/bin:${HOME}/go/bin:${HOME}/.local/bin:/usr/local/bin

_EOF_

# (optional) for WSL2
if [[ -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ]]; then
cat <<_EOF_ >> ~/.zshrc

# ------------------------------------------
# XWINDOW Setting for WSL 
# ------------------------------------------
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
export LIBGL_ALWAYS_INDIRECT=1

_EOF_

fi

