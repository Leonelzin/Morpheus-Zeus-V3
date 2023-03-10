*** Settings ***
Documentation       Wizard (Splash Page) Resource File
...                 
...                 This resource file contains keywords related to wizard
...                 (splash page) manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Library             Collections
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
# Wireless Settings
${WIZ_SPLASH_PAGE_SSID_NAME_DIV}                                xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/div/div[1]
${WIZ_SPLASH_PAGE_SSID_FREQ_DIV}                                xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/div/div[2]

${WIZ_SPLASH_PAGE_SSID_SETTINGS_BUTTON}                         xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/button[1]
${WIZ_SPLASH_PAGE_SSID_REMOVE_BUTTON}                           xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/button[2]

${WIZ_SPLASH_PAGE_ADD_NEW_SSID_BUTTON}                          xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[2]/div/button

${WIZ_SPLASH_PAGE_SSID_SETTINGS_NAME_INPUT}                     ssid_name

${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT}                    ssid_band
${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_DUAL_BAND_VALUE}    string:Dual band
${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_DUAL_BAND_LABEL}    Dual band
${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_2GHZ_VALUE}         string:2.4 GHz
${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_2GHZ_LABEL}         2.4 GHz
${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_5GHZ_VALUE}         string:5 GHz
${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_5GHZ_LABEL}         5 GHz

${WIZ_SPLASH_PAGE_SSID_SETTINGS_AUTH_TYPE_SELECT}               ssid_auth
${WIZ_SPLASH_PAGE_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_VALUE}    string:none
${WIZ_SPLASH_PAGE_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_LABEL}    Sistema Aberto

${WIZ_SPLASH_PAGE_SSID_SETTINGS_BROADCAST_CHECKBOX}             ssid_broadcast

${WIZ_SPLASH_PAGE_SSID_SETTINGS_DISCARD_CHANGES_BUTTON}         ssid_discard_changes
${WIZ_SPLASH_PAGE_SSID_SETTINGS_CONFIRM_CHANGES_BUTTON}         ssid_confirm_changes

# Splash Page Settings
${WIZ_SPLASH_PAGE_TABLE}                                        splash_table

${WIZ_SPLASH_PAGE_1ST_SSID_NAME}                                xpath://*[@id="splash_table"]/tbody/tr[1]/td[1]/div
${WIZ_SPLASH_PAGE_1ST_SSID_BAND}                                xpath://*[@id="splash_table"]/tbody/tr[1]/td[2]
${WIZ_SPLASH_PAGE_1ST_SSID_AUTH}                                xpath://*[@id="splash_table"]/tbody/tr[1]/td[3]/div
${WIZ_SPLASH_PAGE_1ST_SSID_ENABLE_CHECKBOX}                     xpath://*[@id="splash_table"]/tbody/tr[1]/td[4]/div/label/input

${WIZ_SPLASH_PAGE_2ND_SSID_NAME}                                xpath://*[@id="splash_table"]/tbody/tr[2]/td[1]/div
${WIZ_SPLASH_PAGE_2ND_SSID_BAND}                                xpath://*[@id="splash_table"]/tbody/tr[2]/td[2]
${WIZ_SPLASH_PAGE_2ND_SSID_AUTH}                                xpath://*[@id="splash_table"]/tbody/tr[2]/td[3]/div
${WIZ_SPLASH_PAGE_2ND_SSID_ENABLE_CHECKBOX}                     xpath://*[@id="splash_table"]/tbody/tr[2]/td[4]/div/label/input

${WIZ_SPLASH_PAGE_MEDIA_TYPE_SELECT}                            media_type
${WIZ_SPLASH_PAGE_MEDIA_TYPE_SELECT_VIDEO_VALUE}                string:video
${WIZ_SPLASH_PAGE_MEDIA_TYPE_SELECT_VIDEO_LABEL}                Video (link da internet)
${WIZ_SPLASH_PAGE_MEDIA_TYPE_SELECT_IMAGE_VALUE}                string:image
${WIZ_SPLASH_PAGE_MEDIA_TYPE_SELECT_IMAGE_LABEL}                Imagem (link da internet)

${WIZ_SPLASH_PAGE_MEDIA_LINK_INPUT}                             media_link
${WIZ_SPLASH_PAGE_ADVERTISING_TIMEOUT_INPUT}                    advertising_timeout

${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT}                       session_timeout
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_30MIN_VALUE}           number:1800
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_30MIN_LABEL}           30 minutos
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_45MIN_VALUE}           number:2700
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_1H_VALUE}              number:3600
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_2H_VALUE}              number:7200
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_3H_VALUE}              number:10800
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_6H_VALUE}              number:21600
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_12H_VALUE}             number:43200
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_1D_VALUE}              number:86400
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_2D_VALUE}              number:172800
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_3D_VALUE}              number:259200
${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_7D_VALUE}              number:604800

${WIZ_SPLASH_PAGE_LEGAL_INFORMATION_TEXTAREA}                   legal_information

# LAN Settings
${WIZ_SPLASH_PAGE_LAN_IPV4_ADDRESS_INPUT}                       network_ip_address
${WIZ_SPLASH_PAGE_LAN_IPV4_NETMASK_INPUT}                       network_netmask

${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT}                     modo_dns
${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT_MANUAL_VALUE}        boolean:false
${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT_MANUAL_LABEL}        Modo Manual
${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT_AUTO_VALUE}          boolean:true
${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT_AUTO_LABEL}          Modo Automático

${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_SERVER_1_INPUT}                  dns_ip_address_1

*** Keywords ***
Select First SSID Splash Page Enable Checkbox
    Select Checkbox    ${WIZ_SPLASH_PAGE_1ST_SSID_ENABLE_CHECKBOX}

Set Splash Page Media Link To "${media_link}"
    Input Text    ${WIZ_SPLASH_PAGE_MEDIA_LINK_INPUT}    ${media_link}

Wizard (Splash Page) Wireless Settings Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        Element Text Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_NAME_DIV}
        ...    SSID: ${DUT}[env][wireless][2ghz][default_ssid][name]
    ELSE IF    ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        Element Text Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_NAME_DIV}
        ...    SSID: ${DUT}[env][wireless][5ghz][default_ssid][name]
    END

    IF    '${DUT}[profile][wizard][splash_page][wireless][factory_default][ssid][band]' == 'dual_band'
        Element Text Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_FREQ_DIV}
        ...    Frequência: Dual band
    ELSE IF    '${DUT}[profile][wizard][splash_page][wireless][factory_default][ssid][band]' == '2.4ghz'
        Element Text Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_FREQ_DIV}
        ...    Frequência: 2.4 GHz
    ELSE IF    '${DUT}[profile][wizard][splash_page][wireless][factory_default][ssid][band]' == '5ghz'
        Element Text Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_FREQ_DIV}
        ...    Frequência: 5 GHz
    ELSE
        Fail    Could not determine DUT wizard (splash page) factory default SSID band (check DUT profile).
    END

    Element Should Be Visible    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_BUTTON}
    Element Should Be Enabled    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_BUTTON}

    Element Should Be Visible    ${WIZ_SPLASH_PAGE_SSID_REMOVE_BUTTON}
    Element Should Be Disabled    ${WIZ_SPLASH_PAGE_SSID_REMOVE_BUTTON}

    Element Should Be Visible    ${WIZ_SPLASH_PAGE_ADD_NEW_SSID_BUTTON}
    Element Should Be Enabled    ${WIZ_SPLASH_PAGE_ADD_NEW_SSID_BUTTON}

    Click Element    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_BUTTON}

    Wait Until Element Is Visible    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_NAME_INPUT}

    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_NAME_INPUT}
        ...    value
        ...    ${DUT}[env][wireless][2ghz][default_ssid][name]
    ELSE IF    ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_NAME_INPUT}
        ...    value
        ...    ${DUT}[env][wireless][5ghz][default_ssid][name]
    END

    IF    '${DUT}[profile][wizard][splash_page][wireless][factory_default][ssid][band]' == 'dual_band'
        List Selection Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_DUAL_BAND_VALUE}
        List Selection Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_DUAL_BAND_LABEL}
    ELSE IF    '${DUT}[profile][wizard][splash_page][wireless][factory_default][ssid][band]' == '2.4ghz'
        List Selection Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_2GHZ_VALUE}
        List Selection Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_2GHZ_LABEL}
    ELSE IF    '${DUT}[profile][wizard][splash_page][wireless][factory_default][ssid][band]' == '5ghz'
        List Selection Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_5GHZ_VALUE}
        List Selection Should Be
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT}
        ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_FREQ_SELECT_5GHZ_LABEL}
    ELSE
        Fail    Could not determine DUT wizard (splash page) factory default SSID band (check DUT profile).
    END

    List Selection Should Be
    ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_AUTH_TYPE_SELECT}
    ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_VALUE}

    List Selection Should Be
    ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_AUTH_TYPE_SELECT}
    ...    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_AUTH_TYPE_SELECT_OPEN_LABEL}

    IF    ${DUT}[profile][wireless][ssid][factory_default][broadcast_off] == ${TRUE}
        Checkbox Should Be Selected    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_BROADCAST_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_BROADCAST_CHECKBOX}
    END

    Click Button    ${WIZ_SPLASH_PAGE_SSID_SETTINGS_DISCARD_CHANGES_BUTTON}

Wizard (Splash Page) Settings Should Be Factory Default
    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE} and ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_1ST_SSID_NAME}
        ...    innerText
        ...    ${DUT}[env][wireless][5ghz][default_ssid][name]

        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_1ST_SSID_BAND}
        ...    innerText
        ...    5 GHz

        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_1ST_SSID_AUTH}
        ...    innerText
        ...    Sistema Aberto

        Checkbox Should Not Be Selected    ${WIZ_SPLASH_PAGE_1ST_SSID_ENABLE_CHECKBOX}

        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_2ND_SSID_NAME}
        ...    innerText
        ...    ${DUT}[env][wireless][5ghz][default_ssid][name]

        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_2ND_SSID_BAND}
        ...    innerText
        ...    2.4 GHz

        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_2ND_SSID_AUTH}
        ...    innerText
        ...    Sistema Aberto

        Checkbox Should Not Be Selected    ${WIZ_SPLASH_PAGE_2ND_SSID_ENABLE_CHECKBOX}
    ELSE IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_1ST_SSID_NAME}
        ...    innerText
        ...    ${DUT}[env][wireless][2ghz][default_ssid][name]

        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_1ST_SSID_BAND}
        ...    innerText
        ...    2.4 GHz

        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_1ST_SSID_AUTH}
        ...    innerText
        ...    Sistema Aberto

        Checkbox Should Not Be Selected    ${WIZ_SPLASH_PAGE_1ST_SSID_ENABLE_CHECKBOX}
    ELSE IF    ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_1ST_SSID_NAME}
        ...    innerText
        ...    ${DUT}[env][wireless][5ghz][default_ssid][name]

        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_1ST_SSID_BAND}
        ...    innerText
        ...    5 GHz

        Element Attribute Value Should Be
        ...    ${WIZ_SPLASH_PAGE_1ST_SSID_AUTH}
        ...    innerText
        ...    Sistema Aberto

        Checkbox Should Not Be Selected    ${WIZ_SPLASH_PAGE_1ST_SSID_ENABLE_CHECKBOX}
    END

    List Selection Should Be
    ...    ${WIZ_SPLASH_PAGE_MEDIA_TYPE_SELECT}
    ...    ${WIZ_SPLASH_PAGE_MEDIA_TYPE_SELECT_VIDEO_VALUE}

    List Selection Should Be
    ...    ${WIZ_SPLASH_PAGE_MEDIA_TYPE_SELECT}
    ...    ${WIZ_SPLASH_PAGE_MEDIA_TYPE_SELECT_VIDEO_LABEL}

    Element Attribute Value Should Be
    ...    ${WIZ_SPLASH_PAGE_MEDIA_LINK_INPUT}
    ...    value
    ...    https://

    Element Attribute Value Should Be
    ...    ${WIZ_SPLASH_PAGE_ADVERTISING_TIMEOUT_INPUT}
    ...    value
    ...    30

    List Selection Should Be
    ...    ${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT}
    ...    ${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_30MIN_VALUE}

    List Selection Should Be
    ...    ${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT}
    ...    ${WIZ_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_30MIN_LABEL}

Wizard (Splash Page) LAN Settings Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    Element Attribute Value Should Be
    ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_ADDRESS_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][splash_page][lan][factory_default][ipv4][address]

    Element Attribute Value Should Be
    ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_NETMASK_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][splash_page][lan][factory_default][ipv4][netmask]

    IF    '${DUT}[profile][wizard][splash_page][lan][factory_default][ipv4][dns_mode]' == 'manual'
        List Selection Should Be
        ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT_MANUAL_VALUE}

        List Selection Should Be
        ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT_MANUAL_LABEL}

        Element Should Be Enabled    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_SERVER_1_INPUT}
    ELSE IF    '${DUT}[profile][wizard][splash_page][lan][factory_default][ipv4][dns_mode]' == 'automatic'
        List Selection Should Be
        ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT_AUTO_VALUE}

        List Selection Should Be
        ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT}
        ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_MODE_SELECT_AUTO_LABEL}

        Element Should Be Disabled    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_SERVER_1_INPUT}
    ELSE
        Fail    Could not determine DUT wizard (splash page preset) factory default DNS mode (check DUT profile).
    END

    Element Attribute Value Should Be
    ...    ${WIZ_SPLASH_PAGE_LAN_IPV4_DNS_SERVER_1_INPUT}
    ...    value
    ...    ${DUT}[profile][wizard][splash_page][lan][factory_default][ipv4][dns_server_1]

Wizard (Splash Page) Confirmation Step Should Be Correct
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
