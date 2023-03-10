*** Settings ***
Documentation       System Settings Resource File
...                 
...                 This resource file contains keywords related to system
...                 settings webpage manipulation (page object model).

Library             OperatingSystem
Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${SYSTEM_SETTINGS_SUBMENU}                                              configuration_submenu

${SETTINGS_BACKUP_DOWNLOAD_BUTTON}                                      download_button

${SETTINGS_UPLOAD_CHOOSE_FILE_INPUT}                                    data_config
${SETTINGS_UPLOAD_CHOOSE_FILE_BUTTON}                                   //*[@id="main"]/div[2]/div/div/div/div/div[2]/div/div/span/span
${SETTINGS_UPLOAD_INPUT}                                                data_config_filename
${SETTINGS_UPLOAD_BUTTON}                                               upload_button

${RESTORE_FACTORY_DEFAULT_SETTINGS_BUTTON}                              restore_factory_button

${RESTORE_FACTORY_DEFAULT_SETTINGS_CONFIRMATION_MODAL}                  confirmation_modal
${RESTORE_FACTORY_DEFAULT_SETTINGS_CONFIRMATION_MODAL_YES_BUTTON}       yes
${RESTORE_FACTORY_DEFAULT_SETTINGS_CONFIRMATION_MODAL_NO_BUTTON}        no

*** Keywords ***
Access System Settings Page
    Open System Menu
    Wait Until Element Is Visible    ${SYSTEM_SETTINGS_SUBMENU}
    Click Element    ${SYSTEM_SETTINGS_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${RESTORE_FACTORY_DEFAULT_SETTINGS_BUTTON}

Download System Settings Backup File
    Click Button    ${SETTINGS_BACKUP_DOWNLOAD_BUTTON}
    Wait For WEB Message To Disappear Or Timeout After "15" Seconds

Upload System Settings Backup File
    [Arguments]    ${filepath}
    Choose File    ${SETTINGS_UPLOAD_CHOOSE_FILE_BUTTON}    ${filepath}
    Click Button    ${SETTINGS_UPLOAD_BUTTON}
    Wait For WEB Message To Disappear Or Timeout After "250" Seconds

Remove All ZEUS System Settings Files From Browser Download Directory
    ${filepath}    Join Path    ${BROWSER_DOWNLOAD_DIRECTORY}    *_config*.itb
    Remove File    ${filepath}

System Settings Backup File "${filename}" Should Exist In Browser Download Directory
    ${filepath}    Join Path    ${BROWSER_DOWNLOAD_DIRECTORY}    ${filename}
    File Should Exist    ${filepath}

System Settings Should Be Factory Default
    Element Should Be Visible    ${SETTINGS_BACKUP_DOWNLOAD_BUTTON}
    Element Should Be Enabled    ${SETTINGS_BACKUP_DOWNLOAD_BUTTON}

    Element Should Be Visible    ${SETTINGS_UPLOAD_CHOOSE_FILE_BUTTON}
    Element Should Be Enabled    ${SETTINGS_UPLOAD_CHOOSE_FILE_BUTTON}

    Element Should Be Visible    ${SETTINGS_UPLOAD_INPUT}
    Element Attribute Value Should Be
    ...    ${SETTINGS_UPLOAD_INPUT}
    ...    value    ${EMPTY}

    Element Should Be Visible    ${SETTINGS_UPLOAD_BUTTON}
    Element Should Be Disabled    ${SETTINGS_UPLOAD_BUTTON}

    Element Should Be Visible    ${RESTORE_FACTORY_DEFAULT_SETTINGS_BUTTON}
    Element Should Be Enabled    ${RESTORE_FACTORY_DEFAULT_SETTINGS_BUTTON}
