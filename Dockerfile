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
    qt4-qmake

# for X-server access
ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1
#VOLUME /tmp/.X11-unix:/tmp/.X11-unix:rw
VOLUME /tmp/.X11-unix


WORKDIR /root
RUN git clone https://github.com/acornejo/kilolib

# build kilolib
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

# is required for compiling Kilombo code into .hex files for Kilobots
ENV KILOHEADERS=/root/kilolib
WORKDIR /root/work
