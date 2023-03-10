*** Settings ***
Documentation       DUT Connectivity Tests Suite
...                 
...                 This test suite contains tests to verify that it is
...                 possible to connect the TestBerry via wi-fi in the
...                 SSID configured.

Library             Testberry    ${DUT}
Resource            web/login_pom.resource

Force Tags          wireless    connectivity

*** Variable ***
${SSID}        TEST SSID
${PASSWORD}    password

*** Test Cases ***
Connect TestBerry via Wi-Fi 2.4GHz in Open SSID 
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless 2GHz Is Not Supported By DUT
    ...    Login To DUT WEB Page Through IPv4 Address
    Access SSID Settings Page
    Click Add New SSID Button
    Set SSID Name To "${SSID}"
    Set SSID Band To 2.4GHz
    Confirm SSID Settings Changes
    Save And Apply Settings
    Connect Testberry "${TESTBERRY_1}" To Open SSID "${SSID}"
    Wait Until Testberry "${TESTBERRY_1}" Interface "${TESTBERRY_1}[wireless][interface]" Gets An IPv4 Address Or Timeout After "20" Seconds
    &{var}    Get Wi-Fi Connection Interface Information Testberry "${TESTBERRY_1}"
    Should Be Equal    ${SSID}    ${var.wifi_connection_info.general.ssid}
    [Teardown]    Run Keywords
    ...    Skip This Test If Wireless 2GHz Is Not Supported By DUT
    ...    Close Browser
    ...    Login To DUT WEB Page Through IPv4 Address
    ...    Access SSID Settings Page
    ...    Remove SSID "${SSID}"
    ...    Save And Apply Settings
    ...    Close Browser

Connect TestBerry via Wi-Fi 5GHz in Open SSID 
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless 5GHz Is Not Supported By DUT
    ...    Login To DUT WEB Page Through IPv4 Address
    Access SSID Settings Page
    Click Add New SSID Button
    Set SSID Name To "${SSID}"
    Set SSID Band To 2.4GHz
    Confirm SSID Settings Changes
    Save And Apply Settings
    Connect Testberry "${TESTBERRY_1}" To Open SSID "${SSID}"
    Wait Until Testberry "${TESTBERRY_1}" Interface "${TESTBERRY_1}[wireless][interface]" Gets An IPv4 Address Or Timeout After "20" Seconds
    &{var}    Get Wi-Fi Connection Interface Information Testberry "${TESTBERRY_1}"
    Should Be Equal    ${SSID}    ${var.wifi_connection_info.general.ssid}
    [Teardown]    Run Keywords
    ...    Skip This Test If Wireless 5GHz Is Not Supported By DUT
    ...    Close Browser
    ...    Login To DUT WEB Page Through IPv4 Address
    ...    Access SSID Settings Page
    ...    Remove SSID "${SSID}"
    ...    Save And Apply Settings
    ...    Close Browser

Connect TestBerry via Wi-Fi 2.4GHz in Protect SSID with WPA-PSK 
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless 2GHz Is Not Supported By DUT
    ...    Login To DUT WEB Page Through IPv4 Address
    Access SSID Settings Page
    Click Add New SSID Button
    Set SSID Name To "${SSID}"
    Set SSID Band To 2.4GHz
    Set SSID Authentication Type To WPA-PSK
    Set SSID PSK Password To "${PASSWORD}"
    Confirm SSID Settings Changes
    Save And Apply Settings
    Connect Testberry "${TESTBERRY_1}" To Protect SSID "${SSID}" With WPA-PSK and Password "${PASSWORD}"
    Wait Until Testberry "${TESTBERRY_1}" Interface "${TESTBERRY_1}[wireless][interface]" Gets An IPv4 Address Or Timeout After "20" Seconds
    &{var}    Get Wi-Fi Connection Interface Information Testberry "${TESTBERRY_1}"
    Should Be Equal    ${SSID}    ${var.wifi_connection_info.general.ssid}
    [Teardown]    Run Keywords
    ...    Close Browser
    ...    Login To DUT WEB Page Through IPv4 Address
    ...    Access SSID Settings Page
    ...    Remove SSID "${SSID}"
    ...    Save And Apply Settings
    ...    Close Browser

Connect TestBerry via Wi-Fi 2.4GHz in Protect SSID with WPA2-PSK 
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless 2GHz Is Not Supported By DUT
    ...    Login To DUT WEB Page Through IPv4 Address
    Access SSID Settings Page
    Click Add New SSID Button
    Set SSID Name To "${SSID}"
    Set SSID Band To 2.4GHz
    Set SSID Authentication Type To WPA2-PSK
    Set SSID PSK Password To "${PASSWORD}"
    Confirm SSID Settings Changes
    Save And Apply Settings
    Connect Testberry "${TESTBERRY_1}" To Protect SSID "${SSID}" With WPA-PSK and Password "${PASSWORD}"
    Wait Until Testberry "${TESTBERRY_1}" Interface "${TESTBERRY_1}[wireless][interface]" Gets An IPv4 Address Or Timeout After "20" Seconds
    &{var}    Get Wi-Fi Connection Interface Information Testberry "${TESTBERRY_1}"
    Should Be Equal    ${SSID}    ${var.wifi_connection_info.general.ssid}
    [Teardown]    Run Keywords
    ...    Close Browser
    ...    Login To DUT WEB Page Through IPv4 Address
    ...    Access SSID Settings Page
    ...    Remove SSID "${SSID}"
    ...    Save And Apply Settings
    ...    Close Browser

Connect TestBerry via Wi-Fi 5GHz in Protect SSID with WPA-PSK 
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless 5GHz Is Not Supported By DUT
    ...    Login To DUT WEB Page Through IPv4 Address
    Access SSID Settings Page
    Click Add New SSID Button
    Set SSID Name To "${SSID}"
    Set SSID Band To 5GHz
    Set SSID Authentication Type To WPA-PSK
    Set SSID PSK Password To "${PASSWORD}"
    Confirm SSID Settings Changes
    Save And Apply Settings
    Connect Testberry "${TESTBERRY_1}" To Protect SSID "${SSID}" With WPA-PSK and Password "${PASSWORD}"
    Wait Until Testberry "${TESTBERRY_1}" Interface "${TESTBERRY_1}[wireless][interface]" Gets An IPv4 Address Or Timeout After "20" Seconds
    &{var}    Get Wi-Fi Connection Interface Information Testberry "${TESTBERRY_1}"
    Should Be Equal    ${SSID}    ${var.wifi_connection_info.general.ssid}
    [Teardown]    Run Keywords
    ...    Skip This Test If Wireless 5GHz Is Not Supported By DUT
    ...    Close Browser
    ...    Login To DUT WEB Page Through IPv4 Address
    ...    Access SSID Settings Page
    ...    Remove SSID "${SSID}"
    ...    Save And Apply Settings
    ...    Close Browser

Connect TestBerry via Wi-Fi 5GHz in Protect SSID with WPA2-PSK 
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless 5GHz Is Not Supported By DUT
    ...    Login To DUT WEB Page Through IPv4 Address
    Access SSID Settings Page
    Click Add New SSID Button
    Set SSID Name To "${SSID}"
    Set SSID Band To 5GHz
    Set SSID Authentication Type To WPA2-PSK
    Set SSID PSK Password To "${PASSWORD}"
    Confirm SSID Settings Changes
    Save And Apply Settings
    Connect Testberry "${TESTBERRY_1}" To Protect SSID "${SSID}" With WPA-PSK and Password "${PASSWORD}"
    Wait Until Testberry "${TESTBERRY_1}" Interface "${TESTBERRY_1}[wireless][interface]" Gets An IPv4 Address Or Timeout After "20" Seconds
    &{var}    Get Wi-Fi Connection Interface Information Testberry "${TESTBERRY_1}"
    Should Be Equal    ${SSID}    ${var.wifi_connection_info.general.ssid}
    [Teardown]    Run Keywords
    ...    Skip This Test If Wireless 5GHz Is Not Supported By DUT
    ...    Close Browser
    ...    Login To DUT WEB Page Through IPv4 Address
    ...    Access SSID Settings Page
    ...    Remove SSID "${SSID}"
    ...    Save And Apply Settings
    ...    Close Browser
