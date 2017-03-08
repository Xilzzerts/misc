const Chart = require('chart.js');
const mem = require('./adb_utility.js');

function chart(ctx) {
    let live_chart = new Chart(ctx, {
        type: 'line',
        responsive: true,
        maintainAspectRatio: true,
        data: {
            datasets: [{
                label: 'mem',
                data: []
            }
            ]
        },
        options: {
            scales: {
                xAxes:[{
                    type: 'linear',
                    position: 'bottom',
                    ticks: {
                        beginAtZero: true,
                        stepValue: 1,
                        step: 800
                    }
                }],
                yAxes:[{
                    ticks: {
                        beginAtZero: true,
                        stepValue: 1,
                        step: 800
                    }
                },
                ]
            }
        }
    });
    return live_chart;
}

var is_running = false;
var global_interval;

function start_monitoring(ctx, device_name, package_name, key_words, time) {
    let live_chart = chart(ctx);
    let step = 0;
    is_running = true;
    if(global_interval === undefined) {
        global_interval = setInterval(() => {
            get_meminfo(device_name, package_name, key_words).then((v) => {
                if(v) {
                    live_chart.data.datasets[0].data.push({x: step, y: v});
                    step++;
                    live_chart.update();
                } else {
                    stop_monitoring();
                }
            });
        }, time);
    }
}

function stop_monitoring() {
    if(is_running) {
        clearInterval(global_interval);
        is_running = false;
        global_interval = undefined;
    }
}

function clean() {
    let live_chart = chart(ctx);
    live_chart.data.datasets[0].data = [];
    live_chart.update();
}
