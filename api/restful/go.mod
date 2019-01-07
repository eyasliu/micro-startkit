module api/restful

require (
	github.com/emicklei/go-restful v0.0.0-20181206212552-8ec491e7141b
	github.com/micro/go-micro v0.17.0
	github.com/micro/go-web v0.5.2
	labix.org/v2/mgo v0.0.0-20140701140051-000000000287 // indirect
	srv/greeter v0.0.1
)

replace srv/greeter v0.0.1 => ../../srv/greeter
