#!/usr/bin/bash
set -e
# set -x

SCRIPTPATH=$(cd `dirname $0`; pwd)
cd $SCRIPTPATH

namespace=go.micro

# 检查命令
check_cmd_or_exit() {
  if ! command -v $1 > /dev/null;then
    red_text "未安装 $1"
    if [ $1 == "go" ];then
      echo "下载安装: https://studygolang.com/dl"
    fi
    if [ $1 == "micro" ];then
      echo "命令安装: go get -u -v github.com/micro/micro"
    fi
    if [ $1 == "docker" ];then
      echo "windows 下载安装: https://store.docker.com/editions/community/docker-ce-desktop-windows"
      echo "linux 命令安装: curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun"
    fi
    if [ $1 == "protoc" ];then
      echo "下载安装: https://github.com/protocolbuffers/protobuf/releases"
    fi
    if [ $1 == "consul" ];then
      echo "下载安装: https://www.consul.io/downloads.html"
    fi
    
    exit 1
  fi
}

red_text() {
  echo -e "\e[31m$*\e[0m"
}

green_text() {
  echo -e "\e[32m$*\e[0m"
}

help_demo() {
    echo -e "
USAGE:
  ./build.sh <command>

COMMANDS:
  new <类型> <相对地址>          生成一个新服务，类型: api,web,srv,fnc
  preinstall                    安装全局项目依赖包
  install                       安装go依赖
  protoc                        编译所有项目的proto文件
  dev                           启动开发环境
  help                          打印帮助信息

EXAMPLE:
  ./build.sh new api api/user  # 在目录 api/user 生成一个 api 类型的服务，服务名是 api.user

TIPS:
  1. 第一次运行前的需要安装依赖工具环境，安装完成后先执行一遍
  ./build.sh install

  2. 在开发前需要先启动开发环境
  ./build.sh dev
"
}

act_install() {


  for dir in *; do
    if [ -d $dir ];then
      if [ -e $dir/go.mod ];then
        parent_path=$(pwd)
        project_path=$(pwd)/$dir
        cd $project_path
        green_text "项目：$project_path 正在安装依赖"
        go mod download

        cd $parent_path
      else
        cd $dir
        act_install .
      fi
    fi
  done
  # go mod download
}

act_compiler_proto() {
  for file in *; do
    if [ -d $file ]; then
    # echo "is dir"
      # if [ $file == *libs ];then
      #   continue
      # fi
      cd $file
      act_compiler_proto .
      cd ../
    else if [ $file == *.proto ];then
      pwd_path=`pwd -W`
      echo -e $pwd_path/$file "...\c"
      protoc -I=$GOPATH/src -I=. -I=$SCRIPTPATH --proto_path=$SCRIPTPATH --go_out=$SCRIPTPATH --micro_out=$SCRIPTPATH $pwd_path/$file # TODO
      green_text " 完成"
      fi
    fi
  done
}

act_new() {
  new_proj_path=$2/$3
  micro new --gopath=false --namespace=$namespace --type=$2 $new_proj_path
  cd $new_proj_path
  green_text "项目已生成，初始化模块..."
  go mod init $new_proj_path
  green_text "正在安装依赖..."
  go mod tidy
  go mod edit -require=github.com/golang/protobuf@1d3f30b51784bec5aad268e59fd3c2fc1c2fe73f # TODO: go mod 下载的版本有问题，以后应该会移除
  # go mod download
  go mod download

  # 增加项目别名
  
  echo -e "\n" >> go.mod
  echo "require srv v0.0.1" >> go.mod
  echo "replace srv v0.0.1 => ../../srv" >> go.mod
  echo "replace api v0.0.1 => ../../api" >> go.mod

  green_text "正在编译 proto 文件"
  act_compiler_proto
  green_text "完成."
}

act_dev() {

  HANDLERAPI=$2
  HANDLERAPI=${HANDLERAPI:-$MICRO_API_HANDLER}
  HANDLERAPI=${HANDLERAPI:-api}

  consul agent -dev & \
  micro api --address 0.0.0.0:9000 --namespace $namespace.api --handler $HANDLERAPI & \
  micro web --address 0.0.0.0:9001 --namespace $namespace
}

# kill_proc() {

#   # tasklist | grep $1 | grep -v grep | cut -c 20-35 | xargs kill -s 9
# }

# act_dev_kill() {
#   # kill_proc consul.exe
#   if [ "$(expr substr $(uname -s) 1 4)" == "MSYS" ];then
#     # start scripts/devkill.bat
#     # cmd
#     # TASKKILL \/?
#     start "" . /B /I "TASKKILL \/IM micro.exe \/T \/F"
#     # start "" /D . /I TASKKILL \/IM consul.exe \/T \/F
    
#   fi
# }

# 检查依赖项
check_cmd_or_exit go
check_cmd_or_exit docker
check_cmd_or_exit micro
check_cmd_or_exit protoc
check_cmd_or_exit consul


case "$1" in
  "new")
    act_new $@
    ;;
  "preinstall")
    go get -v github.com/golang/protobuf/{proto,protoc-gen-go}
    go get -v github.com/micro/protoc-gen-micro
    go get -v github.com/micro/go-api
    act_install
  ;;
  "install")
    act_install
    ;;
  "protoc")
    act_compiler_proto
    ;;
  "dev")
    act_dev $@
    ;;
  "dev:kill")
    act_dev_kill
    ;;
  *)
    help_demo
    ;;
esac