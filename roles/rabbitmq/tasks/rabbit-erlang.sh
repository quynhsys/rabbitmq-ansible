!# /bin/bash

echo "[rabbitmq-erlang]" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "name=rabbitmq-erlang" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "baseurl=https://dl.bintray.com/rabbitmq/rpm/erlang/21/el/7" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "gpgcheck=1" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "gpgkey=https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "repo_gpgcheck=0" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "enabled=1" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo -e "[nginx]\nname=nginx repo\nbaseurl=http://nginx.org/packages/centos/7/x86_64/\ngpgcheck=0\nenabled=1" >> /etc/yum.repos.d/nginx.repo
