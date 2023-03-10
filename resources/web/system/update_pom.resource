*** Settings ***
Documentation       System Update Resource File
...                 
...                 This resource file contains keywords related to system
...                 update webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            api/fiber/v3/system.resource

*** Variables ***
${SYSTEM_UPDATE_SUBMENU}                                firmware_submenu

${CURRENT_FIRMWARE_VERSION_TEXT}                        device_version

${CRONOS_FIRMWARE_VERSION_SPAN}                         available_version
${CRONOS_FIRMWARE_VERSION_CHANGELOG_BUTTON}             changelog_button
${CRONOS_FIRMWARE_VERSION_UPDATE_BUTTON}                upload_button_remote

${LOCAL_FIRMWARE_UPDATE_CHOOSE_FILE_HIDDEN_INPUT}       data_firmware_button
${LOCAL_FIRMWARE_UPDATE_CHOOSE_FILE_SPAN_BUTTON}        //*[@id="main"]/div[2]/div/div/div/div/div[3]/div/div/span
${LOCAL_FIRMWARE_UPDATE_CHOOSE_FILE_INPUT}              data_firmware_filename

${LOCAL_FIRMWARE_UPDATE_BUTTON}                         upload_button

*** Keywords ***
 Access System Update Page
    Open System Menu
    Wait Until Element Is Visible    ${SYSTEM_UPDATE_SUBMENU}
    Click Element    ${SYSTEM_UPDATE_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${LOCAL_FIRMWARE_UPDATE_BUTTON}

Cronos Available Firmware Version Should Be "${cronos_version}"
    Element Attribute Value Should Be
    ...    ${CRONOS_FIRMWARE_VERSION_SPAN}
    ...    innerText    ${cronos_version}

Current Firmware Version Should Be "${curr_version}"
    Element Attribute Value Should Be
    ...    ${CURRENT_FIRMWARE_VERSION_TEXT}
    ...    innerText    ${curr_version}

System Update Webpage Settings Should Be Correct
    ${curr_version}    FiberV3 Get DUT Firmware Version
    ${cronos_version}    FiberV3 Get Cronos Version

    IF    '${cronos_version}' != '${NONE}'
        Cronos Available Firmware Version Should Be "${cronos_version}"

        ${curr_version_is_newer}    Version "${curr_version}" Is Newer Than Version "${cronos_version}"

        IF    ${curr_version_is_newer} == ${TRUE}
            Element Should Be Disabled    ${CRONOS_FIRMWARE_VERSION_UPDATE_BUTTON}
            Current Firmware Version Should Be "${curr_version}"
        ELSE IF    ${curr_version_is_newer} == ${FALSE}
            Element Should Be Enabled    ${CRONOS_FIRMWARE_VERSION_UPDATE_BUTTON}
            Current Firmware Version Should Be "${curr_version} Desatualizada!"
        END
    ELSE
        Current Firmware Version Should Be "${curr_version}"
        Cronos Available Firmware Version Should Be "Não foi possível obter as informações da versão mais recente disponível"
        Element Should Be Disabled    ${CRONOS_FIRMWARE_VERSION_CHANGELOG_BUTTON}
        Element Should Be Disabled    ${CRONOS_FIRMWARE_VERSION_UPDATE_BUTTON}
    END

    Element Should Be Visible    ${LOCAL_FIRMWARE_UPDATE_CHOOSE_FILE_SPAN_BUTTON}
    Element Should Be Enabled    ${LOCAL_FIRMWARE_UPDATE_CHOOSE_FILE_SPAN_BUTTON}

    Element Should Be Visible    ${LOCAL_FIRMWARE_UPDATE_CHOOSE_FILE_INPUT}
    Element Attribute Value Should Be
    ...    ${LOCAL_FIRMWARE_UPDATE_CHOOSE_FILE_INPUT}
    ...    value    ${EMPTY}

    Element Should Be Visible    ${LOCAL_FIRMWARE_UPDATE_BUTTON}
    Element Should Be Disabled    ${LOCAL_FIRMWARE_UPDATE_BUTTON}
