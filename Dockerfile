FROM wso2esb:4.5.0

ENV CA_AGENT=true \
    MANAGER_URL=apm-docker:5009

COPY startup.sh run_client.sh wso2esb.tar.gz ./

ADD IntroscopeAgentFiles-NoInstaller10.7.0.90tomcat.unix.tar .

# install ant and curl, build SimpleStockQuoteService
RUN rm -rf /var/cache/apk/* /tmp/* && \
    apk update && \
    apk add curl apache-ant && \
    rm -rf /var/cache/apk/* /tmp/* && \
    chmod +x startup.sh run_client.sh && \
    cd samples/axis2Server/src/SimpleStockQuoteService && \
    ant

EXPOSE 9000

ENTRYPOINT ["./startup.sh"]
