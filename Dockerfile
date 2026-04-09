FROM debian:bookworm-slim AS base
 
ENV DEBIAN_FRONTEND="noninteractive"

RUN useradd -ms /bin/bash admin

RUN usermod -aG sudo admin


# Set passwords
RUN --mount=type=secret,id=pusrs \
    echo "root:$(sed -n '1s/\s*#.*$//p' /run/secrets/pusrs)" | chpasswd

RUN --mount=type=secret,id=pusrs \
    echo "admin:$(sed -n '2s/\s*#.*$//p' /run/secrets/pusrs)" | chpasswd

RUN dpkg --add-architecture i386

# Install prerequisites
RUN sed -i 's/^Components: main$/Components: main contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources
RUN apt-get update \
    && apt-get install -y \
        apt-transport-https \
        ca-certificates \
	gpg \
        tar \
        gzip \
	unzip \
	gpg-agent \
	libasound2 \
	pulseaudio \
	pulseaudio-utils \
	libpulse0 \
	alsa-utils \
        sudo \
        wget \
    && rm -rf /var/lib/apt/lists/*


FROM base AS with_wine

# Install wine ${DEBIAN_VERSION}
ARG DEBIAN_VERSION="bookworm"
ARG WINE_BRANCH="stable"

RUN dpkg --add-architecture i386
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/${DEBIAN_VERSION}/winehq-${DEBIAN_VERSION}.sources
RUN apt-get update \
    && apt-get install -y --install-recommends winehq-${WINE_BRANCH} \
    && rm -rf /var/lib/apt/lists/*
#RUN apt-get update \
#    && apt-get install -y --install-recommends wine wine64 wine32 \
#    && rm -rf /var/lib/apt/lists/*


FROM with_wine AS with_tricks

# Gets winetricks

RUN apt-get update \
    && apt-get install -y winetricks \
        dbus-x11 \
        x11-xserver-utils \
        git \
        gosu \
        p7zip \
        software-properties-common \
        tzdata \
        unzip \
        gnupg \
        less \
        pciutils \
        vulkan-tools \
        mesa-vulkan-drivers \
        mesa-vulkan-drivers:i386 \
        libvulkan1 \
        libvulkan1:i386 \
        libglx-mesa0 \
        libgl1-mesa-dri \
	libxv-dev:i386 \
	libglu1-mesa-dev:i386 \
	xauth \
        jq \
        curl \
        libcanberra-gtk-module \
        libcanberra-gtk3-module \
	g++-multilib \
    && rm -rf /var/lib/apt/lists/*


FROM with_tricks AS with_opengl

# Gets virtualg
RUN wget https://raw.githubusercontent.com/VirtualGL/repo/main/VirtualGL.list \
    -O  /etc/apt/sources.list.d/VirtualGL.list
RUN wget -q -O- https://packagecloud.io/dcommander/virtualgl/gpgkey | \
    gpg --dearmor >/etc/apt/trusted.gpg.d/VirtualGL.gpg
RUN apt-get update && apt-get install -y virtualgl virtualgl32

FROM with_opengl AS with_lutris

# Gets Lutris

# Lutris dependencies
RUN echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | tee /etc/apt/sources.list.d/lutris.list \
    && wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | apt-key add - \
    && apt-get update \
    && apt-get -y install \
    lutris \
    && rm -rf /var/lib/apt/lists/*

# Get latest Lutris client
RUN mkdir -p /tmp/lutris && \
    curl -s https://api.github.com/repos/lutris/lutris/releases/latest > /tmp/lutris/version.json && \
    jq ".tarball_url" /tmp/lutris/version.json | xargs curl -Lo /tmp/lutris/lutris && \
    mkdir -p /opt/lutris && \
    tar -C /opt/lutris --strip-components 1 -xf /tmp/lutris/lutris && \
    rm -rf /tmp/lutris

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

USER admin

WORKDIR /home/admin

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
