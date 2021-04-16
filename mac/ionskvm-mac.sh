#!/bin/sh

if [[ $(ioreg -p IOUSB | grep Realforce -c) > 0 ]]; then
  echo "Realforce is present"
  echo $(node ./lgtvcontrol/TVinputChange.js mac)
else
  echo "Realforce not detected"
fi