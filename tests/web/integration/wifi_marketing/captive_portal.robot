*** Settings ***
Documentation       WI-FI Marketing Captive Portal Tests Suite
...
...                 This test suite contains tests to verify that wi-fi marketing
...                 captive portal settings are correctly populated and can be modified
...                 respecting project requirements and business rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/wifi_marketing/captive_portal_pom.resource

Test Teardown       Close Browser

Force Tags          captive-portal

*** Test Cases ***
Validate Wi-Fi Marketing Captive Portal factory default settings
    [Documentation]
    ...    Validate that wi-fi marketing captive portal factory default settings match
    ...    those specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If DUT Factory Default Network Operation Mode Is Not Router
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wi-Fi Marketing Captive Portal Settings Page
    Wi-Fi Marketing Captive Portal Settings Should Be Factory Default
