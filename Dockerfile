FROM sebp/elk
COPY filebeat.sample.csv /opt/logstash/filebeat.sample.csv
COPY 29-elasticsearch-output.conf /etc/logstash/conf.d/29-elasticsearch-output.conf
COPY 03-csv-input.conf /etc/logstash/conf.d/03-csv-input.conf
ENV LS_HOME /opt/logstash
WORKDIR ${LS_HOME}
RUN chown logstash.logstash /etc/logstash/conf.d/*
RUN CONF_DIR=/etc/logstash/conf.d gosu logstash bin/logstash-plugin install logstash-filter-csv
ENV ES_HOME /opt/elasticsearch
WORKDIR ${ES_HOME}
RUN CONF_DIR=/etc/elasticsearch gosu elasticsearch bin/elasticsearch-plugin install ingest-user-agent
RUN CONF_DIR=/etc/elasticsearch gosu elasticsearch bin/elasticsearch-plugin install ingest-geoip
