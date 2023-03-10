*** Settings ***
Documentation       Wireless 2.4GHz Interface Test Suite
...                 
...                 This test suite contains tests to verify that wireless
...                 2.4GHz interface webpage is correctly presented and can be
...                 modified respecting the project requirements and business
...                 rules.

Resource            web/login_pom.resource
Resource            web/wireless/interface_2ghz_pom.resource

Test Teardown       Close Browser

Force Tags          wireless-2ghz

*** Test Cases ***
Validate wireless 2.4GHz interface factory default settings
    [Documentation]
    ...    Validate that wireless 2.4GHz interface factory default settings
    ...    match those specified by requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless 2GHz Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wireless 2GHz Interface Settings Page
    Wireless 2GHz Interface Settings Should Be Factory Default

Maximum TX power of wireless 2.4GHz channels is in accordance with current Anatel rules
    [Documentation]
    ...    This test validates that all wireless 2.4GHz channels
    ...    (2400MHz - 2484MHz) TX power are in accordance with current ANATEL
    ...    rules.
    ...
    ...    Maximum TX power (including EIRP) calculations are based in
    ...    https://intelbras.atlassian.net/browse/PZ-7653.
    ...
    ...    Anatel acts:
    ...    - Act 14448/17, section 10: http://www.ncc.org.br/img/Ato%2014448.pdf
    [Tags]    smoke    anatel
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access Wireless 2GHz Interface Settings Page
    Set Wireless 2GHz Operation Mode Value To Access Point
    Open Wireless 2GHz Channel/Bandwidth Settings
    Set Wireless 2GHz Channel Extension To Automatic
    All Wireless 2GHz Channels TX Power Are In Accordance With Current Anatel Rules
