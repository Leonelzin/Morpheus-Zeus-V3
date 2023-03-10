*** Settings ***
Documentation       Status (signal) Tests Suite
...
...                 This test suite contains tests to verify that signal status
...                 settings are correctly populated and can be modified
...                 respecting project requirements and business rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/network/operation_mode_pom.resource
Resource            web/status/signal_pom.resource

Test Teardown       Close Browser

Force Tags          status    signal

*** Test Cases ***
Validate status signal factory default settings
    [Documentation]
    ...    Validate that status signal factory default settings match those
    ...    specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Status Signal Should Be Factory Default
    
