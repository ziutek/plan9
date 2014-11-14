#!/bin/sh

# Setup mail

pgrep plumber || plumber

pgrep mailfs || 9p read factotum/ctl |grep 'service=imap' |sed -r 's/.*server=([[:alnum:].-]+).*user=([[:alnum:].@_-]+).*/\1 \2/g' |while read server email; do
	mailfs -t -s $email -u $email $server
done
