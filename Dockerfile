FROM debian:bullseye

# Set the shell to bash so we can use curly brace expansion below
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install --no-install-recommends -y \
      dnsmasq \
      pxelinux \
      syslinux-common \
      syslinux-efi

WORKDIR /pxe/tftp/

#RUN mkdir {bios,efi64} && \
#    cp /usr/lib/syslinux/modules/bios/{ldlinux,vesamenu,libcom32,libutil}.c32 /usr/lib/PXELINUX/pxelinux.0 bios/ && \
#    cp /usr/lib/syslinux/modules/efi64/ldlinux.e64 /usr/lib/syslinux/modules/efi64/{vesamenu,libcom32,libutil}.c32 /usr/lib/SYSLINUX.EFI/efi64/syslinux.efi efi64/

RUN mkdir efi64 && \
    cp /usr/lib/syslinux/modules/efi64/ldlinux.e64 /usr/lib/syslinux/modules/efi64/{vesamenu,libcom32,libutil}.c32 /usr/lib/SYSLINUX.EFI/efi64/syslinux.efi efi64/ && \
    ln -rs pxelinux.cfg efi64


COPY dnsmasq.conf /etc/

RUN dnsmasq --test

EXPOSE 67/udp
EXPOSE 69/udp
EXPOSE 4011/udp

ENTRYPOINT ["/usr/sbin/dnsmasq"]
