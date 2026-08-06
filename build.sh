#!/bin/bash
set -ex
#
echo "FFmpeg ${1} Nvenc ${2}"
#
## Prepare
apt-get update
apt-get install -y \
    curl diffutils file coreutils m4 xz-utils nasm python3 python3-pip appstream
#
## Install dependencies
apt-get install -y \
    autoconf \
    automake \
    build-essential \
    cmake \
    git \
    libass-dev \
    libbz2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libjansson-dev \
    liblzma-dev \
    libmp3lame-dev \
    libnuma-dev \
    libogg-dev \
    libopus-dev \
    libsamplerate-dev \
    libspeex-dev \
    libtheora-dev \
    libtool \
    libtool-bin \
    libturbojpeg0-dev \
    libvorbis-dev \
    libx264-dev \
    libxml2-dev \
    libvpx-dev \
    m4 \
    make \
    nasm \
    ninja-build \
    patch \
    pkg-config \
    tar \
    zlib1g-dev \
    autopoint \
    imagemagick \
    gsfonts \
    wget \
    libzmq5 \
    libzmq3-dev

apt-get install -y \
    libgnutls28-dev \
    libsdl2-dev \
    libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev \
    libsnappy-dev \
    libunistring-dev
#
#
git clone -b sdk/$2 https://github.com/FFmpeg/nv-codec-headers.git \
	&& cd nv-codec-headers \
	&& make \
	&& make install
#

wget https://ffmpeg.org/releases/ffmpeg-$1.tar.xz \
 && tar -xf ffmpeg-$1.tar.xz \
 && rm ffmpeg-$1.tar.xz
#
mkdir -p /tmp/bin
# Configure and build ffmpeg with nvenc support
#   ./configure --prefix=/usr/local \
#     --bindir="/tmp/bin" \
#     --enable-filter=drawtext \
#     --enable-nonfree \
#     --enable-nvenc \
#     --enable-gpl \
#     --enable-version3 \
#     --enable-static \
#     --disable-debug \
#     --disable-ffplay \
#     --disable-indev=sndio \
#     --disable-outdev=sndio \
#     --cc=gcc \
#     --enable-fontconfig \
#     --enable-gray \
#     --enable-libmp3lame \
#     --enable-libopus \
#     --enable-libvpx \
#     --enable-libx264 \
#     --enable-libzmq \
#     --disable-htmlpages \
#     --extra-cflags=-I/usr/local/cuda/include \
#     --extra-ldflags=-L/usr/local/cuda/lib64 \
cd ffmpeg-$1 \
 && ./configure --prefix=/usr \
    --bindir="/tmp/bin" \
    --libdir=/usr/lib/x86_64-linux-gnu \
    --arch=amd64 \
    --enable-gpl \
    --disable-stripping \
    --disable-omx \
    --enable-gnutls \
    --enable-libaom \
    --enable-libass \
    --enable-libbs2b \
    --enable-libcaca \
    --enable-libcdio \
    --enable-libcodec2 \
    --enable-libdav1d \
    --enable-libflite \
    --enable-libfontconfig \
    --enable-libfreetype \
    --enable-libfribidi \
    --enable-libglslang \
    --enable-libgme \
    --enable-libgsm \
    --enable-libharfbuzz \
    --enable-libmp3lame \
    --enable-libmysofa \
    --enable-libopenjpeg \
    --enable-libopenmpt \
    --enable-libopus \
    --enable-librubberband \
    --enable-libshine \
    --enable-libsnappy \
    --enable-libsoxr \
    --enable-libspeex \
    --enable-libtheora \
    --enable-libtwolame \
    --enable-libvidstab \
    --enable-libvorbis \
    --enable-libvpx \
    --enable-libwebp \
    --enable-libx265 \
    --enable-libxml2 \
    --enable-libxvid \
    --enable-libzimg \
    --enable-openal \
    --enable-opencl \
    --enable-opengl \
    --disable-sndio \
    --enable-libvpl \
    --disable-libmfx \
    --enable-libdc1394 \
    --enable-libdrm \
    --enable-libiec61883 \
    --enable-chromaprint \
    --enable-frei0r \
    --enable-ladspa \
    --enable-libbluray \
    --enable-libjack \
    --enable-libpulse \
    --enable-librabbitmq \
    --enable-librist \
    --enable-libsrt \
    --enable-libssh \
    --enable-libsvtav1 \
    --enable-libx264 \
    --enable-libzmq \
    --enable-libzvbi \
    --enable-lv2 \
    --enable-sdl2 \
    --enable-libplacebo \
    --enable-librav1e \
    --enable-pocketsphinx \
    --enable-librsvg \
    --enable-libjxl \
    --enable-shared \
    --disable-htmlpages \
    --extra-cflags=-I/usr/local/cuda/include \
    --extra-ldflags=-L/usr/local/cuda/lib64 \
 && make install \
 && cd ..
#
tar -czvf /tmp/bin/ffmpeg-${1}-nvenc-${2}.tar --transform='s|.*/||' /tmp/bin/ffmpeg /tmp/bin/ffprobe
ls -l /tmp/bin
#
echo "Finished FFmpeg ${1} Nvenc ${2}"
#
