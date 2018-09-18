FROM resin/raspberrypi3-node:latest

ENV INITSYSTEM on

ENV POST_PATH /add.php?wid=1&type=5&token=95a5021768d587b39ae13d965a7676cc

WORKDIR /usr/src/app

RUN apt-get clean && apt-get update

RUN apt-get install pigpio python-pigpio python3-pigpio 

ENV TZ America/Indiana/Indianapolis
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY package*.json ./

RUN npm install 

COPY . .

EXPOSE 443

ENTRYPOINT [ "npm", "start" ]
