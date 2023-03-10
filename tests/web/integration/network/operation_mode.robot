*** Settings ***
Documentation       Network Operation Mode Tests Suite
...                 
...                 This test suite contains tests to verify that network
...                 operation mode settings are correct and can be modified
...                 respecting the project requirements and business rules.

Resource            web/login_pom.resource
Resource            web/network/operation_mode_pom.resource

Test Teardown       Close Browser

Force Tags          network

*** Test Cases ***
Validate network operation mode factory default values
    [Documentation]
    ...    Validate that network operation mode factory default settings match
    ...    those specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Network Operation Mode Settings Page
    Network Operation Mode Settings Should Be Factory Default
