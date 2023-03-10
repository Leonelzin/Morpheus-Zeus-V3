*** Settings ***
Documentation       Wireless SSIDs Tests Suite
...                 
...                 This test suite contains tests to verify that wireless SSIDs
...                 are correctly presented and can be modified respecting the
...                 the project requirements and business rules.

Library             Dialogs
Resource            web/login_pom.resource
Resource            web/wireless/ssid_pom.resource

Test Teardown       Close Browser

Force Tags          wireless

*** Test Cases ***
Validate Wireless SSID Factory Default Settings
    [Documentation]    Verify that SSID settings in <Wireless/Wireless Networks> WEB page are correct.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access SSID Settings Page

    Open SSID "${DUT}[env][wireless][2ghz][default_ssid][name]" Settings
    SSID Settings Should Be Factory Default
    Discard SSID Settings Changes

    Open SSID "${DUT}[env][wireless][2ghz][default_ssid][name]" Scheduling Settings
    SSID Scheduling Settings Should Be Factory Default
    Discard SSID Scheduling Changes

    Open SSID "${DUT}[env][wireless][2ghz][default_ssid][name]" MAC ACL Settings
    SSID MAC ACL Settings Should Be Factory Default
    Discard SSID MAC ACL Changes
