*** Settings ***
Documentation       Wireless 5GHz Interface Resource File
...                 
...                 This resource file contains keywords related to wireless
...                 5GHz interface WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Library             Collections
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/wireless/ssid_pom.resource

*** Variables ***
${WIRELESS_5GHZ_HTML_ID}                                            ${DUT}[profile][wireless][5ghz][interface_id]

${WIRELESS_5GHZ_FACTORY_DEFAULT}                                    ${DUT}[profile][wireless][5ghz][factory_default]
${WIRELESS_5GHZ_FACTORY_DEFAULT_OP_MODE}                            ${WIRELESS_5GHZ_FACTORY_DEFAULT}[operation_mode]
${WIRELESS_5GHZ_FACTORY_DEFAULT_SSIDS_ISOLATION_ENABLED}            ${WIRELESS_5GHZ_FACTORY_DEFAULT}[ssids_isolation_enabled]
${WIRELESS_5GHZ_FACTORY_DEFAULT_IEEE_MODE}                          ${WIRELESS_5GHZ_FACTORY_DEFAULT}[ieee_mode]
${WIRELESS_5GHZ_FACTORY_DEFAULT_COUNTRY}                            ${WIRELESS_5GHZ_FACTORY_DEFAULT}[country]
${WIRELESS_5GHZ_FACTORY_DEFAULT_BANDWIDTH}                          ${WIRELESS_5GHZ_FACTORY_DEFAULT}[bandwidth]
${WIRELESS_5GHZ_FACTORY_DEFAULT_CHANNEL}                            ${WIRELESS_5GHZ_FACTORY_DEFAULT}[channel]
${WIRELESS_5GHZ_FACTORY_DEFAULT_TX_POWER}                           ${WIRELESS_5GHZ_FACTORY_DEFAULT}[tx_power]
${WIRELESS_5GHZ_FACTORY_DEFAULT_NOISE_FLOOR_CONTROL_ENABLED}        ${WIRELESS_5GHZ_FACTORY_DEFAULT}[noise_floor_control_enabled]

${WIRELESS_5GHZ_SUBMENU}                                            ${WIRELESS_5GHZ_HTML_ID}_submenu

${WIRELESS_5GHZ_OP_MODE_SELECT}                                     ${WIRELESS_5GHZ_HTML_ID}_wireless_op_mode
${WIRELESS_5GHZ_OP_MODE_SELECT_AP_VALUE}                            string:ap
${WIRELESS_5GHZ_OP_MODE_SELECT_REPEATER_VALUE}                      string:repeater

${WIRELESS_5GHZ_SSIDS_CUSTOM_LOCATOR}                               //*[@data-ssid-index]
${WIRELESS_5GHZ_SSID_INDEX}                                         data-ssid-index
${WIRELESS_5GHZ_SSID_NAME}                                          data-ssid-name

${WIRELESS_5GHZ_SSIDS_ISOLATION_CHECKBOX}                           ${WIRELESS_5GHZ_HTML_ID}_wireless_isolate

${WIRELESS_5GHZ_IEEE_MODE_SELECT}                                   ${WIRELESS_5GHZ_HTML_ID}_wireless_mode_ieee
${WIRELESS_5GHZ_IEEE_MODE_SELECT_A_VALUE}                           string:a
${WIRELESS_5GHZ_IEEE_MODE_SELECT_AN_VALUE}                          string:a/n
${WIRELESS_5GHZ_IEEE_MODE_SELECT_ANAC_VALUE}                        string:a/n/ac

${WIRELESS_5GHZ_COUNTRY_SELECT}                                     ${WIRELESS_5GHZ_HTML_ID}_wireless_country
${WIRELESS_5GHZ_COUNTRY_SELECT_BRAZIL_VALUE}                        string:BR

${WIRELESS_5GHZ_CHANNEL_AND_BW_INPUT}                               ${WIRELESS_5GHZ_HTML_ID}_canal_largura_banda_input
${WIRELESS_5GHZ_CHANNEL_AND_BW_BUTTON}                              ${WIRELESS_5GHZ_HTML_ID}_canal_largura_banda_button
${WIRELESS_5GHZ_SITE_SURVEY_BUTTON}                                 ${WIRELESS_5GHZ_HTML_ID}_canal_site_survey_button

${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT}                           ${WIRELESS_5GHZ_HTML_ID}_bandwidth_mhz
${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT_20_VALUE}                  string:20
${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT_20_40_VALUE}               string:40
${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT_20_40_80_VALUE}            string:80

# Yes, both "force 40 and force 80MHz" checkboxes have the same HTML id
# attribute that is "<radio>_force_40mhz" and there are two variables here
# just to make it more explicit.
${WIRELESS_5GHZ_FORCE_40MHZ_BW_CHECKBOX}                            ${WIRELESS_5GHZ_HTML_ID}_force_40mhz
${WIRELESS_5GHZ_FORCE_80MHZ_BW_CHECKBOX}                            ${WIRELESS_5GHZ_HTML_ID}_force_40mhz

${WIRELESS_5GHZ_ENABLE_DFS_CHANNELS_CHECKBOX}                       ${WIRELESS_5GHZ_HTML_ID}_dfs_channels

${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT}                           ${WIRELESS_5GHZ_HTML_ID}_extension_channel
${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT_AUTO_VALUE}                string:auto
${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT_ABOVE_VALUE}               string:above
${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT_BELOW_VALUE}               string:below

${WIRELESS_5GHZ_ALL_CHANNELS_CHECKBOX}                              head_channel_check

${WIRELESS_5GHZ_CHANNELS_CHECKBOX_CUSTOM_LOCATOR}                   //*[@data-cbox-channel-mhz]
${WIRELESS_5GHZ_CHANNELS_CHECKBOX_MHZ_DATA_ATTR}                    data-cbox-channel-mhz

${WIRELESS_5GHZ_CHANNEL_SETTINGS_CONFIRM_CHANGES_BUTTON}            ${WIRELESS_5GHZ_HTML_ID}_select_bandwidth_channel_button
${WIRELESS_5GHZ_CHANNEL_SETTINGS_DISCARD_CHANGES_BUTTON}            ${WIRELESS_5GHZ_HTML_ID}_cancel_bandwidth_channel_button

${WIRELESS_5GHZ_TX_POWER_SELECT}                                    ${WIRELESS_5GHZ_HTML_ID}_wireless_dbm_range

${WIRELESS_5GHZ_NOISE_FLOOR_CONTROL_SELECT}                         ${WIRELESS_5GHZ_HTML_ID}_wireless_noise_immunity
${WIRELESS_5GHZ_NOISE_FLOOR_CONTROL_SELECT_ACTIVATED_VALUE}         boolean:true
${WIRELESS_5GHZ_NOISE_FLOOR_CONTROL_SELECT_DEACTIVATED_VALUE}       boolean:false

*** Keywords ***
Skip This Test If Wireless 5GHz Is Not Supported By DUT
    IF    ${DUT}[profile][wireless][5ghz][is_supported] == ${FALSE}
        Skip    DUT does not support wireless 5GHz.
    END

Access Wireless 5GHz Interface Settings Page
    Open Wireless Menu
    Wait Until Element Is Visible    ${WIRELESS_5GHZ_SUBMENU}
    Click Element    ${WIRELESS_5GHZ_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
    Wait Until Element Is Visible    ${WIRELESS_5GHZ_OP_MODE_SELECT}

Set Wireless 5GHz Operation Mode Value To Access Point
    Select From List By Value
    ...    ${WIRELESS_5GHZ_OP_MODE_SELECT}
    ...    ${WIRELESS_5GHZ_OP_MODE_SELECT_AP_VALUE}

Set Wireless 5GHz Operation Mode Value To Repeater
    Select From List By Value
    ...    ${WIRELESS_5GHZ_OP_MODE_SELECT}
    ...    ${WIRELESS_5GHZ_OP_MODE_SELECT_REPEATER_VALUE}

Wireless 5GHz Operation Mode Should Be Access Point
    List Selection Should Be
    ...    ${WIRELESS_5GHZ_OP_MODE_SELECT}
    ...    ${WIRELESS_5GHZ_OP_MODE_SELECT_AP_VALUE}

Wireless 5GHz Operation Mode Should Be Repeater
    List Selection Should Be
    ...    ${WIRELESS_5GHZ_OP_MODE_SELECT}
    ...    ${WIRELESS_5GHZ_OP_MODE_SELECT_REPEATER_VALUE}

Select Wireless 5GHz SSIDs Isolation Checkbox
    Select Checkbox    ${WIRELESS_5GHZ_SSIDS_ISOLATION_CHECKBOX}

Unselect Wireless 5GHz SSIDs Isolation Checkbox
    Unselect Checkbox    ${WIRELESS_5GHZ_SSIDS_ISOLATION_CHECKBOX}

Set Wireless 5GHz IEEE Mode To 802.11a
    Select From List By Value
    ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT}
    ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT_A_VALUE}

Set Wireless 5GHz IEEE Mode To 802.11a/n
    Select From List By Value
    ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT}
    ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT_AN_VALUE}

Set Wireless 5GHz IEEE Mode To 802.11a/n/ac
    Select From List By Value
    ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT}
    ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT_ANAC_VALUE}

Wireless 5GHz Country Select Should Be Enabled
    Element Should Be Enabled    ${WIRELESS_5GHZ_COUNTRY_SELECT}

Wireless 5GHz Country Select Should Be Disabled
    Element Should Be Disabled    ${WIRELESS_5GHZ_COUNTRY_SELECT}

Wireless 5GHz Country Should Be Brazil
    List Selection Should Be
    ...    ${WIRELESS_5GHZ_COUNTRY_SELECT}
    ...    ${WIRELESS_5GHZ_COUNTRY_SELECT_BRAZIL_VALUE}

Wireless 5GHz Channel And Bandwidth Text Input Should Be "${text}"
    ${curr_text}    Get Value    ${WIRELESS_5GHZ_CHANNEL_AND_BW_INPUT}
    Should Be Equal As Strings    ${curr_text}    ${text}

Set Wireless 5GHz TX Power To "${dbm}" dBm
    Select From List By Value
    ...    ${WIRELESS_5GHZ_TX_POWER_SELECT}
    ...    number:${dbm}

Wireless 5GHz TX Power Should Be "${tx_power}"
    ${curr_tx_power}    Get Value    ${WIRELESS_5GHZ_TX_POWER_SELECT}
    Should Be Equal As Strings    ${curr_tx_power}    number:${tx_power}

Wireless 5GHz Minimum TX Power Should Be "${tx_power}"
    ${options}    Get List Items    ${WIRELESS_5GHZ_TX_POWER_SELECT}
    ${options}    Evaluate    sorted(${options}, key=int)
    IF    '${options}[0]' == '${tx_power}'
        Return From Keyword
    ELSE
        Fail    Minimum TX power should be '${tx_power}' but was reported as '${options}[0]'.
    END

Wireless 5GHz Maximum TX Power Should Be "${tx_power}"
    ${options}    Get List Items    ${WIRELESS_5GHZ_TX_POWER_SELECT}
    ${options}    Evaluate    sorted(${options}, key=int, reverse=True)
    IF    '${options}[0]' == '${tx_power}'
        Return From Keyword
    ELSE
        Fail    Maximum TX power should be '${tx_power}' but was reported as '${options}[0]'.
    END

Open Wireless 5GHz Channel/Bandwidth Settings
    Click Button    ${WIRELESS_5GHZ_CHANNEL_AND_BW_BUTTON}
    Wait Until Element Is Visible    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT}

Select Wireless 5GHz Preferably 40MHz Bandwidth Checkbox
    Select Checkbox    ${WIRELESS_5GHZ_FORCE_40MHZ_BW_CHECKBOX}

Unselect Wireless 5GHz Preferably 40MHz Bandwidth Checkbox
    Unselect Checkbox    ${WIRELESS_5GHZ_FORCE_40MHZ_BW_CHECKBOX}

Select Wireless 5GHz Preferably 80MHz Bandwidth Checkbox
    Select Checkbox    ${WIRELESS_5GHZ_FORCE_80MHZ_BW_CHECKBOX}

Unselect Wireless 5GHz Preferably 80MHz Bandwidth Checkbox
    Unselect Checkbox    ${WIRELESS_5GHZ_FORCE_80MHZ_BW_CHECKBOX}

Select Wireless 5GHz Enable DFS Channels Checkbox
    Select Checkbox    ${WIRELESS_5GHZ_ENABLE_DFS_CHANNELS_CHECKBOX}

Unselect Wireless 5GHz Enable DFS Channels Checkbox
    Unselect Checkbox    ${WIRELESS_5GHZ_ENABLE_DFS_CHANNELS_CHECKBOX}

Set Wireless 5GHz Channel Bandwidth To 20MHz
    Select From List By Value
    ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT}
    ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT_20_VALUE}

Set Wireless 5GHz Channel Bandwidth To 20/40MHz
    Select From List By Value
    ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT}
    ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT_20_40_VALUE}

Set Wireless 5GHz Channel Bandwidth To 20/40/80MHz
    Select From List By Value
    ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT}
    ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT_20_40_80_VALUE}

Set Wireless 5GHz Channel Extension To Automatic
    Select From List By Value
    ...    ${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT}
    ...    ${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT_AUTO_VALUE}

Set Wireless 5GHz Channel Extension To Above
    Select From List By Value
    ...    ${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT}
    ...    ${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT_ABOVE_VALUE}

Set Wireless 5GHz Channel Extension To Below
    Select From List By Value
    ...    ${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT}
    ...    ${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT_BELOW_VALUE}

Select All Wireless 5GHz Channels Checkbox
    Select Checkbox    ${WIRELESS_5GHZ_ALL_CHANNELS_CHECKBOX}

Unselect All Wireless 5GHz Channels Checkbox
    Unselect Checkbox    ${WIRELESS_5GHZ_ALL_CHANNELS_CHECKBOX}

Select Wireless 5GHz Channel "${channel_mhz}" Checkbox
    ${channels}    Get Webelements    ${WIRELESS_5GHZ_CHANNELS_CHECKBOX_CUSTOM_LOCATOR}
    FOR    ${channel}    IN    @{channels}
        ${curr_channel_mhz}    Get Element Attribute    ${channel}    ${WIRELESS_5GHZ_CHANNELS_CHECKBOX_MHZ_DATA_ATTR}
        IF    '${curr_channel_mhz}' == '${channel_mhz}'
            Select Checkbox    ${channel}
            Return From Keyword
        END
    END
    Fail    Channel frequency '${channel_mhz}' does not exist (or is not available for DUT).

Unselect Wireless 5GHz Channel "${channel_mhz}" Checkbox
    ${channels}    Get Webelements    ${WIRELESS_5GHZ_CHANNELS_CHECKBOX_CUSTOM_LOCATOR}
    FOR    ${channel}    IN    @{channels}
        ${curr_channel_mhz}    Get Element Attribute    ${channel}    ${WIRELESS_5GHZ_CHANNELS_CHECKBOX_MHZ_DATA_ATTR}
        IF    '${curr_channel_mhz}' == '${channel_mhz}'
            Unselect Checkbox    ${channel}
            Return From Keyword
        END
    END
    Fail    Channel frequency '${channel_mhz}' does not exist (or is not available for DUT).

Confirm Wireless 5GHz Channel Settings Changes
    Click Button    ${WIRELESS_5GHZ_CHANNEL_SETTINGS_CONFIRM_CHANGES_BUTTON}
    Wait Until Element Is Not Visible    ${WIRELESS_5GHZ_CHANNEL_SETTINGS_CONFIRM_CHANGES_BUTTON}
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END

Discard Wireless 5GHz Channel Settings Changes
    Click Button    ${WIRELESS_5GHZ_CHANNEL_SETTINGS_DISCARD_CHANGES_BUTTON}
    Wait Until Element Is Not Visible    ${WIRELESS_5GHZ_CHANNEL_SETTINGS_DISCARD_CHANGES_BUTTON}
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END

Every 5GHz Channel Checkbox Should Be Selected
    ${channel_cboxes}    Get Webelements    ${WIRELESS_5GHZ_CHANNELS_CHECKBOX_CUSTOM_LOCATOR}
    FOR    ${channel_cbox}    IN    @{channel_cboxes}
        Checkbox Should Be Selected    ${channel_cbox}
    END

Wireless 5GHz Interface Settings Should Be Factory Default
    IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_OP_MODE}' == 'access_point'
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_OP_MODE_SELECT}
        ...    ${WIRELESS_5GHZ_OP_MODE_SELECT_AP_VALUE}
    ELSE IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_OP_MODE}' == 'repeater'
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_OP_MODE_SELECT}
        ...    ${WIRELESS_5GHZ_OP_MODE_SELECT_REPEATER_VALUE}
    ELSE
        Fail    Could not determine DUT wireless 5GHz interface factory default operating mode (check DUT profile).
    END

    IF    ${WIRELESS_5GHZ_FACTORY_DEFAULT_SSIDS_ISOLATION_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${WIRELESS_5GHZ_SSIDS_ISOLATION_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${WIRELESS_5GHZ_SSIDS_ISOLATION_CHECKBOX}
    END

    IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_IEEE_MODE}' == 'a'
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT}
        ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT_A_VALUE}
    ELSE IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_IEEE_MODE}' == 'a/n'
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT}
        ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT_AN_VALUE}
    ELSE IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_IEEE_MODE}' == 'a/n/ac'
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT}
        ...    ${WIRELESS_5GHZ_IEEE_MODE_SELECT_ANAC_VALUE}
    ELSE
        Fail    Could not determine DUT wireless 5GHz interface factory default IEEE mode (check DUT profile).
    END

    IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_COUNTRY}' == 'brasil'
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_COUNTRY_SELECT}
        ...    ${WIRELESS_5GHZ_COUNTRY_SELECT_BRAZIL_VALUE}
    ELSE
        Fail    Could not determine DUT wireless 5GHz interface factory default country (check DUT profile).
    END

    Element Should Be Visible    ${WIRELESS_5GHZ_SITE_SURVEY_BUTTON}
    Element Should Be Enabled    ${WIRELESS_5GHZ_SITE_SURVEY_BUTTON}

    Open Wireless 5GHz Channel/Bandwidth Settings

    IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_BANDWIDTH}' == '20 MHz'
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT}
        ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT_20_VALUE}
    ELSE IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_BANDWIDTH}' == '20/40 MHz'
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT}
        ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT_20_40_VALUE}
    ELSE IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_BANDWIDTH}' == '20/40/80 MHz'
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT}
        ...    ${WIRELESS_5GHZ_CHANNEL_BANDWIDTH_SELECT_20_40_80_VALUE}
    ELSE
        Fail    Could not determine DUT wireless 5GHz interface factory default channel bandwidth (check DUT profile).
    END

    Checkbox Should Not Be Selected    ${WIRELESS_5GHZ_FORCE_80MHZ_BW_CHECKBOX}
    Checkbox Should Not Be Selected    ${WIRELESS_5GHZ_ENABLE_DFS_CHANNELS_CHECKBOX}

    IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_CHANNEL}' == 'automatic'
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT}
        ...    ${WIRELESS_5GHZ_EXTENSION_CHANNEL_SELECT_AUTO_VALUE}
        Every 5GHz Channel Checkbox Should Be Selected
    ELSE
        Fail    Could not determine DUT wireless 5GHz interface factory default channel (check DUT profile).
    END

    Wireless 5GHz TX Power Should Be "${WIRELESS_5GHZ_FACTORY_DEFAULT_TX_POWER}"

    IF    ${WIRELESS_5GHZ_FACTORY_DEFAULT_NOISE_FLOOR_CONTROL_ENABLED} == ${TRUE}
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_NOISE_FLOOR_CONTROL_SELECT}
        ...    ${WIRELESS_5GHZ_NOISE_FLOOR_CONTROL_SELECT_ACTIVATED_VALUE}
    ELSE IF    ${WIRELESS_5GHZ_FACTORY_DEFAULT_NOISE_FLOOR_CONTROL_ENABLED} == ${FALSE}
        List Selection Should Be
        ...    ${WIRELESS_5GHZ_NOISE_FLOOR_CONTROL_SELECT}
        ...    ${WIRELESS_5GHZ_NOISE_FLOOR_CONTROL_SELECT_DEACTIVATED_VALUE}
    END
