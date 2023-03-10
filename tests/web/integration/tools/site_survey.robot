*** Settings ***
Documentation       Site Survey Test Suite
...                 
...                 This test suite contains tests to verify that site survey
...                 webpage is correctly presented and can be modified
...                 respecting the project requirements and business rules.

Resource            web/login_pom.resource
Resource            web/tools/site_survey_pom.resource

Test Teardown       Close Browser

Force Tags          site-survey

*** Test Cases ***
Validate site survey tool factory settings
    [Documentation]
    ...    Validate that site survey tool factory default settings match those
    ...    specified by project requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Site Survey Settings Page
    Site Survey Settings Should Be Factory Default
