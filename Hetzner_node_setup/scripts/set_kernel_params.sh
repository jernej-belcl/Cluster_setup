#!/bin/bash

ls /usr/local/share/rke2/
sudo cp -f /usr/local/share/rke2/rke2-cis-sysctl.conf /etc/sysctl.d/60-rke2-cis.conf
sudo systemctl restart systemd-sysctl
sudo useradd -r -c 'etcd user' -s /sbin/nologin -M etcd -U