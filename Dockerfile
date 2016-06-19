#FROM buildpack-deps:jessie
FROM python:2.7.11

ARG GRAPHLABLIC
ARG GRAPHLABUSER

RUN pip install --upgrade --no-cache-dir https://get.graphlab.com/GraphLab-Create/1.10.1/${GRAPHLABUSER}/${GRAPHLABLIC}/GraphLab-Create-License.tar.gz; \
    pip install jupyter; \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && apt-get upgrade -y && apt-get install -y supervisor vim xvfb x11vnc wget git fluxbox xterm
    
ENV VNC_RESOLUTION 1280x960
EXPOSE 5900

ADD .fluxbox /root/.fluxbox
ADD scripts /root/scripts
ADD .bashrc /root/.bashrc
ADD .vimrc /root/.vimrc
RUN chmod +x /root/scripts/*.sh /root/.fluxbox

RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/root/scripts/vnc_startup.sh"]
