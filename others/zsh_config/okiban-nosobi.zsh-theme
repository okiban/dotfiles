# Made by Okiban Nosobi - based on jispwoso
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT=$'%{$fg[green]%}┌─(%{$fg[blue]%}%n@%m%{$fg[green]%})-[%{$fg[blue]%}%~%{$reset_color%}%{$fg_bold[blue]%}%{$fg_bold[green]%}] %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}%{$fg_bold[green]%}
└─%{$fg_bold[green]%}[%{$fg_bold[yellow]%}%D{%d/%m/%y}%{$reset_color%}%{$fg[green]%}@%{$fg_bold[red]%}%*%{$fg_bold[green]%}]%{$reset_color%} ${ret_status} %{$reset_color%}'

PROMPT2="%{$fg_blod[black]%}%_> %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# print a new line after the command execution
precmd() {
    precmd() {
        echo
    }
}
