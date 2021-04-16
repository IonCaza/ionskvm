#!/bin/sh

## Run as sudo
chmod 0755 ionskvm-mac.sh
cp ionskvm-mac.sh /usr/local/bin
mkdir /usr/local/bin/lgtvcontrol
git clone https://github.com/IonCaza/ionskvm /usr/local/bin/lgtvcontrol
npm install /usr/local/bin/lgtvcontrol

# xpc build
rm xpc_set_event_stream_handler
gcc -framework Foundation -o xpc_set_event_stream_handler xpc_set_event_stream_handler.m
chmod 0755 xpc_set_event_stream_handler
cp xpc_set_event_stream_handler /usr/local/bin

# plist install
launchctl unload /Library/LaunchDaemons/com.ionskvm.plist
rm /Library/LaunchDaemons/com.ionskvm.plist
chown root:wheel ./com.ionskvm.plist
cp ./com.ionskvm.plist /Library/LaunchDaemons
launchctl load com.ionskvm.plist