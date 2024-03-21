FROM ubuntu:16.04
EXPOSE 61616
WORKDIR /root

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
	firefox \
	firefox-locale-zh-hans \
	fonts-wqy-zenhei fonts-wqy-microhei \
	language-pack-zh-hans \
	vnc4server \
	git\
	matchbox-window-manager


ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN locale-gen zh_CN.UTF-8 &&  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
RUN locale-gen zh_CN.UTF-8  
ENV LANG zh_CN.UTF-8  
ENV LANGUAGE zh_CN:zh  
ENV LC_ALL zh_CN.UTF-8  

RUN mkdir /root/.vnc
COPY vnc/xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

COPY run.sh /root/run.sh
RUN chmod +x /root/run.sh

COPY fonts /usr/share/fonts/

RUN apt-get install -y --no-install-recommends scim scim-pinyin

COPY config /etc/scim/config

RUN apt remove -y ca-certificates
RUN apt-get install -y --no-install-recommends ca-certificates
RUN git clone https://github.com/novnc/noVNC
COPY start-novnc.sh /root/start-novnc.sh
RUN chmod +x /root/start-novnc.sh
RUN apt-get install -y --no-install-recommends ffmpeg
