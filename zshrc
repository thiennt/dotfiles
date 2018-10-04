# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [[ -f $config && ${config:e} != "zwc" ]]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

plugins=(git rails vi-mode zsh-autosuggestions web-search)

ZSH_THEME="robbyrussell"
alias cl=clear
alias v=vim
alias vi=vim
alias mux=tmuxinator

export EDITOR='vim'
export PATH="$PATH:/usr/local/Cellar/qt55/5.5.1/bin"
export LDFLAGS="-L/usr/local/Cellar/qt55/5.5.1/lib"
export CPPFLAGS="-I/usr/local/Cellar/qt5/5.5.1/include"

export PATH="$HOME/.bin:$PATH"
eval "$(rbenv init -)"
export PATH="/usr/local/opt/openssl/bin:$PATH"

MYSQL=/usr/local/mysql/bin
export PATH=$PATH:$MYSQL
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

SUBL=/Applications/Sublime\ Text.app/Contents/SharedSupport/bin
export PATH=$PATH:$SUBL

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="/usr/local/opt/elasticsearch@2.4/bin:$PATH"