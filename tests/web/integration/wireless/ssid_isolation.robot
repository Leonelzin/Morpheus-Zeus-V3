*** Settings ***
Documentation     Wireless SSID Isolation Tests Suite
...
...               This test suite contains tests to verify that wireless SSID
...               isolation feature is correctly presented and can be modified
...               respecting the project requirements and business rules.
Resource          web/login_pom.resource
Resource          web/wireless/interface_2ghz_pom.resource
Resource          web/wireless/interface_5ghz_pom.resource
Test Setup        Login To DUT WEB Page Through IPv4 Address
Test Teardown     Close Browser
Force Tags        wireless    ssid-isolation

*** Test Cases ***
