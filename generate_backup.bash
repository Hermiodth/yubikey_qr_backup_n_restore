#!/bin/bash

# 0. dependencies that we need to install first
#sudo apt install yubikey-personalization qrencode

# 1. we create two random byte arrays, 10 bytes each and save it to corresponding files
dd status=none if=/dev/random bs=10 count=1 | xxd -p -c 10 > hmac_key_part_1
dd status=none if=/dev/random bs=10 count=1 | xxd -p -c 10 > hmac_key_part_2

# 2. then we concatenate those byte arrays into one key
echo "$(cat hmac_key_part_1)$(cat hmac_key_part_2)" > hmac_key

# 3. and save in the form of a QR code
qrencode -o key.png -r hmac_key -s 18 -l H

# 4. then we convert two parts of a key to the images so we can add them unther the QR code and print it together
convert -pointsize 70 "label:$(cat hmac_key_part_1)" "hmac_hey_plaintext_part_1.gif"
convert -pointsize 70 "label:$(cat hmac_key_part_2)" "hmac_hey_plaintext_part_2.gif"

# 5. finally, we concatenate qr code with plaintext key and create one printable image
convert -append key.png hmac_hey_plaintext_part_1.gif hmac_hey_plaintext_part_2.gif key.total.gif
