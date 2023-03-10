*** Settings ***
Documentation       Network (LAN) Tests Suite
...                 
...                 This test suite contains tests to verify that LAN network
...                 settings are correctly populated and can be modified
...                 respecting project requirements and business rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/network/lan_pom.resource

Test Teardown       Close Browser

Force Tags          network    lan

*** Test Cases ***
Validate LAN network factory default settings
    [Documentation]
    ...    Validate that network LAN factory default settings match those
    ...    specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Network LAN Settings Page
    LAN Settings Should Be Factory Default
