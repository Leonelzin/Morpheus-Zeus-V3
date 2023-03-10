*** Settings ***
Documentation       Wireless SSID Management Resource File
...                 
...                 This resource file contains keywords related to wireless
...                 SSID management WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/wireless/ssid_settings_pom.resource
Resource            web/wireless/ssid_scheduling_pom.resource
Resource            web/wireless/ssid_mac_acl_pom.resource

*** Variables ***
${WIRELESS_SSID_SUBMENU}            wirelessSSID_submenu

${SSIDS_CUSTOM_LOCATOR}             //*[@data-ssid-index]
${SSID_INDEX_DATA_ATTR}             data-ssid-index
${SSID_NAME_DATA_ATTR}              data-ssid-name

${SSID_SETTINGS_BUTTON_PREFIX}      ssid_settings
${SSID_SCHEDULING_BUTTON_PREFIX}    ssid_scheduling
${SSID_MAC_ACL_BUTTON_PREFIX}       ssid_mac_acl
${SSID_REMOVE_BUTTON_PREFIX}        ssid_remove

${ADD_NEW_SSID_BUTTON}              add_new_ssid

*** Keywords ***
Access SSID Settings Page
    Open Wireless Menu
    Wait Until Element Is Visible    ${WIRELESS_SSID_SUBMENU}
    Click Element    ${WIRELESS_SSID_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
    Wait Until Element Is Visible    ${SAVE_SETTINGS_BUTTON}

Get All SSIDs
    ${ssids}    Get Webelements    ${SSIDS_CUSTOM_LOCATOR}
    [Return]    ${ssids}

Iterate Through SSIDs And Open SSID "${ssid_name}" Settings
    ${ssids}    Get All SSIDs
    FOR    ${ssid}    IN    @{ssids}
        ${curr_ssid_name}    Get Element Attribute    ${ssid}    ${SSID_NAME_DATA_ATTR}
        IF    """${curr_ssid_name}""" == """${ssid_name}"""
            ${ssid_index}    Get Element Attribute    ${ssid}    ${SSID_INDEX_DATA_ATTR}
            Click Button    ${SSID_SETTINGS_BUTTON_PREFIX}_${ssid_index}
            Wait Until Element Is Visible    ${SSID_NAME_INPUT}
            Wait "2" Seconds For WEB Animation To Finish
            Return From Keyword
        END
    END
    Fail    SSID '${ssid_name}' does not exist.

Iterate Through SSIDs And Open SSID "${ssid_name}" Scheduling Settings
    ${ssids}    Get All SSIDs
    FOR    ${ssid}    IN    @{ssids}
        ${curr_ssid_name}    Get Element Attribute    ${ssid}    ${SSID_NAME_DATA_ATTR}
        IF    """${curr_ssid_name}""" == """${ssid_name}"""
            ${ssid_index}    Get Element Attribute    ${ssid}    ${SSID_INDEX_DATA_ATTR}
            Click Button    ${SSID_SCHEDULING_BUTTON_PREFIX}_${ssid_index}
            Wait Until Element Is Visible    ${SSID_SCHEDULING_SELECT}
            Wait "2" Seconds For WEB Animation To Finish
            Return From Keyword
        END
    END
    Fail    SSID '${ssid_name}' does not exist.

Scheduling Settings Button Should Be Disabled For All SSIDs
    ${ssids}    Get All SSIDs
    FOR    ${ssid}    IN    @{ssids}
        ${curr_ssid_name}    Get Element Attribute    ${ssid}    ${SSID_NAME_DATA_ATTR}
        ${ssid_index}    Get Element Attribute    ${ssid}    ${SSID_INDEX_DATA_ATTR}
        Element Should Be Disabled    ${SSID_SCHEDULING_BUTTON_PREFIX}_${ssid_index}
    END

Iterate Through SSIDs And Open SSID "${ssid_name}" MAC ACL Settings
    ${ssids}    Get All SSIDs
    FOR    ${ssid}    IN    @{ssids}
        ${curr_ssid_name}    Get Element Attribute    ${ssid}    ${SSID_NAME_DATA_ATTR}
        IF    """${curr_ssid_name}""" == """${ssid_name}"""
            ${ssid_index}    Get Element Attribute    ${ssid}    ${SSID_INDEX_DATA_ATTR}
            Click Button    ${SSID_MAC_ACL_BUTTON_PREFIX}_${ssid_index}
            Wait Until Element Is Visible    ${SSID_MAC_ACL_SELECT}
            Wait "2" Seconds For WEB Animation To Finish
            Return From Keyword
        END
    END
    Fail    SSID '${ssid_name}' does not exist.

Iterate Through SSIDs And Remove SSID "${ssid_name}"
    ${ssids}    Get All SSIDs
    FOR    ${ssid}    IN    @{ssids}
        ${curr_ssid_name}    Get Element Attribute    ${ssid}    ${SSID_NAME_DATA_ATTR}
        IF    """${curr_ssid_name}""" == """${ssid_name}"""
            ${ssid_index}    Get Element Attribute    ${ssid}    ${SSID_INDEX_DATA_ATTR}
            Click Button    ${SSID_REMOVE_BUTTON_PREFIX}_${ssid_index}
            Wait "2" Seconds For WEB Animation To Finish
            Return From Keyword
        END
    END
    Fail    SSID '${ssid_name}' does not exist.

Open SSID "${ssid_name}" Settings
    Wait Until Keyword Succeeds    3x    1s    Iterate Through SSIDs And Open SSID "${ssid_name}" Settings

Open SSID "${ssid_name}" Scheduling Settings
    Wait Until Keyword Succeeds    3x    1s    Iterate Through SSIDs And Open SSID "${ssid_name}" Scheduling Settings

Open SSID "${ssid_name}" MAC ACL Settings
    Wait Until Keyword Succeeds    3x    1s    Iterate Through SSIDs And Open SSID "${ssid_name}" MAC ACL Settings

Remove SSID "${ssid_name}"
    Wait Until Keyword Succeeds    3x    1s    Iterate Through SSIDs And Remove SSID "${ssid_name}"

Click Add New SSID Button
    Click Button    ${ADD_NEW_SSID_BUTTON}
    Register Keyword To Run On Failure    NONE
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END
    Wait Until Element Is Visible    ${SSID_NAME_INPUT}

Keep Only One SSID And Remove All Others
    ${ssids}    Get All SSIDs
    ${first_ssid}    Remove From List    ${ssids}    0
    ${first_ssid_name}    Get Element Attribute    ${first_ssid}    ${SSID_NAME_DATA_ATTR}
    @{ssids_names}    Create List

    FOR    ${ssid}    IN    @{ssids}
        ${curr_ssid_name}    Get Element Attribute    ${ssid}    ${SSID_NAME_DATA_ATTR}
        Append To List    ${ssids_names}    ${curr_ssid_name}
    END

    FOR    ${ssid_name}    IN    @{ssids_names}
        Remove SSID "${ssid_name}"
        Wait "2" Seconds For WEB Animation To Finish
    END

    [Return]    ${first_ssid_name}
