#!/bin/bash

# 停用
# exit 0

# 项目名称
PROJECT_NAME="lucky"

# 项目版本
PROJECT_VERSION="v0.2.0"

# 项目链接
PROJECT_URL="https://github.com/gdy666/lucky.git"

# 项目路径
PROJECT_PATH="$PROJECT_NAME"

# Go 语言版本
GO_VERSION="1.22.5"

# 构建参数
GO_BUILD_LDFLAGS="-s -w"

# 二进制文件名称
BINARY_NAME="$PROJECT_NAME"

# GitHub Actions
ACTIONS_ENV() {
    # 获取 Go
    go_url="https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"
    echo "go_url=$go_url" >>$GITHUB_ENV
    echo "GO_VERSION=$GO_VERSION" >>$GITHUB_ENV

    # 获取项目
    git clone --depth=1 $PROJECT_URL -b $PROJECT_VERSION $PROJECT_PATH
    cd $PROJECT_PATH
    git fetch --depth=1 origin $PROJECT_VERSION
    git reset --hard FETCH_HEAD
    # go mod tidy
}

# 本地编译
LOCAL_BUILD() {
    # 获取 Go
    if [ ! -d "/usr/local/go" ]; then
        wget -c https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz -O go$GO_VERSION.linux-amd64.tar.gz
        rm -rf /usr/local/go && tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz
        rm -f go$GO_VERSION.linux-amd64.tar.gz
    fi
    export PATH=$PATH:/usr/local/go/bin

    # 获取项目
    if [ ! -d "$PROJECT_PATH" ]; then
        git clone --depth=1 $PROJECT_URL -b $PROJECT_VERSION $PROJECT_PATH
    fi
    cd $PROJECT_PATH
    git fetch --depth=1 origin $PROJECT_VERSION
    git reset --hard FETCH_HEAD
    # go mod tidy
}

# 编译
BUILD() {
    # 设置代理
    export GOPROXY=https://goproxy.cn,direct

    # 编译
    go build -ldflags "$GO_BUILD_LDFLAGS" -o $BINARY_NAME main.go
}

# 打包
PACKAGE() {
    # 移动二进制文件
    mkdir -p bin/
    mv $BINARY_NAME bin/

    # 打包
    cd bin/
    zip -r "lucky_$(uname -m).zip" *
    cd ..
}

# 主函数
main() {
    # 判断环境
    if [ -n "$GITHUB_ACTIONS" ]; then
        ACTIONS_ENV
    else
        LOCAL_BUILD
    fi

    # 编译
    BUILD

    # 打包
    PACKAGE
}

# 执行主函数
main
