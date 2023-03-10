*** Settings ***
Documentation       Firewall General Tests Suite
...                 
...                 This test suite contains tests to verify that firewall
...                 (general settings) WEB interface is correctly populated and
...                 can be modified respecting the project requirements and
...                 business rules.

Resource            web/login_pom.resource
Resource            web/common.resource
Resource            web/firewall/general_pom.resource
Resource            web/network/operation_mode_pom.resource

Test Setup          Login To DUT WEB Page Through IPv4 Address
Test Teardown       Run Keywords
...                     Discard Saved Settings If There Are Changes
...                     Close Browser

Force Tags          firewall

*** Test Cases ***
Firewall ICMP Flood Protection Setting Availability
    [Tags]    icmp-flood
    Access Firewall General Settings Page
    Select Firewall Enable Checkbox
    Firewall ICMP Flood Protection Checkbox Should Be Visible
    Unselect Firewall Enable Checkbox
    Firewall ICMP Flood Protection Checkbox Should Not Be Visible

Disable Firewall ICMP Flood Protection
    [Tags]    icmp-flood
    Access Firewall General Settings Page
    Select Firewall Enable Checkbox
    Unselect Firewall ICMP Flood Protection Checkbox
    Save Settings

Enable Firewall ICMP Flood Protection
    [Tags]    icmp-flood
    Access Firewall General Settings Page
    Select Firewall Enable Checkbox
    Select Firewall ICMP Flood Protection Checkbox
    Save Settings

Validate firewall general settings and security options factory default values
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Firewall General Settings Page
    Firewall General Settings Should Be Factory Default
    Firewall General Security Options Should Be Factory Default

