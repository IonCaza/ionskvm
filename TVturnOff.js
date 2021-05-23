var config = require('./config.js')
var shell = require('shelljs');

var numberOfRealforceDevices = shell.exec('ioreg -p IOUSB | grep Realforce -c').replace(/\n/g,'')
console.log(numberOfRealforceDevices)

var myArgs = process.argv.slice(2);
var os = myArgs[0];
console.log(os);

var lgtv = require('./index.js')({
    url: 'ws://' + config.ip + ':3000'
});

lgtv.on('error', function (err) {
    console.log(err);
});

lgtv.on('connecting', function () {
    console.log('connecting');
});

lgtv.on('connect', function () {
    console.log('connected');

    lgtv.subscribe('ssap://com.webos.applicationManager/getForegroundAppInfo', function (err, res) {
        console.log('app', res.appId);
        if (os == "mac" && res.appId == config.winPort) {
            lgtv.request('ssap://system.launcher/launch', {id: config.macPort});
        }else if (os == "win" && res.appId == config.macPort) {
            lgtv.request('ssap://system.launcher/launch', {id: config.winPort});            
        }
        process.exit(1)
    });
});


lgtv.on('prompt', function () {
    console.log('please authorize on TV');
});

lgtv.on('close', function () {
    console.log('close');
});

