#!/bin/bash

#sudo apt install zbar-tools

YUBI_KEY=$(zbarcam -1 --raw)
ykpersonalize -2 -a$YUBI_KEY -ochal-resp -ochal-hmac -ohmac-lt64 -oserial-api-visible -oallow-update -y
