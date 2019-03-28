#stop firewalld
systemctl stop firewalld
systemctl disable firewalld
#repo rabbitmq,nginx
echo "[rabbitmq-erlang]" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "name=rabbitmq-erlang" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "baseurl=https://dl.bintray.com/rabbitmq/rpm/erlang/21/el/7" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "gpgcheck=1" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "gpgkey=https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "repo_gpgcheck=0" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo "enabled=1" >> /etc/yum.repos.d/rabbitmq-erlang.repo
echo -e "[nginx]\nname=nginx repo\nbaseurl=http://nginx.org/packages/centos/7/x86_64/\ngpgcheck=0\nenabled=1" >> /etc/yum.repos.d/nginx.repo
#yum -y install socat wget mock
wget http://nginx.org/packages/centos/7/x86_64/RPMS/nginx-1.12.0-1.el7.ngx.x86_64.rpm
rpm -ivh nginx-1.12.0-1.el7.ngx.x86_64.rpm
wget http://github.com/rabbitmq/erlang-rpm/releases/download/v20.1.2/erlang-20.1.2-1.el7.centos.x86_64.rpm
rpm -ivh erlang-20.1.2-1.el7.centos.x86_64.rpm
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.6/rabbitmq-server-3.7.6-1.el7.noarch.rpm
rpm -ivh rabbitmq-server-3.7.6-1.el7.noarch.rpm
#start rabbitmq,nginx
service nginx start
chkconfig nginx on
systemctl start rabbitmq-server
systemctl stop rabbitmq-server
echo "CONFIG_FILE=/etc/rabbitmq/rabbitmq" >> /etc/rabbitmq/rabbitmq-env.conf
echo "ulimit -S -n 4096" >> /etc/rabbitmq/rabbitmq-env.conf
#create rabbitmq.config
echo "[" >> /etc/rabbitmq/rabbitmq.config
echo "  {kernel, [" >> /etc/rabbitmq/rabbitmq.config
echo "     {inet_default_connect_options, [{nodelay, true}]}," >> /etc/rabbitmq/rabbitmq.config
echo "     {inet_default_listen_options,  [{nodelay, true}]}" >> /etc/rabbitmq/rabbitmq.config
echo "  ]}," >> /etc/rabbitmq/rabbitmq.config
echo "  {rabbit, [{auth_backends, [rabbit_auth_backend_internal]}," >> /etc/rabbitmq/rabbitmq.config
echo "            {tcp_listeners, [{"\"::\"",5670}]}," >> /etc/rabbitmq/rabbitmq.config
echo "            {ssl_listeners, [{"\"::\"",5671}]}," >> /etc/rabbitmq/rabbitmq.config
echo "            {tcp_listen_options, [" >> /etc/rabbitmq/rabbitmq.config
echo "                         {backlog,   4096}," >> /etc/rabbitmq/rabbitmq.config
echo "                         {nodelay,   true}" >> /etc/rabbitmq/rabbitmq.config
echo "            ]}," >> /etc/rabbitmq/rabbitmq.config
echo "            {frame_max, 0 }," >> /etc/rabbitmq/rabbitmq.config
echo "            {hipe_compile, true }," >> /etc/rabbitmq/rabbitmq.config
echo "            {ssl_options,   [{cacertfile,            "\"/etc/rabbitmq/ssl/fullchain.pem\""}," >> /etc/rabbitmq/rabbitmq.config
echo "                             {certfile,              "\"/etc/rabbitmq/ssl/cert.pem\""}," >> /etc/rabbitmq/rabbitmq.config
echo "                             {keyfile,               "\"/etc/rabbitmq/ssl/privkey.pem\""}," >> /etc/rabbitmq/rabbitmq.config
echo "                             {password,              "\"Abc123456\""}," >> /etc/rabbitmq/rabbitmq.config
echo "                             {verify,                verify_none}," >> /etc/rabbitmq/rabbitmq.config
echo "                             {fail_if_no_peer_cert,  false}" >> /etc/rabbitmq/rabbitmq.config
echo "                            ]" >> /etc/rabbitmq/rabbitmq.config
echo "            }," >> /etc/rabbitmq/rabbitmq.config
echo "            {heartbeat,                              15}," >> /etc/rabbitmq/rabbitmq.config
echo "            {vm_memory_high_watermark_paging_ratio,  0.75}," >> /etc/rabbitmq/rabbitmq.config
echo "            {vm_memory_high_watermark,               0.75}," >> /etc/rabbitmq/rabbitmq.config
echo "            {disk_free_limit,                        100000000}," >> /etc/rabbitmq/rabbitmq.config
echo "            {collect_statistics_interval, 30000}," >> /etc/rabbitmq/rabbitmq.config
echo "            {loopback_users,                         []}" >> /etc/rabbitmq/rabbitmq.config
echo "          ]" >> /etc/rabbitmq/rabbitmq.config
echo "  }," >> /etc/rabbitmq/rabbitmq.config
echo "  {rabbitmq_management," >> /etc/rabbitmq/rabbitmq.config
echo "           [" >> /etc/rabbitmq/rabbitmq.config
echo "                 {rates_mode,    none}," >> /etc/rabbitmq/rabbitmq.config
echo "                 {listener, [{port,       8443}," >> /etc/rabbitmq/rabbitmq.config
echo "                 {ssl,        false}," >> /etc/rabbitmq/rabbitmq.config
echo "                 {ssl_opts, [{cacertfile, "\"/etc/rabbitmq/ssl/fullchain.pem\""}," >> /etc/rabbitmq/rabbitmq.config
echo "                             {certfile,   "\"/etc/rabbitmq/ssl/cert.pem\""}," >> /etc/rabbitmq/rabbitmq.config
echo "                             {keyfile,    "\"/etc/rabbitmq/ssl/privkey.pem\""}," >> /etc/rabbitmq/rabbitmq.config
echo "                             {password,   "\"Abc123456\""}]}" >> /etc/rabbitmq/rabbitmq.config
echo "           ]}" >> /etc/rabbitmq/rabbitmq.config
echo "    ]}" >> /etc/rabbitmq/rabbitmq.config
echo "]." >> /etc/rabbitmq/rabbitmq.config
rabbitmq-plugins enable rabbitmq_management
chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
systemctl start rabbitmq-server
systemctl enable rabbitmq-server
rabbitmqctl add_user qe.dev 123
rabbitmqctl set_user_tags qe.dev administrator
rabbitmqctl set_permissions -p / qe.dev "." "." ".*"
#install 
curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash -
yum install nodejs git unzip npm nano -y

