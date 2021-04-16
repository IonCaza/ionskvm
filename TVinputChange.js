var config = require('./config.js')

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

    lgtv.subscribe('ssap://audio/getVolume', function (err, res) {
        if (res.changed && res.changed.indexOf('volume') !== -1) console.log('volume changed', res.volume);
        if (res.changed && res.changed.indexOf('muted') !== -1) console.log('mute changed', res.muted);
    });

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

