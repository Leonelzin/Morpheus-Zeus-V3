*** Settings ***
Documentation       Wizard Facebook Tests Suite
...
...                 This test suite contains tests to verify that wizard
...                 facebook settings are correctly populated and can be modified
...                 respecting project requirements and business rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/wizard/facebook_pom.resource

Test Teardown       Close Browser

Force Tags          wizard-facebook

*** Test Cases ***
Validate Wizard Facebook factory default settings
    [Documentation]
    ...    Validate that wizard facebook factory default settings match
    ...    those specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wizard Facebook Settings Page
    Wizard Facebook Settings Should Be Factory Default
