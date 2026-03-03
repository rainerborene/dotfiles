function fish_prompt
  set -l last_status $status

  # 1. Success/Failure Arrow
  if test $last_status -eq 0
    set_color -o green
    printf "➜ "
  else
    set_color -o red
    printf "➜ "
  end

  # 2. Current Directory (cyan)
  set_color cyan
  # 'prompt_pwd' shows the path; 'basename' keeps just the current folder like Zsh's %c
  printf "%s" (basename (prompt_pwd))
  set_color normal

  # 3. Git Status (The Zsh-style mimic)
  # Check if we are in a git repo manually
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1
    # Prefix: git:( in blue, followed by branch in red
    set_color -o blue
    printf " git:("
    set_color red
    printf "%s" (git branch --show-current)
    set_color -o blue
    printf ")"

    # Dirty Check: yellow ✗
    if not git diff --quiet 2>/dev/null
      set_color yellow
      printf " ×"
    end
    set_color normal
  end

  printf " "
end
