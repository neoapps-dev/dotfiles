set -x PATH "/home/neo/yasu/target/release/:/home/neo/development/flutter/bin:/usr/lib/jvm/java-21-openjdk/bin:/home/neo/.local/bin:/home/neo/.local/share/soar/bin:$PATH:/home/neo/.cargo/bin"
if status is-interactive
    # Commands to run in interactive sessions can go here
		set fish_greeting
		echo "[ ] cd Architect && complete ."
    echo "[ ] cd ignite && complete ."
    echo "[ ] cd audiod && complete ."
		alias vim=nvim
end

# pnpm
set -gx PNPM_HOME "/home/neo/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -gx EDITOR "nvim"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" eval set --global --export HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
set --global --export HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
set --global --export HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
fish_add_path --global --move --path "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin";
if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
if not contains "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; set --global --export INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; end;

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
set -x PATH "/usr/bin:$PATH:/uni/bin"
