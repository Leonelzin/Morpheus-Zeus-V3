*** Settings ***
Documentation     Firewall Tests Suite
...
...               This test suite contains e2e tests to verify general firewall
...               options.
Library           Testberry    ${DUT}
Resource          utils.resource
Resource          web/login_pom.resource
Resource          web/common.resource
Resource          web/firewall/general_pom.resource
Resource          web/network/operation_mode_pom.resource

Test Teardown     Close Browser
Force Tags        firewall-wip

*** Test Cases ***
Firewall ICMP Flood In Bridge Mode
    [Documentation]    
    [Tags]    firewall
    [Setup]    Run Keywords    Skip This Test If Testberry "\${TESTBERRY_1}" Is Not Active
    ...                        Login To DUT WEB Page Through IPv4 Address
    Connect Testberry "${TESTBERRY_1}" To Open SSID "${DUT}[env][wireless][2ghz][default_ssid][name]"
    Wait Until Testberry "${TESTBERRY_1}" Interface "${TESTBERRY_1}[wireless][interface]" Gets An IPv4 Address Or Timeout After "20" Seconds
    Access Network Operation Mode Settings Page
    Set Network Operation Mode To Bridge
    Access Firewall General Settings Page
    Select Firewall Enable Checkbox
    Unselect Firewall ICMP Flood Protection Checkbox
    Save And Apply Settings
    Run Keyword And Expect Error    Extected 100% of packets loss   Check Flood Protection Using Testberry "${TESTBERRY_1}" Via "eth0" With "1000" packets To "icmp" procotol
    Select Firewall ICMP Flood Protection Checkbox
    Save And Apply Settings
    Check Flood Protection Using Testberry "${TESTBERRY_1}" Via "eth0" With "1000" packets To "icmp" procotol
    Check Flood Protection Using Testberry "${TESTBERRY_1}" Via "wlan0" With "1000" packets To "icmp" procotol
    Unselect Firewall Enable Checkbox
    Save And Apply Settings
    Run Keyword And Expect Error    Extected 100% of packets loss   Check Flood Protection Using Testberry "${TESTBERRY_1}" Via "eth0" With "1000" packets To "icmp" procotol
    Select Firewall Enable Checkbox
    Save And Apply Settings
    Check Flood Protection Using Testberry "${TESTBERRY_1}" Via "eth0" With "1000" packets To "icmp" procotol
    Check Flood Protection Using Testberry "${TESTBERRY_1}" Via "wlan0" With "1000" packets To "icmp" procotol

