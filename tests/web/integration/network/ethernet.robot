*** Settings ***
Documentation       Network Ethernet Tests Suite
...                 
...                 This test suite contains tests to verify that ethernet
...                 settings webpage is correctly populated and can be modified
...                 respecting project requirements and business rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/network/ethernet_pom.resource

Test Teardown       Close Browser

Force Tags          ethernet

*** Test Cases ***
Validate ethernet interface(s) factory default settings
    [Documentation]
    ...    Validate that ethernet interface(s) factory default settings match
    ...    those specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Network Ethernet Settings Page
    Ethernet Settings Should Be Factory Default
