*** Settings ***
Documentation       Wizard (Router) Tests Suite
...                 
...                 This test suite contains tests to verify that wizard
...                 (router) settings are correctly populated and can be
...                 modified respecting project requirements and business
...                 rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/wizard/common_initial_steps.resource
Resource            web/wizard/router.resource

Test Teardown       Close Browser

Force Tags          wizard    router

*** Test Cases ***
Validate wizard (router) factory default settings
    [Documentation]
    ...    Validate that wizard (router) factory default settings match those
    ...    specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address

    Access Wizard Settings Page
    Wizard Common First Step Should Be Factory Default
    Go To Next Wizard Step

    Wizard Preset (Operation Mode) Should Be Factory Default
    Click Router Preset Button
    Go To Next Wizard Step

    Wizard (Router) Wireless Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Router) LAN Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Router) Confirmation Step Should Be Correct
