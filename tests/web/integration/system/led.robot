*** Settings ***
Documentation       This test suite contains tests to verify that system LED
...                 settings webpage is correctly populated and behaves
...                 according to the project requirements and business rules.

Resource            web/login_pom.resource
Resource            web/system/led_pom.resource

Force Tags          led

*** Test Cases ***
Validate system LED factory default settings
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If LED Settings Are Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    LED Settings Should Be Factory Default
    [Teardown]    Close Browser
