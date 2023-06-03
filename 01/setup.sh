#!/bin/sh

echo "reset"
sudo userdel -r user 1>/dev/null 2>&1

echo "install packages"
sudo apt update 1>/dev/null 2>&1
sudo apt install -y tcsh golang-go qemu-user-static 1>/dev/null 2>&1


sudo useradd -m -s /bin/tcsh user 1>/dev/null 2>&1

echo "set prompt=\"[%n@%m %c]$ \"" | sudo -u user tee /home/user/.tcshrc 1>/dev/null 2>&1

sudo -u user mkdir /home/user/app 1>/dev/null 2>&1
sudo -u user sh -c "cd /home/user/app; go mod init app" 1>/dev/null 2>&1

cat <<EOF | sudo -u user tee /home/user/app/main.go 1>/dev/null 2>&1
package main

func main() {
        println("hello world")
}
EOF

cat <<"EOF" | sudo -u user tee /home/user/app/README 1>/dev/null 2>&1
以下のコマンドでクロスコンパイルをしようとしたところ失敗してしまいました。なぜでしょうか。
また、ビルドするためにはどうすればよいか答えてください。

```
GOOS=linux GOARCH=arm64 go build
```

## 初期状態

- ビルドができない

## 終了状態

- ビルドができる
- 以下のコマンドで`hello world`が出力される

```
qemu-aarch64-static ./app
```

EOF

cat <<EOF

問題ユーザー: user
問題ディレクトリ: /home/user/app
問題内容: /home/user/app/README

以下のコマンドでログインしてください。

sudo su - user
cd ./app
cat README

EOF

