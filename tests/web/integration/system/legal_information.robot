*** Settings ***
Documentation       This test suite contains tests to verify that system legal
...                 information webpage is correctly populated and behaves
...                 according to the project requirements and business rules.

Resource            web/login_pom.resource
Resource            web/system/legal_information_pom.resource

Test Teardown       Close Browser

Force Tags          legal-information

*** Test Cases ***
Validate system legal information factory default settings
    [Documentation]
    ...    Validate that system legal information factory default settings
    ...    match project requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access System Legal Information Page
    System Legal Information Settings Should Be Factory Default
