const POST_PATH = process.env.POST_PATH;
const request = require('request');
const moment = require('moment');
const schedule = require('node-schedule');
const Raspi = require('raspi-io');
const five = require('johnny-five');
const board = new five.Board({
  io: new Raspi()
});


//form URL 
const libinsightURL = `https://ivytech.libinsight.com${POST_PATH}`;

let count = 0;

board.on("ready", function() {

  // Create a new `motion` hardware instance.
  var motion = new five.Motion('GPIO7');

  // "calibrated" occurs once, at the beginning of a session,
  motion.on("calibrated", function() {
    console.log("calibrated", moment().format("MMMM D, YYYY HH:mm:ss"));
  });

 

  // "motionend" events are fired following a "motionstart" event
  // when no movement has occurred in X ms
  motion.on("motionend", function() {

     count += 1;
     console.log("movement", moment().format("hh:mm:ss a"), " The count is " + count);
     
  
  });

  //cron job runs every hour on the hour
  //sends http request to libsight via POST method
  //resets the count to zero
  var j = schedule.scheduleJob('0 * * * *', function(){
  //      let month = moment().format("MMMM");
    let time = moment().format("HH:mm:ss");
    let date = moment().format("MM-DD");
    let url = libinsightURL;
    let dateTime = `'${moment().format("YYYY-MM-DD HH:mm")}'`;
    let counterData = {
      date: moment().subtract(1, 'hours').format("YYYY-MM-DD HH:mm"),
      gate_start: 0, 
      gate_end: count
    };

    request.post(
      {url: url, form: counterData}, 
      function (error, response, body) {
        console.log('Data sent:  hour= ' + moment().subtract(1, 'hours').format("HH:mm") + ' on ' + date + ' at '+ time);

        //uncomment this console.log to test the form submission result	
       // console.log('body:', body); // Print the form submission result
    });
    count = 0;
  });

  //run cron job
  j;

});
