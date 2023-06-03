# 01 ビルドができない - 解答

## ログ

実際にコマンドを実行しビルドができないことを確認する。

```sh
[user@cloud-shell ~/app]$ GOOS=linux GOARCH=arm64 go build
GOOS=linux: Command not found.
```

環境変数として渡している`GOOS=linux`がコマンドとして扱われていることがわかる。

`echo $SHELL`でログインシェルを確認する。

```sh
[user@cloud-shell ~/app]$ echo $SHELL
/bin/tcsh
```

`tcsh`が使われていることがわかる。

tcshでは一時的な環境変数の指定を以下のように行う必要がある。
```sh
env 環境変数名=値 コマンド ...
```

実行コマンドを`env GOOS=linux GOARCH=arm64 go build`に修正し実行する。

```sh
[user@cloud-shell ~/app]$ env GOOS=linux GOARCH=arm64 go build
[user@cloud-shell ~/app]$ 
```	

ビルドが成功しバイナリファイル`app`が生成され実行できることが確認できる。

```sh
[user@cloud-shell ~/app]$ ls
README  app  go.mod  main.go
[user@cloud-shell ~/app]$ file ./app
./app: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statically linked, Go BuildID=rxvUxOdGz7OyOPi0XbMv/bu3hVRBkSNruhLFFUpLt/ERt0D3rtzG2FFtoiBnCk/oeB1j7EgZPpihwdugcUC, not stripped
```

qemu-aarch64-staticを使い正常に実行できることが確認できる。

```sh
[user@cloud-shell ~/app]$ qemu-aarch64-static ./app
hello world
```

## 解答

ビルドコマンドが`sh`や`bash`・`zsh`を想定していたが実際のログインシェルが`tcsh`だったことが問題でした。
`env GOOS=linux GOARCH=arm64 go build`とすることで環境変数を設定しビルドすることができます。

## 別解

- `sh -c "GOOS=linux GOARCH=arm64 go build"`
- ログインシェルを`sh`や`bash`・`zsh`など対応したものに変更する
- 事前に環境変数を設定する(`setenv`コマンドで設定する)
- 事前に`go env -w`で設定する
