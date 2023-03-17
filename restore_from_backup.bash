#!/bin/bash

# dependencies installation
#sudo apt install zbar-tools yubikey-personalization

# 1. oad the QR code and save the key to a variable
YUBI_KEY=$(zbarcam -1 --raw)

# 2. save key from te QR code to the yubikey
#   -2 - upload to slot number 2
#   -a$YUBI_KEY - provide key as AES
#   -y - do not ask for permission, if zbarcam has done its work, copy key to the yubikey immediately
ykpersonalize -2 -a$YUBI_KEY -ochal-resp -ochal-hmac -ohmac-lt64 -oserial-api-visible -oallow-update -y




# Note: If you are unable to read the code from the camera (due to it being broken, taped, or for any other reason), you can use the following command:

#		ykpersonalize -2 -a -ochal-resp -ochal-hmac -ohmac-lt64 -oserial-api-visible -oallow-update

#	Please note that the switch '-a' does not have a specified key. You will be prompted to enter the key manually
#	from the command line, which means you need to read it from the plaintext located under the QR code. Additionally,
#	there is no switch '-y', so you will need to confirm manually.
