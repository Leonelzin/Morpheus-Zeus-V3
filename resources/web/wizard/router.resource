*** Settings ***
Documentation       Wizard (Router) Resource File
...                 
...                 This resource file contains keywords related to wizard
...                 (router) webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/wizard/common_initial_steps.resource

*** Variables ***
# Wireless Settings
${WIZ_ROUTER_SSID_NAME_DIV}                                 xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/div/div[1]
${WIZ_ROUTER_SSID_FREQ_DIV}                                 xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/div/div[2]

${WIZ_ROUTER_SSID_SETTINGS_BUTTON}                          xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/button[1]
${WIZ_ROUTER_SSID_REMOVE_BUTTON}                            xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/button[2]

${WIZ_ROUTER_ADD_NEW_SSID_BUTTON}                           xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[2]/div/button

${WIZ_ROUTER_SSID_SETTINGS_NAME_INPUT}                      ssid_name

${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT}                     ssid_band
${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_DUAL_BAND_VALUE}     string:Dual band
${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_DUAL_BAND_LABEL}     Dual band
${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_2GHZ_VALUE}          string:2.4 GHz
${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_2GHZ_LABEL}          2.4 GHz
${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_5GHZ_VALUE}          string:5 GHz
${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_5GHZ_LABEL}          5 GHz

${WIZ_ROUTER_SSID_SETTINGS_AUTH_TYPE_SELECT}                ssid_auth
${WIZ_ROUTER_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_VALUE}     string:none
${WIZ_ROUTER_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_LABEL}     Sistema Aberto

${WIZ_ROUTER_SSID_SETTINGS_BROADCAST_CHECKBOX}              ssid_broadcast

${WIZ_ROUTER_SSID_SETTINGS_DISCARD_CHANGES_BUTTON}          ssid_discard_changes
${WIZ_ROUTER_SSID_SETTINGS_CONFIRM_CHANGES_BUTTON}          ssid_confirm_changes

# LAN Settings
${WIZ_ROUTER_LAN_IPV4_ADDRESS_INPUT}                        network_ip_address
${WIZ_ROUTER_LAN_IPV4_NETMASK_INPUT}                        network_netmask

${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT}                      modo_dns
${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT_MANUAL_VALUE}         boolean:false
${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT_MANUAL_LABEL}         Modo Manual
${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT_AUTO_VALUE}           boolean:true
${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT_AUTO_LABEL}           Modo Automático

${WIZ_ROUTER_LAN_IPV4_DNS_SERVER_1_INPUT}                   dns_ip_address_1

*** Keywords ***
Wizard (Router) Wireless Settings Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        Element Text Should Be    ${WIZ_ROUTER_SSID_NAME_DIV}    SSID: ${DUT}[env][wireless][2ghz][default_ssid][name]
    ELSE IF    ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        Element Text Should Be    ${WIZ_ROUTER_SSID_NAME_DIV}    SSID: ${DUT}[env][wireless][5ghz][default_ssid][name]
    END

    IF    '${DUT}[profile][wizard][router][wireless][factory_default][ssid][band]' == 'dual_band'
        Element Text Should Be    ${WIZ_ROUTER_SSID_FREQ_DIV}    Frequência: Dual band
    ELSE IF    '${DUT}[profile][wizard][router][wireless][factory_default][ssid][band]' == '2.4ghz'
        Element Text Should Be    ${WIZ_ROUTER_SSID_FREQ_DIV}    Frequência: 2.4 GHz
    ELSE IF    '${DUT}[profile][wizard][router][wireless][factory_default][ssid][band]' == '5ghz'
        Element Text Should Be    ${WIZ_ROUTER_SSID_FREQ_DIV}    Frequência: 5 GHz
    ELSE
        Fail    Could not determine DUT wizard factory default SSID band (check DUT profile).
    END

    Element Should Be Visible    ${WIZ_ROUTER_SSID_SETTINGS_BUTTON}
    Element Should Be Enabled    ${WIZ_ROUTER_SSID_SETTINGS_BUTTON}

    Element Should Be Visible    ${WIZ_ROUTER_SSID_REMOVE_BUTTON}
    Element Should Be Disabled    ${WIZ_ROUTER_SSID_REMOVE_BUTTON}

    Element Should Be Visible    ${WIZ_ROUTER_ADD_NEW_SSID_BUTTON}
    Element Should Be Enabled    ${WIZ_ROUTER_ADD_NEW_SSID_BUTTON}

    Click Element    ${WIZ_ROUTER_SSID_SETTINGS_BUTTON}

    Wait Until Element Is Visible    ${WIZ_ROUTER_SSID_SETTINGS_NAME_INPUT}

    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be
        ...    ${WIZ_ROUTER_SSID_SETTINGS_NAME_INPUT}
        ...    value
        ...    ${DUT}[env][wireless][2ghz][default_ssid][name]
    ELSE IF    ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be
        ...    ${WIZ_ROUTER_SSID_SETTINGS_NAME_INPUT}
        ...    value
        ...    ${DUT}[env][wireless][5ghz][default_ssid][name]
    END

    IF    '${DUT}[profile][wizard][router][wireless][factory_default][ssid][band]' == 'dual_band'
        List Selection Should Be
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_DUAL_BAND_VALUE}
        List Selection Should Be
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_DUAL_BAND_LABEL}
    ELSE IF    '${DUT}[profile][wizard][router][wireless][factory_default][ssid][band]' == '2.4ghz'
        List Selection Should Be
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_2GHZ_VALUE}
        List Selection Should Be
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_2GHZ_LABEL}
    ELSE IF    '${DUT}[profile][wizard][router][wireless][factory_default][ssid][band]' == '5ghz'
        List Selection Should Be
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_5GHZ_VALUE}
        List Selection Should Be
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_ROUTER_SSID_SETTINGS_FREQ_SELECT_5GHZ_LABEL}
    ELSE
        Fail    Could not determine DUT factory default SSID band (check DUT profile).
    END

    List Selection Should Be
    ...    ${WIZ_ROUTER_SSID_SETTINGS_AUTH_TYPE_SELECT}
    ...    ${WIZ_ROUTER_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_VALUE}

    List Selection Should Be
    ...    ${WIZ_ROUTER_SSID_SETTINGS_AUTH_TYPE_SELECT}
    ...    ${WIZ_ROUTER_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_LABEL}

    IF    ${DUT}[profile][wireless][ssid][factory_default][broadcast_off] == ${TRUE}
        Checkbox Should Be Selected    ${WIZ_ROUTER_SSID_SETTINGS_BROADCAST_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${WIZ_ROUTER_SSID_SETTINGS_BROADCAST_CHECKBOX}
    END

    Click Button    ${WIZ_ROUTER_SSID_SETTINGS_DISCARD_CHANGES_BUTTON}

Wizard (Router) LAN Settings Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    Element Attribute Value Should Be
    ...    ${WIZ_ROUTER_LAN_IPV4_ADDRESS_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][router][lan][factory_default][ipv4][address]

    Element Attribute Value Should Be
    ...    ${WIZ_ROUTER_LAN_IPV4_NETMASK_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][router][lan][factory_default][ipv4][netmask]

    IF    '${DUT}[profile][wizard][router][lan][factory_default][ipv4][dns_mode]' == 'manual'
        List Selection Should Be
        ...    ${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT_MANUAL_VALUE}

        List Selection Should Be
        ...    ${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT_MANUAL_LABEL}

        Element Should Be Enabled    ${WIZ_ROUTER_LAN_IPV4_DNS_SERVER_1_INPUT}
    ELSE IF    '${DUT}[profile][wizard][router][lan][factory_default][ipv4][dns_mode]' == 'automatic'
        List Selection Should Be
        ...    ${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT_AUTO_VALUE}

        List Selection Should Be
        ...    ${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_ROUTER_LAN_IPV4_DNS_MODE_SELECT_AUTO_LABEL}

        Element Should Be Disabled    ${WIZ_ROUTER_LAN_IPV4_DNS_SERVER_1_INPUT}
    ELSE
        Fail    Could not determine DUT wizard (router preset) factory default DNS mode (check DUT profile).
    END

    Element Attribute Value Should Be
    ...    ${WIZ_ROUTER_LAN_IPV4_DNS_SERVER_1_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][router][lan][factory_default][ipv4][dns_server_1]

Wizard (Router) Confirmation Step Should Be Correct
    Wait Until Element Is Visible    ${WIZ_LAST_STEP_CONFIRMATION_BUTTON}

    Page Should Contain
    ...    Finalizar

    Page Should Contain
    ...    O modo de operação do equipamento será alterado para Roteador.

    Page Should Contain
    ...    A gerência de seu dispositivo será acessível pela interface Wireless através do endereço IP 10.0.0.1.

    Page Should Contain
    ...    Clique em Finalizar para concluir o processo ou Voltar se ainda deseja alterar alguma informação.

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    Element Should Be Enabled    ${WIZ_LAST_STEP_CONFIRMATION_BUTTON}
