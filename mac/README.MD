# Build xpc_set_event_stream_handler
gcc -framework Foundation -o xpc_set_event_stream_handler xpc_set_event_stream_handler.m

# Plist
* ``` chown root:wheel on plist
* copy plist /Library/LaunchDaemons/
* launchctl load /Library/LaunchDaemons/com.ionskvm.plist