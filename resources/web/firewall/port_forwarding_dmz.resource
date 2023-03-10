*** Settings ***
Documentation       Firewall Port Forwarding Resource File
...
...                 This resource file contains keywords related to firewall
...                 port forwarding WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${FIREWALL_DMZ_FACTORY_DEFAULT}                                                 ${DUT}[profile][firewall][port_forwarding][host_dmz][factory_default]
${FIREWALL_DMZ_FACTORY_DEFAULT_HOST_DESCRIPTION}                                ${FIREWALL_DMZ_FACTORY_DEFAULT}[host_description]
${FIREWALL_DMZ_FACTORY_DEFAULT_HOST_REDIRECT_IP}                                ${FIREWALL_DMZ_FACTORY_DEFAULT}[redirect_ip]

${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT}                              ${DUT}[profile][firewall][port_forwarding][simple][factory_default]
${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_DESCRIPTION}                  ${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT}[simple_description]
${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_PORT_RANGE_START}             ${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT}[port_range_start]
${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_PORT_RANGE_END}               ${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT}[port_range_end]
${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_PROTOCOL}                     ${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT}[protocol]
${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_REDIRECT_IP}                  ${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT}[redirect_ip]

${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT}                            ${DUT}[profile][firewall][port_forwarding][advanced][factory_default]
${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_DESCRIPTION}                ${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT}[advanced_description]
${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_IP_SOURCE_NETWORK}          ${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT}[ip_source_network]
${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_OUTPORT_PORT}               ${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT}[outport_port]
${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_INTERNAL_IP}                ${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT}[internal_ip]
${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_INTERNAL_PORT}              ${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT}[internal_port]
${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_PROTOCOL}                   ${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT}[protocol]

${FIREWALL_PORT_FORWARDING_SUBMENU}                                             redirectionByPortDMZ_submenu
${FIREWALL_DMZ_HOST_DESCRIPTION_INPUT}                                          host_dmz_description
${FIREWALL_DMZ_FORWARDING_IP_ADDRESS_INPUT}                                     redirect_ip
${FIREWALL_SIMPLE_PORT_FORWARDING_DESCRIPTION_INPUT}                            simple_description
${FIREWALL_SIMPLE_PORT_FORWARDING_INTERVAL_START_INPUT}                         simple_ports_interval_start
${FIREWALL_SIMPLE_PORT_FORWARDING_INTERVAL_END_INPUT}                           simple_ports_interval_end
${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT}                              simple_protocol
${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_TCP_VALUE}                    string:tcp
${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_UDP_VALUE}                    string:udp
${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_VALUE}            string:tcpudp
${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_TCP_LABEL}                    TCP
${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_UDP_LABEL}                    UDP
${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_LABEL}            TCP/UDP
${FIREWALL_SIMPLE_PORT_FORWARDING_IP_ADDRESS_INPUT}                             simple_redirect_ip
${FIREWALL_SIMPLE_PORT_FORWARDING_TABLE}                                        simple_table
${FIREWALL_SIMPLE_PORT_FORWARDING_ADD_BUTTON}                                   add_simple_button
#TODO: map firewall rules table variables below
${FIREWALL_SIMPLE_PORT_FORWARDING_ENABLE_TABLE_CELL_CHECKBOX}                   TODO
${FIREWALL_SIMPLE_PORT_FORWARDING_DESCRIPTION_TABLE_CELL_INPUT}                 TODO
${FIREWALL_SIMPLE_PORT_FORWARDING_PORT_TABLE_CELL_INPUT}                        TODO
${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_TABLE_CELL_SELECT}                   TODO
${FIREWALL_SIMPLE_PORT_FORWARDING_INTERNAL_IP_ADDRESS_TABLE_CELL_SELECT}        TODO
${FIREWALL_ADVANCED_PORT_FORWARDING_DESCRIPTION_INPUT}                          advanced_description
${FIREWALL_ADVANCED_PORT_FORWARDING_EXTERNAL_IP_ADDRESS_INPUT}                  advanced_input_ip
${FIREWALL_ADVANCED_PORT_FORWARDING_EXTERNAL_PORT_INPUT}                        advanced_input_port
${FIREWALL_ADVANCED_PORT_FORWARDING_INTERNAL_IP_ADDRESS_INPUT}                  advanced_output_ip
${FIREWALL_ADVANCED_PORT_FORWARDING_INTERNAL_PORT_INPUT}                        advanced_output_port
${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT}                            advanced_protocol
${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP_VALUE}                  string:tcp
${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_UDP_VALUE}                  string:udp
${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_VALUE}          string:tcpudp
${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP__LABEL}                 TCP
${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_UDP_LABEL}                  UDP
${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_LABEL}          TCP/UDP
${FIREWALL_ADVANCED_PORT_FORWARDING_ADD_BUTTON}                                 add_advanced_button
${FIREWALL_SIMPLE_PORT_FORWARDING_TABLE}                                        advanced_table
#TODO: map firewall rules table variables below
${FIREWALL_ADVANCED_PORT_FORWARDING_ENABLE_TABLE_CELL_CHECKBOX}                 TODO
${FIREWALL_ADVANCED_PORT_FORWARDING_DESCRIPTION_TABLE_CELL_INPUT}               TODO
${FIREWALL_ADVANCED_PORT_FORWARDING_EXTERNAL_IP_ADDRESS_TABLE_CELL_INPUT}       TODO
${FIREWALL_ADVANCED_PORT_FORWARDING_EXTERNAL_PORT_TABLE_CELL_INPUT}             TODO
${FIREWALL_ADVANCED_PORT_FORWARDING_INTERNAL_IP_ADDRESS_TABLE_CELL_INPUT}       TODO
${FIREWALL_ADVANCED_PORT_FORWARDING_INTERNAL_PORT_TABLE_CELL_INPUT}             TODO
${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_TABLE_CELL_SELECT}                 TODO

*** Keywords ***
Access Firewall Port Forwarding Settings Page
    [Arguments]    ${wait_for_element_visibility}=${True}
    Open Firewall Menu
    Wait Until Element Is Visible    ${FIREWALL_PORT_FORWARDING_SUBMENU}
    Click Element    ${FIREWALL_PORT_FORWARDING_SUBMENU}
    IF    ${wait_for_element_visibility} == ${True}
        Wait For WEB Message To Disappear Or Timeout After "20" Seconds
        Wait Until Element Is Visible    ${FIREWALL_DMZ_HOST_DESCRIPTION_INPUT}
    END

Set Firewall DMZ Description To "${value}"
    Input text    ${FIREWALL_DMZ_HOST_DESCRIPTION_INPUT}    ${value}

Set Firewall DMZ Forwarding IP Address To "${value}"
    Input text    ${FIREWALL_DMZ_FORWARDING_IP_ADDRESS_INPUT}    ${value}

Set Firewall Simple Port Description To "${value}"
    Input text    ${FIREWALL_SIMPLE_PORT_FORWARDING_DESCRIPTION_INPUT}    ${value}

Set Firewall Simple Port Interval Start To "${value}"
    Input text    ${FIREWALL_SIMPLE_PORT_FORWARDING_INTERVAL_START_INPUT}    ${value}

Set Firewall Simple Port Interval End To "${value}"
    Input text    ${FIREWALL_SIMPLE_PORT_FORWARDING_INTERVAL_END_INPUT}    ${value}

Set Firewall Simple Port Protocol To TCP
    Select from list by value    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT}
    ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_TCP_VALUE}

Set Firewall Simple Port Protocol To UDP
    Select from list by value    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT}
    ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_UDP_VALUE}

Set Firewall Simple Port Protocol To TCP/UDP
    Select from list by value    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT}
    ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_VALUE}

Set Firewall Simple Port Forwarding IP Address To "${value}"
    Input text    ${FIREWALL_SIMPLE_PORT_FORWARDING_IP_ADDRESS_INPUT}    ${value}

Click Firewall Simple Port Forwarding Add Button
    Click Button    ${FIREWALL_SIMPLE_PORT_FORWARDING_ADD_BUTTON}

Set Firewall Advanced Port Description To "${value}"
    Input text    ${FIREWALL_ADVANCED_PORT_FORWARDING_DESCRIPTION_INPUT}    ${value}

Set Firewall Advanced Port Forwarding External IP Address To "${value}"
    Input text    ${FIREWALL_ADVANCED_PORT_FORWARDING_EXTERNAL_IP_ADDRESS_INPUT}    ${value}

Set Firewall Advanced Port External Port To "${value}"
    Input text    ${FIREWALL_ADVANCED_PORT_FORWARDING_EXTERNAL_PORT_INPUT}    ${value}

Set Firewall Advanced Port Forwarding Internal IP Address To "${value}"
    Input text    ${FIREWALL_ADVANCED_PORT_FORWARDING_INTERNAL_IP_ADDRESS_INPUT}    ${value}

Set Firewall Advanced Port Internal Port To "${value}"
    Input text    ${FIREWALL_ADVANCED_PORT_FORWARDING_INTERNAL_PORT_INPUT}    ${value}

Set Firewall Advanced Port Protocol To TCP
    Select from list by value    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT}
    ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP_VALUE}

Set Firewall Advanced Port Protocol To UDP
    Select from list by value    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT}
    ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_UDP_VALUE}

Set Firewall Advanced Port Protocol To TCP/UDP
    Select from list by value    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT}
    ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_VALUE}

Click Firewall Advanced Port Forwarding Add Button
    Click Button    ${FIREWALL_ADVANCED_PORT_FORWARDING_ADD_BUTTON}

Firewall Host DMZ Description Should Be "${host_description}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_DMZ_HOST_DESCRIPTION_INPUT}
    ...    value    ${host_description}

Firewall Host DMZ Redirect IP Should Be "${redirect_ip}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_DMZ_FORWARDING_IP_ADDRESS_INPUT}
    ...    value    ${redirect_ip}

Firewall DMZ Simple Description Should Be "${simple_description}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_DESCRIPTION_INPUT}
    ...    value    ${simple_description}

Firewall DMZ Simple Port Range Start Should Be "${port_range_start}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_INTERVAL_START_INPUT}
    ...    value    ${port_range_start}

Firewall DMZ Simple Port Range End Should Be "${port_range_end}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_INTERVAL_START_INPUT}
    ...    value    ${port_range_end}

Firewall DMZ Simple Redirect IP Should Be "${redirect_ip}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_IP_ADDRESS_INPUT}
    ...    value    ${redirect_ip}

Firewall DMZ Advanced Description Should Be "${advanced_description}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_DESCRIPTION_INPUT}
    ...    value    ${advanced_description}

Firewall DMZ Advanced IP Source Network Should Be "${ip_source_network}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_EXTERNAL_IP_ADDRESS_INPUT}
    ...    value    ${ip_source_network}

Firewall DMZ Advanced Outport Port Should Be "${outport_port}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_INTERNAL_IP_ADDRESS_INPUT}
    ...    value    ${outport_port}

Firewall DMZ Advanced Internal IP Should Be "${internal_ip}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_INTERNAL_IP_ADDRESS_INPUT}
    ...    value    ${internal_ip}

Firewall DMZ Advanced Internal Port Should Be "${internal_port}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_INTERNAL_PORT_INPUT}
    ...    value    ${internal_port}

Firewall Port Forwarding DMZ Settings Should Be Factory Default
    Firewall Host DMZ Description Should Be "${FIREWALL_DMZ_FACTORY_DEFAULT_HOST_DESCRIPTION}"

    Firewall Host DMZ Redirect IP Should Be "${FIREWALL_DMZ_FACTORY_DEFAULT_HOST_REDIRECT_IP}"

    Firewall DMZ Simple Description Should Be "${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_DESCRIPTION}"

    Firewall DMZ Simple Port Range Start Should Be "${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_PORT_RANGE_START}"
    Firewall DMZ Simple Port Range End Should Be "${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_PORT_RANGE_END}"

    IF    '${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_PROTOCOL}' == 'tcp'
        List Selection Should Be
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_TCP_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_TCP_LABEL}
    ELSE IF    '${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_PROTOCOL}' == 'udp'
        List Selection Should Be
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_UDP_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT__UDP_LABEL}
    ELSE IF    '${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_PROTOCOL}' == 'tcp/udp'
        List Selection Should Be
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_SIMPLE_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_LABEL}
    ELSE 
        Fail
        ...    Could not determine DUT factory default firewall protocol.
    END

    Firewall DMZ Simple Redirect IP Should Be "${FIREWALL_PORT_FORWARDING_SIMPLE_FACTORY_DEFAULT_REDIRECT_IP}"

    Element Should Be Visible    ${FIREWALL_SIMPLE_PORT_FORWARDING_TABLE}

    Element Should Be Visible    ${FIREWALL_SIMPLE_PORT_FORWARDING_ADD_BUTTON}
    Element Should Be Enabled    ${FIREWALL_SIMPLE_PORT_FORWARDING_ADD_BUTTON}

    Firewall DMZ Advanced Description Should Be "${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_DESCRIPTION}"

    Firewall DMZ Advanced IP Source Network Should Be "${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_IP_SOURCE_NETWORK}"

    Firewall DMZ Advanced Outport Port Should Be "${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_OUTPORT_PORT}"

    Firewall DMZ Advanced Internal IP Should Be "${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_INTERNAL_IP}"

    Firewall DMZ Advanced Internal Port Should Be "${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_INTERNAL_PORT}"

    IF    '${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_PROTOCOL}' == 'tcp'
        List Selection Should Be
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_LABEL}
    ELSE IF    '${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_PROTOCOL}' == 'udp'
        List Selection Should Be
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_UDP_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_LABEL}
    ELSE IF    '${FIREWALL_PORT_FORWARDING_ADVANCED_FACTORY_DEFAULT_PROTOCOL}' == 'tcp/udp'
        List Selection Should Be
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT}
        ...    ${FIREWALL_ADVANCED_PORT_FORWARDING_PROTOCOL_SELECT_TCP_AND_UDP_LABEL}
    ELSE 
        Fail
        ...    Could not determine DUT factory default firewall protocol.
    END

    Element Should Be Visible    ${FIREWALL_SIMPLE_PORT_FORWARDING_TABLE}

    Element Should Be Visible    ${FIREWALL_ADVANCED_PORT_FORWARDING_ADD_BUTTON}
    Element Should Be Enabled    ${FIREWALL_ADVANCED_PORT_FORWARDING_ADD_BUTTON}
