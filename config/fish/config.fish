if status is-interactive
# Commands to run in interactive sessions can go here
end

starship init fish | source

/home/frgttn/.local/bin/mise activate fish | source

# pnpm
set -gx PNPM_HOME "/home/frgttn/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/frgttn/.lmstudio/bin
# End of LM Studio CLI section

