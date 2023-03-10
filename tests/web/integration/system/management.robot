*** Settings ***
Documentation       This test suite contains tests to verify that system
...                 management webpage is correctly populated and behaves
...                 according to the project requirements and business rules.

Resource            web/login_pom.resource
Resource            web/system/management_pom.resource

Test Teardown       Close Browser

Force Tags          system    management

*** Test Cases ***
Validate system management factory default settings
    [Documentation]
    ...    Validate that system management factory default settings complies
    ...    with project requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access System Management Page
    System Management Settings Should Be Factory Default
