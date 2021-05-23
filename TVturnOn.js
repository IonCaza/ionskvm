// This script is used to wake your TV up using WOL since LGTV does not have TurnON capability

var config = require('./config.js')

var wol = require('wake_on_lan');

wol.wake(config.macAddress);

wol.wake(config.macAddress, function(error) {
  if (error) {
    // handle error
  } else {
    // done sending packets
  }
});

var magic_packet = wol.createMagicPacket(config.macAddress);