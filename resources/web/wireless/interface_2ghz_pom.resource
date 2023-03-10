*** Settings ***
Documentation       Wireless 2.4GHz Interface Resource File
...                 
...                 This resource file contains keywords related to wireless
...                 2.4GHz interface WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Library             Collections
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/wireless/ssid_pom.resource

*** Variables ***
${WIRELESS_2GHZ_HTML_ID}                                            ${DUT}[profile][wireless][2ghz][interface_id]

${WIRELESS_2GHZ_FACTORY_DEFAULT}                                    ${DUT}[profile][wireless][2ghz][factory_default]
${WIRELESS_2GHZ_FACTORY_DEFAULT_OP_MODE}                            ${WIRELESS_2GHZ_FACTORY_DEFAULT}[operation_mode]
${WIRELESS_2GHZ_FACTORY_DEFAULT_SSIDS_ISOLATION_ENABLED}            ${WIRELESS_2GHZ_FACTORY_DEFAULT}[ssids_isolation_enabled]
${WIRELESS_2GHZ_FACTORY_DEFAULT_IEEE_MODE}                          ${WIRELESS_2GHZ_FACTORY_DEFAULT}[ieee_mode]
${WIRELESS_2GHZ_FACTORY_DEFAULT_COUNTRY}                            ${WIRELESS_2GHZ_FACTORY_DEFAULT}[country]
${WIRELESS_2GHZ_FACTORY_DEFAULT_BANDWIDTH}                          ${WIRELESS_2GHZ_FACTORY_DEFAULT}[bandwidth]
${WIRELESS_2GHZ_FACTORY_DEFAULT_CHANNEL}                            ${WIRELESS_2GHZ_FACTORY_DEFAULT}[channel]
${WIRELESS_2GHZ_FACTORY_DEFAULT_TX_POWER}                           ${WIRELESS_2GHZ_FACTORY_DEFAULT}[tx_power]
${WIRELESS_2GHZ_FACTORY_DEFAULT_NOISE_FLOOR_CONTROL_ENABLED}        ${WIRELESS_2GHZ_FACTORY_DEFAULT}[noise_floor_control_enabled]

${WIRELESS_2GHZ_SUBMENU}                                            ${WIRELESS_2GHZ_HTML_ID}_submenu

${WIRELESS_2GHZ_OP_MODE_SELECT}                                     ${WIRELESS_2GHZ_HTML_ID}_wireless_op_mode
${WIRELESS_2GHZ_OP_MODE_SELECT_AP_VALUE}                            string:ap
${WIRELESS_2GHZ_OP_MODE_SELECT_REPEATER_VALUE}                      string:repeater

${WIRELESS_2GHZ_SSIDS_ISOLATION_CHECKBOX}                           ${WIRELESS_2GHZ_HTML_ID}_wireless_isolate

${WIRELESS_2GHZ_IEEE_MODE_SELECT}                                   ${WIRELESS_2GHZ_HTML_ID}_wireless_mode_ieee
${WIRELESS_2GHZ_IEEE_MODE_SELECT_B_VALUE}                           string:b
${WIRELESS_2GHZ_IEEE_MODE_SELECT_G_VALUE}                           string:g
${WIRELESS_2GHZ_IEEE_MODE_SELECT_BG_VALUE}                          string:b/g
${WIRELESS_2GHZ_IEEE_MODE_SELECT_BGN_VALUE}                         string:b/g/n

${WIRELESS_2GHZ_COUNTRY_SELECT}                                     ${WIRELESS_2GHZ_HTML_ID}_wireless_country
${WIRELESS_2GHZ_COUNTRY_SELECT_BRAZIL_VALUE}                        string:BR

${WIRELESS_2GHZ_CHANNEL_AND_BW_INPUT}                               ${WIRELESS_2GHZ_HTML_ID}_canal_largura_banda_input
${WIRELESS_2GHZ_CHANNEL_AND_BW_BUTTON}                              ${WIRELESS_2GHZ_HTML_ID}_canal_largura_banda_button
${WIRELESS_2GHZ_SITE_SURVEY_BUTTON}                                 ${WIRELESS_2GHZ_HTML_ID}_canal_site_survey_button

${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT}                           ${WIRELESS_2GHZ_HTML_ID}_bandwidth_mhz
${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT_20_VALUE}                  string:20
${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT_20_40_VALUE}               string:40

${WIRELESS_2GHZ_FORCE_40MHZ_BW_CHECKBOX}                            ${WIRELESS_2GHZ_HTML_ID}_force_40mhz

${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT}                           ${WIRELESS_2GHZ_HTML_ID}_extension_channel
${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT_AUTO_VALUE}                string:auto
${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT_ABOVE_VALUE}               string:above
${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT_BELOW_VALUE}               string:below

${WIRELESS_2GHZ_ALL_CHANNELS_CHECKBOX}                              head_channel_check

${WIRELESS_2GHZ_CHANNELS_CHECKBOX_CUSTOM_LOCATOR}                   //*[@data-cbox-channel-mhz]
${WIRELESS_2GHZ_CHANNELS_CHECKBOX_MHZ_DATA_ATTR}                    data-cbox-channel-mhz

${WIRELESS_2GHZ_CHANNEL_SETTINGS_CONFIRM_CHANGES_BUTTON}            ${WIRELESS_2GHZ_HTML_ID}_select_bandwidth_channel_button
${WIRELESS_2GHZ_CHANNEL_SETTINGS_DISCARD_CHANGES_BUTTON}            ${WIRELESS_2GHZ_HTML_ID}_cancel_bandwidth_channel_button

${WIRELESS_2GHZ_TX_POWER_SELECT}                                    ${WIRELESS_2GHZ_HTML_ID}_wireless_dbm_range

${WIRELESS_2GHZ_NOISE_FLOOR_CONTROL_SELECT}                         ${WIRELESS_2GHZ_HTML_ID}_wireless_noise_immunity
${WIRELESS_2GHZ_NOISE_FLOOR_CONTROL_SELECT_ACTIVATED_VALUE}         boolean:true
${WIRELESS_2GHZ_NOISE_FLOOR_CONTROL_SELECT_DEACTIVATED_VALUE}       boolean:false

*** Keywords ***
Skip This Test If Wireless 2GHz Is Not Supported By DUT
    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${FALSE}
        Skip    DUT does not support wireless 2.4GHz.
    END

Access Wireless 2GHz Interface Settings Page
    Open Wireless Menu
    Wait Until Element Is Visible    ${WIRELESS_2GHZ_SUBMENU}
    Click Element    ${WIRELESS_2GHZ_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
    Wait Until Element Is Visible    ${WIRELESS_2GHZ_OP_MODE_SELECT}

Set Wireless 2GHz Operation Mode Value To Access Point
    Select From List By Value
    ...    ${WIRELESS_2GHZ_OP_MODE_SELECT}
    ...    ${WIRELESS_2GHZ_OP_MODE_SELECT_AP_VALUE}

Set Wireless 2GHz Operation Mode Value To Repeater
    Select From List By Value
    ...    ${WIRELESS_2GHZ_OP_MODE_SELECT}
    ...    ${WIRELESS_2GHZ_OP_MODE_SELECT_REPEATER_VALUE}

Wireless 2GHz Operation Mode Should Be Access Point
    List Selection Should Be
    ...    ${WIRELESS_2GHZ_OP_MODE_SELECT}
    ...    ${WIRELESS_2GHZ_OP_MODE_SELECT_AP_VALUE}

Wireless 2GHz Operation Mode Should Be Repeater
    List Selection Should Be
    ...    ${WIRELESS_2GHZ_OP_MODE_SELECT}
    ...    ${WIRELESS_2GHZ_OP_MODE_SELECT_REPEATER_VALUE}

Select Wireless 2GHz SSIDs Isolation Checkbox
    Select Checkbox    ${WIRELESS_2GHZ_SSIDS_ISOLATION_CHECKBOX}

Unselect Wireless 2GHz SSIDs Isolation Checkbox
    Unselect Checkbox    ${WIRELESS_2GHZ_SSIDS_ISOLATION_CHECKBOX}

Wireless 2GHz SSIDs Isolation Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${WIRELESS_2GHZ_SSIDS_ISOLATION_CHECKBOX}

Set Wireless 2GHz IEEE Mode To 802.11b
    Select From List By Value
    ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT}
    ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT_B_VALUE}

Set Wireless 2GHz IEEE Mode To 802.11g
    Select From List By Value
    ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT}
    ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT_G_VALUE}

Set Wireless 2GHz IEEE Mode To 802.11b/g
    Select From List By Value
    ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT}
    ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT_BG_VALUE}

Set Wireless 2GHz IEEE Mode To 802.11b/g/n
    Select From List By Value
    ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT}
    ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT_BGN_VALUE}

Wireless 2GHz Country Select Should Be Enabled
    Element Should Be Enabled    ${WIRELESS_2GHZ_COUNTRY_SELECT}

Wireless 2GHz Country Select Should Be Disabled
    Element Should Be Disabled    ${WIRELESS_2GHZ_COUNTRY_SELECT}

Wireless 2GHz Country Should Be Brazil
    List Selection Should Be
    ...    ${WIRELESS_2GHZ_COUNTRY_SELECT}
    ...    ${WIRELESS_2GHZ_COUNTRY_SELECT_BRAZIL_VALUE}

Wireless 2GHz Channel And Bandwidth Text Input Should Be "${text}"
    ${curr_text}    Get Value    ${WIRELESS_2GHZ_CHANNEL_AND_BW_INPUT}
    Should Be Equal As Strings    ${curr_text}    ${text}

Set Wireless 2GHz TX Power To "${dbm}" dBm
    Select From List By Value
    ...    ${WIRELESS_2GHZ_TX_POWER_SELECT}
    ...    number:${dbm}

Wireless 2GHz TX Power Should Be "${tx_power}"
    ${curr_tx_power}    Get Value    ${WIRELESS_2GHZ_TX_POWER_SELECT}
    Should Be Equal As Strings    ${curr_tx_power}    number:${tx_power}

Wireless 2GHz Minimum TX Power Should Be "${tx_power}"
    ${options}    Get List Items    ${WIRELESS_2GHZ_TX_POWER_SELECT}
    ${options}    Evaluate    sorted(${options}, key=int)
    IF    '${options}[0]' == '${tx_power}'
        Return From Keyword
    ELSE
        Fail    Minimum TX power should be '${tx_power}' but was reported as '${options}[0]'.
    END

Wireless 2GHz Maximum TX Power Should Be "${tx_power}"
    ${options}    Get List Items    ${WIRELESS_2GHZ_TX_POWER_SELECT}
    ${options}    Evaluate    sorted(${options}, key=int, reverse=True)
    IF    '${options}[0]' == '${tx_power}'
        Return From Keyword
    ELSE
        Fail    Maximum TX power should be '${tx_power}' but was reported as '${options}[0]'.
    END

Open Wireless 2GHz Channel/Bandwidth Settings
    Click Button    ${WIRELESS_2GHZ_CHANNEL_AND_BW_BUTTON}
    Wait Until Element Is Visible    ${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT}

Select Wireless 2GHz Preferably 40MHz Bandwidth Checkbox
    Select Checkbox    ${WIRELESS_2GHZ_FORCE_40MHZ_BW_CHECKBOX}

Unselect Wireless 2GHz Preferably 40MHz Bandwidth Checkbox
    Unselect Checkbox    ${WIRELESS_2GHZ_FORCE_40MHZ_BW_CHECKBOX}

Set Wireless 2GHz Channel Bandwidth To 20MHz
    Select From List By Value
    ...    ${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT}
    ...    ${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT_20_VALUE}

Set Wireless 2GHz Channel Bandwidth To 20/40MHz
    Select From List By Value
    ...    ${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT}
    ...    ${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT_20_40_VALUE}

Set Wireless 2GHz Channel Extension To Automatic
    Select From List By Value
    ...    ${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT}
    ...    ${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT_AUTO_VALUE}

Set Wireless 2GHz Channel Extension To Above
    Select From List By Value
    ...    ${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT}
    ...    ${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT_ABOVE_VALUE}

Set Wireless 2GHz Channel Extension To Below
    Select From List By Value
    ...    ${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT}
    ...    ${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT_BELOW_VALUE}

Select All Wireless 2GHz Channels Checkbox
    Select Checkbox    ${WIRELESS_2GHZ_ALL_CHANNELS_CHECKBOX}

Unselect All Wireless 2GHz Channels Checkbox
    Unselect Checkbox    ${WIRELESS_2GHZ_ALL_CHANNELS_CHECKBOX}

Select Wireless 2GHz Channel "${channel_mhz}" Checkbox
    ${channels}    Get Webelements    ${WIRELESS_2GHZ_CHANNELS_CHECKBOX_CUSTOM_LOCATOR}
    FOR    ${channel}    IN    @{channels}
        ${curr_channel_mhz}    Get Element Attribute    ${channel}    ${WIRELESS_2GHZ_CHANNELS_CHECKBOX_MHZ_DATA_ATTR}
        IF    '${curr_channel_mhz}' == '${channel_mhz}'
            Select Checkbox    ${channel}
            Return From Keyword
        END
    END
    Fail    Channel frequency '${channel_mhz}' does not exist (or is not available for DUT).

Unselect Wireless 2GHz Channel "${channel_mhz}" Checkbox
    ${channels}    Get Webelements    ${WIRELESS_2GHZ_CHANNELS_CHECKBOX_CUSTOM_LOCATOR}
    FOR    ${channel}    IN    @{channels}
        ${curr_channel_mhz}    Get Element Attribute    ${channel}    ${WIRELESS_2GHZ_CHANNELS_CHECKBOX_MHZ_DATA_ATTR}
        IF    '${curr_channel_mhz}' == '${channel_mhz}'
            Unselect Checkbox    ${channel}
            Return From Keyword
        END
    END
    Fail    Channel frequency '${channel_mhz}' does not exist (or is not available for DUT).

Confirm Wireless 2GHz Channel Settings Changes
    Click Button    ${WIRELESS_2GHZ_CHANNEL_SETTINGS_CONFIRM_CHANGES_BUTTON}
    Wait Until Element Is Not Visible    ${WIRELESS_2GHZ_CHANNEL_SETTINGS_CONFIRM_CHANGES_BUTTON}
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END

Discard Wireless 2GHz Channel Settings Changes
    Click Button    ${WIRELESS_2GHZ_CHANNEL_SETTINGS_DISCARD_CHANGES_BUTTON}
    Wait Until Element Is Not Visible    ${WIRELESS_2GHZ_CHANNEL_SETTINGS_DISCARD_CHANGES_BUTTON}
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END

Every 2GHz Channel Checkbox Should Be Selected
    ${channel_cboxes}    Get Webelements    ${WIRELESS_2GHZ_CHANNELS_CHECKBOX_CUSTOM_LOCATOR}
    FOR    ${channel_cbox}    IN    @{channel_cboxes}
        Checkbox Should Be Selected    ${channel_cbox}
    END

Wireless 2GHz Interface Settings Should Be Factory Default
    IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_OP_MODE}' == 'access_point'
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_OP_MODE_SELECT}
        ...    ${WIRELESS_2GHZ_OP_MODE_SELECT_AP_VALUE}
    ELSE IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_OP_MODE}' == 'repeater'
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_OP_MODE_SELECT}
        ...    ${WIRELESS_2GHZ_OP_MODE_SELECT_REPEATER_VALUE}
    ELSE
        Fail    Could not determine DUT wireless 2.4GHz interface factory default operating mode (check DUT profile).
    END

    IF    ${WIRELESS_2GHZ_FACTORY_DEFAULT_SSIDS_ISOLATION_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${WIRELESS_2GHZ_SSIDS_ISOLATION_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${WIRELESS_2GHZ_SSIDS_ISOLATION_CHECKBOX}
    END

    IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_IEEE_MODE}' == 'b'
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT}
        ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT_B_VALUE}
    ELSE IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_IEEE_MODE}' == 'g'
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT}
        ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT_G_VALUE}
    ELSE IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_IEEE_MODE}' == 'b/g'
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT}
        ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT_B_G_VALUE}
    ELSE IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_IEEE_MODE}' == 'b/g/n'
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT}
        ...    ${WIRELESS_2GHZ_IEEE_MODE_SELECT_B_G_N_VALUE}
    ELSE
        Fail    Could not determine DUT wireless 2.4GHz interface factory default IEEE mode (check DUT profile).
    END

    IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_COUNTRY}' == 'brasil'
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_COUNTRY_SELECT}
        ...    ${WIRELESS_2GHZ_COUNTRY_SELECT_BRAZIL_VALUE}
    ELSE
        Fail    Could not determine DUT wireless 2.4GHz interface factory default country (check DUT profile).
    END

    Element Should Be Visible    ${WIRELESS_2GHZ_SITE_SURVEY_BUTTON}
    Element Should Be Enabled    ${WIRELESS_2GHZ_SITE_SURVEY_BUTTON}

    Open Wireless 2GHz Channel/Bandwidth Settings

    IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_BANDWIDTH}' == '20 MHz'
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT}
        ...    ${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT_20_VALUE}
    ELSE IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_BANDWIDTH}' == '20/40 MHz'
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT}
        ...    ${WIRELESS_2GHZ_CHANNEL_BANDWIDTH_SELECT_20_40_VALUE}
    ELSE
        Fail
        ...    Could not determine DUT wireless 2.4GHz interface factory default channel bandwidth (check DUT profile).
    END

    Checkbox Should Not Be Selected    ${WIRELESS_2GHZ_FORCE_40MHZ_BW_CHECKBOX}

    IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_CHANNEL}' == 'automatic'
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT}
        ...    ${WIRELESS_2GHZ_EXTENSION_CHANNEL_SELECT_AUTO_VALUE}
        Every 2GHz Channel Checkbox Should Be Selected
    ELSE
        Fail    Could not determine DUT wireless 2.4GHz interface factory default channel (check DUT profile).
    END

    Wireless 2GHz TX Power Should Be "${WIRELESS_2GHZ_FACTORY_DEFAULT_TX_POWER}"

    IF    ${WIRELESS_2GHZ_FACTORY_DEFAULT_NOISE_FLOOR_CONTROL_ENABLED} == ${TRUE}
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_NOISE_FLOOR_CONTROL_SELECT}
        ...    ${WIRELESS_2GHZ_NOISE_FLOOR_CONTROL_SELECT_ACTIVATED_VALUE}
    ELSE IF    ${WIRELESS_2GHZ_FACTORY_DEFAULT_NOISE_FLOOR_CONTROL_ENABLED} == ${FALSE}
        List Selection Should Be
        ...    ${WIRELESS_2GHZ_NOISE_FLOOR_CONTROL_SELECT}
        ...    ${WIRELESS_2GHZ_NOISE_FLOOR_CONTROL_SELECT_DEACTIVATED_VALUE}
    END

All Wireless 2GHz Channels TX Power Are In Accordance With Current Anatel Rules
    [Documentation]
    ...    This keyword validates that all wireless 2.4GHz channels
    ...    (2400MHz - 2484MHz) TX power are in accordance with current ANATEL
    ...    rules.
    ...
    ...    Maximum TX power (including EIRP) calculations are based in
    ...    https://intelbras.atlassian.net/browse/PZ-7653.
    ...
    ...    Anatel acts:
    ...    - Act 14448/17, section 10: http://www.ncc.org.br/img/Ato%2014448.pdf

    ${anatel_max_tx_power}    Set Variable    30

    ${2ghz_iface_antenna_gain}    Set Variable    ${DUT}[profile][wireless][2ghz][antenna_gain]

    ${2ghz_channels}    Get Webelements    //*[@data-tx-limit-dbm-channel-mhz]

    IF    ${DUT}[profile][wireless][is_outdoor] == ${TRUE}
        ${db_to_subtract}    Set Variable    0

        IF    ${2ghz_iface_antenna_gain} > 6
            ${db_to_subtract}    Evaluate    math.floor(${2ghz_iface_antenna_gain/3})
        END

        ${anatel_max_tx_power}    Evaluate    ${anatel_max_tx_power} - ${db_to_subtract}

        FOR    ${channel}    IN    @{2ghz_channels}
            ${displayed_tx_limit}    Get Text    ${channel}
            ${displayed_tx_limit}    Convert To Integer    ${displayed_tx_limit}
            ${channel_mhz}    Get Element Attribute    ${channel}    data-tx-limit-dbm-channel-mhz

            IF    ${displayed_tx_limit} > ${anatel_max_tx_power}
                ${error_msg}    Catenate
                ...    ANATEL: maximum TX power for ${channel_mhz}MHz is
                ...    ${anatel_max_tx_power}dBm (-1dB for every 3dBi of antenna gain)
                ...    but channel settings is allowing ${displayed_tx_limit}dBm.

                Fail    ${error_msg}
            END
        END
    ELSE IF    ${DUT}[profile][wireless][is_outdoor] == ${FALSE}
        ${anatel_max_eirp}    Set Variable    36

        FOR    ${channel}    IN    @{2ghz_channels}
            ${displayed_tx_limit}    Get Text    ${channel}
            ${displayed_tx_limit}    Convert To Integer    ${displayed_tx_limit}
            ${channel_mhz}    Get Element Attribute    ${channel}    data-tx-limit-dbm-channel-mhz

            IF    ${displayed_tx_limit} > ${anatel_max_tx_power}
                ${error_msg}    Catenate
                ...    ANATEL: maximum TX power for ${channel_mhz}Mhz is ${anatel_max_tx_power}dBm
                ...    but channel settings is allowing ${displayed_tx_limit}dBm.

                Fail    ${error_msg}
            END

            ${eirp}    Evaluate    ${2ghz_iface_antenna_gain} + ${displayed_tx_limit}

            IF    ${eirp} > ${anatel_max_eirp}
                ${error_msg}    Catenate
                ...    ANATEL: maximum EIRP for ${channel_mhz}MHz is ${anatel_max_eirp}dBm but channel settings is allowing
                ...    ${displayed_tx_limit} (TX power) + ${2ghz_iface_antenna_gain} (antenna gain) = ${eirp} dBm (EIRP).

                Fail    ${error_msg}
            END
        END
    END
