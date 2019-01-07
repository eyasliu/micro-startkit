# go micro 启动脚手架

## build.sh 集成工具

环境依赖

1. go v1.11+
2. docker
3. micro
4. protoc
5. consul

如果没有安装好依赖，执行 `./build.sh` 时会有引导你安装

```sh
$ ./build.sh
未安装 docker
windows 下载安装: https://store.docker.com/editions/community/docker-ce-desktop-windows
linux 命令安装: curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
```

#### Usage

```sh
$ ./build.sh

USAGE:
  ./build.sh <command>

COMMANDS:
  new <类型> <服务名> <相对地址>  生成一个新服务，类型: api,web,srv,fnc
  preinstall                    安装全局项目依赖包
  install                       安装go依赖
  protoc                        编译所有项目的proto文件
  dev                           启动开发环境
  help                          打印帮助信息

EXAMPLE:
  ./build.sh new api api.user api/user  # 在目录 api/user 生成一个 api 类型的服务，服务名是 api.user

TIPS:
  1. 第一次运行前的需要安装依赖工具环境，安装完成后先执行一遍
  `./build.sh install`

  2. 在开发前需要先启动开发环境
  `./build.sh dev`

```

**./build.sh new <类型> <服务名> <相对地址>**

生成一个新服务, `micro new` 的命令封装

* 类型: 即 micro 的 --type 选项 api,web,srv,fnc
* 服务名: 即 micro 的 --namespace 选项
* 相对地址：需要生成的相对路径

**./build.sh preinstall**

安装全局需要的依赖包

**./build.sh install**

遍历所有目录，在有 go.mod 的目录执行安装 go 依赖

**./build.sh protoc**

遍历所有目录的 .proto 文件，并编译成 go 和 micro 的包

1. proto 的导入路径会设置为 build.sh 的当前目录路径和 $GOPATH/src


**./build.sh dev**

启动开发环境

1. 启动 consul
2. ~~监听proto文件改动自动编译~~

> 项目需要自行逐个启动
