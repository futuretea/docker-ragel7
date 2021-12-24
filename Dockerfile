FROM alpine:3.13
RUN apk update
RUN apk add git make libtool gcc g++ autoconf automake curl asciidoc
RUN mkdir /app
WORKDIR /app

# Install colm
RUN git clone -b 0.14.7 https://github.com/adrian-thurston/colm.git
WORKDIR /app/colm
RUN ./autogen.sh && ./configure
RUN make && make install

# Install ragel
WORKDIR /app
RUN git clone -b 7.0.4 https://github.com/adrian-thurston/ragel.git
WORKDIR /app/ragel
RUN ./autogen.sh && ./configure --with-colm=/usr/local --disable-manual
RUN make && make install
RUN mkdir /work
WORKDIR /work
