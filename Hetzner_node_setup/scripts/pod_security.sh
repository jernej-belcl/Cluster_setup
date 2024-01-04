#!/bin/bash

cd /etc/rancher/rke2/config.yaml.d
sed -i '/"profile": "cis-1.23",/a \  "pod-security-admission-config-file": "/etc/rancher/rke2/rancher-psact.yaml",' 50-rancher.yaml
systemctl restart rke2-server.service

