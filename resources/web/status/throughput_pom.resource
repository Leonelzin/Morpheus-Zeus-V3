*** Settings ***
Documentation       Status Throughput Resource File
...                 
...                 This resource file contains keywords related to status
...                 throughput webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Library             Collections
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/status/processing_pom.resource

*** Variables ***
${ETH1_HTML_ID}                                             ${DUT}[profile][ethernet][interface_1][html_id]
${ETH2_HTML_ID}                                             ${DUT}[profile][ethernet][interface_2][html_id]

${WIRELESS_2GHZ_HTML_ID}                                    ${DUT}[profile][wireless][2ghz][interface_id]
${WIRELESS_5GHZ_HTML_ID}                                    ${DUT}[profile][wireless][5ghz][interface_id]

${STATUS_THROUGHPUT_FACTORY_DEFAULT}                        ${DUT}[profile][status][throughput][factory_default]
${STATUS_THROUGHPUT_FACTORY_DEFAULT_2GHZ_SSID_FILTER}       ${STATUS_THROUGHPUT_FACTORY_DEFAULT}[2ghz_ssid_filter]
${STATUS_THROUGHPUT_FACTORY_DEFAULT_5GHZ_SSID_FILTER}       ${STATUS_THROUGHPUT_FACTORY_DEFAULT}[5ghz_ssid_filter]

${STATUS_THROUGHPUT_SUBMENU}                                throughput_submenu

${STATUS_THROUGHPUT_ETH1_PANEL}                             ethernet_${ETH1_HTML_ID}
${STATUS_THROUGHPUT_ETH2_PANEL}                             ethernet_${ETH2_HTML_ID}
${STATUS_THROUGHPUT_2GHZ_PANEL}                             wireless_${WIRELESS_2GHZ_HTML_ID}
${STATUS_THROUGHPUT_5GHZ_PANEL}                             wireless_${WIRELESS_5GHZ_HTML_ID}

${STATUS_THROUGHPUT_2GHZ_SSID_FILTER_SELECT}                interface_filter_${WIRELESS_2GHZ_HTML_ID}
${STATUS_THROUGHPUT_2GHZ_SSID_FILTER_SELECT_ALL_LABEL}      Todos
${STATUS_THROUGHPUT_2GHZ_TX_CURR}                           tx_atual_wireless_${WIRELESS_2GHZ_HTML_ID}
${STATUS_THROUGHPUT_2GHZ_TX_MAX}                            tx_maximo_wireless_${WIRELESS_2GHZ_HTML_ID}
${STATUS_THROUGHPUT_2GHZ_RX_CURR}                           rx_atual_wireless_${WIRELESS_2GHZ_HTML_ID}
${STATUS_THROUGHPUT_2GHZ_RX_MAX}                            rx_maximo_wireless_${WIRELESS_2GHZ_HTML_ID}

${STATUS_THROUGHPUT_5GHZ_SSID_FILTER_SELECT}                interface_filter_${WIRELESS_5GHZ_HTML_ID}
${STATUS_THROUGHPUT_5GHZ_SSID_FILTER_SELECT_ALL_LABEL}      Todos
${STATUS_THROUGHPUT_5GHZ_TX_CURR}                           tx_atual_wireless_${WIRELESS_5GHZ_HTML_ID}
${STATUS_THROUGHPUT_5GHZ_TX_MAX}                            tx_maximo_wireless_${WIRELESS_5GHZ_HTML_ID}
${STATUS_THROUGHPUT_5GHZ_RX_CURR}                           rx_atual_wireless_${WIRELESS_5GHZ_HTML_ID}
${STATUS_THROUGHPUT_5GHZ_RX_MAX}                            rx_maximo_wireless_${WIRELESS_5GHZ_HTML_ID}

${STATUS_THROUGHPUT_ETH1_TX_CURR}                           current_tx_ethernet_${ETH1_HTML_ID}
${STATUS_THROUGHPUT_ETH1_RX_CURR}                           current_rx_ethernet_${ETH1_HTML_ID}
${STATUS_THROUGHPUT_ETH1_TX_MAX}                            max_tx_ethernet_${ETH1_HTML_ID}
${STATUS_THROUGHPUT_ETH1_RX_MAX}                            max_rx_ethernet_${ETH1_HTML_ID}

${STATUS_THROUGHPUT_ETH2_TX_CURR}                           current_tx_ethernet_${ETH2_HTML_ID}
${STATUS_THROUGHPUT_ETH2_RX_CURR}                           current_rx_ethernet_${ETH2_HTML_ID}
${STATUS_THROUGHPUT_ETH2_TX_MAX}                            max_tx_ethernet_${ETH2_HTML_ID}
${STATUS_THROUGHPUT_ETH2_RX_MAX}                            max_rx_ethernet_${ETH2_HTML_ID}

${REGEX_MBPS}                                               \\d{1,3}(.\\d{1,3})? Mbps
${STATUS_THROUGHPUT_TX_CURR_REGEX}                          ^TX: ${REGEX_MBPS}$
${STATUS_THROUGHPUT_RX_CURR_REGEX}                          ^RX: ${REGEX_MBPS}$
${STATUS_THROUGHPUT_TX_MAX_REGEX}                           ^Máximo: ${REGEX_MBPS}$
${STATUS_THROUGHPUT_RX_MAX_REGEX}                           ^Máximo: ${REGEX_MBPS}$

*** Keywords ***
Access Status Throughput Settings Page
    Open Status Menu
    Wait Until Element Is Visible    ${STATUS_THROUGHPUT_SUBMENU}
    Click Element    ${STATUS_THROUGHPUT_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
    Wait Until Element Is Visible    ${STATUS_THROUGHPUT_ETH1_PANEL}

Status Throughput Settings Should Be Factory Default
    Wait "5" Seconds
    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        IF    '${STATUS_THROUGHPUT_FACTORY_DEFAULT_2GHZ_SSID_FILTER}' == 'all'
            List Selection Should Be
            ...    ${STATUS_THROUGHPUT_2GHZ_SSID_FILTER_SELECT}
            ...    ${STATUS_THROUGHPUT_2GHZ_SSID_FILTER_SELECT_ALL_LABEL}
        ELSE
            List Selection Should Be
            ...    ${STATUS_THROUGHPUT_2GHZ_SSID_FILTER_SELECT}
            ...    ${STATUS_THROUGHPUT_FACTORY_DEFAULT_2GHZ_SSID_FILTER}
        END

        ${2ghz_tx_curr}    Get Text    ${STATUS_THROUGHPUT_2GHZ_TX_CURR}
        Should Match Regexp    ${2ghz_tx_curr}    ${STATUS_THROUGHPUT_TX_CURR_REGEX}

        ${2ghz_tx_max}    Get Text    ${STATUS_THROUGHPUT_2GHZ_TX_MAX}
        Should Match Regexp    ${2ghz_tx_max}    ${STATUS_THROUGHPUT_TX_MAX_REGEX}

        ${2ghz_rx_curr}    Get Text    ${STATUS_THROUGHPUT_2GHZ_RX_CURR}
        Should Match Regexp    ${2ghz_rx_curr}    ${STATUS_THROUGHPUT_RX_CURR_REGEX}

        ${2ghz_rx_max}    Get Text    ${STATUS_THROUGHPUT_2GHZ_RX_MAX}
        Should Match Regexp    ${2ghz_rx_max}    ${STATUS_THROUGHPUT_RX_MAX_REGEX}
    END

    IF    ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        IF    '${STATUS_THROUGHPUT_FACTORY_DEFAULT_5GHZ_SSID_FILTER}' == 'all'
            List Selection Should Be
            ...    ${STATUS_THROUGHPUT_5GHZ_SSID_FILTER_SELECT}
            ...    ${STATUS_THROUGHPUT_5GHZ_SSID_FILTER_SELECT_ALL_LABEL}
        ELSE
            List Selection Should Be
            ...    ${STATUS_THROUGHPUT_5GHZ_SSID_FILTER_SELECT}
            ...    ${STATUS_THROUGHPUT_FACTORY_DEFAULT_5GHZ_SSID_FILTER}
        END

        ${5ghz_tx_curr}    Get Text    ${STATUS_THROUGHPUT_5GHZ_TX_CURR}
        Should Match Regexp    ${5ghz_tx_curr}    ${STATUS_THROUGHPUT_TX_CURR_REGEX}

        ${5ghz_tx_max}    Get Text    ${STATUS_THROUGHPUT_5GHZ_TX_MAX}
        Should Match Regexp    ${5ghz_tx_max}    ${STATUS_THROUGHPUT_TX_MAX_REGEX}

        ${5ghz_rx_curr}    Get Text    ${STATUS_THROUGHPUT_5GHZ_RX_CURR}
        Should Match Regexp    ${5ghz_rx_curr}    ${STATUS_THROUGHPUT_RX_CURR_REGEX}

        ${5ghz_rx_max}    Get Text    ${STATUS_THROUGHPUT_5GHZ_RX_MAX}
        Should Match Regexp    ${5ghz_rx_max}    ${STATUS_THROUGHPUT_RX_MAX_REGEX}
    END

    IF    ${DUT}[profile][ethernet][interface_1][is_supported] == ${TRUE}
        ${eth1_tx_curr}    Get Text    ${STATUS_THROUGHPUT_ETH1_TX_CURR}
        Should Match Regexp    ${eth1_tx_curr}    ${STATUS_THROUGHPUT_TX_CURR_REGEX}

        ${eth1_tx_max}    Get Text    ${STATUS_THROUGHPUT_ETH1_TX_MAX}
        Should Match Regexp    ${eth1_tx_max}    ${STATUS_THROUGHPUT_TX_MAX_REGEX}

        ${eth1_rx_curr}    Get Text    ${STATUS_THROUGHPUT_ETH1_RX_CURR}
        Should Match Regexp    ${eth1_rx_curr}    ${STATUS_THROUGHPUT_RX_CURR_REGEX}

        ${eth1_rx_max}    Get Text    ${STATUS_THROUGHPUT_ETH1_RX_MAX}
        Should Match Regexp    ${eth1_rx_max}    ${STATUS_THROUGHPUT_RX_MAX_REGEX}
    END

    IF    ${DUT}[profile][ethernet][interface_2][is_supported] == ${TRUE}
        ${eth2_tx_curr}    Get Text    ${STATUS_THROUGHPUT_ETH2_TX_CURR}
        Should Match Regexp    ${eth2_tx_curr}    ${STATUS_THROUGHPUT_TX_CURR_REGEX}

        ${eth2_tx_max}    Get Text    ${STATUS_THROUGHPUT_ETH2_TX_MAX}
        Should Match Regexp    ${eth2_tx_max}    ${STATUS_THROUGHPUT_TX_MAX_REGEX}

        ${eth2_rx_curr}    Get Text    ${STATUS_THROUGHPUT_ETH2_RX_CURR}
        Should Match Regexp    ${eth2_rx_curr}    ${STATUS_THROUGHPUT_RX_CURR_REGEX}

        ${eth2_rx_max}    Get Text    ${STATUS_THROUGHPUT_ETH2_RX_MAX}
        Should Match Regexp    ${eth2_rx_max}    ${STATUS_THROUGHPUT_RX_MAX_REGEX}
    END
