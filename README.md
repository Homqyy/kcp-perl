# kcp-perl

[README in English](https://github.com/Homqyy/kcp-perl/blob/main/README.en.md)

[TOC]

## 1 概要

- `kcp-perl`是一个扩展“[skywind3000/kcp项目](https://github.com/skywind3000/kcp)”的Perl模块，且该模块是面向对象的。

- 该项目有如下几个特点：
    - 友好性：
        - Perl-Like风格
        - 面向对象的
    - 可靠性：有配套的测试脚本
    - 实时性：基于最新的KCP项目源码构建
    - 便利性：可以用`cpan`工具直接获取发行版本

### 1.1 目录结构

```
kcp-perl
├── build.sh        # 构建脚本
├── Changes         # 版本说明
├── .devcontainer   # VSCode编辑器配置
├── Dockerfile.dev  # 开发容器的配置文件
├── .gitignore
├── .gitmodules
├── KCP             # KCP的Perl扩展模块
│   ├── Changes     # 针对 KCP.pm 的版本说明
│   ├── KCP.xs      # 扩展源码
│   ├── lib
│   │   ├── KCP
│   │   │   └── Test.pm
│   │   └── KCP.pm
│   ├── Makefile.PL
│   ├── MANIFEST
│   ├── ppport.h
│   ├── README
│   ├── t           # 测试脚本目录
│   └── typemap
├── kcp-src         # Git子模块：关联到 “skywind3000/kcp 项目
├── LICENSE
├── README.md
```

### 1.2 快速获取

- 通过`cpan`工具安装`kcp-perl`发行包：
    - 安装最新版本：`cpan -i KCP`
    - 安装指定版本：`cpan -i HOMQYY/KCP-0.04.tar.gz`

### 1.3 在线帮助手册

- [KCP使用手册](https://metacpan.org/release/HOMQYY/KCP-0.04/view/lib/KCP.pm)

---

## 2 依赖

依赖分为系统工具和perl模块

### 2.1 系统工具

1. cpan

```
yum install -y cpan
```

2. perl-Test-Simple（测试需要）

```
yum install -y perl-Test-Simple
```

### 2.2 Perl模块

1. Devel::PPPort

```
cpan -i Devel::PPPort
```

2. Test::More（测试需要）

```
cpan -i Test::More
```

---

## 3 构建

- 如果是首次拉取代码，需要先用以下命令获取kcp源码：

```
git submodule init
git submodule update
```

### 3.1 一键构建

```
./build.sh
```

### 3.2 分步构建

- 配置

```
./build.sh configure
```

- 编译

```
./build.sh compile
```

- 测试

```
./build.sh test
```

- 安装

```
./build.sh install
```

---

## 4 使用

- 在成功安装之后，在`Shell`下执行以下命令查看帮助手册：`man KCP` 或 `perldoc KCP`；或则浏览在线说明：[KCP使用手册](https://metacpan.org/release/HOMQYY/KCP-0.04/view/lib/KCP.pm)

- 在安装完之后便可以正常使用`kcp-perl`了，比如：

    ```perl
    use KCP;

    sub output
    {
        my ($data, $user) = @_;

        $user->{socket}->send($data, 0);
    }

    ...

    my $kcp = KCP::new($conv, $user);

    $kcp->set_mode("fast")->set_output(\&output);

    ...

    # scheduled call

    $kcp->update($current_millisec);

    ...

    # to send $data

    $kcp->send($data);
    
    ...

    # to recv data

    $kcp->recv($data, 65536);

    # input data of transport

    $socket->recv($data, 65536, 0);

    $kcp->input($data);

    ...
    ```