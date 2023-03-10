*** Settings ***
Documentation       This test suite contains tests to verify that system reboot
...                 webpage is correctly populated and behaves according to the
...                 project requirements and business rules.

Resource            web/login_pom.resource
Resource            web/system/reboot_pom.resource

Test Teardown       Close Browser

Force Tags          reboot

*** Test Cases ***
Validate system reboot factory default settings
    [Documentation]
    ...    Validate that system reboot factory default settings match the
    ...    requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access System Reboot Page
    System Reboot Settings Should Be Factory Default
