package main

import (
	"fmt"
	"io"
	"os"
	"strings"

	"code.google.com/p/goplan9/plan9"
	"code.google.com/p/goplan9/plan9/client"
)

func die(s string) {
	fmt.Fprintln(os.Stderr, "die:", s)
	os.Exit(1)
}

func checkErr(err error) {
	if err != nil {
		die(err.Error())
	}
}

func main() {
	fsys, err := client.MountService("factotum")
	checkErr(err)
	rpc, err := fsys.Open("rpc", plan9.ORDWR)
	checkErr(err)

	query := "start proto=pass " + strings.Join(os.Args[1:], " ")
	_, err = io.WriteString(rpc, query)
	checkErr(err)

	var buf [80]byte

	n, err := rpc.Read(buf[:])
	checkErr(err)
	if resp := string(buf[:n]); resp != "ok" {
		die(resp)
	}

	_, err = io.WriteString(rpc, "read")
	checkErr(err)

	n, err = rpc.Read(buf[:])
	checkErr(err)

	resp := string(buf[:n])
	rs := strings.SplitN(resp, " ", 3)
	if len(rs) < 3 || rs[0] != "ok" {
		die(resp)
	}
	os.Stdout.WriteString(rs[2] + "\n")
}
