#!/bin/sh

# start axis2 server
nohup samples/axis2Server/axis2server.sh > axis2server.log &

# start axis2 client
nohup ./run_client.sh > axis2client.log &

PWD=$(pwd)

# configure java agent
if [ ${CA_AGENT} = true ] && [ -d "${PWD}/wily" ]; then

  WILY_CONFIG=${WILY_CONFIG}

  ### Start of APM agent setup ####
  export JAVA_OPTS="${JAVA_OPTS} -javaagent:${PWD}/wily/Agent.jar -Dcom.wily.introscope.agentProfile=${WILY_CONFIG}/IntroscopeAgent.profile -Dcom.wily.introscope.agent.agentName=WSO2ESB -Dintroscope.agent.customProcessName=WSO2ESB -Dintroscope.agent.platform.monitor.system=Alpine"

  if [ ! -z "${AGENT_HOSTNAME}" ]; then
    export JAVA_OPTS="${JAVA_OPTS} -Dcom.wily.introscope.agent.hostName=${AGENT_HOSTNAME}"
  fi

  ### update agent profile
	if [ ! -z "${MANAGER_URL}" ]; then

		sed -i "s|agentManager.url.1=|#agentManager.url.1=|g;s|#agentManager.url.1=|agentManager.url.1=${MANAGER_URL}\n#agentManager.url.1=|g;" ${WILY_CONFIG}/IntroscopeAgent.profile

		if [ ! -z "${MANAGER_TOKEN}" ]; then
			if grep -q "^agentManager.credential" ${WILY_CONFIG}/IntroscopeAgent.profile; then
				# replace property
				sed -i "s|^agentManager.credential=.*$|agentManager.credential=${MANAGER_TOKEN}|g;" ${WILY_CONFIG}/IntroscopeAgent.profile
			else
				# add property
				sed -i "s|^agentManager.url.1=|agentManager.credential=${MANAGER_TOKEN}\nagentManager.url.1=|g;" ${WILY_CONFIG}/IntroscopeAgent.profile
			fi
		else
			# comment out property
			sed -i "s|^agentManager.credential=|#agentManager.credential=|g;" ${WILY_CONFIG}/IntroscopeAgent.profile
		fi
	fi

  # set log level
	if [ ! -z "${LOG_LEVEL}" ]; then
		sed -i "s|log4j.logger.IntroscopeAgent=INFO|log4j.logger.IntroscopeAgent=${LOG_LEVEL}|g;" ${WILY_CONFIG}/IntroscopeAgent.profile
	fi

  # install wso2esb extension
  if [ -f wso2esb.tar.gz ]; then
    if [ ! -f ${WILY_CONFIG}/webservices.pbd.orig ]; then
      cp ${WILY_CONFIG}/webservices.pbd ${WILY_CONFIG}/webservices.pbd.orig
    fi
    if [ ! -f ${WILY_CONFIG}/spm-correlation.pbd.orig ]; then
      cp ${WILY_CONFIG}/spm-correlation.pbd ${WILY_CONFIG}/spm-correlation.pbd.orig
    fi
    cd wily
    tar -xf ../wso2esb.tar.gz
    cd ..
    grep wso2esb ${WILY_CONFIG}/tomcat-typical.pbl > /dev/null 2>&1
    if [ "$?" -ne "0" ]; then
      echo -e "\nwso2esb.pbd\napache-http-core.pbd\napache-axis2.pbd\n" >> ${WILY_CONFIG}/tomcat-typical.pbl
    fi
  fi

  #### End of APM agent setup ####

else
	echo "no apm agent"
fi


# start sample 1
bin/wso2esb-samples.sh -sn 1
