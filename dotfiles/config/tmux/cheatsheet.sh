#!/usr/bin/env bash
# Dev-environment cheatsheet: four fixed-width, color-coded columns,
# self-centered inside the popup. Bound to `prefix ?` in tmux.conf.

# UTF-8 locale so ${#str} counts characters (not bytes) — keeps the `·` in
# headers from shifting the column divider.
export LC_ALL="${LC_ALL:-en_US.UTF-8}" LANG="${LANG:-en_US.UTF-8}"

COLW=44                                  # fixed column width (dense, not stretched)
KEYW=14                                  # key field width within a column
NSEP=3                                   # width of " | " divider
NCOLS=4
CONTENTW=$(( NCOLS*COLW + (NCOLS-1)*NSEP ))

W=$(tput cols  2>/dev/null || echo 160)
H=$(tput lines 2>/dev/null || echo 50)

RESET=$'\033[0m'
PINK=$'\033[1;38;2;255;121;198m'
CYAN=$'\033[1;38;2;139;233;253m'
GREEN=$'\033[38;2;80;250;123m'
GRAY=$'\033[38;2;98;114;164m'

# One cell, exactly COLW visible chars (no newline).
cell() {
  local line="$1"
  local t n
  case "$line" in
    '')   printf '%*s' "$COLW" '';                                return;;
    '§'*) t="${line#§}"; n=${#t}; (( n > COLW )) && n=COLW
          printf '%b%s%*s%b' "$PINK" "$t" "$(( COLW - n ))" '' "$RESET"; return;;
    '»'*) t="${line#»}"; n=${#t}; (( n > COLW )) && n=COLW
          printf '%b%s%*s%b' "$GRAY" "$t" "$(( COLW - n ))" '' "$RESET"; return;;
  esac
  local key desc
  if [[ "$line" == *"::"* ]]; then key="${line%%::*}"; desc="${line#*::}"; else desc="$line"; key=""; fi
  key="${key% }"; key="${key# }"; desc="${desc# }"; desc="${desc% }"
  # action/description on the LEFT, shortcut right-aligned (green) within COLW
  local klen=${#key}
  local descroom=$(( COLW - klen - 1 )); (( descroom < 0 )) && descroom=0
  local pdesc; printf -v pdesc '%-*.*s' "$descroom" "$descroom" "$desc"
  printf '%s %b%s%b' "$pdesc" "$GREEN" "$key" "$RESET"
}

C1=$(cat <<'EOF'
§ TMUX · prefix = Ctrl-a
§ Layout / workflow
ide :: IDE (resumes Claude)
AGENT_CMD=claude ide :: fresh Claude
AGENT_CMD=opencode ide :: opencode
prefix ? :: this cheatsheet
prefix Space :: restore IDE layout
prefix r :: reload tmux config
prefix : :: command prompt

§ Panes
prefix | :: split right
prefix - :: split below
prefix h/j/k/l :: focus move
prefix H/J/K/L :: resize (hold)
prefix z :: zoom toggle
prefix x :: close pane
prefix o :: cycle panes
prefix { } :: swap prev / next
prefix ! :: pane to new window
prefix Opt-1..5 :: preset layouts
mouse :: click / drag

§ Windows (tabs)
prefix c :: new window
prefix 1..9 :: go to window N
prefix n/p :: next / prev
prefix , :: rename window
prefix & :: close window

§ Sessions
prefix d :: detach (keeps running)
prefix s :: pick session
prefix $ :: rename session
tmux a :: attach (shell)
tmux ls :: list (shell)
tmux kill-session :: close IDE (kill)

§ Scroll back & copy output
prefix [ :: scroll / copy mode
/ or ? :: search output
v :: start selection
y :: copy to clipboard
q :: exit scroll mode
EOF
)

C2=$(cat <<'EOF'
§ NVIM · edit · leader = Space
§ Survival
:w :q :wq :: save / quit / both
:q! :: quit window, discard
:qa! :: quit ALL, discard
:e! :: reload file, discard
i a o :: insert / append / open
Esc :: back to normal mode
u / Ctrl-r :: undo / redo
. :: repeat last change
Ctrl-Z / fg :: suspend / resume
Space (wait) :: which-key menu

§ Move (cursor)
h j k l :: left / down / up / right
Nk / Nj :: up / down N lines (rel)
w / b :: word fwd / back
0 / $ :: line start / end
gg / G :: top / bottom of file
:N :: go to line N
Ctrl-d / Ctrl-u :: half page dn / up
% :: matching bracket
Ctrl-o / Ctrl-i :: jump back / fwd

§ Copy / paste
v / V :: highlight char / lines
Ctrl-v :: block / column select
ggVG :: select whole file
y :: copy (yank) selection
d / x :: cut / delete selection
p / P :: paste after / before
yy / dd :: copy / cut line
yiw / ciw :: copy / change word
> / < :: indent / outdent (visual)
EOF
)

C3=$(cat <<'EOF'
§ NVIM · find · code · git
§ Search
/ or ? :: search in file
n / N :: next / prev match
* :: word under cursor
:%s/a/b/g :: find & replace all
Space ff :: find files (by name)
Space fg :: grep in project
Space fb :: open buffers
Space fr :: recent files

§ Code (LSP)
gd / gr :: definition / references
gI / gy :: implementation / type
K :: hover docs
Space ca :: code action
Space rn :: rename symbol
Space cf :: format file
[d / ]d :: prev / next diagnostic
Space xx :: list diagnostics
Tab / Ctrl-Space :: complete / open

§ Tree & splits
Space e / o :: toggle / focus tree
Space l :: jump to code editor
Ctrl-w h / l :: tree <-> editor
Ctrl-w v / s :: vsplit / split
Ctrl-w q :: close split

§ Git & diff
Space gd :: diff (AI changes)
Space gh :: file history
Space gg :: lazygit
]c / [c :: next / prev hunk
Space hp :: preview hunk
Space hs / hr :: stage / reset hunk
Space hb :: blame line

§ Bottom terminal
deno test --watch :: unit watch
deno task dev :: dev server
deno task lint :: eslint
deno fmt :: format
» Never 2 dev servers (PGlite)
EOF
)

C4=$(cat <<'EOF'
§ LAZYGIT · open with Space gg
§ Navigate
Tab :: next panel
[ / ] :: prev / next panel
1..5 :: jump to panel
? :: lazygit help
q :: quit lazygit

§ Files: stage & commit
space :: stage / unstage
a :: stage all
Enter :: stage hunks / lines
c :: commit
C :: commit in editor
A :: amend last commit
d :: discard changes
e :: edit file

§ Branch & sync
space :: checkout branch
n :: new branch
P :: push
p :: pull
f :: fast-forward
M / r :: merge / rebase

§ Commits (on a commit)
s :: squash down
f :: fixup into below
r :: reword message
d :: drop commit
p :: pick (in rebase)
z / Z :: undo / redo

§ Stash
s :: stash changes
space :: apply stash
g :: pop stash
d :: drop stash
EOF
)

A1=(); while IFS= read -r ln; do A1+=("$ln"); done <<<"$C1"
A2=(); while IFS= read -r ln; do A2+=("$ln"); done <<<"$C2"
A3=(); while IFS= read -r ln; do A3+=("$ln"); done <<<"$C3"
A4=(); while IFS= read -r ln; do A4+=("$ln"); done <<<"$C4"

rows=${#A1[@]}
(( ${#A2[@]} > rows )) && rows=${#A2[@]}
(( ${#A3[@]} > rows )) && rows=${#A3[@]}
(( ${#A4[@]} > rows )) && rows=${#A4[@]}

# Center the fixed-width block within the popup.
LPAD=$(( (W - CONTENTW) / 2 )); (( LPAD < 0 )) && LPAD=0
TPAD=$(( (H - (rows + 3)) / 2 )); (( TPAD < 0 )) && TPAD=0
margin=$(printf '%*s' "$LPAD" '')

for (( i=0; i<TPAD; i++ )); do printf '\n'; done

if [[ -n "${CHEAT_PIN:-}" ]]; then
  title=' ⌨  Dev Cheatsheet  ·  prefix = Ctrl-a  ·  leader = Space'
else
  title=' ⌨  Dev Cheatsheet  ·  prefix = Ctrl-a  ·  leader = Space  ·  q quits'
fi
tp=$(( (CONTENTW - ${#title}) / 2 )); (( tp < 0 )) && tp=0
printf '%s%*s%b%s%b\n' "$margin" "$tp" '' "$CYAN" "$title" "$RESET"
rule=$(printf '%*s' "$CONTENTW" '' | tr ' ' '─')
printf '%s%b%s%b\n' "$margin" "$GRAY" "$rule" "$RESET"

for (( i=0; i<rows; i++ )); do
  printf '%s' "$margin"
  cell "${A1[i]-}"; printf ' %b│%b ' "$GRAY" "$RESET"
  cell "${A2[i]-}"; printf ' %b│%b ' "$GRAY" "$RESET"
  cell "${A3[i]-}"; printf ' %b│%b ' "$GRAY" "$RESET"
  cell "${A4[i]-}"; printf '\n'
done
