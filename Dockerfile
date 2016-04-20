FROM node:4.3

RUN mkdir -p /usr/src/shiny
WORKDIR /usr/src/app

RUN apt-get update -qy
RUN apt-get install -y cmake python gcc g++ git build-essential
RUN apt-get install -y r-base
RUN echo "options(bitmapType='cairo')" >> ~/.Rprofile

RUN useradd -r -m shiny
RUN  mkdir -p /var/log/shiny-server
RUN  mkdir -p /srv/shiny-server
RUN  mkdir -p /var/lib/shiny-server
RUN  chown shiny /var/log/shiny-server
RUN  mkdir -p /etc/shiny-server

COPY . /usr/src/shiny

RUN R -e \"install.packages(c('shiny', 'rmarkdown'), repos='http://cran.rstudio.com')\"
RUN npm install
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local
RUN make
RUN npm rebuild
RUN ./ext/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js rebuild
RUN  ln -s /usr/local/shiny-server/bin/shiny-server /usr/bin/shiny-server
