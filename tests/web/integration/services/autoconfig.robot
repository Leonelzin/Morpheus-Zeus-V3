*** Settings ***
Documentation       Automatic Device Configuration Service Tests Suite
...                 
...                 This test suite contains tests to verify that automatic
...                 device configuration service WEB interface is correctly
...                 populated and can be modified respecting the project
...                 requirements and business rules.

Resource            web/login_pom.resource
Resource            web/services/autoconfig_pom.resource

Test Setup          Run Keywords
...                     Skip This Test If Automatic Device Configuration Is Not Supported By DUT
...                     Login To DUT WEB Page Through IPv4 Address
Test Teardown       Run Keywords
...                     Discard Saved Settings If There Are Changes
...                     Close Browser

Force Tags          services    auto-configuration

*** Test Cases ***
Verify automatic device configuration factory default settings
    [Documentation]    Verify that discovery factory default settings match those specified by the requirements.
    [Tags]    factory-default    smoke
    #TODO: make sure that before running this test the DUT is in factory default state.
    Access Automatic Device Configuration Service Settings Page
    Automatic Device Configuration Settings Should Be Factory Default

Change authorization mode to automatic and save settings
    Access Automatic Device Configuration Service Settings Page
    Select Automatic Authorization Checkbox
    Save Settings

Change authorization mode to moderate and save settings
    Access Automatic Device Configuration Service Settings Page
    Select Moderate Authorization Checkbox
    Save Settings

Devices awaiting authorization accordion is visible when authorization mode is moderate
    Access Automatic Device Configuration Service Settings Page
    Select Moderate Authorization Checkbox
    Authorized Devices Accordion Should Be Visible

Swap authorization mode and save settings
    Access Automatic Device Configuration Service Settings Page
    Select Automatic Authorization Checkbox
    Save Settings
    Select Moderate Authorization Checkbox
    Save Settings

Refresh list of devices awaiting authorization
    Access Automatic Device Configuration Service Settings Page
    Select Moderate Authorization Checkbox
    Open Devices Awaiting Authorization Modal
    Click Refresh Devices Awaiting Authorization Modal Button
    Wait Until WEB Message Is "Atualizando..." Or Timeout After "3" Seconds
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
