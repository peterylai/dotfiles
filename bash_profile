# =================
# Path
# =================

PATH=$HOME/bin:$PATH

# Load RVM into a shell session *as a function*
if which rvm > /dev/null; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

# Load rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

export PGHOST=localhost

# =================
# Aliases
# =================
alias ls='ls -G'
alias ll='ls -al'
alias b='cd ..'
alias subl='open -a "Sublime Text"'
export EDITOR="sublime -w"

# =================
# Bash Prompt
# =================

# --------------------
# Colors for the prompt
# --------------------
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
       CYAN="\[\033[0;36m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
      RESET="\[\033[0m\]"

# -----------------
# For the prompt
# -----------------

# Long git to show + ? !
is_git_repo() {
    $(git rev-parse --is-inside-work-tree &> /dev/null)
}
is_git_dir() {
    $(git rev-parse --is-inside-git-dir 2> /dev/null)
}
is_dotfiles_and_not_home() {
    ([ `pwd` != "$HOME" ] && [ `git rev-parse --git-dir` = "$HOME/.git" ])
}
get_git_branch() {
    local branch_name
    # Get the short symbolic ref
    branch_name=$(git symbolic-ref --quiet --short HEAD 2> /dev/null) ||
    # If HEAD isn't a symbolic ref, get the short SHA
    branch_name=$(git rev-parse --short HEAD 2> /dev/null) ||
    # Otherwise, just give up
    branch_name="(unknown)"
    printf $branch_name
}
# Git status information
prompt_git() {
    local git_info git_state uc us ut st
    if ( !(is_git_repo || is_git_dir) || (is_dotfiles_and_not_home) ); then
        return 1
    fi
    git_info=$(get_git_branch)
    # Check for uncommitted changes in the index
    if ! $(git diff --quiet --ignore-submodules --cached); then
        uc="+"
    fi
    # Check for unstaged changes
    if ! $(git diff-files --quiet --ignore-submodules --); then
        us="!"
    fi
    # Check for untracked files
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        ut="?"
    fi
    # Check for stashed files
    if $(git rev-parse --verify refs/stash &>/dev/null); then
        st="$"
    fi
    git_state=$uc$us$ut$st
    # Combine the branch name and state information
    if [[ $git_state ]]; then
        git_info="$git_info${RESET}[${RED}$git_state${RESET}]"
    fi
    printf "${WHITE}${style_branch}${git_info}"
}

#----------------------
# Style the prompt
# ---------------------
style_user="${RESET}${BLUE}"
style_path="${RESET}${CYAN}"
style_chars="${RESET}${WHITE}"
style_branch="${RESET}${GREEN}"
my_prompt_icon="♬"

# ---------------------
# Build the prompt
# ---------------------
PROMPT_COMMAND='PS1="${style_user}${my_prompt_icon}\[ \] ${style_path}\w ${RESET}$(prompt_git) ${RESET}"'