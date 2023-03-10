*** Settings ***
Documentation     Wireless SSID Scheduling Test Suite
...
...               This test suite contains tests to verify that wireless SSID
...               scheduling feature is correctly presented and can be modified
...               respecting the project requirements and business rules.
Resource          web/login_pom.resource
Resource          web/services/ntp_pom.resource
Resource          web/wireless/ssid_pom.resource
Test Setup        Login To DUT WEB Page Through IPv4 Address
Test Teardown     Close Browser
Force Tags        wireless    ssid-scheduling

*** Test Cases ***
Verify that it is not possible to enable wireless SSID scheduling when NTP client is disabled
    [Documentation]    Verify that wireless 'SSID Scheduling' is not available when NTP client is disabled.
    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8122/view/6637/version/25660
    [Setup]    Run Keywords
    ...                        Skip This Test If NTP Client Feature Is Not Supported By DUT
    ...                        Login To DUT WEB Page Through IPv4 Address
    Access NTP Service Settings Page
    Unselect NTP Enable Checkbox
    Save Settings
    Access SSID Settings Page
    Scheduling Settings Button Should Be Disabled For All SSIDs
    [Teardown]    Run Keywords
    ...    Discard Saved Settings If There Are Changes
    ...    Close Browser
