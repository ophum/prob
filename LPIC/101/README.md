# 問1

起動しているシェル（デフォルトシェル）は？

## 解答

起動しているシェルは、以下のコマンドを実行して`CMD`列に書かれている名称になります。

```
sakura@cloud-shell% ps -p ${$}
    PID TTY          TIME CMD
     12 pts/0    00:00:00 zsh
```

よって`zsh`となります。

なお `$` は現在のPIDを示します。

# 問2

環境変数をすべて表示するコマンドは？

## 解答

`env`コマンドです。

```
sakura@cloud-shell% env | tail
_ZPLUG_OHMYZSH=robbyrussell/oh-my-zsh
_ZPLUG_PREZTO=sorin-ionescu/prezto
_ZPLUG_AWKPATH=/home/sakura/.zplug/misc/contrib
_ZPLUG_CONFIG_SUBSHELL=:
RBENV_SHELL=zsh
PYENV_SHELL=zsh
NVM_DIR=/home/sakura/.nvm
NVM_CD_FLAGS=-q
NVM_RC_VERSION=
_=/bin/env
```

さくらのクラウドシェルでは多くの環境変数が設定されているため`| tail`によって末尾10行のみを表示しています。

# 問3

コマンドのパスを設定・表示する環境変数名は？

## 解答

`PATH`です。 `echo $PATH`とすることで表示できます。

```
sakura@cloud-shell% echo $PATH
/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin
```

また、PATHに新しいパスを追加するには`set`コマンドを用いて以下のようにします。

```
sakura@cloud-shell% export PATH=/my/path:$PATH
sakura@cloud-shell% echo $PATH
/my/path:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin
```

# 問4

シェルで`abc`と入力したあとで、先頭に`a`を追加したくなりました。

このとき先頭にカーソルを移動するショートカットはなんですか？

## 解答

`Ctrl-a`です。

# 問5

シェルで`sleep 100`と入力したあとで、このプロセスを止めたくなりました。

このとき起動中のプロセス（`sleep 100`）を停止するショートカットはなんですか？

## 解答

`Ctrl-c`です。

```
sakura@cloud-shell% sleep 100
^C
```

# 問6

シェルで`sleep 100`と入力したあとで、このプロセスを中断したくなりました。

このとき起動中のプロセス（`sleep 100`）を中断するショートカットはなんですか？

## 解答

`Ctrl-z`です。
中断するとプロンプトを操作できるようになります。

```
sakura@cloud-shell% sleep 100
^Z
zsh: suspended  sleep 100
sakura@cloud-shell%
```

処理を戻すには`fg`(forground)が利用できます。

```
sakura@cloud-shell% fg
[1]  + continued  sleep 100
^C
```

# 問7

カレントディレクトリを環境変数を用いて表示してください。

## 解答

環境変数`PWD`を利用して確認できます。

```
sakura@cloud-shell% echo $PWD
/home/sakura
```

なお、クラウドシェルの場合右プロンプトにカレントディレクトリが表示されている（`[~]`）のですぐに分かりますね！

# 問8

ホスト名を環境変数を用いて表示してください。

## 解答

環境変数`HOST`を利用して確認できます。

```
sakura@cloud-shell% echo $HOST
cloud-shell
```

なお、クラウドシェルの場合プロンプトが`<user>@<host-name>`となっているのですぐに分かりますね！

# 問9

`tar`コマンドはアーカイブファイルを作成・展開するコマンドです。

tar.gzなファイルをクラウドシェルにダウンロードし、tar.gzにアーカイブされているファイル一覧を表示してください。

## 解答

まずはtarコマンドのmanページを表示しましょう。  
`man tar`を入力してください。  
一覧表示であることからlistというキーワードで検索すると以下のオプション（`-t, --list`）がヒットします。

```
sakura@cloud-shell% man tar
...
       -t, --list
              List the contents of an archive.  Arguments are optional.  When given, they specify the names of the members to list.
...
```

では`tar -tf ファイル名`（または`tar --list -f ファイル名`）を実行するとアーカイブされたファイル一覧が表示されました。

```
sakura@cloud-shell% tar -tf go1.21.1.linux-amd64.tar.gz | head
go/
go/CONTRIBUTING.md
go/LICENSE
go/PATENTS
go/README.md
go/SECURITY.md
go/VERSION
go/api/
go/api/README
go/api/except.txt
```

# 問10

`dd`コマンドはファイルやデバイス全体のファイルをブロック単位でコピーするコマンドです。

ddコマンドを用いて512bytesのファイルを作成してください。  
入力ファイルは何でもOKです。

## 解答

入力を`/dev/urandom`とし、`512bytes.txt`というファイルに512bytes分書き込むには以下のコマンドを実行します。

```
sakura@cloud-shell% dd if=/dev/urandom of=512bytes.txt bs=512 count=1
1+0 records in
1+0 records out
512 bytes copied, 0.000135449 s, 3.8 MB/s
```

`du`コマンドを用いてバイトサイズを確認すると確かに512となっていますね。

```
sakura@cloud-shell% du -b 512bytes.txt
512     512bytes.txt
```

