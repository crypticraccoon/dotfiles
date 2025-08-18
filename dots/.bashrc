# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Source

source /usr/share/bash-completion/completions/dkms 
source /usr/share/git/git-prompt.sh
source ${HOME}/.alias
#============================================
#		Env Variables
#============================================
export ELECTRON_OZONE_PLATFORM_HINT=auto 
export ELECTRON_USE_ANGLE=vulkan
export ELECTRON_ENABLE_FEATURES=Vulkan

export CHROME_EXECUTABLE=/bin/chromium
export _JAVA_AWT_WM_NONREPARENTING=1
export ANDROID_HOME=${HOME}/Android/Sdk
export NDK_HOME=${HOME}/Android/Sdk/ndk/27.0.12077973

export LESS='-R --use-color -Dd+r$Du+b'
export EDITOR=/usr/bin/nvim
export FZF_DEFAULT_OPTS="
 --exact
 --border sharp
 --margin=1
 --height=25
 --color='16,fg:1,preview-fg:4,border:1'
 --preview '([[ -f {} ]] && (cat -n {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
"

export FZF_DEFAULT_COMMAND='fd 
	 --type f 
	 --hidden 
	 --follow 
	 --exclude .password-store  
	 --exclude .git 
	 --exclude .gitignore 
	 --exclude node_modules 
	 --exclude .npm
	 '

#============================================
#		Paths
#============================================
PATH="${PATH}:${HOME}/.local/bin/"
PATH="${PATH}:${HOME}/.cargo/bin/"


PATH=$PATH:/usr/local/go/bin
PATH="$PATH:${HOME}/personal/programs/flutter/bin"
PATH="$PATH:${HOME}/Android/Sdk/tools/bin"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
bind -x '"\C-t":`__fzf_cd__`'

#============================================
#		PS1
#============================================
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d ' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		color=1
		NC="\[\e[m\]]"
		echo -n " "
		for i in $(echo $BRANCH | sed -e 's/\(.\)/\1\n/g'); do
			color=$((color-1))
			branch="\033[01;38;5;${color}m${i}"
			echo -en "${branch}"
		done
		STAT=`parse_git_dirty`
		echo -n "${STAT}"
	else
		echo ""
	fi
}


# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "$status" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "$status" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "$status" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "$status" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "$status" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "$status" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''

	if [ "$renamed" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "$ahead" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "$newfile" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "$untracked" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "$deleted" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "$dirty" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "$bits" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}
function docker_context {
	 if [[ ! -f /bin/docker ]]; then 
			echo "docker missing"
	 else
			echo "\$(docker context ls | awk '/*/{print \$1}')"
	 fi
}

directory="\w"
git="\[\e[31m\]\`parse_git_branch\`\[\e[m\]"
prompt="\[\033[01;38;5;8m\]>\[\033[01;38;5;9m\]>\[\033[01;38;5;10m\]> \[\033[01;38;5;15m\]"

PS1="\n\[[\033[01;38;5;014m\]󰘧\e[0m] $directory$git $(docker_context)  \n$prompt"

