#!/bin/sh

pgrep plumber || $PLAN9/bin/plumber 
pgrep factotum || factotum
aescbc -d < $HOME/lib/fact.keys |while read key; do echo $key |9p write factotum/ctl; done

pgrep mailfs || 9p read factotum/ctl |grep 'service=imap' |sed -r 's/.*server=([[:alnum:].]+).*user=([[:alnum:].@]+).*/\1 \2/g' |while read server email; do
	mailfs -t -s $email -u $email $server
done
