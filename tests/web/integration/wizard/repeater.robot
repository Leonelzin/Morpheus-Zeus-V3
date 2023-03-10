*** Settings ***
Documentation       Wizard Repeater Tests Suite
...                 
...                 This test suite contains tests to verify that wizard
...                 (repeater) settings are correctly populated and can be
...                 modified respecting project requirements and business
...                 rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/wizard/common_initial_steps.resource
Resource            web/wizard/repeater.resource

Test Teardown       Close Browser

Force Tags          wizard    repeater

*** Test Cases ***
Validate wizard steps (repeater 2.4GHz) on single band devices
    [Documentation]
    ...    Validate that wizard (repeater 2.4GHz) factory default settings
    ...    match those specified by the requirements for single band devices.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If DUT Wireless Is Dual Band
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address

    Access Wizard Settings Page
    Wizard Common First Step Should Be Factory Default
    Go To Next Wizard Step

    Wizard Preset (Operation Mode) Should Be Factory Default
    Click Repeater Preset Button
    Go To Next Wizard Step

    Wizard (Single Band Repeater) Wireless 2.4GHz Client Interface Settings Should Be Factory Default
    Set Wireless Client (2.4GHz) SSID Name To "test"
    Go To Next Wizard Step

    Wizard (Repeater) LAN Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Repeater) Confirmation Step Should Be Correct

Validate wizard steps (repeater 2.4GHz client) on dual band devices
    [Documentation]
    ...    Validate that wizard (repeater 2.4GHz client) factory default
    ...    settings match those specified by the requirements for dual band
    ...    devices.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If DUT Wireless Is Not Dual Band
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address

    Access Wizard Settings Page
    Wizard Common First Step Should Be Factory Default
    Go To Next Wizard Step

    Wizard Preset (Operation Mode) Should Be Factory Default
    Click Repeater Preset Button
    Go To Next Wizard Step

    Wizard (Dual Band Repeater) Wireless Client Interface Selection Should Be Factory Default
    Click Wireless 2.4GHz Interface Option
    Go To Next Wizard Step

    Wizard (Dual Band Repeater) Wireless 2.4GHz Client Interface Settings Should Be Factory Default
    Set Wireless Client (2.4GHz) SSID Name To "test"
    Go To Next Wizard Step

    Wizard (Dual Band Repeater) Wireless 5GHz AP Interface Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Repeater) LAN Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Repeater) Confirmation Step Should Be Correct

Validate wizard steps (repeater 5GHz client) on dual band devices
    [Documentation]
    ...    Validate that wizard (repeater 5GHz client) factory default settings
    ...    match those specified by the requirements for dual banda devices.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If DUT Wireless Is Not Dual Band
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address

    Access Wizard Settings Page
    Wizard Common First Step Should Be Factory Default
    Go To Next Wizard Step

    Wizard Preset (Operation Mode) Should Be Factory Default
    Click Repeater Preset Button
    Go To Next Wizard Step

    Wizard (Dual Band Repeater) Wireless Client Interface Selection Should Be Factory Default
    Click Wireless 5GHz Interface Option
    Go To Next Wizard Step

    Wizard (Dual Band Repeater) Wireless 5GHz Client Interface Settings Should Be Factory Default
    Set Wireless Client (5GHz) SSID Name To "test"
    Go To Next Wizard Step

    Wizard (Dual Band Repeater) Wireless 2.4GHz AP Interface Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Repeater) LAN Settings Should Be Factory Default
    Go To Next Wizard Step

    Wizard (Repeater) Confirmation Step Should Be Correct
