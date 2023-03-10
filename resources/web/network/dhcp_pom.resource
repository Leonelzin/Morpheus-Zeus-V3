*** Settings ***
Documentation       Network (DHCP server) Resource File
...                 
...                 This resource file contains keywords related to network
...                 DHCP server settings webpage manipulation (page object
...                 model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/sidemenu_pom.resource
Resource            web/network/lan_pom.resource
Resource            web/network/operation_mode_pom.resource

*** Variables ***
${DHCP_SERVER_FACTORY_DEFAULT}                                      ${DUT}[profile][network][factory_default][dhcp_server]
${DHCP_SERVER_IPV4_FACTORY_DEFAULT_ENABLED}                         ${DHCP_SERVER_FACTORY_DEFAULT}[ipv4][enabled]
${DHCP_SERVER_IPV4_FACTORY_DEFAULT_ADDR_POOL_START}                 ${DHCP_SERVER_FACTORY_DEFAULT}[ipv4][address_pool_start]
${DHCP_SERVER_IPV4_FACTORY_DEFAULT_ADDR_POOL_END}                   ${DHCP_SERVER_FACTORY_DEFAULT}[ipv4][address_pool_end]
${DHCP_SERVER_IPV4_FACTORY_DEFAULT_LEASE_TIME}                      ${DHCP_SERVER_FACTORY_DEFAULT}[ipv4][lease_time]
${DHCP_SERVER_IPV4_FACTORY_DEFAULT_DNS_REBIND_ATK_PROT_ENABLED}     ${DHCP_SERVER_FACTORY_DEFAULT}[ipv4][dns_rebind_attack_protection_enabled]
${DHCP_SERVER_IPV6_FACTORY_DEFAULT_MODE}                            ${DHCP_SERVER_FACTORY_DEFAULT}[ipv6][mode]

${DHCP_SERVER_SUBMENU}                                              dhcp_submenu

${DHCP_SERVER_IPV4_STATUS_SELECT}                                   status_servidor_dhcp
${DHCP_SERVER_IPV4_STATUS_SELECT_ACTIVATED_VALUE}                   boolean:true
${DHCP_SERVER_IPV4_STATUS_SELECT_DEACTIVATED_VALUE}                 boolean:false

${DHCP_SERVER_IPV4_ADDR_POOL_START_INPUT}                           intervalo_start
${DHCP_SERVER_IPV4_ADDR_POOL_END_INPUT}                             intervalo_end
${DHCP_SERVER_IPV4_LEASE_TIME_INPUT}                                tempo_renovacao

${DHCP_SERVER_IPV4_DNS_REBIND_ATK_PROT_CHECKBOX}                    rebind_protection

${DHCP_SERVER_IPV4_STATIC_BINDING_TABLE}                            limit_band_table
${DHCP_SERVER_IPV4_STATIC_BINDING_TABLE_ADD_BUTTON}                 dhcp_add_button

${DHCP_SERVER_IPV6_MODE_SELECT}                                     status_servidor_dhcp_ipv6
${DHCP_SERVER_IPV6_MODE_SELECT_AUTO_STATELESS_VALUE}                string:stateless
${DHCP_SERVER_IPV6_MODE_SELECT_DEACTIVATED_VALUE}                   string:disabled

*** Keywords ***
Access Network DHCP Server Settings Page
    Open Network Menu
    Wait Until Element Is Visible    ${DHCP_SERVER_SUBMENU}
    Click Element    ${DHCP_SERVER_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${SAVE_SETTINGS_BUTTON}

DHCPv4 Server Address Pool Start Should Be "${pool_start_addr}"
    Element Attribute Value Should Be
    ...    ${DHCP_SERVER_IPV4_ADDR_POOL_START_INPUT}
    ...    value    ${pool_start_addr}

DHCPv4 Server Address Pool End Should Be "${pool_end_addr}"
    Element Attribute Value Should Be
    ...    ${DHCP_SERVER_IPV4_ADDR_POOL_END_INPUT}
    ...    value    ${pool_end_addr}

DHCPv4 Server Lease Time Should Be "${lease_time}"
    Element Attribute Value Should Be
    ...    ${DHCP_SERVER_IPV4_LEASE_TIME_INPUT}
    ...    value    ${lease_time}

All DHCPv4 Server Settings Should Be Disabled
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_STATUS_SELECT}
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_ADDR_POOL_START_INPUT}
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_ADDR_POOL_END_INPUT}
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_LEASE_TIME_INPUT}
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_DNS_REBIND_ATK_PROT_CHECKBOX}
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_STATIC_BINDING_TABLE_ADD_BUTTON}

All DHCPv4 Server Settings Should Be Disabled Except DHCPv4 Status
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_ADDR_POOL_START_INPUT}
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_ADDR_POOL_END_INPUT}
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_LEASE_TIME_INPUT}
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_DNS_REBIND_ATK_PROT_CHECKBOX}
    Element Should Be Disabled    ${DHCP_SERVER_IPV4_STATIC_BINDING_TABLE_ADD_BUTTON}

DHCP Server Settings Should Be Factory Default
    IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'bridge'
        IF    ${NETWORK_LAN_FACTORY_DEFAULT_IPV4_DYNAMIC_ADDR_ENABLED} == ${TRUE}
            All DHCPv4 Server Settings Should Be Disabled
        END
        Element Should Not Be Visible    ${DHCP_SERVER_IPV6_MODE_SELECT}
    END

    IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'router'
        IF    '${DHCP_SERVER_IPV6_FACTORY_DEFAULT_MODE}' == 'automatic_stateless'
            List Selection Should Be
            ...    ${DHCP_SERVER_IPV6_MODE_SELECT}
            ...    ${DHCP_SERVER_IPV6_MODE_SELECT_AUTO_STATELESS_VALUE}
        ELSE IF    '${DHCP_SERVER_IPV6_FACTORY_DEFAULT_MODE}' == 'deactivated'
            List Selection Should Be
            ...    ${DHCP_SERVER_IPV6_MODE_SELECT}
            ...    ${DHCP_SERVER_IPV6_MODE_SELECT_DEACTIVATED_VALUE}
        ELSE
            Fail    Could not determine DUT factory default DHCPv6 server mode (check DUT profile).
        END
    END

    IF    ${DHCP_SERVER_IPV4_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        List Selection Should Be
        ...    ${DHCP_SERVER_IPV4_STATUS_SELECT}
        ...    ${DHCP_SERVER_IPV4_STATUS_SELECT_ACTIVATED_VALUE}
    ELSE
        List Selection Should Be
        ...    ${DHCP_SERVER_IPV4_STATUS_SELECT}
        ...    ${DHCP_SERVER_IPV4_STATUS_SELECT_DEACTIVATED_VALUE}
        IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'router'
            All DHCPv4 Server Settings Should Be Disabled Except DHCPv4 Status
        END
    END

    DHCPv4 Server Address Pool Start Should Be "${DHCP_SERVER_IPV4_FACTORY_DEFAULT_ADDR_POOL_START}"
    DHCPv4 Server Address Pool End Should Be "${DHCP_SERVER_IPV4_FACTORY_DEFAULT_ADDR_POOL_END}"
    DHCPv4 Server Lease Time Should Be "${DHCP_SERVER_IPV4_FACTORY_DEFAULT_LEASE_TIME}"

    IF    ${DHCP_SERVER_IPV4_FACTORY_DEFAULT_DNS_REBIND_ATK_PROT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${DHCP_SERVER_IPV4_DNS_REBIND_ATK_PROT_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${DHCP_SERVER_IPV4_DNS_REBIND_ATK_PROT_CHECKBOX}
    END

    Element Should Be Visible    ${DHCP_SERVER_IPV4_STATIC_BINDING_TABLE}
    Element Should Be Visible    ${DHCP_SERVER_IPV4_STATIC_BINDING_TABLE_ADD_BUTTON}
