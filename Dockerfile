FROM isim/wso2esb

COPY startup.sh run_client.sh ./

# install ant and curl, build SimpleStockQuoteService
RUN apt-get update && \
    apt-get install -y curl ant && \
    apt-get clean && \
    chmod +x startup.sh run_client.sh && \
    cd samples/axis2Server/src/SimpleStockQuoteService && \
    ant

EXPOSE 9000

ENTRYPOINT ./startup.sh
