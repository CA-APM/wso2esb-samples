FROM isim/wso2esb

ENV CA_AGENT=true \
    MANAGER_URL=apm-docker.ca.com:5009

COPY startup.sh run_client.sh ./

ADD IntroscopeAgentFiles-NoInstaller10.7.0.90tomcat.unix.tar .

# install ant and curl, build SimpleStockQuoteService
RUN apt-get update && \
    apt-get install -y curl ant && \
    apt-get clean && \
    chmod +x startup.sh run_client.sh && \
    cd samples/axis2Server/src/SimpleStockQuoteService && \
    ant

EXPOSE 9000

ENTRYPOINT ./startup.sh
