*** Settings ***
Documentation       Discovery Service Tests Suite
...                 
...                 This test suite contains tests to verify that discovery WEB
...                 interface is correctly populated and can be modified
...                 respecting the project requirements and business rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/services/discovery_pom.resource

Test Teardown       Close Browser

Force Tags          services    discovery

*** Test Cases ***
Validate Discovery Factory Default Values
    [Documentation]
    ...    Validate that discovery factory default settings match those
    ...    specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Discovery Service Settings Page
    Discovery Settings Should Be Factory Default
