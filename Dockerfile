FROM isim/wso2esb

# install ant and curl, build SimpleStockQuoteService
RUN apt-get update && \
    apt-get install -y curl ant && \
    apt-get clean && \
    cd samples/axis2Server/src/SimpleStockQuoteService && \
    ant

EXPOSE 9000

CMD ./startup.sh
