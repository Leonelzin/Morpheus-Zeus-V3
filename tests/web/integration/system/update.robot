*** Settings ***
Documentation       This test suite contains tests to verify that system update
...                 webpage is correctly populated and behaves according to the
...                 project requirements and business rules.

Resource            web/login_pom.resource
Resource            web/system/update_pom.resource

Test Teardown       Close Browser

Force Tags          update

*** Test Cases ***
Validate system update webpage settings
    [Documentation]
    ...    Validate that System/Update webpage match project requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Login To DUT WEB Page Through IPv4 Address
    Access System Update Page
    System Update Webpage Settings Should Be Correct
