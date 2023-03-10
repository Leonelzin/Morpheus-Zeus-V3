*** Settings ***
Documentation       Status Signal Resource File
...                 
...                 This resource file contains keywords related to status
...                 signal webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Library             Collections
Resource            web/common.resource
Resource            web/sidemenu_pom.resource


*** Variables ***
${STATUS_SIGNAL_SUBMENU}                        signal_submenu

${WIRELESS_OP_MODE_SELECT_CLIENT_VALUE}         string:client
${WIRELESS_OP_MODE_SELECT_REPEATER_VALUE}       string:repeater

${STATUS_SIGNAL_SIGNAL_STATUS}                  signal_status_message
${STATUS_SIGNAL_CURRENT_SIGNAL}                 current_signal
${STATUS_SIGNAL_CURRENT_SNR}                    current_snr
${STATUS_SIGNAL_MESSAGE_POP_UP}                 zeusNotifyMessage
${STATUS_SIGNAL_MESSAGE_VALUE}                  Esta funcionalidade está disponível somente em modo repetidor/cliente

${STATUS_SIGNAL_CURRENT_SIGNAL_REGEX}           ^Sinal: -\\d{1,3} dBm
${STATUS_SIGNAL_CURRENT_SNR_REGEX}              ^SNR: \\d{1,3} dB


*** Keywords ***
Access Status Signal Settings Page
    Open Status Menu
    Wait Until Element Is Visible    ${STATUS_SIGNAL_SUBMENU}
    Click Element    ${STATUS_SIGNAL_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
    Wait Until Element Is Visible    ${STATUS_SIGNAL_SIGNAL_STATUS}

Access Status Signal Settings Page Wait Message
    Open Status Menu
    Wait Until Element Is Visible    ${STATUS_SIGNAL_SUBMENU}
    Click Element    ${STATUS_SIGNAL_SUBMENU}
    Wait Until Element Is Visible    ${STATUS_SIGNAL_MESSAGE_POP_UP}

Status Signal Factory Default Information
    IF    ${DUT}[profile][status][signal][is_supported] == ${TRUE}
        Access Status Signal Settings Page
        Wait "2" Seconds
        ${sinal}    Get Text    ${STATUS_SIGNAL_CURRENT_SIGNAL}
        Should Match Regexp    ${sinal}    ${STATUS_SIGNAL_CURRENT_SIGNAL_REGEX}
        ${snr}    Get Text    ${STATUS_SIGNAL_CURRENT_SNR}
        Should Match Regexp    ${snr}    ${STATUS_SIGNAL_CURRENT_SNR_REGEX}
    ELSE
        Skip    Feature Status Signal is not suported by DUT.
    END

Status Signal Should Be Factory Default
    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE} and ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_OP_MODE}' == 'access_point'
            IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_OP_MODE}' == 'access_point'
                Skip    Wireless 2G and 5G are access_point.
            ELSE
                Status Signal Factory Default Information
            END
        ELSE
            Status Signal Factory Default Information
        END
    ELSE IF   ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_OP_MODE}' == 'access_point'
            Skip    Wireless 2G is access_point.
        ELSE
            Status Signal Factory Default Information
        END
    ELSE IF   ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_OP_MODE}' == 'access_point'
            Skip    Wireless 5G is access_point.
        ELSE
            Status Signal Factory Default Information
        END
    ELSE
        Skip    Wireless 2G and 5G are not suported.
    END
