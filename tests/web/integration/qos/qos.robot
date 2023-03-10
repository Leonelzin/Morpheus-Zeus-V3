*** Settings ***
Documentation       QoS (Quality Of Service)
...                 
...                 This test suite contains tests to verify that QoS settings
...                 are correctly populated and can be modified respecting
...                 project requirements and business rules.

Resource            web/common.resource
Resource            web/login_pom.resource
Resource            web/qos/qos_pom.resource

Test Teardown       Close Browser

Force Tags          qos

*** Test Cases ***
Validate QoS factory default settings
    [Documentation]
    ...    Validate that QoS factory default settings match those specified by
    ...    project requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access QoS Service Settings Page
    QoS Settings Should Be Factory Default
