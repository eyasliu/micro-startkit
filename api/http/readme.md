# http 映射服务

启动开发环境

```
./build.sh dev http
```

启动后端服务

```
cd srv/greeter
go run main.go
```

启动 http 服务

```
cd api/http
go run main.go
```

浏览器访问

```
http://localhost:9000/greeter
http://localhost:9000/greeter/Mike
```