#!/bin/sh

## Run as sudo
rm /usr/local/bin/ionskvm-mac.sh
cp ionskvm-mac.sh /usr/local/bin
chmod 0755 /usr/local/bin/ionskvm-mac.sh
rm -rf /usr/local/bin/lgtvcontrol
mkdir /usr/local/bin/lgtvcontrol
git clone https://github.com/IonCaza/ionskvm /usr/local/bin/lgtvcontrol
oldpath=`pwd`
cd /usr/local/bin
npm install

# xpc build
cd $oldpath
rm xpc_set_event_stream_handler
gcc -framework Foundation -o xpc_set_event_stream_handler xpc_set_event_stream_handler.m
chmod 0755 xpc_set_event_stream_handler
cp xpc_set_event_stream_handler /usr/local/bin

# plist install
launchctl unload /Library/LaunchDaemons/com.ionskvm.plist
rm /Library/LaunchDaemons/com.ionskvm.plist
cp ./com.ionskvm.plist /Library/LaunchDaemons
chown root:wheel /Library/LaunchDaemons/com.ionskvm.plist
launchctl load /Library/LaunchDaemons/com.ionskvm.plist