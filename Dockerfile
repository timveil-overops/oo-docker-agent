FROM timveil/oo-docker-base

LABEL maintainer="tjveil@gmail.com"

ARG SECRET_KEY=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1
ARG COLLECTOR_HOST=collector
ARG COLLECTOR_PORT=6060
ARG MACHINE_NAME=agent

RUN curl -sSL http://get.takipi.com/takipi-t4c-installer | bash /dev/stdin -i \
        --sk=$SECRET_KEY \
        --daemon_host=$COLLECTOR_HOST \
        --daemon_port=$COLLECTOR_PORT \
        --machine_name=$MACHINE_NAME \
        && rm -rf /opt/takipi/work/secret.key \
        && sed -i -e '/^takipi.collector.host/d' /opt/takipi/agent.properties

ENTRYPOINT java -agentlib:TakipiAgent -Dtakipi.debug.logconsole -jar overops-event-generator.jar