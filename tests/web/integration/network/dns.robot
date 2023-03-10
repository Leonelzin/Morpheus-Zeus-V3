*** Settings ***
Documentation       Network (DNS) Tests Suite
...                 
...                 This test suite contains tests to verify that network DNS
...                 settings are correctly populated and can be modified
...                 respecting project requirements and business rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/network/dns_pom.resource

Test Teardown       Close Browser

Force Tags          network    dns

*** Test Cases ***
Validate network DNS factory default settings
    [Documentation]
    ...    Validate that network DNS factory default settings match those
    ...    specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Network DNS Settings Page
    DNS Settings Should Be Factory Default
