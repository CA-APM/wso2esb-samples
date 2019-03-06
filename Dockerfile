FROM wso2esb:4.5.0

ENV CA_AGENT=true \
    MANAGER_URL=apm-docker:5009

# install ant and curl, build SimpleStockQuoteService
RUN rm -rf /var/cache/apk/* /tmp/* && \
    apk update && \
    apk add curl apache-ant && \
    rm -rf /var/cache/apk/* /tmp/* && \
    cd samples/axis2Server/src/SimpleStockQuoteService && \
    ant

EXPOSE 9000

ADD IntroscopeAgentFiles-NoInstaller10.7.0.90tomcat.unix.tar .

COPY startup.sh run_client.sh wso2esb.tar.gz ./

RUN chmod +x startup.sh run_client.sh

ENTRYPOINT ["./startup.sh"]
