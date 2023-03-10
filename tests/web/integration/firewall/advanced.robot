*** Settings ***
Documentation       Firewall Advanced Tests Suite
...
...                 This test suite contains tests to verify that firewall
...                 (advanced settings) WEB interface is correctly populated and
...                 can be modified respecting the project requirements and
...                 business rules.

Resource            web/login_pom.resource
Resource            web/common.resource
Resource            web/firewall/general_pom.resource
Resource            web/network/operation_mode_pom.resource
Resource            web/firewall/advanced.resource

Test Setup          Login To DUT WEB Page Through IPv4 Address
Test Teardown       Run Keywords
...                     Discard Saved Settings If There Are Changes
...                     Close Browser

Force Tags          firewall

*** Test Cases ***
Validate Firewall Advanced factory default settings
    [Documentation]
    ...    VValidate that firewall advanced factory default settings match those
    ...    specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If DUT Factory Default Network Operation Mode Is Not Router
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Firewall Advanced Settings Page
    Firewall Advanced Should Be Factory Default

