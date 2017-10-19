FROM ubuntu:14.04

SHELL ["bash", "-c"]

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    gcc-avr \
    gdb-avr \
    binutils-avr \
    avr-libc \
    avrdude \
    libsdl1.2-dev \
    libjansson-dev \
    cmake \
    check \
    libftdi-dev \
    libqt4-dev \
    qt4-qmake \
    && rm -rf /var/lib/apt/lists/*

# for X-server access
ENV DISPLAY=:0 \
    QT_X11_NO_MITSHM=1 \
    KILOHEADERS=/root/kilolib
VOLUME /tmp/.X11-unix


# build kilolib
WORKDIR /root
RUN git clone https://github.com/acornejo/kilolib
WORKDIR /root/kilolib
RUN make

# build kilombo
WORKDIR /root
RUN git clone https://github.com/JIC-CSB/kilombo
WORKDIR /root/kilombo
RUN mkdir build
WORKDIR /root/kilombo/build
RUN cmake .. && make install

# build kilogui
WORKDIR /root
RUN git clone https://github.com/mickael9/kilobots-toolchain
WORKDIR /root/kilobots-toolchain
RUN make install

COPY startup /root/startup

RUN chmod a+w /root/* -Rf

RUN echo "umask 000" >> /root/.bashrc

WORKDIR /root/work
