module api/greeter

require (
	github.com/gin-contrib/sse v0.0.0-20170109093832-22d885f9ecc7 // indirect
	github.com/gin-gonic/gin v1.3.0
	github.com/mattn/go-isatty v0.0.4 // indirect
	github.com/micro/go-micro v0.17.0
	github.com/micro/go-web v0.5.2
	golang.org/x/sync v0.0.0-20181221193216-37e7f081c4d4 // indirect
	golang.org/x/sys v0.0.0-20190102155601-82a175fd1598 // indirect
	gopkg.in/go-playground/assert.v1 v1.2.1 // indirect
	gopkg.in/go-playground/validator.v8 v8.18.2 // indirect
	gopkg.in/yaml.v2 v2.2.2 // indirect
)

require (
	github.com/golang/protobuf v1.2.1-0.20181128192352-1d3f30b51784
	labix.org/v2/mgo v0.0.0-20140701140051-000000000287 // indirect
	srv/greeter v0.0.1
)

replace srv/greeter v0.0.1 => ../../srv/greeter

replace api v0.0.1 => ../../api
