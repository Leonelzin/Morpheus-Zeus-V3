*** Settings ***
Documentation       Network (Static Routing) Resource File
...                 
...                 This resource file contains keywords related to network
...                 static routing settings webpage manipulation (page object
...                 model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/sidemenu_pom.resource

*** Variables ***
${NETWORK_ROUTES_FACTORY_DEFAULT}                               ${DUT}[profile][network][factory_default][static_routes]

${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_DESCRIPTION}              ${NETWORK_ROUTES_FACTORY_DEFAULT}[ipv4][description]
${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_DESTINATION_IP}           ${NETWORK_ROUTES_FACTORY_DEFAULT}[ipv4][destination_ip]
${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_DESTINATION_NETMASK}      ${NETWORK_ROUTES_FACTORY_DEFAULT}[ipv4][destination_netmask]
${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_GATEWAY}                  ${NETWORK_ROUTES_FACTORY_DEFAULT}[ipv4][gateway]
${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_INTERFACE}                ${NETWORK_ROUTES_FACTORY_DEFAULT}[ipv4][interface]

${NETWORK_ROUTES_SUBMENU}                                       routes_submenu

${NETWORK_ROUTES_IPV4_DESCRIPTION_INPUT}                        route_description

${NETWORK_ROUTES_IPV4_DESTINATION_IP_INPUT}                     route_target_ip
${NETWORK_ROUTES_IPV4_DESTINATION_NETMASK_INPUT}                route_target_netmask

${NETWORK_ROUTES_IPV4_GATEWAY_INPUT}                            route_gateway

${NETWORK_ROUTES_IPV4_IFACE_SELECT}                             route_interface
${NETWORK_ROUTES_IPV4_IFACE_SELECT_LAN_VALUE}                   string:lan
${NETWORK_ROUTES_IPV4_IFACE_SELECT_WAN_VALUE}                   string:wan

${NETWORK_ROUTES_IPV4_TABLE}                                    route_table

${NETWORK_ROUTES_IPV4_ADD_BUTTON}                               add_button

*** Keywords ***
Access Network Routes Settings Page
    Open Network Menu
    Wait Until Element Is Visible    ${NETWORK_ROUTES_SUBMENU}
    Click Element    ${NETWORK_ROUTES_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${SAVE_SETTINGS_BUTTON}

Network Route IPv4 Description Should Be "${description}"
    Element Attribute Value Should Be
    ...    ${NETWORK_ROUTES_IPV4_DESCRIPTION_INPUT}
    ...    value    ${description}

Network Route IPv4 Destination IP Should Be "${destination_ip}"
    Element Attribute Value Should Be
    ...    ${NETWORK_ROUTES_IPV4_DESTINATION_IP_INPUT}
    ...    value    ${destination_ip}

Network Route IPv4 Destination Netmask Should Be "${destination_netmask}"
    Element Attribute Value Should Be
    ...    ${NETWORK_ROUTES_IPV4_DESTINATION_NETMASK_INPUT}
    ...    value    ${destination_netmask}

Network Route IPv4 Gateway Should Be "${gateway}"
    Element Attribute Value Should Be
    ...    ${NETWORK_ROUTES_IPV4_GATEWAY_INPUT}
    ...    value    ${gateway}

Network Route IPv4 Interface Should Be "${interface}"
    List Selection Should Be
    ...    ${NETWORK_ROUTES_IPV4_IFACE_SELECT}
    ...    ${interface}

Static Routing Settings Should Be Factory Default
    Network Route IPv4 Description Should Be "${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_DESCRIPTION}"
    Network Route IPv4 Destination IP Should Be "${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_DESTINATION_IP}"
    Network Route IPv4 Destination Netmask Should Be "${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_DESTINATION_NETMASK}"
    Network Route IPv4 Gateway Should Be "${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_GATEWAY}"

    IF    '${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_INTERFACE}' == 'wan'
        List Selection Should Be
        ...    ${NETWORK_ROUTES_IPV4_IFACE_SELECT}
        ...    ${NETWORK_ROUTES_IPV4_IFACE_SELECT_WAN_VALUE}
    ELSE IF    '${NETWORK_ROUTES_FACTORY_DEFAULT_IPV4_INTERFACE}' == 'lan'
        List Selection Should Be
        ...    ${NETWORK_ROUTES_IPV4_IFACE_SELECT}
        ...    ${NETWORK_ROUTES_IPV4_IFACE_SELECT_LAN_VALUE}
    ELSE
        Fail    Could not determine DUT factory default network static route interface (check DUT profile).
    END

    Element Should Be Visible    ${NETWORK_ROUTES_IPV4_TABLE}
    Element Should Be Visible    ${NETWORK_ROUTES_IPV4_ADD_BUTTON}
    Element Should Be Enabled    ${NETWORK_ROUTES_IPV4_ADD_BUTTON}
