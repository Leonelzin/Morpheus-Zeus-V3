*** Settings ***
Documentation       Status Processing (PPS) Test Suite
...                 
...                 This test suite contains tests to verify that status
...                 processing (PPS) webpage is correctly presented and can be
...                 modified respecting the project requirements and business
...                 rules.

Resource            web/login_pom.resource
Resource            web/status/processing_pom.resource

Test Teardown       Close Browser

Force Tags          processing    pps

*** Test Cases ***
Validate status processing (PPS) factory default settings
    [Documentation]
    ...    Validate that status processing (PPS) factory default settings match
    ...    those specified by requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Status Processing Settings Page
    Status Processing Settings Should Be Factory Default
