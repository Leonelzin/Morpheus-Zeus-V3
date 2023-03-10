*** Settings ***
Documentation       DDNS Service Tests Suite
...                 
...                 This test suite contains tests to verify that DDNS service
...                 settings are correctly populated and can be modified
...                 respecting project requirements and business rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/network/operation_mode_pom.resource
Resource            web/services/ddns_pom.resource

Test Teardown       Close Browser

Force Tags          services    ddns

*** Test Cases ***
Validate DDNS service factory default settings
    [Documentation]
    ...    Validate that DDNS service factory default settings match the
    ...    requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If DUT Factory Default Network Operation Mode Is Not Router
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access DDNS Service Settings Page
    DDNS Settings Should Be Factory Default
