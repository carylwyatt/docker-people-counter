# docker-people-counter

A dockerized version of [gate-counter](https://github.com/carylwyatt/gate-counter).

*There's much more info in the original repo (link above) about what this people counter does, why it works that way, and how it came to be. Check that out if you have questions.*

## before you build

### javascript file

There are two javascript files in this build:
  - `counter-insight.js` is the default file and is listed as the start script in the `package.json` file
  - `counter-google.js` is the alternate format if you don't have access to LibInsight
    - you can find all of the instructions for setting up the google form in the [gate-counter](https://github.com/carylwyatt/gate-counter) repo
    - make sure to edit `package.json` start script to reflect google vs insight

### environment variable

If you're using the default LibInsight version of this counter, you will need to find the auth token for your LibInsight dataset:
- Log in to LibApps and head to LibInsight
- From the main nav up top, select **Admin** > **Widgets and APIs**
- Locate the name of your space, then under **Actions** click on the icon that looks like `</>`
- In the code box, select the second line, and copy everything past the word `POST` (including the `/` before `add.php?.....`)
- Now you have two options:
  1. Update the `Dockerfile` on line 4: `ENV POST_PATH [code you copied]`
  2. During the run step (see below) add this flag after the `-it` flag: `-e POST_PATH [code you copied]` 

## build

`docker build -t counter .`

## run

`docker run -it --cap-add=ALL --privileged -v /lib/modules:/lib/modules counter`

This should create a new raspi-IO board, initialize the REPL, and calibrate the sensor. It should then remain open and start counting as people walk in front of it. Every hour on the hour, it should send the data from the previous hour to the LibInsight API. (This will be every 10 minutes in the google version.) To exit the counter, hit Ctrl-C twice. This should stop counting, close the board, and exit and stop the Docker container.  

