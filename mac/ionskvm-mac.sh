#!/bin/sh

if [[ $(ioreg -p IOUSB | grep Realforce -c) > 0 ]]; then
  echo "Realforce is present"
  node ./lgtvcontrol/TVinputChange.js mac > /tmp/ionskvm_app.log 2> /tmp/ionskvm_err.log
  echo "Swap complete"
else
  echo "Realforce not detected"
fi