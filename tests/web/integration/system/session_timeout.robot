*** Settings ***
Documentation       System Management Session Timeout Tests Suite
...
...                 This test suite contains tests to validate that system
...                 management session timeout can only be changed to values
...                 that comply with the project's business rules.

Resource            utils.resource
Resource            web/login_pom.resource
Resource            web/system/management_pom.resource
Resource            resources/web/header_pom.resource

Suite Teardown      Run Keywords
...                     Login To DUT WEB Page Through IPv4 Address
...                     Access System Management Page
...                     Set System Management Session Timeout To "3600"
...                     Save And Apply Settings
...                     Close Browser
Test Setup          Login To DUT WEB Page Through IPv4 Address
Test Teardown       Close Browser

Force Tags          system    session-timeout

*** Variables ***
${SESSION_TIMEOUT_RANGE_ERROR_WEB_MESSAGE}      Timeout da Sessão deve estar entre 60 a 86400 segundos

*** Test Cases ***
Validate session timeout allowed range: lower limit
    Access System Management Page
    Set System Management Session Timeout To A Value Below The Lower Limit
    Click Save Settings Button And Expect WEB Message To Be "${SESSION_TIMEOUT_RANGE_ERROR_WEB_MESSAGE}"

Validate session timeout allowed range: upper limit
    Access System Management Page
    Set System Management Session Timeout To A Value Above The Upper Limit
    Click Save Settings Button And Expect WEB Message To Be "${SESSION_TIMEOUT_RANGE_ERROR_WEB_MESSAGE}"

System timeout session must only allow numbers
    Access System Management Page
    Set System Management Session Timeout To "Ab!@#$%*()[]`'~^;:.,<>-+=_/"
    System Management Session Timeout Should Be ""

Session timeout clock widget should appear only when session time is < 45 seconds
    Set System Management Session Timeout Minimum And Relog DUT
    Session Timeout Clock Widget Should Not Be Visible
    Wait "26" Seconds
    Session Timeout Clock Widget Should Be Visible

Session timeout clock widget should be hidden when session time is refreshed
    Set System Management Session Timeout Minimum And Relog DUT
    Wait "26" Seconds
    Click Refresh Session Button
    Session Timeout Clock Widget Should Not Be Visible

Session time clock widget should return to initial value after refresh
    Set System Management Session Timeout Minimum And Relog DUT
    Wait "30" Seconds
    Click Refresh Session Button
    Wait "65" Seconds
    Login Page Should Be Displayed

User should be redirected to login webpage when session time expires
    Set System Management Session Timeout Minimum And Relog DUT
    Wait "65" Seconds
    Login Page Should Be Displayed
