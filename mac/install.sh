#!/bin/sh

## Run as sudo - supply param 3 for all, 1 for plist
oldpath=`pwd`
GOTO=$1
if [ $# -eq 0 ] 
then
    GOTO=3
fi

# app build
if [ $GOTO -ge 3 ] 
then
rm /usr/local/bin/ionskvm-mac.sh
cp ionskvm-mac.sh /usr/local/bin
chmod 0755 /usr/local/bin/ionskvm-mac.sh
rm -rf /usr/local/bin/lgtvcontrol
mkdir /usr/local/bin/lgtvcontrol
git clone https://github.com/IonCaza/ionskvm /usr/local/bin/lgtvcontrol
cd /usr/local/bin/lgtvcontrol
npm install
fi

# xpc build
if [ $GOTO -ge 2 ] 
then
cd $oldpath
rm xpc_set_event_stream_handler
gcc -framework Foundation -o xpc_set_event_stream_handler xpc_set_event_stream_handler.m
chmod 0755 xpc_set_event_stream_handler
cp xpc_set_event_stream_handler /usr/local/bin
fi

# plist install
if [ $GOTO -ge 1 ] 
then
launchctl unload /Library/LaunchDaemons/com.ionskvm.plist
rm /Library/LaunchDaemons/com.ionskvm.plist
cp ./com.ionskvm.plist /Library/LaunchDaemons
chown root:wheel /Library/LaunchDaemons/com.ionskvm.plist
launchctl load /Library/LaunchDaemons/com.ionskvm.plist
fi