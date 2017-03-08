//get_app_meminfo.js
//author: Zirconi

//adb -s emulator-5556 install helloWorld.apk
const child_process = require('child_process');
const mem_common_prefix = 'adb shell dumpsys meminfo ';
const devices_command = 'adb devices';
const ps_command = 'adb shell ps';

function generate_command(command, device_name) {
    let arr = command.split(' ');
    return 'adb -s ' + device_name + ' ' + arr.slice(1).join(' ') + ' ';
}

function exec_command(command) {
    return new Promise((resolve, reject) => {
        child_process.exec(command,
        (error, stdout, stderr) => {
            if(error) {
                reject(error);
            } else {
                resolve(stdout);
            }
        });
    });
}

function parse_meminfo(stdout, key_word, column) {
    let key_lines = stdout.split(/\r\n|\n/).filter((v) => {
        let line = v.trim();
        for(let i = 0; i < key_word.length; ++i) {
            if(line.startsWith(key_word[i])) {
                return true;
            }
        }
    });
    let key_arr = key_lines.map((v) => {
        return v.split(' ').filter((f) => {
            return f && parseInt(f, 10) >= 0;
        });
    });
    if(key_arr.length == 1) {
        return key_arr[0][column];
    }
    return key_arr.reduce((p, n) => {
        return parseInt(p[column], 10) + parseInt(n[column], 10);
    });
}

async function get_info(device_name, package_name, key_words) {
    let val = undefined;
    let ret = undefined;
    try {
        val = await exec_command(generate_command(mem_common_prefix, device_name)
        + package_name);
        ret = parse_meminfo(val, key_words, 0);
    } catch(e) {
        console.log(e);
        console.log('RAW OUTPUT: ' + val);
    }
    return ret;
}

function get_meminfo(device_name, package_name, key_words) {
    return get_info(device_name, package_name, [key_words]);
}

function parse_devices_list(stdout) {
    let key_lines = stdout.split(/\r\n|\n/).filter((v) => {
        return v.indexOf('device') != -1 && v.indexOf('List of devices') == -1;
    });
    if(key_lines.length === 0) {
        return undefined;
    }
    return key_lines.map((v) => {
        return v.trim().split(/ |\t/)[0].trim();
    });
}

async function get_devices_list() {
    let content = undefined;
    let list = undefined;
    try {
        content = await exec_command(devices_command);
        list = parse_devices_list(content);
    } catch(e) {
        console.log(e);
        console.log('RAW OUTPUT: ' + val);
    }
    return list;
}

function parse_process_list(content) {
    let arr = content.split(/\r\n|\n/)
    .map((v) => {
        let filter = v.split(/ |\t/).filter((item) => {
            return item;
        });
        return filter;
    }).filter((f) => {
        return f.length > 0 && f[0] !== 'root' && f[0] != 'USER';
    });
    return arr.map((v) => {return v[v.length - 1].trim();});
}

async function get_process_list(device_name) {
    let content = undefined;
    let list = undefined;
    try {
        content = await exec_command(generate_command(ps_command, device_name));
        list = parse_process_list(content);
    } catch(e) {
        console.log(e);
        console.log('RAW OUTPUT: ' + e);
    }
    return list;
}

module.exports.get_info = get_info;
module.exports.get_meminfo = get_meminfo;
module.exports.get_devices_list = get_devices_list;
module.exports.get_process_list = get_process_list;
