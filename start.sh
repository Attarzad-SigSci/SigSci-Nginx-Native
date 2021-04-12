#!/bin/sh
echo "Starting container"
echo ".................."
echo "Starting Agent"
/usr/sbin/sigsci-agent &
echo "Starting Nginx"
/usr/sbin/nginx
/bin/sh 