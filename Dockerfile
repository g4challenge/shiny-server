FROM node:5.0

RUN mkdir -p /usr/src/shiny
WORKDIR /usr/src/shiny

RUN apt-get update -qy
RUN apt-get install -y cmake python gcc g++ git build-essential gfortran
RUN wget https://cran.r-project.org/src/base/R-3/R-3.3.1.tar.gz
RUN tar -xvf R-*
WORKDIR R-3.3.1/
RUN ./configure
RUN make
RUN make install
WORKDIR /usr/src/shiny

RUN echo "options(bitmapType='cairo')" >> ~/.Rprofile

RUN  groupadd -r shiny && useradd -r -g  shiny shiny
RUN  mkdir -p /var/log/shiny-server
RUN  mkdir -p /srv/shiny-server
RUN  mkdir -p /var/lib/shiny-server
RUN  chown shiny /var/log/shiny-server
RUN  mkdir -p /etc/shiny-server

COPY . /usr/src/shiny

RUN R -e 'install.packages(c("shiny", "rmarkdown"), repos="http://cran.rstudio.com")'
RUN npm install
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr/local
RUN make
RUN npm rebuild
RUN ./ext/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js rebuild
RUN make install
RUN  ln -s /usr/local/shiny-server/bin/shiny-server /usr/bin/shiny-server

COPY config/default.config /etc/shiny-server/shiny-server.conf

EXPOSE 3838

CMD shiny-server