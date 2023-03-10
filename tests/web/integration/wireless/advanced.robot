*** Settings ***
Documentation       System Advanced Service Tests Suite
...                 
...                 This test set contains tests to verify that advanced
...                 wireless settings webpage is correctly presented and can
...                 be modified respecting the project requirements and
...                 business rules.

Resource            api/fiber/v3/system.resource
Resource            web/login_pom.resource
Resource            web/wireless/advanced_pom.resource

Test Teardown       Close Browser

Force Tags          wireless-advanced

*** Test Cases ***
Validate Wireless Assisted Roaming Factory Default Settings
    [Documentation]    Verify that wireless assisted roaming (802.11k/v) settings in Wireless/Advanced WEB page is correct.
    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8594/view/27172/version/27173
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless Assisted Roaming Feature Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wireless Advanced Settings Page
    Assisted Roaming Settings Should Be Factory Default

Validate Wireless Fast Roaming Factory Default Settings
    [Documentation]    Verify that wireless fast roaming (802.11r) settings in Wireless/Advanced WEB page is correct.
    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8594/view/27176/version/27177
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless Fast Roaming Feature Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wireless Advanced Settings Page
    Fast Roaming Settings Should Be Factory Default

Validate Wireless Qualcomm Smart Handover Factory Default Settings
    [Documentation]    Verify that Qualcomm smart handover settings in Wireless/Advanced WEB page is correct.
    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8594/view/5425/version/27171
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If Qualcomm Smart Handover Feature Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wireless Advanced Settings Page
    Qualcomm Smart Handover Settings Should Be Factory Default

Validate Wireless Band Steering Factory Default Values
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If Band Steering Feature Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wireless Advanced Settings Page
    Band Steering Handover Settings Should Be Factory Default

Validate Wireless MU-MIMO Factory Default Values
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If MU-MIMO Feature Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wireless Advanced Settings Page
    MU-MIMO Settings Should Be Factory Default

Validate Wireless Beamforming Factory Default Values
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    Skip This Test If Beamforming Feature Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Wireless Advanced Settings Page
    Beamforming Settings Should Be Factory Default
