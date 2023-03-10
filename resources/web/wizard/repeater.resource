*** Settings ***
Documentation       Wizard (Repeater) Resource File
...                 
...                 This resource file contains keywords related to wizard
...                 (repeater) webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/wizard/common_initial_steps.resource

*** Variables ***
${WIRELESS_2GHZ_HTML_ID}                                        ${DUT}[profile][wireless][2ghz][interface_id]
${WIRELESS_5GHZ_HTML_ID}                                        ${DUT}[profile][wireless][5ghz][interface_id]

# Wireless Common Settings
${WIZ_REPEATER_WIRELESS_5GHZ_CLIENT_INTERFACE_BUTTON}           5_ghz_option
${WIZ_REPEATER_WIRELESS_2GHZ_CLIENT_INTERFACE_BUTTON}           2_4_ghz_option

# Wireless 2.4GHz Settings
${WIZ_REPEATER_2GHZ_SSID_INPUT}                                 ${WIRELESS_2GHZ_HTML_ID}_wireless_ssid_sta_ssid
${WIZ_REPEATER_2GHZ_SSID_SEARCH_BUTTON}                         ${WIRELESS_2GHZ_HTML_ID}_search_network_button
${WIZ_REPEATER_2GHZ_BSSID_INPUT}                                ${WIRELESS_2GHZ_HTML_ID}_wireless_ssid_sta_bssid
${WIZ_REPEATER_2GHZ_SSID_BROADCAST_DISABLE_CHECKBOX}            ${WIRELESS_2GHZ_HTML_ID}_ssid_broadcast

${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT}                           ${WIRELESS_2GHZ_HTML_ID}_ssid_security_crypto
${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT_OPEN_VALUE}                string:none
${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT_OPEN_LABEL}                Sistema Aberto

# Wireless 5GHz Settings
${WIZ_REPEATER_5GHZ_SSID_INPUT}                                 ${WIRELESS_5GHZ_HTML_ID}_wireless_ssid_sta_ssid
${WIZ_REPEATER_5GHZ_SSID_SEARCH_BUTTON}                         ${WIRELESS_5GHZ_HTML_ID}_search_network_button
${WIZ_REPEATER_5GHZ_BSSID_INPUT}                                ${WIRELESS_5GHZ_HTML_ID}_wireless_ssid_sta_bssid
${WIZ_REPEATER_5GHZ_SSID_BROADCAST_DISABLE_CHECKBOX}            ${WIRELESS_5GHZ_HTML_ID}_ssid_broadcast

${WIZ_REPEATER_5GHZ_SSID_AUTH_SELECT}                           ${WIRELESS_5GHZ_HTML_ID}_ssid_security_crypto
${WIZ_REPEATER_5GHZ_SSID_AUTH_SELECT_OPEN_VALUE}                string:none
${WIZ_REPEATER_5GHZ_SSID_AUTH_SELECT_OPEN_LABEL}                Sistema Aberto

# Wireless SSID Settings
${WIZ_REPEATER_SSID_NAME_DIV}                                   xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/div/div[1]
${WIZ_REPEATER_SSID_FREQ_DIV}                                   xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/div/div[2]

${WIZ_REPEATER_SSID_SETTINGS_BUTTON}                            xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/button[1]
${WIZ_REPEATER_SSID_REMOVE_BUTTON}                              xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/button[2]

${WIZ_REPEATER_ADD_NEW_SSID_BUTTON}                             xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[2]/div/button

${WIZ_REPEATER_SSID_SETTINGS_NAME_INPUT}                        ssid_name

${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT}                       ssid_band
${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT_DUAL_BAND_VALUE}       string:Dual band
${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT_DUAL_BAND_LABEL}       Dual band
${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT_2GHZ_VALUE}            string:2.4 GHz
${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT_2GHZ_LABEL}            2.4 GHz
${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT_5GHZ_VALUE}            string:5 GHz
${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT_5GHZ_LABEL}            5 GHz

${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT}                  ssid_auth
${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_VALUE}       string:none
${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_LABEL}       Sistema Aberto

${WIZ_REPEATER_SSID_SETTINGS_BROADCAST_CHECKBOX}                ssid_broadcast

${WIZ_REPEATER_SSID_SETTINGS_DISCARD_CHANGES_BUTTON}            ssid_discard_changes
${WIZ_REPEATER_SSID_SETTINGS_CONFIRM_CHANGES_BUTTON}            ssid_confirm_changes

# LAN Settings
${WIZ_REPEATER_LAN_IPV4_DHCP_CLIENT_ENABLE_CHECKBOX}            network_mode
${WIZ_REPEATER_LAN_IPV4_ADDRESS_INPUT}                          network_ip_address
${WIZ_REPEATER_LAN_IPV4_NETMASK_INPUT}                          network_netmask
${WIZ_REPEATER_LAN_IPV4_DEFAULT_GATEWAY_INPUT}                  network_gateway

${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT}                        modo_dns
${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT_MANUAL_VALUE}           boolean:false
${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT_MANUAL_LABEL}           Modo Manual
${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT_AUTO_VALUE}             boolean:true
${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT_AUTO_LABEL}             Modo Automático

${WIZ_REPEATER_LAN_IPV4_DNS_SERVER_1_INPUT}                     dns_ip_address_1

*** Keywords ***
Skip This Test If DUT Wireless Is Not Dual Band
    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${FALSE} or ${DUT}[profile][wireless][5ghz][is_supported] == ${FALSE}
        Skip    DUT wireless is not dual band.
    END

Skip This Test If DUT Wireless Is Dual Band
    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE} and ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        Skip    DUT wireless is not single band.
    END

Click Wireless 2.4GHz Interface Option
    Click Button    ${WIZ_REPEATER_WIRELESS_2GHZ_CLIENT_INTERFACE_BUTTON}

Click Wireless 5GHz Interface Option
    Click Button    ${WIZ_REPEATER_WIRELESS_5GHZ_CLIENT_INTERFACE_BUTTON}

Set Wireless Client (2.4GHz) SSID Name To "${ssid_name}"
    Input Text    ${WIZ_REPEATER_2GHZ_SSID_INPUT}    ${ssid_name}

Set Wireless Client (5GHz) SSID Name To "${ssid_name}"
    Input Text    ${WIZ_REPEATER_5GHZ_SSID_INPUT}    ${ssid_name}

Wizard (Single Band Repeater) Wireless 2.4GHz Client Interface Settings Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_2GHZ_SSID_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][repeater][wireless][client][factory_default][ssid][name]

    Element Should Be Visible    ${WIZ_REPEATER_2GHZ_SSID_SEARCH_BUTTON}
    Element Should Be Enabled    ${WIZ_REPEATER_2GHZ_SSID_SEARCH_BUTTON}

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_2GHZ_BSSID_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][repeater][wireless][client][factory_default][ssid][bssid]

    IF    ${DUT}[profile][wizard][repeater][wireless][client][factory_default][ssid][hide] == ${TRUE}
        Checkbox Should Be Selected    ${WIZ_REPEATER_2GHZ_SSID_BROADCAST_DISABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${WIZ_REPEATER_2GHZ_SSID_BROADCAST_DISABLE_CHECKBOX}
    END

    List Selection Should Be
    ...    ${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT}
    ...    ${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT_OPEN_VALUE}

    List Selection Should Be
    ...    ${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT}
    ...    ${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT_OPEN_LABEL}

Wizard (Dual Band Repeater) Wireless Client Interface Selection Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    IF    '${DUT}[profile][wizard][repeater][wireless][client][factory_default][interface]' == '5ghz'
        Element Should Have Class
        ...    ${WIZ_REPEATER_WIRELESS_5GHZ_CLIENT_INTERFACE_BUTTON}
        ...    btn-intelbras
    ELSE IF    '${DUT}[profile][wizard][repeater][wireless][client][factory_default][interface]' == '2.4ghz'
        Element Should Have Class
        ...    ${WIZ_REPEATER_WIRELESS_2GHZ_CLIENT_INTERFACE_BUTTON}
        ...    btn-intelbras
    ELSE
        Fail
        ...    Could not determine DUT wizard (repeater) factory default wireless client interface (check DUT profile).
    END

Wizard (Dual Band Repeater) Wireless 2.4GHz Client Interface Settings Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_2GHZ_SSID_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][repeater][wireless][client][factory_default][ssid][name]

    Element Should Be Visible    ${WIZ_REPEATER_2GHZ_SSID_SEARCH_BUTTON}
    Element Should Be Enabled    ${WIZ_REPEATER_2GHZ_SSID_SEARCH_BUTTON}

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_2GHZ_BSSID_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][repeater][wireless][client][factory_default][ssid][bssid]

    IF    ${DUT}[profile][wizard][repeater][wireless][client][factory_default][ssid][hide] == ${TRUE}
        Checkbox Should Be Selected    ${WIZ_REPEATER_2GHZ_SSID_BROADCAST_DISABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${WIZ_REPEATER_2GHZ_SSID_BROADCAST_DISABLE_CHECKBOX}
    END

    List Selection Should Be
    ...    ${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT}
    ...    ${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT_OPEN_VALUE}

    List Selection Should Be
    ...    ${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT}
    ...    ${WIZ_REPEATER_2GHZ_SSID_AUTH_SELECT_OPEN_LABEL}

Wizard (Dual Band Repeater) Wireless 5GHz Client Interface Settings Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_5GHZ_SSID_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][repeater][wireless][client][factory_default][ssid][name]

    Element Should Be Visible    ${WIZ_REPEATER_5GHZ_SSID_SEARCH_BUTTON}
    Element Should Be Enabled    ${WIZ_REPEATER_5GHZ_SSID_SEARCH_BUTTON}

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_5GHZ_BSSID_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][repeater][wireless][client][factory_default][ssid][bssid]

    IF    ${DUT}[profile][wizard][repeater][wireless][client][factory_default][ssid][hide] == ${TRUE}
        Checkbox Should Be Selected    ${WIZ_REPEATER_5GHZ_SSID_BROADCAST_DISABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${WIZ_REPEATER_5GHZ_SSID_BROADCAST_DISABLE_CHECKBOX}
    END

    List Selection Should Be
    ...    ${WIZ_REPEATER_5GHZ_SSID_AUTH_SELECT}
    ...    ${WIZ_REPEATER_5GHZ_SSID_AUTH_SELECT_OPEN_VALUE}

    List Selection Should Be
    ...    ${WIZ_REPEATER_5GHZ_SSID_AUTH_SELECT}
    ...    ${WIZ_REPEATER_5GHZ_SSID_AUTH_SELECT_OPEN_LABEL}

Wizard (Dual Band Repeater) Wireless 2.4GHz AP Interface Settings Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    Element Text Should Be
    ...    ${WIZ_REPEATER_SSID_NAME_DIV}
    ...    SSID: ${DUT}[env][wireless][2ghz][default_ssid][name]

    Element Text Should Be
    ...    ${WIZ_REPEATER_SSID_FREQ_DIV}
    ...    Frequência: 2.4 GHz

    Element Should Be Visible    ${WIZ_REPEATER_SSID_SETTINGS_BUTTON}
    Element Should Be Enabled    ${WIZ_REPEATER_SSID_SETTINGS_BUTTON}

    Element Should Be Visible    ${WIZ_REPEATER_SSID_REMOVE_BUTTON}
    Element Should Be Disabled    ${WIZ_REPEATER_SSID_REMOVE_BUTTON}

    Element Should Be Visible    ${WIZ_REPEATER_ADD_NEW_SSID_BUTTON}
    Element Should Be Enabled    ${WIZ_REPEATER_ADD_NEW_SSID_BUTTON}

    Click Element    ${WIZ_REPEATER_SSID_SETTINGS_BUTTON}

    Wait Until Element Is Visible    ${WIZ_REPEATER_SSID_SETTINGS_NAME_INPUT}

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_SSID_SETTINGS_NAME_INPUT}
    ...    value
    ...    ${DUT}[env][wireless][2ghz][default_ssid][name]

    Element Should Be Disabled    ${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT}

    List Selection Should Be
    ...    ${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT}
    ...    ${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT_2GHZ_VALUE}

    List Selection Should Be
    ...    ${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT}
    ...    ${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT_2GHZ_LABEL}

    List Selection Should Be
    ...    ${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT}
    ...    ${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_VALUE}

    List Selection Should Be
    ...    ${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT}
    ...    ${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_LABEL}

    IF    ${DUT}[profile][wireless][ssid][factory_default][broadcast_off] == ${TRUE}
        Checkbox Should Be Selected    ${WIZ_REPEATER_SSID_SETTINGS_BROADCAST_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${WIZ_REPEATER_SSID_SETTINGS_BROADCAST_CHECKBOX}
    END

    Click Button    ${WIZ_REPEATER_SSID_SETTINGS_DISCARD_CHANGES_BUTTON}

Wizard (Dual Band Repeater) Wireless 5GHz AP Interface Settings Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    Element Text Should Be
    ...    ${WIZ_REPEATER_SSID_NAME_DIV}
    ...    SSID: ${DUT}[env][wireless][5ghz][default_ssid][name]

    Element Text Should Be
    ...    ${WIZ_REPEATER_SSID_FREQ_DIV}
    ...    Frequência: 5 GHz

    Element Should Be Visible    ${WIZ_REPEATER_SSID_SETTINGS_BUTTON}
    Element Should Be Enabled    ${WIZ_REPEATER_SSID_SETTINGS_BUTTON}

    Element Should Be Visible    ${WIZ_REPEATER_SSID_REMOVE_BUTTON}
    Element Should Be Disabled    ${WIZ_REPEATER_SSID_REMOVE_BUTTON}

    Element Should Be Visible    ${WIZ_REPEATER_ADD_NEW_SSID_BUTTON}
    Element Should Be Enabled    ${WIZ_REPEATER_ADD_NEW_SSID_BUTTON}

    Click Element    ${WIZ_REPEATER_SSID_SETTINGS_BUTTON}

    Wait Until Element Is Visible    ${WIZ_REPEATER_SSID_SETTINGS_NAME_INPUT}

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_SSID_SETTINGS_NAME_INPUT}
    ...    value
    ...    ${DUT}[env][wireless][5ghz][default_ssid][name]

    Element Should Be Disabled    ${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT}

    List Selection Should Be
    ...    ${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT}
    ...    ${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT_5GHZ_VALUE}

    List Selection Should Be
    ...    ${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT}
    ...    ${WIZ_REPEATER_SSID_SETTINGS_FREQ_SELECT_5GHZ_LABEL}

    List Selection Should Be
    ...    ${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT}
    ...    ${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_VALUE}

    List Selection Should Be
    ...    ${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT}
    ...    ${WIZ_REPEATER_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_LABEL}

    IF    ${DUT}[profile][wireless][ssid][factory_default][broadcast_off] == ${TRUE}
        Checkbox Should Be Selected    ${WIZ_REPEATER_SSID_SETTINGS_BROADCAST_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${WIZ_REPEATER_SSID_SETTINGS_BROADCAST_CHECKBOX}
    END

    Click Button    ${WIZ_REPEATER_SSID_SETTINGS_DISCARD_CHANGES_BUTTON}

Wizard (Repeater) LAN Settings Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    IF    ${DUT}[profile][wizard][repeater][lan][factory_default][ipv4][dhcp_client_enabled] == ${TRUE}
        Checkbox Should Be Selected    ${WIZ_REPEATER_LAN_IPV4_DHCP_CLIENT_ENABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${WIZ_REPEATER_LAN_IPV4_DHCP_CLIENT_ENABLE_CHECKBOX}
    END

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_LAN_IPV4_ADDRESS_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][repeater][lan][factory_default][ipv4][address]

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_LAN_IPV4_NETMASK_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][repeater][lan][factory_default][ipv4][netmask]

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_LAN_IPV4_DEFAULT_GATEWAY_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][repeater][lan][factory_default][ipv4][default_gateway]

    IF    '${DUT}[profile][wizard][repeater][lan][factory_default][ipv4][dns_mode]' == 'manual'
        List Selection Should Be
        ...    ${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT_MANUAL_VALUE}

        List Selection Should Be
        ...    ${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT_MANUAL_LABEL}

        Element Should Be Enabled    ${WIZ_REPEATER_LAN_IPV4_DNS_SERVER_1_INPUT}
    ELSE IF    '${DUT}[profile][wizard][repeater][lan][factory_default][ipv4][dns_mode]' == 'automatic'
        List Selection Should Be
        ...    ${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT_AUTO_VALUE}

        List Selection Should Be
        ...    ${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_REPEATER_LAN_IPV4_DNS_MODE_SELECT_AUTO_LABEL}

        Element Should Be Disabled    ${WIZ_REPEATER_LAN_IPV4_DNS_SERVER_1_INPUT}
    ELSE
        Fail    Could not determine DUT wizard (repeater preset) factory default DNS mode (check DUT profile).
    END

    Element Attribute Value Should Be
    ...    ${WIZ_REPEATER_LAN_IPV4_DNS_SERVER_1_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][repeater][lan][factory_default][ipv4][dns_server_1]

Wizard (Repeater) Confirmation Step Should Be Correct
    Wait Until Element Is Visible    ${WIZ_LAST_STEP_CONFIRMATION_BUTTON}

    Page Should Contain
    ...    Finalizar

    Page Should Contain
    ...    Todas as configurações foram salvas com sucesso.

    Page Should Contain
    ...    Clique em Finalizar para concluir o processo ou Voltar se ainda deseja alterar alguma informação.

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    Element Should Be Enabled    ${WIZ_LAST_STEP_CONFIRMATION_BUTTON}
