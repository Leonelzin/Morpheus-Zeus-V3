*** Settings ***
Documentation       System Password Resource File
...                 
...                 This resource file contains keywords related to system
...                 password webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${SYSTEM_PASSWORD_SUBMENU}              user_submenu

${CURRENT_PASSWORD_INPUT}               user_password
${NEW_PASSWORD_INPUT}                   user_newPassword
${NEW_PASSWORD_CONFIRMATION_INPUT}      user_confirmPassword

*** Keywords ***
Access System Password Page
    Open System Menu
    Wait Until Element Is Visible    ${SYSTEM_PASSWORD_SUBMENU}
    Click Element    ${SYSTEM_PASSWORD_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${CURRENT_PASSWORD_INPUT}

Set System Current Password To "${password}"
    Input Text
    ...    ${CURRENT_PASSWORD_INPUT}
    ...    ${password}

Set System New Password To "${password}"
    Input Text
    ...    ${NEW_PASSWORD_INPUT}
    ...    ${password}

Set System New Password Confirmation To "${password}"
    Input Text
    ...    ${NEW_PASSWORD_CONFIRMATION_INPUT}
    ...    ${password}

System Password Settings Should Be Factory Default
    Element Should Be Visible    ${CURRENT_PASSWORD_INPUT}
    Element Should Be Visible    ${NEW_PASSWORD_INPUT}
    Element Should Be Visible    ${NEW_PASSWORD_CONFIRMATION_INPUT}

    Element Should Be Enabled    ${CURRENT_PASSWORD_INPUT}
    Element Should Be Enabled    ${NEW_PASSWORD_INPUT}
    Element Should Be Enabled    ${NEW_PASSWORD_CONFIRMATION_INPUT}

    Element Should Be Disabled    ${SAVE_SETTINGS_BUTTON}

    Element Attribute Value Should Be
    ...    ${CURRENT_PASSWORD_INPUT}
    ...    value    ${EMPTY}

    Element Attribute Value Should Be
    ...    ${NEW_PASSWORD_INPUT}
    ...    value    ${EMPTY}

    Element Attribute Value Should Be
    ...    ${NEW_PASSWORD_CONFIRMATION_INPUT}
    ...    value    ${EMPTY}
