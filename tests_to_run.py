"""
Robot Framework documentation on how to select test cases to run:
https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#selecting-test-cases

If all list variables in this file are left empty (empty list)
then ALL tests under 'morpheus/tests/' will be executed.
"""


INCLUDE_TAGS = ['smoke']

EXCLUDE_TAGS = ['no-run']

SUITES = []

TESTS_BY_NAME = []


"""
+-----------------------------------------------------------------------------+
|                               AVAILABLE TAGS                                |
|-----------------------------------------------------------------------------|
| HIGH LEVEL..: web, web-e2e, integration, factory-default                    |
|-----------------------------------------------------------------------------|
| STATUS......: status, processing                                            |
|-----------------------------------------------------------------------------|
| WIZARD......: wizard-router, wizard-repeater, wizard-facebook, router       |
|-----------------------------------------------------------------------------|
| NETWORK.....: ethernet, lan, network-lan, wan, dns, routes                  |
|-----------------------------------------------------------------------------|
| WIRELESS....: wireless, wireless-2ghz, wireless-5ghz, wireless-roaming,     |
|               wireless-advanced, ssid-isolation, ssid-scheduling            |
|-----------------------------------------------------------------------------|
| WI-FI MARKETING....:  captive-portal                                        |
|-----------------------------------------------------------------------------|
| TOOLS....:    site-survey                                                   |
|-----------------------------------------------------------------------------|
| SERVICES....: services, auto-configuration, discovery, discovery-intelbras, |
|               ntp, snmp, log, watchdog, ddns                                |
|-----------------------------------------------------------------------------|
| QOS ........: qos                                                           |
|-----------------------------------------------------------------------------|
| FIREWALL....: firewall, dmz, icmp-flood, ip-control, mac-control            |
|-----------------------------------------------------------------------------|
| SYSTEM......: system, led, system-management, ssh, password, first-access,  |
|               settings, legal-information, update, reboot                   |
+-----------------------------------------------------------------------------+
"""