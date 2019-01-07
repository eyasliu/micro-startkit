package main

import (
	log "github.com/micro/go-log"

	"api/user/client"
	"api/user/handler"

	micro "github.com/micro/go-micro"

	example "api/user/proto/example"
)

func main() {
	// New Service
	service := micro.NewService(
		micro.Name("eyasliu.api.user"),
		micro.Version("latest"),
	)

	// Initialise service
	service.Init(
		// create wrap for the Example srv client
		micro.WrapHandler(client.ExampleWrapper(service)),
	)

	// Register Handler
	example.RegisterExampleHandler(service.Server(), new(handler.Example))

	// Run service
	if err := service.Run(); err != nil {
		log.Fatal(err)
	}
}
