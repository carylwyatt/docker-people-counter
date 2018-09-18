# docker-people-counter

A dockerized version of [gate-counter](https://github.com/carylwyatt/gate-counter).

## before you build

### javascript file

There are two javascript files in this build:
  - `counter-insight.js` is the default file and is listed as the start script in the `package.json` file
  - `counter-google.js` is the alternate format if you don't have access to LibInsight
    - you can find all of the instructions for setting up the google form in the [gate-counter](https://github.com/carylwyatt/gate-counter) repo
    - make sure to edit `package.json` start script to reflect google vs insight

### environment variable

If you're using the default LibInsight version of this counter, you will need to find the auth token for your LibInsight dataset.

## build

`docker build -t [username]/docker-people-counter .`

## run

`docker run -it --cap-add=ALL --privileged -v /lib/modules:/lib/modules [username]/docker-people-counter`

This should create a new raspi-IO board, initialize the REPL, then immediately close the board. (I'm working on getting this to just run from that point without closing the board.) To get your command prompt back, type `CTRL + P + Q`. 

## exec

You can use the exec command to run the app for now. 

- Run `docker ps` to get the ID (you only really need the first four characters) to run the container.
- Run `docker exec -it [ID number] /bin/bash` to get a prompt
- Run `node gate-counter.js` to open raspi-io board, initialize REPL, and calibrate the IR sensor

## count

You should be good to start counting!
