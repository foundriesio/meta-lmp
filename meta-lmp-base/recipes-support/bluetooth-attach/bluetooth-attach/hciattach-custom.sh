#!/bin/sh

set -e

echo Setting up the High Speed HCI interface
hciattach ${HCI_PORT} any 115200 flow
hciconfig hci0 up
hcitool -i hci0 cmd 0x3f 0x0009 0xc0 0xc6 0x2d 0x00
killall hciattach
sleep 2
hciattach ${HCI_PORT} any -s ${HCI_SPEED} ${HCI_SPEED} flow
hciconfig hci0 up
