FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    git libffi-dev build-essential libjpeg-dev libpng-dev libusb-1.0-0-dev \
    avrdude dfu-util gcc-avr binutils-avr avr-libc stm32flash \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /klipper

# Install Klipper
RUN git clone https://github.com/Klipper3d/klipper.git .
RUN make menuconfig || true

# Install Moonraker
WORKDIR /moonraker
RUN git clone https://github.com/Arksine/moonraker.git .
RUN pip install -r scripts/moonraker-requirements.txt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7125

CMD ["/entrypoint.sh"]