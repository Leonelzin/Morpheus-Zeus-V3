*** Settings ***
Documentation       WI-FI Marketing Splash Page Tests Suite
...
...                 This test suite contains tests to verify that wi-fi marketing
...                 splash page settings are correctly populated and can be modified
...                 respecting project requirements and business rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/wifi_marketing/splash_page_pom.resource
Resource            web/network/operation_mode_pom.resource

Test Teardown       Close Browser

Force Tags          splash_page

*** Test Cases ***
Validate Wi-Fi Marketing Splash Page factory default settings
    [Documentation]
    ...    Validate that wi-fi marketing splash page factory default settings match
    ...    those specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If DUT Factory Default Network Operation Mode Is Not Router
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wi-Fi Marketing Splash Page Settings Page
    Wi-Fi Marketing Splash Page Settings Should Be Factory Default
