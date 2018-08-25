# django-docker-local

DockerでDjangoのローカル環境を構築するソースコードです。

myappサービスはDjangoチュートリアルのサンプルを使用しています。

runserverはSupervisorによって管理しています。

## Setup

ローカル環境の初期化
```
make init
```
管理ユーザーの作成
```
make createsuperuser
```

## Usage

サービスの起動
```
make up
```
サービスの停止
```
make down
```
bashの起動
```
make bash
```
Supervisorの状態確認
```
make supervisor-status
```
Supervisor(runserver)の再起動
```
make supervisor-restart
```

## Confirm

### Django管理画面

* http://localhost:8000/admin/

### Djangoチュートリアルのサンプルアプリケーション画面

* http://localhost:8000/polls/

### Jenkins

* http://localhost:8080/