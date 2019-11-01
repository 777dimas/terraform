#!/bin/bash

apt update -y

apt upgrade -y

apt install nginx -y

systemctl enable nginx

