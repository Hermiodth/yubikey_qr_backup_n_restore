#!/bin/bash

#sudo apt install yubikey-personalization qrencode

dd status=none if=/dev/random bs=10 count=1 | xxd -p -c 20 > hmac_key_part_1
dd status=none if=/dev/random bs=10 count=1 | xxd -p -c 20 > hmac_key_part_2
echo "$(cat hmac_key_part_1)$(cat hmac_key_part_2)" > hmac_key
qrencode -o key.png -r hmac_key -s $((18)) -l H
convert -pointsize $((70)) "label:$(cat hmac_key_part_1)" "hmac_hey_plaintext_part_1.gif"
convert -pointsize $((70)) "label:$(cat hmac_key_part_2)" "hmac_hey_plaintext_part_2.gif"
convert -append key.png hmac_hey_plaintext_part_1.gif hmac_hey_plaintext_part_2.gif key.total.gif
