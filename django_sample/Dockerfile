FROM python:2.7.15

ARG sitecustomize_file="/usr/local/lib/python2.7/site-packages/sitecustomize.py"
RUN touch ${sitecustomize_file}
RUN echo "import sys; sys.setdefaultencoding('utf-8')" > ${sitecustomize_file}

COPY .ssh /root/.ssh
RUN chmod -R 700 /root/.ssh/*

WORKDIR /home/docker
RUN chmod -R 777 /home/docker
COPY requirements.txt .
RUN pip install -r requirements.txt

RUN apt-get update
RUN apt-get install -y mysql-client

# Java実行環境とsshdをインストール
RUN apt-get -y install sudo openssh-server openjdk-8-jdk

# ユーザー追加
RUN useradd -m -s /bin/bash docker
# パスワード設定
RUN echo "docker:docker" | chpasswd
# sudoが使えるように
RUN echo 'docker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# SSH公開鍵をコピー
COPY .ssh ./.ssh
RUN chmod -R 700 ./.ssh/*
RUN chown -R docker:docker ./.ssh

# Supervisor設定
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /usr/local/etc/

EXPOSE 22
RUN mkdir -p /var/run/sshd
CMD [ "/usr/local/bin/supervisord", "-n", "-c", "/usr/local/etc/supervisord.conf"]
