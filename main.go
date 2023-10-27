package main

import (
	"os"

	"github.com/CCOLLOT/my-app-foo/cmd"
)

func main() {
	if err := cmd.InitAndRunCommand(); err != nil {
		os.Exit(3)
	}
}
