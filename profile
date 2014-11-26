export PLAN9=/usr/local/plan9

export BROWSER=firefox

# Variables for rc(1).
export home=$HOME
export prompt="$"
export user=$USER

# Plumb files instead of starting new editor.
export EDITOR=E
unset FCEDIT VISUAL

# Get rid of backspace characters in Unix man output.
export PAGER=nobs

export font=$HOME/plan9/fonts/anonpro/anonpro.11.font

export PATH=$PATH:$PLAN9/bin

pgrep factotum || {
	export DISPLAY=:0
	factotum
	until keys=$(aescbc -d < $HOME/lib/fact.keys); do
		:
	done
	echo "$keys" |while read key; do echo $key |9p write factotum/ctl; done
	unset DISPLAY
}
