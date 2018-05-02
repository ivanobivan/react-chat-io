FROM keymetrics/pm2:latest-alpine
RUN npm install webpack babel-cli pm2 -g
WORKDIR /tmp
ADD package.json /tmp/package.json
ADD pm2.json /tmp/pm2.json
ENV NPM_CONFIG_LOGLEVEL warn
RUN npm config set registry https://registry.npmjs.org/ && npm install
WORKDIR /usr/src/app
ADD . /usr/src/app
RUN cp -a /tmp/node_modules /usr/src/app/ && webpack
CMD [ "pm2-runtime","--json","pm2.json" ]
EXPOSE 5050 43554
