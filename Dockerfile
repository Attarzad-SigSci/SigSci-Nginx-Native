FROM nginx:1.19.5

# initial setup
RUN apt-get update
RUN apt-get install -y apt-transport-https wget sed curl gnupg

# add the Signal Sciences and nginx repos to our apt sources
RUN wget -qO - https://apt.signalsciences.net/release/gpgkey | apt-key add -
RUN echo "deb https://apt.signalsciences.net/release/debian/ buster main" > /etc/apt/sources.list.d/sigsci-nginx.list
RUN apt-get update


# install and configure the sigsci agent
RUN apt-get -y install sigsci-agent
# install the sigsci module
RUN apt-get -y install nginx-module-sigsci-nxo=1.19.5*

# copy config and app over
RUN  mkdir /app && mkdir /etc/sigsci
COPY agent.conf /ect/sigsci/agent.conf
COPY app/nginx.conf /etc/nginx/nginx.conf
COPY app/default.conf /etc/nginx/sites-enabled/default.conf
COPY app/index.html /usr/share/nginx/html/index.html
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENTRYPOINT ["/app/start.sh"]
