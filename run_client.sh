#!/bin/sh

# let servers start
sleep 10
cd samples/axis2Client
# run axis2 client forever
while true
do
  ant stockquote -Dtrpurl=http://localhost:8280/services/StockQuote
	sleep 5
done
