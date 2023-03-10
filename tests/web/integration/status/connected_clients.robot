*** Settings ***
Documentation       Status (Connected Clients)
...                 
...                 This test suite contains tests to verify that status
...                 (connected clients) WEB interface is correctly populated
...                 and behaves according to the project requirements and
...                 business rules.

Resource            web/common.resource
Resource            web/login_pom.resource
Resource            web/status/connected_clients_pom.resource

Test Teardown       Close Browser

Force Tags          status

*** Test Cases ***
Validate status connected clients factory default settings
    [Documentation]
    ...    Validate that system management factory default settings complies
    ...    with project requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Status Connected Clients Page
    Status Connected Clients Settings Should Be Factory Default
