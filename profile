export PLAN9=/usr/local/plan9

export BROWSER=x-www-browser

# Variables for rc(1).
export home=$HOME
export prompt="$"
export user=$USER

# Plumb files instead of starting new editor.
export EDITOR=E
unset FCEDIT VISUAL

export font=$HOME/plan9/fonts/anonpro/anonpro.11.font

export PATH=$PATH:$PLAN9/bin

pgrep factotum && [ -e $HOME/lib/fact.keys ] || {
	factotum
	until aescbc -d < $HOME/lib/fact.keys; do
		echo "Wrong password for $HOME/lib/fact.keys" >/dev/stderr
	done |while read key; do
		echo $key |9p write factotum/ctl
	done
}
