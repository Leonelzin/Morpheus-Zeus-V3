*** Settings ***
Documentation       WI-FI Marketing Splash Page Resource File
...
...                 This resource file contains keywords related to wi-fi
...                 marketing splash page WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Library             Collections
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT}                           ${DUT}[profile][wifi_marketing][splash_page][factory_default]

${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT_MEDIA_TYPE}                ${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT}[media_type]
${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT_MEDIA_LINK}                ${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT}[media_link]
${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT_ADVERTISING_TIMEOUT}       ${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT}[advertising_timeout]
${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT_SESSION_TIMEOUT}           ${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT}[session_timeout]
${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT_LEGAL_INFORMATION}         ${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT}[legal_information]

${WIFI_MARKETING_SPLASH_PAGE_SUBMENU}                                   splash_submenu
${WIFI_MARKETING_SPLASH_PAGE_TABLE}                                     splash_table

${WIFI_MARKETING_SPLASH_PAGE_2G_SSID}                                   xpath://*[@id="splash_table"]/tbody/tr[1]/td[1]/div
${WIFI_MARKETING_SPLASH_PAGE_2G_BAND}                                   xpath://*[@id="splash_table"]/tbody/tr[1]/td[2]
${WIFI_MARKETING_SPLASH_PAGE_2G_AUTH}                                   xpath://*[@id="splash_table"]/tbody/tr[1]/td[3]/div
${WIFI_MARKETING_SPLASH_PAGE_2G_ENABLE}                                 xpath://*[@id="splash_table"]/tbody/tr[1]/td[4]/div/label/input
${WIFI_MARKETING_SPLASH_PAGE_5G_SSID}                                   xpath://*[@id="splash_table"]/tbody/tr[2]/td[1]/div
${WIFI_MARKETING_SPLASH_PAGE_5G_BAND}                                   xpath://*[@id="splash_table"]/tbody/tr[2]/td[2]
${WIFI_MARKETING_SPLASH_PAGE_5G_AUTH}                                   xpath://*[@id="splash_table"]/tbody/tr[2]/td[3]/div
${WIFI_MARKETING_SPLASH_PAGE_5G_ENABLE}                                 xpath://*[@id="splash_table"]/tbody/tr[2]/td[4]/div/label/input

${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT}                         media_type
${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT_VIDEO_VALUE}             string:video
${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT_VIDEO_LABEL}             Video (link da internet)
${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT_IMAGE_VALUE}             string:image
${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT_IMAGE_LABEL}             Imagem (link da internet)

${WIFI_MARKETING_SPLASH_PAGE_MEDIA_LINK_INPUT}                          media_link
${WIFI_MARKETING_SPLASH_PAGE_ADVERTISING_TIMEOUT_INPUT}                 advertising_timeout

${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT}                    session_timeout
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_30MIN_LABEL}        30 minutos
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_30MIN_VALUE}        number:1800
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_45MIN_VALUE}        number:2700
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_1H_VALUE}           number:3600
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_2H_VALUE}           number:7200
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_3H_VALUE}           number:10800
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_6H_VALUE}           number:21600
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_12H_VALUE}          number:43200
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_1D_VALUE}           number:86400
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_2D_VALUE}           number:172800
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_3D_VALUE}           number:259200
${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_7D_VALUE}           number:604800

${WIFI_MARKETING_SPLASH_PAGE_LEGAL_INFORMATION_INPUT}                   legal_information

*** Keywords ***
Access Wi-Fi Marketing Splash Page Settings Page
    Open Wifi Marketing Menu
    Wait Until Element Is Visible    ${WIFI_MARKETING_SPLASH_PAGE_SUBMENU}
    Click Element    ${WIFI_MARKETING_SPLASH_PAGE_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
    Wait Until Element Is Visible    ${WIFI_MARKETING_SPLASH_PAGE_TABLE}

Wi-Fi Marketing Splash Page Settings Should Be Factory Default
    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_2G_SSID}
        ...    innerText    ${DUT}[env][wireless][2ghz][default_ssid][name]
        Element Attribute Value Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_2G_BAND}
        ...    innerText    2.4 GHz
        Checkbox Should Not Be Selected    ${WIFI_MARKETING_SPLASH_PAGE_2G_ENABLE}
    ELSE IF    ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_5G_SSID}
        ...    innerText    ${DUT}[env][wireless][5ghz][default_ssid][name]
        Element Attribute Value Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_5G_BAND}
        ...    innerText    5 GHz
        Element Attribute Value Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_5G_AUTH}
        ...    innerText    Sistema Aberto
        Checkbox Should Not Be Selected    ${WIFI_MARKETING_SPLASH_PAGE_5G_ENABLE}
    END

    IF    '${DUT}[profile][wireless][ssid][factory_default][auth]' == 'open'
        Element Attribute Value Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_2G_AUTH}
        ...    innerText    Sistema Aberto
        Element Attribute Value Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_5G_AUTH}
        ...    innerText    Sistema Aberto
    ELSE
        Fail    Could not determine SSID authentication. Check DUT profile (SSID auth information).
    END

    IF    '${DUT}[profile][wifi_marketing][splash_page][factory_default][media_type]' == 'video'
        List Selection Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT}
        ...    ${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT_VIDEO_VALUE}
        List Selection Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT}
        ...    ${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT_VIDEO_LABEL}
    ELSE
        List Selection Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT}
        ...    ${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT_IMAGE_VALUE}
        List Selection Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT}
        ...    ${WIFI_MARKETING_SPLASH_PAGE_MEDIA_TYPE_SELECT_IMAGE_LABEL}
    END

    Element Attribute Value Should Be
    ...    ${WIFI_MARKETING_SPLASH_PAGE_MEDIA_LINK_INPUT}
    ...    value    https://

    IF    '${DUT}[profile][wifi_marketing][splash_page][factory_default][advertising_timeout]' == '30'
        Element Attribute Value Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_ADVERTISING_TIMEOUT_INPUT}
        ...    value    30
    END

    IF    '${DUT}[profile][wifi_marketing][splash_page][factory_default][session_timeout]' == '30 min'
        List Selection Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT}
        ...    ${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_30MIN_VALUE}
        List Selection Should Be
        ...    ${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT}
        ...    ${WIFI_MARKETING_SPLASH_PAGE_SESSION_TIMEOUT_SELECT_30MIN_LABEL}
        Page Should Contain
        ...    O tempo de sessão informado será sobrescrito quando utilizado junto com as funcionalidades de Captive Portal Externo ou Facebook Wi-Fi.
    END

    Element Attribute Value Should Be
    ...    ${WIFI_MARKETING_SPLASH_PAGE_LEGAL_INFORMATION_INPUT}
    ...    value    ${WIFI_MARKETING_SPLASH_PAGE_FACTORY_DEFAULT_LEGAL_INFORMATION}
    Page Should Contain    Termos de uso devem possuir no máximo 1250 caracteres e não devem possuir quebra de linha
    Page Should Not Contain    Caso necessário, digite aqui o Termo de Uso a ser exibido ao usuário
