# Base image (choose appropriate architecture)
ARG BUILD_FROM=ghcr.io/home-assistant/armv7-base-python:3.11
FROM ${BUILD_FROM}

# Install system dependencies
RUN apk add --no-cache \
    python3-dev \
    libffi-dev \
    build-base \
    git \
    avrdude \
    dfu-util \
    stm32flash \
    libusb-dev \
    eudev-dev \
    supervisor

# Clone Klipper
WORKDIR /klipper
RUN git clone https://github.com/Klipper3d/klipper.git . && \
    pip install --no-cache-dir -r requirements.txt

# Clone Moonraker
WORKDIR /moonraker
RUN git clone https://github.com/Arksine/moonraker.git . && \
    pip install --no-cache-dir -r scripts/moonraker-requirements.txt

# Copy configuration files
COPY run.sh /
COPY supervisord.conf /etc/
COPY defaults/ /defaults/

# Set permissions
RUN chmod a+x /run.sh && \
    mkdir -p /tmp/klippy_uds && \
    mkdir -p /tmp/klipper_logs

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost:7125 || exit 1

# Volumes (managed by Home Assistant)
VOLUME /config

# Start script
CMD ["/run.sh"]
