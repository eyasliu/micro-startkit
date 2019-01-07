module api/api

require (
	github.com/aliyun/alibaba-cloud-sdk-go v0.0.0-20181227134249-b84c15130b5c // indirect
	github.com/chrismalek/oktasdk-go v0.0.0-20181212195951-3430665dfaa0 // indirect
	github.com/coreos/go-systemd v0.0.0-20181031085051-9002847aa142 // indirect
	github.com/hashicorp/go-plugin v0.0.0-20181212150838-f444068e8f5a // indirect
	github.com/hashicorp/vault-plugin-secrets-gcpkms v0.0.0-20181212182553-6cd991800a6d // indirect
	github.com/hashicorp/vault-plugin-secrets-kv v0.0.0-20181219175933-9dbe04db0e34 // indirect
	github.com/micro/cli v0.0.0-20181223203424-1b0c9793c300 // indirect
	github.com/micro/examples v0.0.0-20181227092101-71cd614487c8
	github.com/micro/go-micro v0.17.0
	github.com/micro/mdns v0.0.0-20181201230301-9c3770d4057a // indirect
	github.com/micro/micro v0.17.1
	labix.org/v2/mgo v0.0.0-20140701140051-000000000287 // indirect
	layeh.com/radius v0.0.0-20181224030715-9a016ab9b9ec // indirect
)

require (
	github.com/golang/protobuf v1.2.1-0.20181128192352-1d3f30b51784
	srv/greeter v0.0.1
)

replace srv/greeter v0.0.1 => ../../srv/greeter
