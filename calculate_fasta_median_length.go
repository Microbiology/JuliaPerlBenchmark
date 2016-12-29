package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"sort"
)

func main() {
	if len(os.Args) != 2 {
		fmt.Fprintf(os.Stderr, "usage: %s <FASTAFILE>\n\n", os.Args[0])
		os.Exit(1)
	}

	file := os.Args[1]
	fh, err := os.Open(file)
	if err != nil {
		fmt.Fprintf(os.Stderr, "fail to open file: %s\n", file)
		os.Exit(1)
	}
	defer func() {
		fh.Close()
	}()

	var line string
	length := -1
	lengths := make([]int, 0, 10000) // slice with initial capacity of 10000

	reader := bufio.NewReader(fh)
	for {
		line, err = reader.ReadString('\n')
		if err == io.EOF {
			break
		}
		if line[0] == '>' { // ignore header line
			if length != -1 { // not the first sequence
				lengths = append(lengths, length)
			}
			length = 0
			continue
		}

		if line[len(line)-1] == '\n' { // remove '\n'
			line = line[0 : len(line)-1]
		}
		if line[len(line)-1] == '\r' { // remove '\r'
			line = line[0 : len(line)-1]
		}
		length += len(line)
	}
	if length != -1 { // do not forget the last record
		lengths = append(lengths, length)
	}

	sort.Ints(lengths) // sort
	// fmt.Println(lengths)

	n := len(lengths)
	if n == 0 {
		fmt.Printf("%d\t%s\n", 0, file)
	} else if n%2 == 1 { // odd
		fmt.Printf("%d\t%s\n", lengths[(n-1)/2], file)
	} else { // even
		fmt.Printf("%d\t%s\n", (lengths[(n-1)/2]+lengths[n/2])/2, file)
	}
}
