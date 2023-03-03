# kcp-perl

[TOC]

## 1 Abstarct

- The `kcp-perl` is a object-oriented perl module for extending [skywind3000/kcp](https://github.com/skywind3000/kcp)

- This project has some advantages:
    - friendly:
        - Perl-like style
        - object-orirented
    - reliable: matched test scripts of the project
    - real-time：construting project based on the latest KCP source code
    - conveniently：you can get the release version by using `cpan`

### 1.1 Directory

```
kcp-perl
├── build.sh        # building tool
├── Changes
├── .devcontainer   # VSCode Configure of extension 'Dev Containers'
├── Dockerfile.dev  # config of container for developing
├── .gitignore
├── .gitmodules
├── KCP             # perl extension of KCP
│   ├── Changes
│   ├── KCP.xs      # code of the extension
│   ├── lib
│   │   ├── KCP
│   │   │   └── Test.pm
│   │   └── KCP.pm
│   ├── Makefile.PL
│   ├── MANIFEST
│   ├── ppport.h
│   ├── README
│   ├── t           # test scripts
│   └── typemap
├── kcp-src         # associate to "skywind3000/kcp" project
├── LICENSE
├── README.md
```

### 1.2 Install

- install `kcp-perl` release with `cpan`:
    - install latest version: 

        ```
        cpan -i KCP
        ```

    - install special version:
    
        ```
        cpan -i HOMQYY/KCP-0.04.tar.gz
        ```

### 1.3 Online manual

- [KCP Guide manual](https://metacpan.org/release/HOMQYY/KCP-0.04/view/lib/KCP.pm)

---

## 2 Require

The project is depend on some "system tools" and "perl modules"

### 2.1 System tools

1. cpan

    ```
    yum install -y cpan
    ```

2. perl-Test-Simple（required by test）

    ```
    yum install -y perl-Test-Simple
    ```

### 2.2 Perl modules

1. Devel::PPPort

    ```
    cpan -i Devel::PPPort
    ```

2. Test::More（required by test）

    ```
    cpan -i Test::More
    ```

---

## 3 Build

If you are getting the project at first time, you should execute the following command to get code of kcp

```
git submodule init
git submodule update
```

Next, to start building


### 3.1 Building by one step

```
./build.sh
```

### 3.2 Building by step

- Configure

    ```
    ./build.sh configure
    ```

- Compile

    ```
    ./build.sh compile
    ```

- Test

    ```
    ./build.sh test
    ```

- Install

    ```
    ./build.sh install
    ```

---

## 4 Usage

- You can get "Guide Manual" by using following commands in Shell after installing:

    ```
    man KCP
    ```
    ```
    perldoc KCP
    ```

    - or view the guide manual online: [KCP Guide manual](https://metacpan.org/release/HOMQYY/KCP-0.04/view/lib/KCP.pm)

- After installing, you can use it, for example:

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