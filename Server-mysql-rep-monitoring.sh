#!/bin/bash

#Installing and configuring MySQL server
apt install mysql-server -y
systemctl enable mysql.service
cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
cp ./replica-mysql-config /etc/mysql/mysql.conf.d/mysqld.cnf
mysql --execute="stop replica;"
mysql --execute="change master to master_host='79.174.91.152', master_user='replica', master_password='OtusPeshkov24', master_log_file='binlog.000005', master_log_pos=688, get_master_public_key = 1;"
mysql --execute="start replica;"

apt install prometeheus prometheus-node-exporter -y
systemctl enable --now prometeheus
systemctl enable --now prometeheus-node-exporter
cp ./prometheus-conf /etc/prometheus/prometheus.yml
service prometheus restart

#Installing and configuring Logstash
#dpkg -i https://cdn.otus.ru/media/public/e7/a1/logstash_8.9.1_amd64-224190-e7a1b1.deb
systemctl enable --now logstash
cp ./logstash-conf /etc/logstash/logstash.yml
service logstash restart

#Installing and configuring Elasticsearch
#dpkg -i https://cdn.otus.ru/media/public/50/9c/elasticsearch_8.9.1_amd64-224190-509cdd.deb
systemctl enable --now elasticsearch
cp ./elastic-conf /etc/elasticsearch/elasticsearch.yml
service elasticsearch restart

#Installing and configuring Kibana
#dpkg -i https://cdn.otus.ru/media/public/c0/98/kibana_8.9.1_amd64-224190-c09868.deb
systemctl enable --now kibana
cp ./kibana-conf /etc/kibana/kibana.yml
service kibana restart

#Configuring network
#cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak
#cp ./mysql-rep-ip-conf /etc/netplan/00-installer-config.yaml
#netplan apply
