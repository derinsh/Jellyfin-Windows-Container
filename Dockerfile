ARG winver=

FROM mcr.microsoft.com/windows/servercore:$winver

# Make jellyfin directory in image
RUN md C:\jellyfin

# Copy server install
COPY jellyfin_* C:\\jellyfin\\system

# Create mountpoint for config files
VOLUME C:\\jellyfin\data

# Jellyfin server ports
EXPOSE 8096/tcp
EXPOSE 8097/tcp
EXPOSE 8920/tcp

Workdir C:\\jellyfin
CMD "C:\jellyfin\system\jellyfin.exe -d C:\jellyfin\data"
