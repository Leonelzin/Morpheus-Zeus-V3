*** Settings ***
Documentation       System Log Service Tests Suite
...                 
...                 This test suite contains tests to verify that the WEB System Log
...                 the interface is correctly populated and can be modified
...                 respecting project requirements and business rules
...                 validate factory default values and automate them.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/services/log_pom.resource

Test Teardown       Close Browser

Force Tags          services    log

*** Test Cases ***
Validate System Log Factory Default Values
    [Documentation]
    ...    Validate that system log factory default settings match those
    ...    specified by the requirements.
    [Tags]    factory-default
    [Setup]    Run Keywords
    ...    Skip This Test If Log Service Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Log Service Settings Page
    Log Settings Should Be Factory Default
