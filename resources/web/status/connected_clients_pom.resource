*** Settings ***
Documentation       Status (Connected Clients) Resource File
...                 
...                 This resource file contains keywords related to status
...                 connected clients WEB page manipulation (page object
...                 model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/network/operation_mode_pom.resource

*** Variables ***
${STATUS_CONN_CLIENTS_FACTORY_DEFAULT}                                  ${DUT}[profile][status][connected_clients][factory_default]
${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_IFACE_FILTER}                     ${STATUS_CONN_CLIENTS_FACTORY_DEFAULT}[filters][interface]
${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_SSID_FILTER}                      ${STATUS_CONN_CLIENTS_FACTORY_DEFAULT}[filters][ssid]
${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_ADDR_TYPE_FILTER}                 ${STATUS_CONN_CLIENTS_FACTORY_DEFAULT}[filters][addressing_type]
${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_AUTO_UPDATE}                      ${STATUS_CONN_CLIENTS_FACTORY_DEFAULT}[auto_update_enabled]

${STATUS_CONN_CLIENTS_SUBMENU}                                          clients_submenu

${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}                              interface_filter
${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_ANY_VALUE}                    string:ANY
${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_ETHERNET_VALUE}               string:Ethernet
${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_VALUE}               string:Wireless
${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_2GHZ_VALUE}          string:Wireless (2.4 GHz)
${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_5GHZ_VALUE}          string:Wireless (5 GHz)
${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_ANY_LABEL}                    Qualquer
${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_ETHERNET_LABEL}               Ethernet
${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_LABEL}               Wireless
${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_5GHZ_LABEL}          Wireless (5 GHz)
${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_2GHZ_LABEL}          Wireless (2.4 GHz)

${STATUS_CONN_CLIENTS_SSID_FILTER_SELECT}                               ssid_filter
${STATUS_CONN_CLIENTS_SSID_FILTER_SELECT_ANY_VALUE}                     string:ANY
${STATUS_CONN_CLIENTS_SSID_FILTER_SELECT_ANY_LABEL}                     Qualquer

${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}                          type_filter
${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_ANY_VALUE}                string:ANY
${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_DHCP_DYNAMIC_VALUE}       string:dhcp
${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_DHCP_RESERVED_VALUE}      string:dhcp_reserved
${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_STATIC_VALUE}             string:static
${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_ANY_LABEL}                Qualquer
${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_DHCP_DYNAMIC_LABEL}       DHCP (Dinâmico)
${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_DHCP_RESERVED_LABEL}      DHCP (Reservedo)
${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_STATIC_LABEL}             Estático

${STATUS_CONN_CLIENTS_DISCONNECT_SELECTED_BUTTON}                       disconnect_button
${STATUS_CONN_CLIENTS_BLOCK_SELECTED_BUTTON}                            block_button
${STATUS_CONN_CLIENTS_REFRESH_BUTTON}                                   refresh_button
${STATUS_CONN_CLIENTS_AUTO_UPDATE_CHECKBOX}                             automatic_update_check

${STATUS_CONN_CLIENTS_TABLE}                                            xpath://*[@id="main"]/div[2]/div/div/div/div[3]/div/table
${STATUS_CONN_CLIENTS_TABLE_HEADER_DISCONNECT_CHECKBOX}                 head_disconnect_check
${STATUS_CONN_CLIENTS_TABLE_HEADER_ADDR_TYPE}                           head_type

*** Keywords ***
Access Status Connected Clients Page
    Open Status Menu
    Wait Until Element Is Visible    ${STATUS_CONN_CLIENTS_SUBMENU}
    Click Element    ${STATUS_CONN_CLIENTS_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
    Wait Until Element Is Visible    ${STATUS_CONN_CLIENTS_REFRESH_BUTTON}

Status Connected Clients Filters Should Be Factory Default
    IF    '${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_IFACE_FILTER}' == 'any'
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_ANY_VALUE}
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_ANY_LABEL}
    ELSE IF    '${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_IFACE_FILTER}' == 'ethernet'
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_ETHERNET_VALUE}
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_ETHERNET_LABEL}
    ELSE IF    '${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_IFACE_FILTER}' == 'wireless'
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_VALUE}
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_LABEL}
    ELSE IF    '${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_IFACE_FILTER}' == 'wireless_2.4ghz'
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_2GHZ_VALUE}
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_2GHZ_LABEL}
    ELSE IF    '${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_IFACE_FILTER}' == 'wireless_5ghz'
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_5GHZ_VALUE}
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_WIRELESS_5GHZ_LABEL}
    ELSE
        Fail    Could not determine DUT connected clients factory default interface filter (check DUT profile).
    END

    IF    '${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_SSID_FILTER}' == 'any'
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_SSID_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_SSID_FILTER_SELECT_ANY_VALUE}
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_SSID_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT_ANY_LABEL}
    ELSE
        List Selection Should Be
        ...    ${STATUS_CONN_CLIENTS_SSID_FILTER_SELECT}
        ...    ${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_SSID_FILTER}
    END

    IF    '${NETWORK_FACTORY_DEFAULT_OP_MODE}' == 'router'
        Element Should Be Visible    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}
        IF    '${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_ADDR_TYPE_FILTER}' == 'any'
            List Selection Should Be
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_ANY_VALUE}
            List Selection Should Be
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_ANY_LABEL}
        ELSE IF    '${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_ADDR_TYPE_FILTER}' == 'static'
            List Selection Should Be
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_STATIC_VALUE}
            List Selection Should Be
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_STATIC_LABEL}
        ELSE IF    '${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_ADDR_TYPE_FILTER}' == 'dhcp'
            List Selection Should Be
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_DHCP_DYNAMIC_VALUE}
            List Selection Should Be
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_DHCP_DYNAMIC_LABEL}
        ELSE IF    '${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_ADDR_TYPE_FILTER}' == 'dhcp_reserved'
            List Selection Should Be
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_DHCP_RESERVED_VALUE}
            List Selection Should Be
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}
            ...    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT_DHCP_RESERVED_LABEL}
        ELSE
            Fail    Could not determine DUT factory default addressing type filter (check DUT profile).
        END
    ELSE IF    '${NETWORK_FACTORY_DEFAULT_OP_MODE}' == 'bridge'
        Element Should Not Be Visible    ${STATUS_CONN_CLIENTS_ADDR_TYPE_FILTER_SELECT}
    END

Status Connected Clients Table Headers Should Be Correct
    Checkbox Should Not Be Selected    ${STATUS_CONN_CLIENTS_TABLE_HEADER_DISCONNECT_CHECKBOX}
    Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    Interface
    Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    SSID
    Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    Hostname
    Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    IP
    Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    Rx
    Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    Tx
    Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    Endereço MAC
    Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    Sinal
    Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    Inativo
    Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    Conectado

    IF    '${NETWORK_FACTORY_DEFAULT_OP_MODE}' == 'router'
        Element Should Be Visible    ${STATUS_CONN_CLIENTS_TABLE_HEADER_ADDR_TYPE}
        Table Header Should Contain    ${STATUS_CONN_CLIENTS_TABLE}    Tipo
    ELSE
        Element Should Not Be Visible    ${STATUS_CONN_CLIENTS_TABLE_HEADER_ADDR_TYPE}
    END

Status Connected Clients Settings Should Be Factory Default
    Element Should Be Visible    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}
    Element Should Be Enabled    ${STATUS_CONN_CLIENTS_IFACE_FILTER_SELECT}

    Element Should Be Visible    ${STATUS_CONN_CLIENTS_SSID_FILTER_SELECT}
    Element Should Be Enabled    ${STATUS_CONN_CLIENTS_SSID_FILTER_SELECT}

    Element Should Be Visible    ${STATUS_CONN_CLIENTS_DISCONNECT_SELECTED_BUTTON}
    Element Should Be Disabled    ${STATUS_CONN_CLIENTS_DISCONNECT_SELECTED_BUTTON}

    Element Should Be Visible    ${STATUS_CONN_CLIENTS_BLOCK_SELECTED_BUTTON}
    Element Should Be Disabled    ${STATUS_CONN_CLIENTS_BLOCK_SELECTED_BUTTON}

    Element Should Be Visible    ${STATUS_CONN_CLIENTS_REFRESH_BUTTON}
    Element Should Be Enabled    ${STATUS_CONN_CLIENTS_REFRESH_BUTTON}

    IF    ${STATUS_CONN_CLIENTS_FACTORY_DEFAULT_AUTO_UPDATE} == ${TRUE}
        Checkbox Should Be Selected    ${STATUS_CONN_CLIENTS_AUTO_UPDATE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${STATUS_CONN_CLIENTS_AUTO_UPDATE_CHECKBOX}
    END

    Status Connected Clients Filters Should Be Factory Default
    Status Connected Clients Table Headers Should Be Correct
