*** Settings ***
Documentation       System Legal Information Resource File
...                 
...                 This resource file contains keywords related to system
...                 legal information WEB page manipulation (page object model).

Library             OperatingSystem
Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${SYSTEM_LEGAL_INFO_SUBMENU}                compliance_submenu

${LEGAL_INFO_TERMS_OF_USE_CHECKBOX}         terms_of_use_checkbox
${LEGAL_INFO_PRIVACY_POLICY_CHECKBOX}       privacy_polity_checkbox

*** Keywords ***
Access System Legal Information Page
    Open System Menu
    Wait Until Element Is Visible    ${SYSTEM_LEGAL_INFO_SUBMENU}
    Click Element    ${SYSTEM_LEGAL_INFO_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${SAVE_SETTINGS_BUTTON}

System Legal Information Settings Should Be Factory Default
    Element Should Be Visible    ${LEGAL_INFO_TERMS_OF_USE_CHECKBOX}
    Element Should Be Disabled    ${LEGAL_INFO_TERMS_OF_USE_CHECKBOX}
    Checkbox Should Be Selected    ${LEGAL_INFO_TERMS_OF_USE_CHECKBOX}

    Element Should Be Visible    ${LEGAL_INFO_PRIVACY_POLICY_CHECKBOX}
    Element Should Be Enabled    ${LEGAL_INFO_PRIVACY_POLICY_CHECKBOX}
    Checkbox Should Be Selected    ${LEGAL_INFO_PRIVACY_POLICY_CHECKBOX}
