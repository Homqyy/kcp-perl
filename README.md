# perl-kcp

## 1 概要

- `perl-kcp`是一个扩展“[skywind3000/kcp](https://github.com/skywind3000/kcp)”的一个面向对象的Perl模块，在安装的时候内置了KCP的库。

- 该项目有如下几个特点：
    - 友好性：
        - Perl-Like风格
        - 面向对象的
    - 可靠性：有配套的测试脚本
    - 实时性：基于最新的KCP项目源码构建
    - 便利性：可以用`cpan`工具直接获取项目

### 1.1 目录结构

```
perl-kcp
├── build.sh                    # 构建脚本
├── Changes                     # 版本说明
├── Dockerfile.dev              # 开发容器的配置文件
├── Dockerfile.dev              # 开发容器的配置文件
├── KCP                         # 扩展KCP的Perl模块
│   ├── Changes
│   ├── KCP.xs
│   ├── lib
│   │   ├── KCP
│   │   │   └── Test.pm         # 专门用来测试perl-kcp的测试包
│   │   └── KCP.pm              # perl-kcp包
│   ├── Makefile.PL
│   ├── MANIFEST
│   ├── ppport.h
│   ├── t                       # 测试脚本目录
│   └── typemap
├── kcp-src                     # 子模块，关联到 “skywind3000/kcp 项目
├── LICENSE
└── README.md
```

### 1.2 快速获取

1. 安装`libkcp.so`和`ikcp.h`到系统中。
    - 如果编译KCP项目源码，可参考以下命令：

    ```
    cmake -B ./build -S . -D BUILD_SHARED_LIBS=ON

    cd build

    make && make install
    ```
2.  通过`cpan`工具获取`perl-kcp`

```
cpan -i HOMQYY/KCP-0.03.tar.gz
```

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

- 在成功安装之后，在`Shell`下执行以下命令查看帮助手册：`man KCP` 或 `perldoc KCP`；或则浏览在线说明：[KCP-0.03](https://metacpan.org/release/HOMQYY/KCP-0.03/view/lib/KCP.pm)

- 在安装完之后便可以正常使用`perl-kcp`了，比如：

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

    $kcp->input($data, 65536);

    ...
    ```

---

## 5 配置

- 通过环境变量进行配置，支持的环境变量有：
    - KCP_INC_DIR
    - KCP_LIB