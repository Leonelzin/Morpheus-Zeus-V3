*** Settings ***
Documentation       Wizard (Access Point) Page Tests Suite
...                 
...                 This test suite contains tests to verify that wizard
...                 (access point) settings are correctly populated and can be
...                 modified respecting project requirements and business
...                 rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/wizard/common_initial_steps.resource
Resource            web/wizard/access_point.resource

Test Teardown       Close Browser

Force Tags          wizard    access-point

*** Test Cases ***
Validate wizard (access point) factory default settings
    [Documentation]
    ...    Validate that wizard (access point) factory default settings match
    ...    those specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address

    Access Wizard Settings Page
    Wizard Common First Step Should Be Factory Default
    Go To Next Wizard Step

    Wizard Preset (Operation Mode) Should Be Factory Default
    Click Access Point Preset Button
    Go To Next Wizard Step

    Wizard (Access Point) Wireless Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Access Point) Auto Configuration Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Access Point) LAN Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Access Point) Confirmation Step Should Be Correct
