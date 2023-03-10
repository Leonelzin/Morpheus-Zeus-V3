*** Settings ***
Documentation     QoS Tests Suite
...
...               This test suite contains tests to verify if QoS global limits
...               limits are correctly operating in the DUT.
Library           MorpheusUtils
Library           Testberry    ${DUT}
Resource          utils.resource
Resource          web/login_pom.resource
Resource          web/qos/qos_pom.resource
Test Teardown     Close Browser
Force Tags        qos
#TODO: create an exclusive SSID for QoS tests (QoS Suite Setup)
#TODO: remove SSID that was created exclusively for QoS tests (QoS Suite Teardown)
#TODO: disable non-management Testberry ethernet interfaces that should not be used (force traffic through wireless interface)
#TODO: test steps that verify throughput could be enhanced by implementing new keywords to synthesize the whole throughput setup and execution
#TODO: it is needed to revisit these tests when creating tests for router mode

*** Test Cases ***
Enable QoS And Set Global Upload Limit
    [Documentation]    Verify if DUT QoS is correctly limiting upload globally.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8564/view/6437/version/24746
    [Setup]    Run Keywords    Skip This Test If Testberry "\${TESTBERRY_1}" Is Not Active
    ...                        Skip This Test If Testberry "\${TESTBERRY_2}" Is Not Active
    ...                        Login To DUT WEB Page Through IPv4 Address
    Access QoS Service Settings Page
    Select QoS Enable Checkbox
    ${curr_value}    Get Current QoS Global Upload Limit
    ${random_int}    Generate Random Integer From "1" To "10" That Is Not Equal To "${curr_value}"
    Set QoS Global Upload Limit To "${random_int}" Mbps
    Save And Apply Settings
    Start Iperf3 Server On Testberry "${TESTBERRY_1}" Port "1234"
    Connect Testberry "${TESTBERRY_2}" To Open SSID "${DUT}[env][wireless][2ghz][default_ssid][name]"
    Wait Until Testberry "${TESTBERRY_2}" Interface "${TESTBERRY_2}[wireless][interface]" Gets An IPv4 Address Or Timeout After "20" Seconds
    ${bits_per_second}    Start Iperf3 TCP Client From Testberry "${TESTBERRY_2}" To Testberry "${TESTBERRY_1}" Interface "${TESTBERRY_1}[ethernet][interface]" On Port "1234" For "5" Seconds
    Throughput "${bits_per_second}" Should Be Lower Than "${random_int}" Mbps
    Throughput "${bits_per_second}" Should Be Higher Than "70"% Of "${random_int}" Mbps

Enable QoS And Set Global Download Limit
    [Documentation]    Verify if DUT QoS is correctly limiting download globally.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8564/view/6437/version/24746
    [Setup]    Run Keywords    Skip This Test If Testberry "\${TESTBERRY_1}" Is Not Active
    ...                        Skip This Test If Testberry "\${TESTBERRY_2}" Is Not Active
    ...                        Login To DUT WEB Page Through IPv4 Address
    Access QoS Service Settings Page
    Select QoS Enable Checkbox
    ${curr_value}    Get Current QoS Global Download Limit
    ${random_int}    Generate Random Integer From "1" To "10" That Is Not Equal To "${curr_value}"
    Set QoS Global Download Limit To "${random_int}" Mbps
    Save And Apply Settings
    Start Iperf3 Server On Testberry "${TESTBERRY_2}" Port "1234"
    Connect Testberry "${TESTBERRY_2}" To Open SSID "${DUT}[env][wireless][2ghz][default_ssid][name]"
    Wait Until Testberry "${TESTBERRY_2}" Interface "${TESTBERRY_2}[wireless][interface]" Gets An IPv4 Address Or Timeout After "20" Seconds
    ${bits_per_second}    Start Iperf3 TCP Client From Testberry "${TESTBERRY_1}" To Testberry "${TESTBERRY_2}" Interface "${TESTBERRY_2}[wireless][interface]" On Port "1234" For "5" Seconds
    Throughput "${bits_per_second}" Should Be Lower Than "${random_int}" Mbps
    Throughput "${bits_per_second}" Should Be Higher Than "70"% Of "${random_int}" Mbps
