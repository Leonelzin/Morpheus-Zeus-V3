*** Settings ***
Documentation       Wireless 5GHz Interface Test Suite
...                 
...                 This test suite contains tests to verify that wireless
...                 5GHz interface webpage is correctly presented and can be
...                 modified respecting the project requirements and business
...                 rules.

Resource            web/login_pom.resource
Resource            web/wireless/interface_5ghz_pom.resource

Test Teardown       Close Browser

Force Tags          wireless-5ghz

*** Test Cases ***
Validate wireless 5GHz interface factory settings
    [Documentation]
    ...    Validate that wireless 5GHz interface factory default settings
    ...    match those specified by requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless 5GHz Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wireless 5GHz Interface Settings Page
    Wireless 5GHz Interface Settings Should Be Factory Default
