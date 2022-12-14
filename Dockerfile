# This docker file can be used in kubernetes. 
# It accepts all cluster related parameters at run time. 
# It means it's very easy to add new containers to the cluster 

FROM ubuntu:20.04


ARG BranchName=master

#Running update and install makes the builder not to use cache which resolves some updates
RUN apt-get update && apt-get install -y curl wget iproute2 cron logrotate

RUN wget -O ant.zip https://github.com/ant-media/Ant-Media-Server/releases/download/ams-v2.4.3/ant-media-server-community-2.4.3.zip
RUN wget https://raw.githubusercontent.com/ant-media/Scripts/${BranchName}/install_ant-media-server.sh \
    && chmod 755 install_ant-media-server.sh

RUN ./install_ant-media-server.sh -i ant.zip -s false


# Options 
# -g: Use global(Public) IP in network communication. Its value can be true or false. Default value is false.
#
# -s: Use Public IP as server name. Its value can be true or false. Default value is false.
#
# -r: Replace candidate address with server name. Its value can be true or false. Default value is false
#
# -m: Server mode. It can be standalone or cluster. Its default value is standalone. If cluster mode is 
#     specified then mongodb host, username and password should also be provided
#
# -h: MongoDB host
#
# -u: MongoDB username
#
# -p: MongoDB password

ENTRYPOINT ["/usr/local/antmedia/start.sh"]
