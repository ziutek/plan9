#!/bin/sh
kvm -ctrl-grab -cpu host -net nic -net user,hostfwd=tcp:127.0.0.1:2567-:567,hostfwd=tcp:127.0.0.1:17010-:17010 -drive file=plan9.raw.img,media=disk,index=0,cache=writeback
