*** Settings ***
Documentation       Login WEB Page Resource File
...                 
...                 This resource file contains keywords related to login WEB
...                 page manipulation (page object model).

Library             Collections
Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            api/fiber/v3/service.resource
Resource            api/fiber/v3/system.resource
Resource            web/common.resource
Resource            web/header_pom.resource
Resource            web/sidemenu_pom.resource
Resource            web/status/general_pom.resource
Resource            utils.resource

*** Variables ***
${CHROME_BROWSER_IS_RECOMMENDED_WEB_MESSAGE}    É recomendado utilizar o navegador Chrome para configuração do dispositivo.

${LOGIN_USERNAME_INPUT}                         usuario
${LOGIN_PASSWORD_INPUT}                         senha

${LOGIN_BUTTON}                                 logar

${LOGIN_NEW_PASSWORD_INPUT}                     newPassword
${LOGIN_NEW_PASSWORD_CONFIRMATION_INPUT}        confirmPassword
${LOGIN_CHANGE_PASSWORD_BUTTON}                 salvar_button

${LOGIN_COMPLIANCE_CHECKBOX}                    compliance_checkbox

#TODO: variable WIZARD_HOSTNAME_INPUT should be moved to wizard_pom.resource (does not exist yet).
${WIZARD_HOSTNAME_INPUT}                        wan_alias

*** Keywords ***
Access DUT WEB Login Page Through IPv4 Address
    Open Browser    ${DUT_URL}    ${BROWSER}    executable_path=${WEBDRIVER_PATH}
    Wait Until Page Title Is    ${DUT}[profile][general][login_page_title]    60s
    IF    '${BROWSER}' != 'Chrome'
        Wait Until WEB Message Is "${CHROME_BROWSER_IS_RECOMMENDED_WEB_MESSAGE}" Or Timeout After "30" Seconds
        Dismiss Current Displayed WEB Message
    END

Set Login Username To "${value}"
    Input Text    ${LOGIN_USERNAME_INPUT}    ${value}

Set Login Password To "${value}"
    Input Text    ${LOGIN_PASSWORD_INPUT}    ${value}

Click Login Button
    Click Button    ${LOGIN_BUTTON}

Set New Login Password To "${value}"
    Input Text    ${LOGIN_NEW_PASSWORD_INPUT}    ${value}

Set New Login Password Confirmation To "${value}"
    Input Text    ${LOGIN_NEW_PASSWORD_CONFIRMATION_INPUT}    ${value}

Select Login Compliance Checkbox
    Select Checkbox    ${LOGIN_COMPLIANCE_CHECKBOX}

Unselect Login Compliance Checkbox
    Unselect Checkbox    ${LOGIN_COMPLIANCE_CHECKBOX}

Click Login First Access Change Password Button
    Click Button    ${LOGIN_CHANGE_PASSWORD_BUTTON}

First Access Change Password Button Should Be Disabled
    Element Should Be Disabled    ${LOGIN_CHANGE_PASSWORD_BUTTON}

Login To DUT WEB Page Through IPv4 Address
    Access DUT WEB Login Page Through IPv4 Address
    Set Login Username To "${DUT}[env][management][login][username]"
    Set Login Password To "${DUT}[env][management][login][password]"
    Log    DUT current username: ${DUT}[env][management][login][username]
    Log    DUT current password: ${DUT}[env][management][login][password]
    Click Login Button
    ${factory_default}    FiberV3 Check If DUT Is In Factory Default State
    IF    '${DUT_FIRMWARE_STAGE}' == '${FIRMWARE_STAGE_PRODUCTION}' and ${factory_default} == ${True}
        Wait Until Element Is Visible    ${LOGIN_NEW_PASSWORD_INPUT}
        Perform DUT WEB First Access Password Change
    ELSE
        Wait Until Page Title Is    ${DUT}[profile][general][web_management_page_title]    60s
        Wait For WEB Message To Disappear Or Timeout After "60" Seconds
        Wait Until Status Menu Is Fully Open
    END
    ${cronos_version_is_newer}    Cronos Firmware Version Is Newer Than Current DUT Firmware Version
    IF    ${cronos_version_is_newer} == ${TRUE}
        Reject Cronos Firmware Upgrade Request
    END

Perform DUT WEB First Access Password Change
    Set New Login Password To "${DUT}[env][management][login][first_access_password]"
    Set New Login Password Confirmation To "${DUT}[env][management][login][first_access_password]"
    Select Login Compliance Checkbox
    Click Login First Access Change Password Button
    Wait Until Page Title Is    ${DUT}[profile][general][web_management_page_title]    60s
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
    Wait Until Element Is Visible    ${WIZARD_HOSTNAME_INPUT}
    Set To Dictionary    ${DUT}[env][management][login]    password
    ...    ${DUT}[env][management][login][first_access_password]
    Log    DUT current password: ${DUT}[env][management][login][password]
    ${config_hash}    FiberV3 Get DUT Settings Hash
    Set Global Variable    ${FIRST_ACCESS_PASSWORD_CONFIG_HASH}    ${config_hash}

Wait Until Login Page Is Displayed Or Timeout After "${timeout}" Seconds
    Wait Until Page Title Is    ${DUT}[profile][general][login_page_title]    ${timeout}
    Wait Until Element Is Visible    ${LOGIN_USERNAME_INPUT}
    Wait Until Element Is Visible    ${LOGIN_PASSWORD_INPUT}
    Wait Until Element Is Visible    ${LOGIN_BUTTON}

Login Page Should Be Displayed
    Title Should Be    ${DUT}[profile][general][login_page_title]
    Element Should Be Visible    ${LOGIN_USERNAME_INPUT}
    Element Should Be Visible    ${LOGIN_PASSWORD_INPUT}
    Element Should Be Visible    ${LOGIN_BUTTON}

Login To DUT With Username "${username}" And Password "${password}"
    Set Login Username To "${username}"
    Set Login Password To "${password}"
    Click Login Button

Perform DUT WEB First Access Password Change With Password "${password}" And Confirmation Password "${confirmation}"
    Wait Until User First Access Page Is Displayed
    Set New Login Password To "${password}"
    Set New Login Password Confirmation To "${confirmation}"
    Select Login Compliance Checkbox
    Click Login First Access Change Password Button

Wait Until User First Access Page Is Displayed
    Wait Until Element Is Visible    ${LOGIN_NEW_PASSWORD_INPUT}
    Wait Until Element Is Visible    ${LOGIN_NEW_PASSWORD_CONFIRMATION_INPUT}
    Wait Until Element Is Visible    ${LOGIN_COMPLIANCE_CHECKBOX}
    Wait Until Element Is Visible    ${LOGIN_CHANGE_PASSWORD_BUTTON}

Wait Until Wizard First Step Page Is Displayed
    Wait Until Element Is Visible    ${WIZARD_HOSTNAME_INPUT}

Logout From DUT WEB Management And Login Again
    Logout From DUT WEB Management
    IF    '${BROWSER}' != 'Chrome'
        Wait Until WEB Message Is "${CHROME_BROWSER_IS_RECOMMENDED_WEB_MESSAGE}" Or Timeout After "30" Seconds
        Dismiss Current Displayed WEB Message
    END
    Login To DUT With Username "${DUT}[env][management][login][username]" And Password "${DUT}[env][management][login][password]"
    Wait Until Page Title Is    ${DUT}[profile][general][web_management_page_title]    60s
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds

Cronos Firmware Version Is Newer Than Current DUT Firmware Version
    ${firmware_version}    FiberV3 Get DUT Firmware Version
    Log    DUT VERSION: ${firmware_version}
    ${cronos_version}    FiberV3 Get Cronos Version
    Log    CRONOS VERSION: ${cronos_version}
    IF    '${cronos_version}' == '${NONE}'
        ${cronos_version_is_newer}    Set Variable    ${FALSE}
    ELSE
        ${cronos_version_is_newer}    Version "${cronos_version}" Is Newer Than Version "${firmware_version}"
    END
    [Return]    ${cronos_version_is_newer}
