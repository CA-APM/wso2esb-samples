#!/bin/bash

# start axis2 server
nohup samples/axis2Server/axis2server.sh > axis2server.log &

# start axis2 client
nohup ./run_client.sh > axis2client.log &

# start sample 1
bin/wso2esb-samples.sh -sn 1
