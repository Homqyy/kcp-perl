# perl-kcp

## 1 概要

这是一个扩展“[skywind3000/kcp](https://github.com/skywind3000/kcp)“的一个Perl模块。如果之前没有安装过KCP库，可以直接安装内置的KCP库使用；反之，可以通过配置提供指定的KCP库。

---

## 2 依赖

依赖分为系统工具和perl模块

### 2.1 系统工具

1. cpan

```
yum install -y cpan
```

### 2.2 Perl模块

1. Devel::PPPort

```
cpan -i Devel::PPPort
```

2. Test::More

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

- 在成功安装之后，在`Shell`下执行以下命令查看帮助手册：`man KCP` 或 `perldoc KCP`

---

## 5 配置

- 通过环境变量进行配置，支持的环境变量有：
    - KCP_INC_DIR
    - KCP_LIB