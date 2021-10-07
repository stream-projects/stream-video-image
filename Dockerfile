# stream-video image
FROM    nvidia/cudagl:11.3.0-devel-ubuntu20.04
ENV	    NVIDIA_DRIVER_CAPABILITIES all
WORKDIR     /tmp/workdir
ENV DEBIAN_FRONTEND="noninteractive"
# Install Dependencies
RUN     apt-get -y update && \
        apt-get install -y --no-install-recommends git build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libva-drm2 libva-x11-2 libegl-dev libfdk-aac-dev libappindicator3-1 libatk-bridge2.0-0 libgbm1 libfribidi-dev
# Install Chrome 
ARG CHROME_VERSION="91.0.4472.77-1"
RUN     apt-get -y update && \
        wget https://launchpad.net/~saiarcot895/+archive/ubuntu/chromium-dev/+files/libvdpau1_1.4-2~ubuntu20.04.1_amd64.deb && \
        apt -y install ./libvdpau1_1.4-2~ubuntu20.04.1_amd64.deb && \
        wget https://launchpad.net/~saiarcot895/+archive/ubuntu/chromium-dev/+files/vdpau-va-driver_0.7.4-7ubuntu1~ppa2~20.04.1_amd64.deb && \
        apt -y install ./vdpau-va-driver_0.7.4-7ubuntu1~ppa2~20.04.1_amd64.deb && \
        wget --no-verbose -O chrome.deb https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb && \
        apt  -y install ./chrome.deb