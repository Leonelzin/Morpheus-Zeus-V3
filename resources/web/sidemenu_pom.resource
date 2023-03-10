*** Settings ***
Documentation       Managemente Webpage Side Menu Resource File
...
...                 This resource file contains keywords related to DUT
...                 management webpage side menu manipulation.

Library             String
Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource

*** Variables ***
${STATUS_MENU}                          status_menu
${STATUS_SUBMENU_CONTAINER}             status

${NETWORK_MENU}                         network_menu
${NETWORK_MENU_CONTAINER}               network

${SERVICES_MENU}                        services_menu
${SERVICES_SUBMENU_CONTAINER}           services

${WIRELESS_MENU}                        wireless_menu
${WIRELESS_SUBMENU_CONTAINER}           wireless

${TOOLS_MENU}                           tools_menu
${TOOLS_SUBMENU_CONTAINER}              tools

${FIREWALL_MENU}                        firewall_menu
${FIREWALL_SUBMENU_CONTAINER}           firewall

${SYSTEM_MENU}                          system_menu
${SYSTEM_SUBMENU_CONTAINER}             system

${WIZARD_MENU}                          .assistant
${WIZARD_SUBMENU_CONTAINER}             assistant

${WIFI_MARKETING_MENU}                  wifimarketing_menu
${WIFI_MARKETING_SUBMENU_CONTAINER}     wifimarketing

*** Keywords ***
Open Menu
    [Arguments]    ${menu_locator}    ${menu_container_locator}
    Wait Until Element Is Visible    ${menu_locator}
    Register Keyword To Run On Failure    NONE
    ${status}    Run Keyword And Return Status    Element Should Be Visible    ${menu_container_locator}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    ${status} == ${FALSE}
        Click Element    ${menu_locator}
    END
    Wait Until Element Is Visible    ${menu_container_locator}
    # accordion WEB component (menu_container_locator) will have class 'in' as soon as it is fully opened
    Wait Until Element Has Class    ${menu_container_locator}    in    2s

Open Status Menu
    Open Menu    ${STATUS_MENU}    ${STATUS_SUBMENU_CONTAINER}

Open Network Menu
    Open Menu    ${NETWORK_MENU}    ${NETWORK_MENU_CONTAINER}

Open Services Menu
    Open Menu    ${SERVICES_MENU}    ${SERVICES_SUBMENU_CONTAINER}

Open Wireless Menu
    Open Menu    ${WIRELESS_MENU}    ${WIRELESS_SUBMENU_CONTAINER}

Open Tools Menu
    Open Menu    ${TOOLS_MENU}    ${TOOLS_SUBMENU_CONTAINER}

Open Firewall Menu
    Open Menu    ${FIREWALL_MENU}    ${FIREWALL_SUBMENU_CONTAINER}

Open System Menu
    Open Menu    ${SYSTEM_MENU}    ${SYSTEM_SUBMENU_CONTAINER}

Open Wizard Menu
    Open Menu    ${WIZARD_MENU}    ${WIZARD_SUBMENU_CONTAINER}

Open Wifi Marketing Menu
    Open Menu    ${WIFI_MARKETING_MENU}    ${WIFI_MARKETING_SUBMENU_CONTAINER}

Wait Until Status Menu Is Fully Open
    Wait Until Element Is Visible    ${STATUS_SUBMENU_CONTAINER}
    Wait Until Element Has Class    ${STATUS_SUBMENU_CONTAINER}    in    2s
