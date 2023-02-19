#FROM nginx:alpine
#COPY static /usr/share/nginx/html

FROM amazoncorretto:17-alpine

ARG WILDFLY_VERSION=26.1.3.Final
ARG NR_APP_NAME

ENV WILDFLY_HOME /opt/wildfly
ENV NEW_RELIC_HOME=/opt/newrelic
ENV NEW_RELIC_APP_NAME $NR_APP_NAME
ENV NEW_RELIC_LOG_FILE_NAME=STDOUT
ENV TZ=America/New_York

RUN apk add --no-cache tzdata fontconfig ttf-dejavu

RUN addgroup -S wildfly && adduser -S wildfly -G wildfly  \
    && wget https://github.com/wildfly/wildfly/releases/download/${WILDFLY_VERSION}/wildfly-${WILDFLY_VERSION}.zip  \
    && unzip wildfly-$WILDFLY_VERSION.zip -d /opt  \
    && ln -s /opt/wildfly-$WILDFLY_VERSION $WILDFLY_HOME  \
    && rm wildfly-$WILDFLY_VERSION.zip \
    && mkdir -p $WILDFLY_HOME/modules/com/oracle/main/ \
    && chown -R wildfly:wildfly $WILDFLY_HOME/
    
RUN wget https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip \
    && unzip newrelic-java.zip -d /opt \
    && rm newrelic-java.zip \
    && chown -R wildfly:wildfly $NEW_RELIC_HOME/
