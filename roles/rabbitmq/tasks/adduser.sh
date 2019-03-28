!# /bin/bash

rabbitmqctl add_user qe.dev 123
rabbitmqctl set_user_tags qe.dev administrator
rabbitmqctl set_permissions -p / qe.dev "." "." ".*"
