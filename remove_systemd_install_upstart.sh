#!/bin/bash
apt-get update && apt-get -y install upstart-sysv
update-initramfs -u
