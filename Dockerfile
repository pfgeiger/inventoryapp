FROM java:8
VOLUME /tmp
ADD app.jar app.jar
RUN bash -c 'touch /app.jar'

# Install prereqs
RUN apt-get update && apt-get install -y jq

# Copy agent files
COPY agents/ /agents/

# Add the new relic agent
RUN wget https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip -O /tmp/newrelic.zip \
  && unzip -u -d /agents /tmp/newrelic.zip newrelic/newrelic.jar \
  && rm /tmp/newrelic.zip

COPY startup.sh startup.sh
EXPOSE 8080
ENTRYPOINT ["./startup.sh"]
