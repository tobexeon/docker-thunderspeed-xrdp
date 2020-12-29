FROM ubuntu:18.04

ADD Deepin-ThunderSpeed.tar.gz /

RUN echo 'deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse \n\
        deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse \n\
        deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse \n\
        deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse'\
        > /etc/apt/sources.list\
	&& dpkg --add-architecture i386\
	&& apt update\
	&& apt install -y wget ca-certificates git openbox xrdp fonts-wqy-microhei\
	; apt install -y wget ca-certificates git openbox xrdp fonts-wqy-microhei -f\
	&& git clone https://github.com/wszqkzqk/deepin-wine-ubuntu\
	&& dpkg -i deepin-wine-ubuntu/*.deb\
	; apt install -f -y\
	; apt install -f -y\
	&& apt autoremove wget git ca-certificates --purge -y\
	&& apt-get clean autoclean\
	&& rm -rf /var/lib/{apt,dpkg,cache,log}/\
	&& rm -rf deepin*\
	&& useradd -m -s /bin/bash thunder\
	&& chown -R thunder /home/thunder\
        && chgrp -R thunder /home/thunder\
	&& passwd thunder\
	&& echo '/opt/deepinwine/tools/run.sh Deepin-ThunderSpeed 7.10.35.366deepin18 \n\
        openbox'\
        >/home/thunder/.xsession\
	&& chown thunder /home/thunder/.xsession\
	&& chgrp thunder /home/thunder/.xsession\
	&& echo 'rm -rf /var/run/xrdp/* \n\
        rm -rf /tmp/.* \n\
        xrdp-sesman \n\
        xrdp -n'\
        > /init\
	&& chmod +x /init

CMD sh -c /init
