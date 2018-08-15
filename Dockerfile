FROM resin/raspberrypi3-node:latest

ENV INITSYSTEM on

WORKDIR /usr/src/app

#RUN mkdir /home/app

#RUN groupadd -r app && useradd -r -g app app 

#RUN chown -R app:app /usr/src/app

#RUN chown -R app:app /home/app

#USER app

RUN apt-get clean && apt-get update

RUN apt-get install pigpio python-pigpio python3-pigpio 
#RUN apt-get install rpi-update && sudo rpi-update

COPY package*.json ./

RUN npm install 

COPY . .

EXPOSE 443

CMD [ "npm", "start" ]
