*** Settings ***
Documentation       System Reboot Resource File
...                 
...                 This resource file contains keywords related to system
...                 reboot webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/sidemenu_pom.resource

*** Variables ***
${SYSTEM_REBOOT_SUBMENU}    reboot_submenu

${SYSTEM_REBOOT_BUTTON}     reboot_button

*** Keywords ***
Access System Reboot Page
    Open System Menu
    Wait Until Element Is Visible    ${SYSTEM_REBOOT_SUBMENU}
    Click Element    ${SYSTEM_REBOOT_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${SYSTEM_REBOOT_BUTTON}

System Reboot Settings Should Be Factory Default
    Element Should Be Visible    ${SYSTEM_REBOOT_BUTTON}
    Element Should Be Enabled    ${SYSTEM_REBOOT_BUTTON}
