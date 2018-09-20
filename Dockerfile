FROM resin/raspberrypi3-node:latest

ENV INITSYSTEM on

ENV POST_PATH /add.php?wid=5&type=5&token=b63c2e64fbba9780b4273482f4425071

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
