*** Settings ***
Documentation       QoS Resource File
...                 
...                 This resource file contains keywords related to QoS webpage
...                 manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource

*** Variables ***
${QOS_FACTORY_DEFAULT}                                                  ${DUT}[profile][qos][factory_default]
${QOS_FACTORY_DEFAULT_ENABLED}                                          ${QOS_FACTORY_DEFAULT}[enabled]
${QOS_FACTORY_DEFAULT_INTERNET_LINK_UPLOAD}                             ${QOS_FACTORY_DEFAULT}[internet_link][upload_mbps]
${QOS_FACTORY_DEFAULT_INTERNET_LINK_DOWNLOAD}                           ${QOS_FACTORY_DEFAULT}[internet_link][download_mbps]
${QOS_FACTORY_DEFAULT_TYPE}                                             ${QOS_FACTORY_DEFAULT}[type]
${QOS_FACTORY_DEFAULT_SSID_BAND_LIMIT_ENABLED}                          ${QOS_FACTORY_DEFAULT}[ssid_band_limit][enabled]
${QOS_FACTORY_DEFAULT_SSID_BAND_GUARANTEE_ENABLED}                      ${QOS_FACTORY_DEFAULT}[ssid_band_guarantee][enabled]

${QOS_MENU}                                                             .qos

${QOS_ENABLE_CHECKBOX}                                                  qosEnabled
${QOS_INTERNET_LINK_UPLOAD_INPUT}                                       upload_ssid
${QOS_INTERNET_LINK_DOWNLOAD_INPUT}                                     download_ssid

${QOS_TYPE_SELECT}                                                      type
${QOS_TYPE_SELECT_SSID_VALUE}                                           string:byssid
${QOS_TYPE_SELECT_IP_MAC_VALUE}                                         string:bwlimit

${QOS_SSID_BAND_LIMIT_TABLE}                                            band_limit_table
${QOS_SSID_BAND_LIMIT_FIRST_SSID_ENABLE_CHECKBOX}                       xpath://*[@id="band_limit_table"]/tbody/tr/td[1]/div/label/input
${QOS_SSID_BAND_LIMIT_FIRST_SSID_NAME_TEXT}                             xpath://*[@id="band_limit_table"]/tbody/tr/td[2]/div
${QOS_SSID_BAND_LIMIT_FIRST_SSID_FREQUENCY_TEXT}                        xpath://*[@id="band_limit_table"]/tbody/tr/td[3]
${QOS_SSID_BAND_LIMIT_FIRST_SSID_UPLOAD_INPUT}                          xpath://*[@id="band_limit_table"]/tbody/tr/td[4]/input
${QOS_SSID_BAND_LIMIT_FIRST_SSID_DOWNLOAD_INPUT}                        xpath://*[@id="band_limit_table"]/tbody/tr/td[5]/input

${QOS_SSID_BAND_GUARANTEE_ENABLED}                                      enable_guarantee_band
${QOS_SSID_BAND_GUARANTEE_TABLE}                                        band_guarantee_table
${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SSID_NAME_TEXT}                    xpath://*[@id="band_guarantee_table"]/tbody/tr/td[1]/div
${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SSID_FREQUENCY_TEXT}               xpath://*[@id="band_guarantee_table"]/tbody/tr/td[2]
${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SINGLE_BAND_UPLOAD_INPUT}          band_guarantee_upload_cell
${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SINGLE_BAND_DOWNLOAD_INPUT}        band_guarantee_download_cell
${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_2GHZ_UPLOAD_INPUT}       band_guarantee_upload_cell_B
${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_2GHZ_DOWNLOAD_INPUT}     band_guarantee_download_cell_B
${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_5GHZ_UPLOAD_INPUT}       band_guarantee_upload_cell_A
${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_5GHZ_DOWNLOAD_INPUT}     band_guarantee_download_cell_A

*** Keywords ***
Access QoS Service Settings Page
    Wait Until Element Is Visible    ${QOS_MENU}
    Click Element    ${QOS_MENU}
    Wait For WEB Message To Disappear
    Wait Until Element Is Visible    ${QOS_ENABLE_CHECKBOX}

Get Current QoS Global Download Limit
    ${value}    Get Value    ${QOS_INTERNET_LINK_DOWNLOAD_INPUT}
    [Return]    ${value}

Get Current QoS Global Upload Limit
    ${value}    Get Value    ${QOS_INTERNET_LINK_UPLOAD_INPUT}
    [Return]    ${value}

Select QoS Enable Checkbox
    Select Checkbox    ${QOS_ENABLE_CHECKBOX}

Unselect QoS Enable Checkbox
    Unselect Checkbox    ${QOS_ENABLE_CHECKBOX}

Set QoS Global Upload Limit To "${value}" Mbps
    Input Text
    ...    ${QOS_INTERNET_LINK_UPLOAD_INPUT}
    ...    ${value}

Set QoS Global Download Limit To "${value}" Mbps
    Input Text
    ...    ${QOS_INTERNET_LINK_DOWNLOAD_INPUT}
    ...    ${value}

Select QoS By SSID
    Select From List By Value
    ...    ${QOS_TYPE_SELECT}
    ...    ${QOS_TYPE_SELECT_SSID_VALUE}

Select QoS By IP And MAC Address
    Select From List By Value
    ...    ${QOS_TYPE_SELECT}
    ...    ${QOS_TYPE_SELECT_IP_MAC_VALUE}

QoS Internet Link Settings Should Be Factory Default
    Element Should Be Visible    ${QOS_INTERNET_LINK_UPLOAD_INPUT}
    Element Should Be Visible    ${QOS_INTERNET_LINK_DOWNLOAD_INPUT}

    IF    ${QOS_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Element Should Be Enabled    ${QOS_INTERNET_LINK_UPLOAD_INPUT}
        Element Should Be Enabled    ${QOS_INTERNET_LINK_DOWNLOAD_INPUT}
    ELSE
        Element Should Be Disabled    ${QOS_INTERNET_LINK_UPLOAD_INPUT}
        Element Should Be Disabled    ${QOS_INTERNET_LINK_DOWNLOAD_INPUT}
    END

    Element Attribute Value Should Be
    ...    ${QOS_INTERNET_LINK_UPLOAD_INPUT}
    ...    value    ${QOS_FACTORY_DEFAULT_INTERNET_LINK_UPLOAD}

    Element Attribute Value Should Be
    ...    ${QOS_INTERNET_LINK_DOWNLOAD_INPUT}
    ...    value    ${QOS_FACTORY_DEFAULT_INTERNET_LINK_DOWNLOAD}

Qos Type Should Be Factory Default
    Element Should Be Visible    ${QOS_TYPE_SELECT}

    IF    ${QOS_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Element Should Be Enabled    ${QOS_TYPE_SELECT}
    ELSE
        Element Should Be Disabled    ${QOS_TYPE_SELECT}
    END

    IF    '${QOS_FACTORY_DEFAULT_TYPE}' == 'limit_and_guarantee_per_ssid'
        Element Attribute Value Should Be
        ...    ${QOS_TYPE_SELECT}
        ...    value    ${QOS_TYPE_SELECT_SSID_VALUE}
    ELSE
        Element Attribute Value Should Be
        ...    ${QOS_TYPE_SELECT}
        ...    value    ${QOS_TYPE_SELECT_IP_MAC_VALUE}
    END

QoS SSID Band Limit Settings Should Be Factory Default
    Element Should Be Visible    ${QOS_SSID_BAND_LIMIT_TABLE}

    IF    ${QOS_FACTORY_DEFAULT_SSID_BAND_LIMIT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${QOS_SSID_BAND_LIMIT_FIRST_SSID_ENABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${QOS_SSID_BAND_LIMIT_FIRST_SSID_ENABLE_CHECKBOX}
    END

    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        Element Text Should Be
        ...    ${QOS_SSID_BAND_LIMIT_FIRST_SSID_NAME_TEXT}
        ...    ${DUT}[env][wireless][2ghz][default_ssid][name]
    ELSE
        Element Text Should Be
        ...    ${QOS_SSID_BAND_LIMIT_FIRST_SSID_NAME_TEXT}
        ...    ${DUT}[env][wireless][5ghz][default_ssid][name]
    END

    IF    '${DUT}[profile][wireless][ssid][factory_default][band]' == 'dual_band'
        Element Text Should Be
        ...    ${QOS_SSID_BAND_LIMIT_FIRST_SSID_FREQUENCY_TEXT}
        ...    Dual band
    ELSE IF    '${DUT}[profile][wireless][ssid][factory_default][band]' == '2.4ghz'
        Element Text Should Be
        ...    ${QOS_SSID_BAND_LIMIT_FIRST_SSID_FREQUENCY_TEXT}
        ...    2.4 GHz
    ELSE IF    '${DUT}[profile][wireless][ssid][factory_default][band]' == '5ghz'
        Element Text Should Be
        ...    ${QOS_SSID_BAND_LIMIT_FIRST_SSID_FREQUENCY_TEXT}
        ...    5 GHz
    END

    Element Attribute Value Should Be
    ...    ${QOS_SSID_BAND_LIMIT_FIRST_SSID_UPLOAD_INPUT}
    ...    value    ${QOS_FACTORY_DEFAULT_INTERNET_LINK_UPLOAD}

    Element Attribute Value Should Be
    ...    ${QOS_SSID_BAND_LIMIT_FIRST_SSID_DOWNLOAD_INPUT}
    ...    value    ${QOS_FACTORY_DEFAULT_INTERNET_LINK_DOWNLOAD}

QoS SSID Band Guarantee Settings Should Be Factory Default
    IF    ${QOS_FACTORY_DEFAULT_SSID_BAND_GUARANTEE_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${QOS_SSID_BAND_GUARANTEE_ENABLED}
    ELSE
        Checkbox Should Not Be Selected    ${QOS_SSID_BAND_GUARANTEE_ENABLED}
    END

    Element Should Be Visible    ${QOS_SSID_BAND_GUARANTEE_TABLE}

    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        Element Text Should Be
        ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SSID_NAME_TEXT}
        ...    ${DUT}[env][wireless][2ghz][default_ssid][name]
    ELSE
        Element Text Should Be
        ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SSID_NAME_TEXT}
        ...    ${DUT}[env][wireless][5ghz][default_ssid][name]
    END

    IF    '${DUT}[profile][wireless][ssid][factory_default][band]' == 'dual_band'
        Element Text Should Be
        ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SSID_FREQUENCY_TEXT}
        ...    Dual band

        Element Should Be Visible    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_5GHZ_UPLOAD_INPUT}
        Element Should Be Visible    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_2GHZ_UPLOAD_INPUT}

        Element Should Be Visible    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_5GHZ_DOWNLOAD_INPUT}
        Element Should Be Visible    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_2GHZ_DOWNLOAD_INPUT}

        Element Attribute Value Should Be
        ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_5GHZ_UPLOAD_INPUT}
        ...    value    ${EMPTY}

        Element Attribute Value Should Be
        ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_2GHZ_UPLOAD_INPUT}
        ...    value    ${EMPTY}

        Element Attribute Value Should Be
        ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_5GHZ_DOWNLOAD_INPUT}
        ...    value    ${EMPTY}

        Element Attribute Value Should Be
        ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_DUAL_BAND_2GHZ_DOWNLOAD_INPUT}
        ...    value    ${EMPTY}
    ELSE
        IF    '${DUT}[profile][wireless][ssid][factory_default][band]' == '2.4ghz'
            Element Text Should Be
            ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SSID_FREQUENCY_TEXT}
            ...    2.4 GHz
        ELSE IF    '${DUT}[profile][wireless][ssid][factory_default][band]' == '5ghz'
            Element Text Should Be
            ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SSID_FREQUENCY_TEXT}
            ...    5 GHz
        END
        Element Should Be Visible    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SINGLE_BAND_DOWNLOAD_INPUT}
        Element Should Be Visible    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SINGLE_BAND_UPLOAD_INPUT}

        Element Attribute Value Should Be
        ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SINGLE_BAND_UPLOAD_INPUT}
        ...    value    ${EMPTY}

        Element Attribute Value Should Be
        ...    ${QOS_SSID_BAND_GUARANTEE_FIRST_SSID_SINGLE_BAND_DOWNLOAD_INPUT}
        ...    value    ${EMPTY}
    END

QoS Settings Should Be Factory Default
    IF    ${QOS_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${QOS_ENABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${QOS_ENABLE_CHECKBOX}
    END

    QoS Internet Link Settings Should Be Factory Default
    Qos Type Should Be Factory Default

    IF    '${QOS_FACTORY_DEFAULT_TYPE}' == 'limit_and_guarantee_per_ssid'
        QoS SSID Band Limit Settings Should Be Factory Default
        QoS SSID Band Guarantee Settings Should Be Factory Default
    END
