*** Settings ***
Documentation       Status Throughput Test Suite
...                 
...                 This test suite contains tests to verify that status
...                 throughput (Mpbs) webpage is correctly presented and can be
...                 modified respecting the project requirements and business
...                 rules.

Resource            web/login_pom.resource
Resource            web/status/throughput_pom.resource

Test Teardown       Close Browser

Force Tags          throughput

*** Test Cases ***
Validate status throughput factory default settings
    [Documentation]
    ...    Validate that status throughput (Mbps) factory default settings
    ...    match those specified by requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Status Throughput Settings Page
    Status Throughput Settings Should Be Factory Default
