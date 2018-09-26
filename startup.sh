#!/bin/bash

# start axis2 server
nohup samples/axis2Server/axis2server.sh > axis2server.log &

# start axis2 client
nohup ./run_client.sh > axis2client.log &

PWD=$(pwd)

# configure java agent
if [ ${CA_AGENT} = true ] && [ -d "${PWD}/wily" ]; then

  ### Start of APM agent setup ####
  export JAVA_OPTS="${JAVA_OPTS} -javaagent:${PWD}/wily/Agent.jar -Dcom.wily.introscope.agentProfile=${PWD}/wily/coer/config/IntroscopeAgent.profile -Dcom.wily.introscope.agent.agentName=WSO2ESB -Dintroscope.agent.customProcessName=WSO2ESB -Dintroscope.agent.platform.monitor.system=Alpine"

  ### update agent profile
	if [ ! -z "${MANAGER_URL}" ]; then

		sed -i "s|agentManager.url.1=|#agentManager.url.1=|g;s|#agentManager.url.1=|agentManager.url.1=${MANAGER_URL}\n#agentManager.url.1=|g;" ${PWD}/wily/core/config/IntroscopeAgent.profile

		if [ ! -z "${MANAGER_TOKEN}" ]; then
			if grep -q "^agentManager.credential" ${PWD}/wily/core/config/IntroscopeAgent.profile; then
				# replace property
				sed -i "s|^agentManager.credential=.*$|agentManager.credential=${MANAGER_TOKEN}|g;" ${PWD}/wily/core/config/IntroscopeAgent.profile
			else
				# add property
				sed -i "s|^agentManager.url.1=|agentManager.credential=${MANAGER_TOKEN}\nagentManager.url.1=|g;" ${PWD}/wily/core/config/IntroscopeAgent.profile
			fi
		else
			# comment out property
			sed -i "s|^agentManager.credential=|#agentManager.credential=|g;" ${PWD}/wily/core/config/IntroscopeAgent.profile
		fi
	fi

	if [ ! -z "${LOG_LEVEL}" ]; then
		sed -i "s|log4j.logger.IntroscopeAgent=INFO|log4j.logger.IntroscopeAgent=${LOG_LEVEL}|g;" ${PWD}/wily/core/config/IntroscopeAgent.profile
	fi
  #### End of APM agent setup ####
else
	echo "no apm agent"
	# setup 3rd party java agent if needed here
fi


# start sample 1
bin/wso2esb-samples.sh -sn 1
