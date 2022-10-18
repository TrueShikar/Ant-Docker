FROM ubuntu:20.04

RUN apt update -y
RUN apt-get install wget curl systemd sudo -y
RUN wget -O ant.zip https://github.com/ant-media/Ant-Media-Server/releases/download/ams-v2.4.3/ant-media-server-community-2.4.3.zip
RUN ./install_ant-media-server.sh -i ant.zip

CMD service antmedia start
