*** Settings ***
Documentation       Wizard (Splash Page) Tests Suite
...                 
...                 This test suite contains tests to verify that wizard
...                 (splash page) settings are correctly populated and can be
...                 modified respecting project requirements and business
...                 rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/wizard/common_initial_steps.resource
Resource            web/wizard/splash_page.resource

Test Teardown       Close Browser

Force Tags          wizard    splash-page

*** Test Cases ***
Validate wizard (splash page) steps
    [Documentation]
    ...    Validate that wizard (splash page) factory default settings match
    ...    those specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address

    Access Wizard Settings Page
    Wizard Common First Step Should Be Factory Default
    Go To Next Wizard Step

    Wizard Preset (Operation Mode) Should Be Factory Default
    Click Splash Page Preset Button
    Go To Next Wizard Step

    Wizard (Splash Page) Wireless Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Splash Page) Settings Should Be Factory Default
    Select First SSID Splash Page Enable Checkbox
    Set Splash Page Media Link To "https://www.youtube.com/watch?v=HcGNqrAtsgg"
    Go To Next Wizard Step

    Wizard (Splash Page) LAN Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Splash Page) Confirmation Step Should Be Correct
