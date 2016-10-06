FROM node:6

EXPOSE 3000

COPY ./ /usr/src/movieupcapi

RUN cd /usr/src/movieupcapi; npm install

CMD [ "node", "/usr/src/movieupcapi/movieupcapi.js" ]
