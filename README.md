# WSO2ESB Samples

# Description
This docker-compose project helps you run the WSO2ESB samples from https://docs.wso2.com/display/ESB450/Samples.

## Short Description
This docker-compose project helps you run the WSO2ESB samples from https://docs.wso2.com/display/ESB450/Samples.

## APM version
Tested with CA APM 10.7.

## Supported third party versions
Tested with WSO2ESB 4.5.0.

## Limitations
n/a

## License
[Apache License, Version 2.0](LICENSE)

# Installation Instructions

## Prerequisites
Download the following files:
* WSO2ESB binary (e.g. `wso2esb-4.5.0.zip`)
* CA APM Java Agent binary (e.g. [`IntroscopeAgentFiles-NoInstaller10.7.0.90tomcat.unix.tar`](https://support.ca.com))

Install [Docker](https://docs.docker.com/install/) and [docker-compose](https://docs.docker.com/compose/install/).

## Dependencies
CA APM 10.7 and WSO2ESB 4.5.0.

## Installation
1. Build an WSO2ESB base image: `docker build -f Dockerfiel-esb450 -t wso2esb:4.5.0`
2. Build the samples image: `docker-compose build`

## Configuration
* Set the environment variables `MANAGER_URL` and `AGENT_HOSTNAME` in `docker-compose.yml` to configure those CA APM agent properties.
* Change the `command` in `docker-compose.yml` to select the sample number you want to run.

# Usage Instructions
Start a new container with `docker-compose up -d`. This will execute the configured sample once.

To run the sample again or run manual requests as described on https://docs.wso2.com/display/ESB450/Samples run a shell in the container `docker exec -it wso2esb-samples_esb_1 sh`, then follow the instructions from the samples, e.g. `cd samples/axis2Client/` and run the command `ant stockquote -Daddurl=http://localhost:9000/services/SimpleStockQuoteService -Dtrpurl=http://localhost:8280/ -Dsymbol=MSFT`.

## Debugging and Troubleshooting
Check the WSO2ESB logs in `repository/logs`.

## Support
This document and associated tools are made available from CA Technologies as examples and provided at no charge as a courtesy to the CA APM Community at large. This resource may require modification for use in your environment. However, please note that this resource is not supported by CA Technologies, and inclusion in this site should not be construed to be an endorsement or recommendation by CA Technologies. These utilities are not covered by the CA Technologies software license agreement and there is no explicit or implied warranty from CA Technologies. They can be used and distributed freely amongst the CA APM Community, but not sold. As such, they are unsupported software, provided as is without warranty of any kind, express or implied, including but not limited to warranties of merchantability and fitness for a particular purpose. CA Technologies does not warrant that this resource will meet your requirements or that the operation of the resource will be uninterrupted or error free or that any defects will be corrected. The use of this resource implies that you understand and agree to the terms listed herein.

Although these utilities are unsupported, please let us know if you have any problems or questions by adding a comment to the CA APM Community Site area where the resource is located, so that the Author(s) may attempt to address the issue or question.

Unless explicitly stated otherwise this extension is only supported on the same platforms as the APM core agent. See [APM Compatibility Guide](http://www.ca.com/us/support/ca-support-online/product-content/status/compatibility-matrix/application-performance-management-compatibility-guide.aspx).

### Support URL
https://github.com/CA-APM/wso2esb-samples/issues

# Contributing
The [CA APM Community](https://communities.ca.com/community/ca-apm) is the primary means of interfacing with other users and with the CA APM product team.  The [developer subcommunity](https://communities.ca.com/community/ca-apm/ca-developer-apm) is where you can learn more about building APM-based assets, find code examples, and ask questions of other developers and the CA APM product team.

If you wish to contribute to this or any other project, please refer to [easy instructions](https://communities.ca.com/docs/DOC-231150910) available on the CA APM Developer Community.

## Categories
Examples

# Change log
Changes for each version of the extension.

Version | Author | Comment
--------|--------|--------
1.0 | CA Technologies, A Broadcom Company | First version of the extension.
