#!/bin/sh

# let servers start
STARTING=1
while true; do
    grep "WSO2 Carbon started" repository/logs/wso2carbon.log > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
      break;
    fi
    echo "zzzzzz"
    sleep 5
done

cd samples/axis2Client
# run axis2 client forever
while true
do
  case $1 in
    5)
      ant stockquote -Daddurl=http://localhost:9000/services/SimpleStockQuoteService -Dtrpurl=http://localhost:8280/ -Dsymbol=MSFT
      ;;
    *)
      ant stockquote -Dtrpurl=http://localhost:8280/services/StockQuote
      ;;
  esac

  if [ ! -z "$2" ]; then
    sleep $2
  else
    exit 0
  fi
done
