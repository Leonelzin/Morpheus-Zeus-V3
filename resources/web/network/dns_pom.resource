*** Settings ***
Documentation       Network (DNS) Resource File
...                 
...                 This resource file contains keywords related to network DNS
...                 settings webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/sidemenu_pom.resource

*** Variables ***
${NETWORK_DNS_FACTORY_DEFAULT_IPV4}                 ${DUT}[profile][network][factory_default][dns][ipv4]
${NETWORK_DNS_FACTORY_DEFAULT_IPV4_MODE}            ${NETWORK_DNS_FACTORY_DEFAULT_IPV4}[mode]
${NETWORK_DNS_FACTORY_DEFAULT_IPV4_SERVER_1}        ${NETWORK_DNS_FACTORY_DEFAULT_IPV4}[server_1]
${NETWORK_DNS_FACTORY_DEFAULT_IPV4_SERVER_2}        ${NETWORK_DNS_FACTORY_DEFAULT_IPV4}[server_2]

${NETWORK_DNS_FACTORY_DEFAULT_IPV6}                 ${DUT}[profile][network][factory_default][dns][ipv6]
${NETWORK_DNS_FACTORY_DEFAULT_IPV6_MODE}            ${NETWORK_DNS_FACTORY_DEFAULT_IPV6}[mode]
${NETWORK_DNS_FACTORY_DEFAULT_IPV6_SERVER_1}        ${NETWORK_DNS_FACTORY_DEFAULT_IPV6}[server_1]
${NETWORK_DNS_FACTORY_DEFAULT_IPV6_SERVER_2}        ${NETWORK_DNS_FACTORY_DEFAULT_IPV6}[server_2]

${NETWORK_DNS_SUBMENU}                              dns_submenu

${NETWORK_DNS_IPV4_MODE_SELECT}                     modo_dns
${NETWORK_DNS_IPV4_MODE_SELECT_MANUAL_VALUE}        boolean:false
${NETWORK_DNS_IPV4_MODE_SELECT_AUTOMATIC_VALUE}     boolean:true

${NETWORK_DNS_IPV4_SERVER_1_INPUT}                  dns_ip_address_1
${NETWORK_DNS_IPV4_SERVER_2_INPUT}                  dns_ip_address_2

${NETWORK_DNS_IPV6_MODE_SELECT}                     modo_dns_ipv6
${NETWORK_DNS_IPV6_MODE_SELECT_MANUAL_VALUE}        boolean:false
${NETWORK_DNS_IPV6_MODE_SELECT_AUTOMATIC_VALUE}     boolean:true

${NETWORK_DNS_IPV6_SERVER_1_INPUT}                  dns_ip_address_1_ipv6
${NETWORK_DNS_IPV6_SERVER_2_INPUT}                  dns_ip_address_2_ipv6

*** Keywords ***
Access Network DNS Settings Page
    Open Network Menu
    Wait Until Element Is Visible    ${NETWORK_DNS_SUBMENU}
    Click Element    ${NETWORK_DNS_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${SAVE_SETTINGS_BUTTON}

Network DNS IPv4 Mode Should Be "${mode}"
    List Selection Should Be
    ...    ${NETWORK_DNS_IPV4_MODE_SELECT}
    ...    ${mode}

Network DNS IPv6 Mode Should Be "${mode}"
    List Selection Should Be
    ...    ${NETWORK_DNS_IPV6_MODE_SELECT}
    ...    ${mode}

Network DNS IPv4 Server 1 Should Be "${server_address}"
    Element Attribute Value Should Be
    ...    ${NETWORK_DNS_IPV4_SERVER_1_INPUT}
    ...    value    ${server_address}

Network DNS IPv4 Server 2 Should Be "${server_address}"
    Element Attribute Value Should Be
    ...    ${NETWORK_DNS_IPV4_SERVER_2_INPUT}
    ...    value    ${server_address}

Network DNS IPv6 Server 1 Should Be "${server_address}"
    Element Attribute Value Should Be
    ...    ${NETWORK_DNS_IPV6_SERVER_1_INPUT}
    ...    value    ${server_address}

Network DNS IPv6 Server 2 Should Be "${server_address}"
    Element Attribute Value Should Be
    ...    ${NETWORK_DNS_IPV6_SERVER_2_INPUT}
    ...    value    ${server_address}

DNS Settings Should Be Factory Default
    IF    '${NETWORK_DNS_FACTORY_DEFAULT_IPV4_MODE}' == 'manual'
        List Selection Should Be
        ...    ${NETWORK_DNS_IPV4_MODE_SELECT}
        ...    ${NETWORK_DNS_IPV4_MODE_SELECT_MANUAL_VALUE}
        Element Should Be Enabled    ${NETWORK_DNS_IPV4_SERVER_1_INPUT}
        Element Should Be Enabled    ${NETWORK_DNS_IPV4_SERVER_2_INPUT}
    ELSE IF    '${NETWORK_DNS_FACTORY_DEFAULT_IPV4_MODE}' == 'automatic'
        List Selection Should Be
        ...    ${NETWORK_DNS_IPV4_MODE_SELECT}
        ...    ${NETWORK_DNS_IPV4_MODE_SELECT_AUTOMATIC_VALUE}
        Element Should Be Disabled    ${NETWORK_DNS_IPV4_SERVER_1_INPUT}
        Element Should Be Disabled    ${NETWORK_DNS_IPV4_SERVER_2_INPUT}
    END

    Network DNS IPv4 Server 1 Should Be "${NETWORK_DNS_FACTORY_DEFAULT_IPV4_SERVER_1}"
    Network DNS IPv4 Server 2 Should Be "${NETWORK_DNS_FACTORY_DEFAULT_IPV4_SERVER_2}"

    IF    '${NETWORK_DNS_FACTORY_DEFAULT_IPV6_MODE}' == 'manual'
        List Selection Should Be
        ...    ${NETWORK_DNS_IPV6_MODE_SELECT}
        ...    ${NETWORK_DNS_IPV6_MODE_SELECT_MANUAL_VALUE}
        Element Should Be Enabled    ${NETWORK_DNS_IPV6_SERVER_1_INPUT}
        Element Should Be Enabled    ${NETWORK_DNS_IPV6_SERVER_2_INPUT}
    ELSE IF    '${NETWORK_DNS_FACTORY_DEFAULT_IPV6_MODE}' == 'automatic'
        List Selection Should Be
        ...    ${NETWORK_DNS_IPV6_MODE_SELECT}
        ...    ${NETWORK_DNS_IPV6_MODE_SELECT_AUTOMATIC_VALUE}
        Element Should Be Disabled    ${NETWORK_DNS_IPV6_SERVER_1_INPUT}
        Element Should Be Disabled    ${NETWORK_DNS_IPV6_SERVER_2_INPUT}
    END

    Network DNS IPv6 Server 1 Should Be "${NETWORK_DNS_FACTORY_DEFAULT_IPV6_SERVER_1}"
    Network DNS IPv6 Server 2 Should Be "${NETWORK_DNS_FACTORY_DEFAULT_IPV6_SERVER_2}"
