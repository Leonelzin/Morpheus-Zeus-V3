*** Settings ***
Documentation       Wizard Facebook Resource File
...                 This resource file contains keywords related to wizard
...                 facebook page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Library             Collections
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${WIZARD_WIRELESS_FACTORY_DEFAULT_SSID}                             ${DUT_ENV}[wireless][2ghz][default_ssid][name]

${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT}                         ${DUT}[profile][wizard][facebook][wireless][factory_default]
${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_SSID_NAME}               ${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT}[ssid_name]
${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_SSID_FREQUENCY}          ${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT}[ssid_frequency]
${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_AUTHENTICATION_TYPE}     ${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT}[authentication_type]
${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_SSID_HIDE}               ${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT}[ssid_hide]

${WIZARD_NEXT_BUTTON}                                               button_next
${WIZARD_TERMS_OF_USE_CANCEL_BUTTON}                                xpath:/html/body/div[5]/div/div/div[3]/button[1]
${WIZARD_CANCEL_BUTTON}                                             ssid_discard_changes

${WIZARD_FACEBOOK_OPTION_BUTTON}                                    op_mode_option_facebook

${WIZARD_FACEBOOK_EDIT_SSID_BUTTON}                                 xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/button[1]

${WIZARD_FACEBOOK_SSID_NAME_INPUT}                                  ssid_name

${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT}                            ssid_band
${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT_2GHZ_VALUE}                 string:2.4 GHz
${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT_5GHZ_VALUE}                 string:5 GHz
${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT_DUALBAND_VALUE}             string:Dual band

${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT}                       ssid_auth
${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_OPEN_SYSTEM_VALUE}     string:none
${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_WPA_PSK_VALUE}         string:psk
${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_WPA2_PSK_VALUE}        string:psk2
${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_WPA_VALUE}             string:wpa
${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_WPA2_VALUE}            string:wpa2
${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT_FACEBOOK_WIFI_VALUE}        string:facebook_wifi

${WIZARD_FACEBOOK_HIDE_SSID_CHECKBOX}                               ssid_broadcast

${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT_DUALBAND_LABEL}             Dual band
${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_OPEN_SYSTEM_LABEL}     Sistema Aberto

*** Keywords ***
Access Wizard Facebook Settings Page
    Open Wizard Menu
    Wait For WEB Message To Disappear Or Timeout After "15" Seconds
    Wait Until Element Is Visible    ${WIZARD_NEXT_BUTTON}
    Click Element    ${WIZARD_NEXT_BUTTON}
    Click Element    ${WIZARD_FACEBOOK_OPTION_BUTTON}
    Click Element    ${WIZARD_NEXT_BUTTON}
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
    Wait Until Element Is Visible    ${WIZARD_FACEBOOK_EDIT_SSID_BUTTON}

Wizard Facebook Settings Should Be Factory Default
    Click Element    ${WIZARD_FACEBOOK_EDIT_SSID_BUTTON}

    Wait Until Element Is Visible    ${WIZARD_TERMS_OF_USE_CANCEL_BUTTON}
    Page Should Contain
    ...    O serviço de check-in do Facebook é uma ferramenta disponibilizada pelo Facebook, assim, a Intelbras não garante a disponibilidade do serviço, podendo este ser interrompido pelo Facebook sem aviso prévio. Saiba mais sobre a função Facebook Wi-Fi em
    Page Should Contain Link
    ...    https://www.facebook.com/business/facebook-wifi
    Click Element    ${WIZARD_TERMS_OF_USE_CANCEL_BUTTON}

    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be    ${WIZARD_FACEBOOK_SSID_NAME_INPUT}    value
        ...    ${DUT}[env][wireless][2ghz][default_ssid][name]
    ELSE IF    ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be    ${WIZARD_FACEBOOK_SSID_NAME_INPUT}    value
        ...    ${DUT}[env][wireless][5ghz][default_ssid][name]
    END

    IF    '${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_SSID_FREQUENCY}' == '2.4 GHz'
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT}
        ...    ${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT_2GHZ_VALUE}
    ELSE IF    '${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_SSID_FREQUENCY}' == '5 GHz'
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT}
        ...    ${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT_5GHZ_VALUE}
    ELSE IF    '${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_SSID_FREQUENCY}' == 'Dual band'
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT}
        ...    ${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT_DUALBAND_VALUE}
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT}
        ...    ${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT_DUALBAND_LABEL}
    END

    IF    '${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_AUTHENTICATION_TYPE}' == 'Open System'
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT}
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_OPEN_SYSTEM_VALUE}
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT}
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_OPEN_SYSTEM_LABEL}
    ELSE IF    '${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_AUTHENTICATION_TYPE}' == 'WPA-PSK'
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT}
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_WPA_PSK_VALUE}
    ELSE IF    '${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_AUTHENTICATION_TYPE}' == 'WPA2-PSK'
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT}
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_WPA2_PSK_VALUE}
    ELSE IF    '${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_AUTHENTICATION_TYPE}' == 'WPA'
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT}
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_WPA_VALUE}
    ELSE IF    '${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_AUTHENTICATION_TYPE}' == 'WPA2'
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT}
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT_WPA2_VALUE}
    ELSE IF    '${WIZARD_FACEBOOK_WIRELESS_FACTORY_DEFAULT_AUTHENTICATION_TYPE}' == 'Facebook Wi-Fi'
        List Selection Should Be
        ...    ${WIZARD_FACEBOOK_AUTHENTICATION_TYPE_SELECT}
        ...    ${WIZARD_FACEBOOK_SSID_FREQUENCY_SELECT_FACEBOOK_WIFI_VALUE}
    END

    Checkbox Should Not Be Selected    ${WIZARD_FACEBOOK_HIDE_SSID_CHECKBOX}

    Click Element    ${WIZARD_CANCEL_BUTTON}
    Click Element    ${WIZARD_NEXT_BUTTON}
    Page Should Contain
    ...    Página do facebook não associada
