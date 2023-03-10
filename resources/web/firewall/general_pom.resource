*** Settings ***
Documentation       Firewall Resource File
...                 
...                 This resource file contains keywords related to firewall
...                 (general settings) WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/network/operation_mode_pom.resource

*** Variables ***
${FIREWALL_GENERAL_SUBMENU}                                                     firewallGeral_submenu

${FIREWALL_ENABLE_CHECKBOX}                                                     firewall_enable
${FIREWALL_WAN_PING_ENABLE_CHECKBOX}                                            wan_ping_enable
${FIREWALL_UPNP_ENABLE_CHECKBOX}                                                upnp_enable

${FIREWALL_ICMP_FLOOD_PROTECT_CHECKBOX}                                         firewall_icmp_flood
${FIREWALL_TCP_SYN_FLOOD_PROTECT_CHECKBOX}                                      firewall_tcp_syn_flood
${FIREWALL_UDP_FLOOD_PROTECT_CHECKBOX}                                          firewall_udp_flood
${FIREWALL_TCP_INVALID_FLAGS_PORT_SCAN_PROTECT_CHECKBOX}                        firewall_portscan_protect
${FIREWALL_IP_SPOOFING_PROTECT_CHECKBOX}                                        firewall_spoof_protect
${FIREWALL_INVALID_PACKETS_PROTECT_CHECKBOX}                                    firewall_drop_invalid

${FIREWALL_FACTORY_DEFAULT}                                                     ${DUT}[profile][firewall][factory_default]
${FIREWALL_FACTORY_DEFAULT_ENABLED}                                             ${FIREWALL_FACTORY_DEFAULT}[enabled]
${FIREWALL_FACTORY_DEFAULT_UPNP_ENABLED}                                        ${FIREWALL_FACTORY_DEFAULT}[upnp_enabled]
${FIREWALL_FACTORY_DEFAULT_WAN_PING_ENABLED}                                    ${FIREWALL_FACTORY_DEFAULT}[wan_ping_enabled]
${FIREWALL_FACTORY_DEFAULT_ICMP_FLOOD_PROTECT_ENABLED}                          ${FIREWALL_FACTORY_DEFAULT}[icmp_flood_protection_enabled]
${FIREWALL_FACTORY_DEFAULT_TCP_SYN_FLOOD_PROTECT_ENABLED}                       ${FIREWALL_FACTORY_DEFAULT}[tcp_syn_flood_protection_enabled]
${FIREWALL_FACTORY_DEFAULT_UDP_FLOOD_PROTECT_ENABLED}                           ${FIREWALL_FACTORY_DEFAULT}[udp_flood_protection_enabled]
${FIREWALL_FACTORY_DEFAULT_TCP_INVALID_FLAGS_AND_PORT_SCAN_PROTECT_ENABLED}     ${FIREWALL_FACTORY_DEFAULT}[tcp_invalid_flags_and_port_scan_protection_enabled]
${FIREWALL_FACTORY_DEFAULT_IP_SPOOFING_PROTECT_ENABLED}                         ${FIREWALL_FACTORY_DEFAULT}[ip_spoofing_protection_enabled]
${FIREWALL_FACTORY_DEFAULT_INVALID_PACKETS_PROTECT_ENABLED}                     ${FIREWALL_FACTORY_DEFAULT}[invalid_packets_protection_enabled]

*** Keywords ***
Access Firewall General Settings Page
    Open Firewall Menu
    Wait Until Element Is Visible    ${FIREWALL_GENERAL_SUBMENU}
    Click Element    ${FIREWALL_GENERAL_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "20" Seconds
    Wait Until Element Is Visible    ${FIREWALL_ENABLE_CHECKBOX}

Select Firewall Enable Checkbox
    Select Checkbox    ${FIREWALL_ENABLE_CHECKBOX}

Unselect Firewall Enable Checkbox
    Unselect Checkbox    ${FIREWALL_ENABLE_CHECKBOX}

Firewall Enable Checkbox Should Be Selected
    Checkbox Should Be Selected    ${FIREWALL_ENABLE_CHECKBOX}

Firewall Enable Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${FIREWALL_ENABLE_CHECKBOX}

Select Firewall WAN Ping Enable Checkbox
    Select Checkbox    ${FIREWALL_WAN_PING_ENABLE_CHECKBOX}

Unselect Firewall WAN Ping Enable Checkbox
    Unselect Checkbox    ${FIREWALL_WAN_PING_ENABLE_CHECKBOX}

Firewall WAN Ping Enable Checkbox Should Be Visible
    Element Should Be Visible    ${FIREWALL_WAN_PING_ENABLE_CHECKBOX}

Firewall WAN Ping Enable Checkbox Should Not Be Visible
    Element Should Not Be Visible    ${FIREWALL_WAN_PING_ENABLE_CHECKBOX}

Firewall WAN Ping Enable Checkbox Should Be Selected
    Checkbox Should Be Selected    ${FIREWALL_WAN_PING_ENABLE_CHECKBOX}

Firewall WAN Ping Enable Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${FIREWALL_WAN_PING_ENABLE_CHECKBOX}

Select Firewall UPNP Enable Checkbox
    Select Checkbox    ${FIREWALL_UPNP_ENABLE_CHECKBOX}

Unselect Firewall UPNP Enable Checkbox
    Unselect Checkbox    ${FIREWALL_UPNP_ENABLE_CHECKBOX}

Firewall UPNP Enable Checkbox Should Be Visible
    Element Should Be Visible    ${FIREWALL_UPNP_ENABLE_CHECKBOX}

Firewall UPNP Enable Checkbox Should Not Be Visible
    Element Should Not Be Visible    ${FIREWALL_UPNP_ENABLE_CHECKBOX}

Firewall UPNP Enable Checkbox Should Be Selected
    Checkbox Should Be Selected    ${FIREWALL_UPNP_ENABLE_CHECKBOX}

Firewall UPNP Enable Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${FIREWALL_UPNP_ENABLE_CHECKBOX}

Select Firewall ICMP Flood Protection Checkbox
    Select Checkbox    ${FIREWALL_ICMP_FLOOD_PROTECT_CHECKBOX}

Unselect Firewall ICMP Flood Protection Checkbox
    Unselect Checkbox    ${FIREWALL_ICMP_FLOOD_PROTECT_CHECKBOX}

Firewall ICMP Flood Protection Checkbox Should Be Selected
    Checkbox Should Be Selected    ${FIREWALL_ICMP_FLOOD_PROTECT_CHECKBOX}

Firewall ICMP Flood Protection Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${FIREWALL_ICMP_FLOOD_PROTECT_CHECKBOX}

Select Firewall TCP SYN Flood Protection Checkbox
    Select Checkbox    ${FIREWALL_TCP_SYN_FLOOD_PROTECT_CHECKBOX}

Unselect Firewall TCP SYN Flood Protection Checkbox
    Unselect Checkbox    ${FIREWALL_TCP_SYN_FLOOD_PROTECT_CHECKBOX}

Firewall TCP SYN Flood Protection Checkbox Should Be Selected
    Checkbox Should Be Selected    ${FIREWALL_TCP_SYN_FLOOD_PROTECT_CHECKBOX}

Firewall TCP SYN Flood Protection Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${FIREWALL_TCP_SYN_FLOOD_PROTECT_CHECKBOX}

Select Firewall UDP Flood Protection Checkbox
    Select Checkbox    ${FIREWALL_UDP_FLOOD_PROTECT_CHECKBOX}

Unselect Firewall UDP Flood Protection Checkbox
    Unselect Checkbox    ${FIREWALL_UDP_FLOOD_PROTECT_CHECKBOX}

Firewall UDP Flood Protection Checkbox Should Be Selected
    Checkbox Should Be Selected    ${FIREWALL_UDP_FLOOD_PROTECT_CHECKBOX}

Firewall UDP Flood Protection Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${FIREWALL_UDP_FLOOD_PROTECT_CHECKBOX}

Select Firewall TCP Invalid Flag And Port Scan Protection Checkbox
    Select Checkbox    ${FIREWALL_TCP_INVALID_FLAGS_PORT_SCAN_PROTECT_CHECKBOX}

Unselect Firewall TCP Invalid Flag And Port Scan Protection Checkbox
    Unselect Checkbox    ${FIREWALL_TCP_INVALID_FLAGS_PORT_SCAN_PROTECT_CHECKBOX}

Firewall TCP Invalid Flag And Port Scan Protection Checkbox Should Be Selected
    Checkbox Should Be Selected    ${FIREWALL_TCP_INVALID_FLAGS_PORT_SCAN_PROTECT_CHECKBOX}

Firewall TCP Invalid Flag And Port Scan Protection Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${FIREWALL_TCP_INVALID_FLAGS_PORT_SCAN_PROTECT_CHECKBOX}

Select Firewall IP Spoofing Protection Checkbox
    Select Checkbox    ${FIREWALL_IP_SPOOFING_PROTECT_CHECKBOX}

Unselect Firewall IP Spoofing Protection Checkbox
    Unselect Checkbox    ${FIREWALL_IP_SPOOFING_PROTECT_CHECKBOX}

Firewall IP Spoofing Protection Checkbox Should Be Selected
    Checkbox Should Be Selected    ${FIREWALL_IP_SPOOFING_PROTECT_CHECKBOX}

Firewall IP Spoofing Protection Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${FIREWALL_IP_SPOOFING_PROTECT_CHECKBOX}

Select Firewall Invalid Packets Protection Checkbox
    Select Checkbox    ${FIREWALL_INVALID_PACKETS_PROTECT_CHECKBOX}

Unselect Firewall Invalid Packets Protection Checkbox
    Unselect Checkbox    ${FIREWALL_INVALID_PACKETS_PROTECT_CHECKBOX}

Firewall Invalid Packets Protection Checkbox Should Be Selected
    Checkbox Should Be Selected    ${FIREWALL_INVALID_PACKETS_PROTECT_CHECKBOX}

Firewall Invalid Packets Protection Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${FIREWALL_INVALID_PACKETS_PROTECT_CHECKBOX}

Firewall General Settings Should Be Factory Default
    IF    ${FIREWALL_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${FIREWALL_ENABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${FIREWALL_ENABLE_CHECKBOX}
    END

    IF    '${NETWORK_FACTORY_DEFAULT_OP_MODE}' == 'router'
        IF    ${FIREWALL_FACTORY_DEFAULT_UPNP_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${FIREWALL_UPNP_ENABLE_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${FIREWALL_UPNP_ENABLE_CHECKBOX}
        END

        IF    ${FIREWALL_FACTORY_DEFAULT_WAN_PING_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${FIREWALL_WAN_PING_ENABLE_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${FIREWALL_WAN_PING_ENABLE_CHECKBOX}
        END
    END

Firewall General Security Options Should Be Factory Default
    IF    ${FIREWALL_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        IF    ${FIREWALL_FACTORY_DEFAULT_ICMP_FLOOD_PROTECT_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${FIREWALL_ICMP_FLOOD_PROTECT_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${FIREWALL_ICMP_FLOOD_PROTECT_CHECKBOX}
        END

        IF    ${FIREWALL_FACTORY_DEFAULT_TCP_SYN_FLOOD_PROTECT_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${FIREWALL_TCP_SYN_FLOOD_PROTECT_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${FIREWALL_TCP_SYN_FLOOD_PROTECT_CHECKBOX}
        END

        IF    ${FIREWALL_FACTORY_DEFAULT_UDP_FLOOD_PROTECT_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${FIREWALL_UDP_FLOOD_PROTECT_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${FIREWALL_UDP_FLOOD_PROTECT_CHECKBOX}
        END

        IF    ${FIREWALL_FACTORY_DEFAULT_TCP_INVALID_FLAGS_AND_PORT_SCAN_PROTECT_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${FIREWALL_TCP_INVALID_FLAGS_PORT_SCAN_PROTECT_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${FIREWALL_TCP_INVALID_FLAGS_PORT_SCAN_PROTECT_CHECKBOX}
        END

        IF    ${FIREWALL_FACTORY_DEFAULT_IP_SPOOFING_PROTECT_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${FIREWALL_IP_SPOOFING_PROTECT_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${FIREWALL_IP_SPOOFING_PROTECT_CHECKBOX}
        END

        IF    ${FIREWALL_FACTORY_DEFAULT_INVALID_PACKETS_PROTECT_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${FIREWALL_INVALID_PACKETS_PROTECT_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${FIREWALL_INVALID_PACKETS_PROTECT_CHECKBOX}
        END
    ELSE
        Element Should Not Be Visible    ${FIREWALL_ICMP_FLOOD_PROTECT_CHECKBOX}
        Element Should Not Be Visible    ${FIREWALL_TCP_SYN_FLOOD_PROTECT_CHECKBOX}
        Element Should Not Be Visible    ${FIREWALL_UDP_FLOOD_PROTECT_CHECKBOX}
        Element Should Not Be Visible    ${FIREWALL_TCP_INVALID_FLAGS_PORT_SCAN_PROTECT_CHECKBOX}
        Element Should Not Be Visible    ${FIREWALL_IP_SPOOFING_PROTECT_CHECKBOX}
        Element Should Not Be Visible    ${FIREWALL_INVALID_PACKETS_PROTECT_CHECKBOX}
    END
