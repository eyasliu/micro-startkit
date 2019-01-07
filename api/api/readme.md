# api 请求映射


启动开发环境

```
./build.sh dev api
```

启动后端服务

```
cd srv/greeter
go run main.go
```

启动 http 服务

```
cd api/api
go run main.go
```

浏览器访问

```
http://localhost:9000/greeter/say/hello?name=Mike
```