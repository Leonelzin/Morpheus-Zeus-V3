*** Settings ***
Documentation       SNMP Service Tests Suite
...                 
...                 This test suite contains tests to verify that SNMP settings
...                 are correctly populated and can be modified respecting
...                 project requirements and business rules.

Resource            web/login_pom.resource
Resource            web/services/snmp_pom.resource

Test Teardown       Close Browser

Force Tags          services    snmp

*** Test Cases ***
Validate SNMP factory default settings
    [Documentation]
    ...    Validate that SNMP factory default settings match the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If SNMP Feature Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access SNMP Service Settings Page
    SNMP Settings Should Be Factory Default
