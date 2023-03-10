*** Settings ***
Documentation       This test suite contains tests to verify that system
...                 password webpage is correctly populated and behaves
...                 according to the project requirements and business rules.

Resource            web/login_pom.resource
Resource            web/system/password_pom.resource

Test Teardown       Close Browser

Force Tags          password

*** Test Cases ***
Validate system password webpage factory default settings
    [Documentation]
    ...    Validate that system password factory default settings match project
    ...    requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access System Password Page
    System Password Settings Should Be Factory Default
