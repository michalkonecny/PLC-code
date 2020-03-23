package main

import "fmt"
import "time"

func main() {
	printerMessages := make(chan string)
	go printer(printerMessages)
	go switcher(printerMessages)
	time.Sleep(10*time.Second)
}

func printer(messages chan string) {
	i := 0;
	for {
		select {
			case msg := <- messages:
				if msg == "stop" {
					<- messages
				}
			case <- time.After(time.Second/5):
				fmt.Println(i)
				i ++
		}
	}
}

func switcher(printerMessages chan string) {
	for {
		time.Sleep(time.Second)
		printerMessages <- "stop"
		time.Sleep(time.Second)
		printerMessages <- "start"
	}
}