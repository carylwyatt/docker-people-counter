FROM resin/raspberrypi3-node:latest

ENV INITSYSTEM on

WORKDIR /usr/src/app

RUN apt-get clean && apt-get update

RUN apt-get install pigpio python-pigpio python3-pigpio 

COPY package*.json ./

RUN npm install 

COPY . .

EXPOSE 443

CMD [ "npm", "start" ]
