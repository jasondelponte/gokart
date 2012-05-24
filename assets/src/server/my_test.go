package main

import (
	"testing"
)

func Test_Add2Plus1(t *testing.T) {
	if 2+1 != 3 {
		t.Error("Adding 2+1 didn't work as expected")
	} else {
		t.Log("2+1 test passed.")
	}
}
