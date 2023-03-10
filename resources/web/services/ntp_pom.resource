*** Settings ***
Documentation     NTP Resource File
...
...               This resource file contains keywords related
...               to NTP WEB page manipulation (page object model).
Library           SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource          web/common.resource

*** Variables ***
${NTP_CLIENT_FACTORY_DEFAULT}                           ${DUT}[profile][features][ntp_client][factory_default]
${NTP_CLIENT_FACTORY_DEFAULT_ENABLED}                   ${NTP_CLIENT_FACTORY_DEFAULT}[enabled]
${NTP_CLIENT_FACTORY_DEFAULT_SERVER_1}                  ${NTP_CLIENT_FACTORY_DEFAULT}[server_1]
${NTP_CLIENT_FACTORY_DEFAULT_SERVER_2}                  ${NTP_CLIENT_FACTORY_DEFAULT}[server_2]
${NTP_CLIENT_FACTORY_DEFAULT_TIMEZONE}                  ${NTP_CLIENT_FACTORY_DEFAULT}[timezone]
${NTP_CLIENT_FACTORY_DEFAULT_DAYLIGHT_SAVING_TIME}      ${NTP_CLIENT_FACTORY_DEFAULT}[daylight_saving_time]
${NTP_SUBMENU}                                          ntp_submenu
${NTP_ENABLE_CHECKBOX}                                  ntp_ntp
${NTP_SERVER_1_INPUT}                                   ntp_ip_address_1
${NTP_SERVER_2_INPUT}                                   ntp_ip_address_2
${NTP_ZONE_SELECT}                                      ntp_zone
${NTP_ZONE_SELECT_BOGOTA_VALUE}                         string:America/Bogota
${NTP_ZONE_SELECT_MANAUS_VALUE}                         string:America/Manaus
${NTP_ZONE_SELECT_SAO_PAULO_VALUE}                      string:America/Sao_Paulo
${NTP_ZONE_SELECT_NORONHA_VALUE}                        string:America/Noronha
${NTP_DAYLIGHT_SAVING_TIME_CHECKBOX}                    daylight_saving_time

*** Keywords ***
Skip This Test If NTP Client Feature Is Not Supported By DUT
    IF    ${DUT}[profile][features][ntp_client][is_supported] == ${False}
        Open Services Menu
        Element Should Not Be Visible    ${NTP_SUBMENU}
        Skip    DUT does not support NTP client.
    END

Access NTP Service Settings Page
    Open Services Menu
    Wait Until Element Is Visible    ${NTP_SUBMENU}
    Click Element    ${NTP_SUBMENU}
    Wait For WEB Message To Disappear
    Wait Until Element Is Visible    ${NTP_ENABLE_CHECKBOX}

Select NTP Enable Checkbox
    Select Checkbox    ${NTP_ENABLE_CHECKBOX}

Unselect NTP Enable Checkbox
    Unselect Checkbox    ${NTP_ENABLE_CHECKBOX}

NTP Enable Checkbox Should Be Selected
    Checkbox Should Be Selected    ${NTP_ENABLE_CHECKBOX}

NTP Enable Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${NTP_ENABLE_CHECKBOX}

Get NTP Enable Checkbox Status
    ${status}    Get Element Attribute    ${NTP_ENABLE_CHECKBOX}    checked
    IF    """${status}""" == """true"""
        Return From Keyword    ${True}
    END
    Return From Keyword    ${False}

Set NTP Server 1 To "${value}"
    Input Text    ${NTP_SERVER_1_INPUT}    ${value}

Get Current Server 1 Value
    ${value}    Get Value    ${NTP_SERVER_1_INPUT}
    [Return]    ${value}

NTP Server 1 Should Be Disabled
    Element Should Be Disabled    ${NTP_SERVER_1_INPUT}

NTP Server 1 Should Be Enabled
    Element Should Be Enabled    ${NTP_SERVER_1_INPUT}

Set NTP Server 2 To "${value}"
    Input Text    ${NTP_SERVER_2_INPUT}    ${value}

Get Current Server 2 Value
    ${value}    Get Value    ${NTP_SERVER_2_INPUT}
    [Return]    ${value}

NTP Server 2 Should Be Disabled
    Element Should Be Disabled    ${NTP_SERVER_2_INPUT}

NTP Server 2 Should Be Enabled
    Element Should Be Enabled    ${NTP_SERVER_2_INPUT}

Get Current Zone Value
    ${value}    Get Value    ${NTP_ZONE_SELECT}
    [Return]    ${value}

Set NTP Zone To Bogota
    Select From List By Value    ${NTP_ZONE_SELECT}    ${NTP_ZONE_SELECT_BOGOTA_VALUE}

Set NTP Zone To Manaus
    Select From List By Value    ${NTP_ZONE_SELECT}    ${NTP_ZONE_SELECT_MANAUS_VALUE}

Set NTP Zone To Sao Paulo
    Select From List By Value    ${NTP_ZONE_SELECT}    ${NTP_ZONE_SELECT_SAO_PAULO_VALUE}

Set NTP Zone To Noronha
    Select From List By Value    ${NTP_ZONE_SELECT}    ${NTP_ZONE_SELECT_NORONHA_VALUE}

NTP Zone Select Should Be Disabled
    Element Should Be Disabled    ${NTP_ZONE_SELECT}

NTP Zone Select Should Be Enabled
    Element Should Be Enabled    ${NTP_ZONE_SELECT}

Select NTP Daylight Saving Time Checkbox
    Select Checkbox    ${NTP_DAYLIGHT_SAVING_TIME_CHECKBOX}

Unselect NTP Daylight Saving Time Checkbox
    Unselect Checkbox    ${NTP_DAYLIGHT_SAVING_TIME_CHECKBOX}

NTP Daylight Saving Time Checkbox Should Be Selected
    Checkbox Should Be Selected    ${NTP_DAYLIGHT_SAVING_TIME_CHECKBOX}

NTP Daylight Saving Time Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${NTP_DAYLIGHT_SAVING_TIME_CHECKBOX}

NTP Daylight Saving Time Checkbox Should Be Disabled
    Element Should Be Disabled    ${NTP_DAYLIGHT_SAVING_TIME_CHECKBOX}

NTP Daylight Saving Time Checkbox Should Be Enabled
    Element Should Be Enabled    ${NTP_DAYLIGHT_SAVING_TIME_CHECKBOX}

NTP Client Server 1 Should Be "${value}"
    Element Attribute Value Should Be    ${NTP_SERVER_1_INPUT}    value    ${value}

NTP Client Server 2 Should Be "${value}"
    Element Attribute Value Should Be    ${NTP_SERVER_2_INPUT}    value    ${value}

NTP Client Timezone Should Be "${value}"
    List Selection Should Be    ${NTP_ZONE_SELECT}    ${value}
