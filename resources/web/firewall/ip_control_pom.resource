*** Settings ***
Documentation       Firewall IP Control Resource File
...
...                 This resource file contains keywords related to firewall
...                 IP control WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${FIREWALL_IP_CONTROL_SUBMENU}                                                      controlByIP_submenu
${FIREWALL_IP_CONTROL_TYPE_SELECT}                                                  fw_ip_rule_control_type
${FIREWALL_IP_CONTROL_TYPE_SELECT_IP_VALUE}                                         string:ip
${FIREWALL_IP_CONTROL_TYPE_SELECT_NETWORK_VALUE}                                    string:network
${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}                                              fw_ip_rule_protocol
${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_VALUE}                                    string:tcp
${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_UDP_VALUE}                                    string:udp
${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_AND_UDP_VALUE}                            string:tcpudp
${FIREWALL_IP_CONTROL_ACTION_SELECT}                                                fw_ip_rule_action
${FIREWALL_IP_CONTROL_ACTION_SELECT_ALLOW_VALUE}                                    string:accept
${FIREWALL_IP_CONTROL_ACTION_SELECT_BLOCK_VALUE}                                    string:reject
${FIREWALL_IP_CONTROL_DESCRIPTON_INPUT}                                             fw_ip_rule_description
${FIREWALL_IP_CONTROL_NETWORK_IP_INPUT}                                             fw_ip_rule_ip
${FIREWALL_IP_CONTROL_NETMASK_INPUT}                                                fw_ip_rule_netmask
${FIREWALL_IP_CONTROL_NETWORK_START_IP_INPUT}                                       fw_ip_rule_start_ip
${FIREWALL_IP_CONTROL_NETWORK_END_IP_INPUT}                                         fw_ip_rule_end_ip
${FIREWALL_IP_CONTROL_ADD_RULE_BUTTON}                                              fw_ip_rule_add
${FIREWALL_IP_RULES_TABLE}                                                          ip_table
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_ENABLE_CHECKBOX}                              fw_ip_rule_table_cbox_
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_REMOVE_BUTTON}                                fw_ip_rule_table_delete_
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_DESCRIPTION_INPUT_CUSTOM_LOCATOR}             //*[@data-fw-ip-rule-table-desc-index]
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_DESCRIPTION_INPUT_INDEX_DATA_ATTRIBUTE}       data-fw-ip-rule-table-desc-index
# IP_1 input can be: Network/IP address
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_1_INPUT_CUSTOM_LOCATOR}                    //*[@data-fw-ip-rule-table-ip1-index]
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_1_INPUT_INDEX_DATA_ATTRIBUTE}              data-fw-ip-rule-table-ip1-index
# IP_2 input can be: Netmask or IP address (depending on which "control type" the user chooses)
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_2_INPUT_CUSTOM_LOCATOR}                    //*[@data-fw-ip-rule-table-ip2-index]
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_2_INPUT_INDEX_DATA_ATTRIBUTE}              data-fw-ip-rule-table-ip2-index
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_PROTOCOL_SELECT_CUSTOM_LOCATOR}               //*[@data-fw-ip-rule-table-proto-index]
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_PROTOCOL_SELECT_INDEX_DATA_ATTRIBUTE}         data-fw-ip-rule-table-proto-index
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_ACTION_SELECT_CUSTOM_LOCATOR}                 //*[@data-fw-ip-rule-table-action-index]
${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_ACTION_SELECT_INDEX_DATA_ATTRIBUTE}           data-fw-ip-rule-table-action-index

${FIREWALL_IP_CONTROL_FACTORY_DEFAULT}                                              ${DUT}[profile][firewall][ip_control][factory_default]
${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_CONTROL_TYPE}                                 ${FIREWALL_IP_CONTROL_FACTORY_DEFAULT}[control_type]
${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_PROTOCOL}                                     ${FIREWALL_IP_CONTROL_FACTORY_DEFAULT}[protocol]
${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_ACTION}                                       ${FIREWALL_IP_CONTROL_FACTORY_DEFAULT}[action]
${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_DESCRIPTION}                                  ${FIREWALL_IP_CONTROL_FACTORY_DEFAULT}[description]
${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_IP}                                           ${FIREWALL_IP_CONTROL_FACTORY_DEFAULT}[ip]
${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_NETWORK}                                      ${FIREWALL_IP_CONTROL_FACTORY_DEFAULT}[network]
${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_RANGE_IP_START}                               ${FIREWALL_IP_CONTROL_FACTORY_DEFAULT}[range_ip_start]
${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_RANGE_IP_END}                                 ${FIREWALL_IP_CONTROL_FACTORY_DEFAULT}[range_ip_end]

${FIREWALL_IP_CONTROL_TYPE_SELECT}                                                  fw_ip_rule_control_type
${FIREWALL_IP_CONTROL_TYPE_SELECT_IP_CONTROL_VALUE}                                 string:ip
${FIREWALL_IP_CONTROL_TYPE_SELECT_NETWORK_RANGE_CONTROL_VALUE}                      string:network
${FIREWALL_IP_CONTROL_TYPE_SELECT_IP_CONTROL_LABEL}                                 Controle por IP
${FIREWALL_IP_CONTROL_TYPE_SELECT_NETWORK_RANGE_CONTROL_LABEL}                      Controle por Faixa de Rede

${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}                                              fw_ip_rule_control_typefw_ip_rule_protocol
${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_VALUE}                                    string:tcp
${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_UDP_VALUE}                                    string:udp
${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_UDP_VALUE}                                string:tcpudp
${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_UDP_LABEL}                                TCP/UDP
${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_LABEL}                                    TCP
${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_UDP_LABEL}                                    UDP

${FIREWALL_IP_CONTROL_ACTION_SELECT}                                                fw_ip_rule_action
${FIREWALL_IP_CONTROL_ACTION_SELECT_ALLOW_VALUE}                                    string:accept
${FIREWALL_IP_CONTROL_ACTION_SELECT_BLOCK_VALUE}                                    string:reject
${FIREWALL_IP_CONTROL_ACTION_SELECT_ALLOW_LABEL}                                    Liberar
${FIREWALL_IP_CONTROL_ACTION_SELECT_BLOCK_LABEL}                                    Bloquear

${FIREWALL_IP_CONTROL_DESCRIPTION_INPUT}                                            fw_ip_rule_description

${FIREWALL_IP_CONTROL_IP_INPUT}                                                     fw_ip_rule_ip
${FIREWALL_IP_CONTROL_IP_START_INPUT}                                               fw_ip_rule_start_ip
${FIREWALL_IP_CONTROL_IP_END_INPUT}                                                 fw_ip_rule_end_ip
${FIREWALL_IP_CONTROL_GROUP_ADDON_INPUT}                                            xpath://*[@id="main"]/div[2]/div/div/div/div/div/div[1]/div/div/span
${FIREWALL_IP_CONTROL_NETWORK_INPUT}                                                fw_ip_rule_netmask

${FIREWALL_IP_CONTROL_IP_TABLE}                                                     ip_table

${FIREWALL_IP_CONTROL_ADD_BUTTON}                                                   fw_ip_rule_add

*** Keywords ***
Access Firewall IP Control Settings Page
    Open Firewall Menu
    Wait Until Element Is Visible    ${FIREWALL_IP_CONTROL_SUBMENU}
    Click Element    ${FIREWALL_IP_CONTROL_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "20" Seconds
    Wait Until Element Is Visible    ${FIREWALL_IP_CONTROL_TYPE_SELECT}

Set Firewall Control Type To IP Control
    Select from list by value    ${FIREWALL_IP_CONTROL_TYPE_SELECT}    ${FIREWALL_IP_CONTROL_TYPE_SELECT_IP_VALUE}

Set Firewall Control Type To Network
    Select from list by value    ${FIREWALL_IP_CONTROL_TYPE_SELECT}    ${FIREWALL_IP_CONTROL_TYPE_SELECT_NETWORK_VALUE}

Set Firewall Protocol To TCP
    Select from list by value    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_VALUE}

Set Firewall Protocol To UDP
    Select from list by value    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_UDP_VALUE}

Set Firewall Protocol To TCP/UDP
    Select from list by value    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_AND_UDP_VALUE}

Set Firewall Action To Allow
    Select from list by value    ${FIREWALL_IP_CONTROL_ACTION_SELECT}    ${FIREWALL_IP_CONTROL_ACTION_SELECT_ALLOW_VALUE}

Set Firewall Action To Block
    Select from list by value    ${FIREWALL_IP_CONTROL_ACTION_SELECT}    ${FIREWALL_IP_CONTROL_ACTION_SELECT_BLOCK_VALUE}

Set Firewall Description To "${value}"
    Input text    ${FIREWALL_IP_CONTROL_DESCRIPTON_INPUT}    ${value}

Set Firewall Network/IP To "${value}"
    Input text    ${FIREWALL_IP_CONTROL_NETWORK_IP_INPUT}    ${value}

Set Firewall Netmask To "${value}"
    Input text    ${FIREWALL_IP_CONTROL_NETMASK_INPUT}    ${value}

Set Firewall Network Start IP To "${value}"
    Input text    ${FIREWALL_IP_CONTROL_NETWORK_START_IP_INPUT}    ${value}

Set Firewall Network End IP To "${value}"
    Input text    ${FIREWALL_IP_CONTROL_NETWORK_END_IP_INPUT}    ${value}

Click Add Rule Button
    Click Button    ${FIREWALL_IP_CONTROL_ADD_RULE_BUTTON}

Get Firewall IP Rule Index By Description
    [Arguments]    ${description}
    ${rules_description}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_DESCRIPTION_INPUT_CUSTOM_LOCATOR}
    FOR    ${rule_description}    IN    @{rules_description}
        ${text}    Get Value    ${rule_description}
        IF    """${text}""" == """${description}"""
            ${rule_index}    Get Element Attribute    ${rule_description}
            ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_DESCRIPTION_INPUT_INDEX_DATA_ATTRIBUTE}
            Return From Keyword    ${rule_index}
        END
    END
    Return From Keyword    ${False}

Enable Firewall IP Rule At Table Index "${index}"
    Select Checkbox    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_ENABLE_CHECKBOX}${index}

Disable Firewall IP Rule At Table Index "${index}"
    Unselect Checkbox    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_ENABLE_CHECKBOX}${index}

Remove Firewall IP Rule At Table Index "${index}"
    Click Button    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_REMOVE_BUTTON}${index}

Set Firewall IP Rule Description At Table Index "${index}" To "${description}"
    ${rules_description}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_DESCRIPTION_INPUT_CUSTOM_LOCATOR}
    FOR    ${rule_description}    IN    @{rules_description}
        ${rule_index}    Get Element Attribute    ${rule_description}
        ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_DESCRIPTION_INPUT_INDEX_DATA_ATTRIBUTE}
        IF    """${rule_index}""" == """${index}"""
            Input Text    ${rule_description}    ${description}
            Return From Keyword
        END
    END
    Capture Page Screenshot
    Fail    Could not find a firewall IP rule at table index '${index}'

Set Firewall IP Rule IP/Network Address At Table Index "${index}" To "${value}"
    ${rules_ip}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_1_INPUT_CUSTOM_LOCATOR}
    FOR    ${rule_ip}    IN    @{rules_ip}
        ${rule_index}    Get Element Attribute    ${rule_ip}
        ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_1_INPUT_INDEX_DATA_ATTRIBUTE}
        IF    """${rule_index}""" == """${index}"""
            Input Text    ${rule_ip}    ${value}
            Return From Keyword
        END
    END
    Capture Page Screenshot
    Fail    Could not find a firewall IP rule at table index '${index}'

Set Firewall IP Rule Netmask At Table Index "${index}" To "${value}"
    ${rules_netmask}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_2_INPUT_CUSTOM_LOCATOR}
    FOR    ${rule_netmask}    IN    @{rules_netmask}
        ${rule_index}    Get Element Attribute    ${rule_netmask}
        ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_2_INPUT_INDEX_DATA_ATTRIBUTE}
        IF    """${rule_index}""" == """${index}"""
            Input Text    ${rule_netmask}    ${value}
            Return From Keyword
        END
    END
    Capture Page Screenshot
    Fail    Could not find a firewall IP rule at table index '${index}'

Set Firewall IP Rule Start IP Address At Table Index "${index}" To "${value}"
    ${rules_start_ip}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_1_INPUT_CUSTOM_LOCATOR}
    FOR    ${rule_start_ip}    IN    @{rules_start_ip}
        ${rule_index}    Get Element Attribute    ${rule_start_ip}
        ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_1_INPUT_INDEX_DATA_ATTRIBUTE}
        IF    """${rule_index}""" == """${index}"""
            Input Text    ${rule_start_ip}    ${value}
            Return From Keyword
        END
    END
    Capture Page Screenshot
    Fail    Could not find a firewall IP rule at table index '${index}'

Set Firewall IP Rule End IP Address At Table Index "${index}" To "${value}"
    ${rules_end_ip}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_2_INPUT_CUSTOM_LOCATOR}
    FOR    ${rule_end_ip}    IN    @{rules_end_ip}
        ${rule_index}    Get Element Attribute    ${rule_end_ip}
        ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_IP_2_INPUT_INDEX_DATA_ATTRIBUTE}
        IF    """${rule_index}""" == """${index}"""
            Input Text    ${rule_end_ip}    ${value}
            Return From Keyword
        END
    END
    Capture Page Screenshot
    Fail    Could not find a firewall IP rule at table index '${index}'

Set Firewall IP Rule Protocol At Table Index "${index}" To TCP
    ${rules_protocol}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_PROTOCOL_SELECT_CUSTOM_LOCATOR}
    FOR    ${rule_protocol}    IN    @{rules_protocol}
        ${rule_index}    Get Element Attribute    ${rule_protocol}
        ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_PROTOCOL_SELECT_INDEX_DATA_ATTRIBUTE}
        IF    """${rule_index}""" == """${index}"""
            Select From List By Value    ${rule_protocol}    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_VALUE}
            Return From Keyword
        END
    END
    Capture Page Screenshot
    Fail    Could not find a firewall IP rule at table index '${index}'

Set Firewall IP Rule Protocol At Table Index "${index}" To UDP
    ${rules_protocol}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_PROTOCOL_SELECT_CUSTOM_LOCATOR}
    FOR    ${rule_protocol}    IN    @{rules_protocol}
        ${rule_index}    Get Element Attribute    ${rule_protocol}
        ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_PROTOCOL_SELECT_INDEX_DATA_ATTRIBUTE}
        IF    """${rule_index}""" == """${index}"""
            Select From List By Value    ${rule_protocol}    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_UDP_VALUE}
            Return From Keyword
        END
    END
    Capture Page Screenshot
    Fail    Could not find a firewall IP rule at table index '${index}'

Set Firewall IP Rule Protocol At Table Index "${index}" To TCP/UDP
    ${rules_protocol}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_PROTOCOL_SELECT_CUSTOM_LOCATOR}
    FOR    ${rule_protocol}    IN    @{rules_protocol}
        ${rule_index}    Get Element Attribute    ${rule_protocol}
        ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_PROTOCOL_SELECT_INDEX_DATA_ATTRIBUTE}
        IF    """${rule_index}""" == """${index}"""
            Select From List By Value    ${rule_protocol}    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_AND_UDP_VALUE}
            Return From Keyword
        END
    END
    Capture Page Screenshot
    Fail    Could not find a firewall IP rule at table index '${index}'

Set Firewall IP Rule Action At Table Index "${index}" To Allow
    ${rules_action}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_ACTION_SELECT_CUSTOM_LOCATOR}
    FOR    ${rule_action}    IN    @{rules_action}
        ${rule_index}    Get Element Attribute    ${rule_action}
        ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_ACTION_SELECT_INDEX_DATA_ATTRIBUTE}
        IF    """${rule_index}""" == """${index}"""
            Select From List By Value    ${rule_action}    ${FIREWALL_IP_CONTROL_ACTION_SELECT_ALLOW_VALUE}
            Return From Keyword
        END
    END
    Capture Page Screenshot
    Fail    Could not find a firewall IP rule at table index '${index}'

Set Firewall IP Rule Action At Table Index "${index}" To Block
    ${rules_action}    Get Webelements    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_ACTION_SELECT_CUSTOM_LOCATOR}
    FOR    ${rule_action}    IN    @{rules_action}
        ${rule_index}    Get Element Attribute    ${rule_action}
        ...    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_ACTION_SELECT_INDEX_DATA_ATTRIBUTE}
        IF    """${rule_index}""" == """${index}"""
            Select From List By Value    ${rule_action}    ${FIREWALL_IP_CONTROL_ACTION_SELECT_BLOCK_VALUE}
            Return From Keyword
        END
    END
    Capture Page Screenshot
    Fail    Could not find a firewall IP rule at table index '${index}'

Firewall IP Control Description Should Be "${description}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_IP_CONTROL_DESCRIPTION_INPUT}
    ...    value    ${description}

Firewall IP Control IP Should Be "${ip}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_IP_CONTROL_IP_INPUT}
    ...    value    ${ip}

Firewall IP Control IP Start Should Be "${ip}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_IP_CONTROL_IP_INPUT}
    ...    value    ${ip}

Firewall IP Control IP End Should Be "${ip}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_IP_CONTROL_IP_INPUT}
    ...    value    ${ip}

Firewall IP Control Network Should Be "${network}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_IP_CONTROL_NETWORK_INPUT}
    ...    value    ${network}

Firewall IP Control Settings Should Be Factory Default
    IF    '${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_CONTROL_TYPE}' == 'ip'
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_TYPE_SELECT}
        ...    ${FIREWALL_IP_CONTROL_TYPE_SELECT_IP_CONTROL_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_TYPE_SELECT}
        ...    ${FIREWALL_IP_CONTROL_TYPE_SELECT_IP_CONTROL_LABEL}
        Element Should Be Visible    ${FIREWALL_IP_CONTROL_IP_INPUT}
        Element Should Be Enabled    ${FIREWALL_IP_CONTROL_IP_INPUT}
        Firewall IP Control IP Should Be "${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_IP}"
        Firewall IP Control Network Should Be "${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_NETWORK}"
        Element Should Not Be Visible    ${FIREWALL_IP_CONTROL_IP_START_INPUT}
        Element Should Not Be Visible    ${FIREWALL_IP_CONTROL_IP_END_INPUT}
    ELSE IF    '${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_CONTROL_TYPE}' == 'range'
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_TYPE_SELECT}
        ...    ${FIREWALL_IP_CONTROL_TYPE_SELECT_NETWORK_RANGE_CONTROL_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_TYPE_SELECT}
        ...    ${FIREWALL_IP_CONTROL_TYPE_SELECT_NETWORK_RANGE_CONTROL_LABEL}
        Element Should Not Be Visible    ${FIREWALL_IP_CONTROL_IP_INPUT}
        Element Should Be Enabled    ${FIREWALL_IP_CONTROL_IP_START_INPUT}
        Element Should Be Enabled    ${FIREWALL_IP_CONTROL_IP_END_INPUT}
        Firewall IP Control IP Start Should Be "${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_RANGE_IP_START}"
        Firewall IP Control IP End Should Be "${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_RANGE_IP_END}"
        Element Should Be Visible    ${FIREWALL_IP_CONTROL_IP_START_INPUT}
        Element Should Be Visible    ${FIREWALL_IP_CONTROL_IP_END_INPUT}
    ELSE 
        Fail
        ...    Could not determine DUT factory default firewall type.
    END

    IF    '${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_PROTOCOL}' == 'TCP'
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_LABEL}
    ELSE IF    '${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_PROTOCOL}' == 'UDP'
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_UDP_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_UDP_LABEL}
    ELSE IF    '${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_PROTOCOL}' == 'tcp/udp'
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_UDP_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT}
        ...    ${FIREWALL_IP_CONTROL_PROTOCOL_SELECT_TCP_UDP_LABEL}
    ELSE 
        Fail
        ...    Could not determine DUT factory default firewall protocol.
    END

    IF    '${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_ACTION}' == 'allow'
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_ACTION_SELECT}
        ...    ${FIREWALL_IP_CONTROL_ACTION_SELECT_ALLOW_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_ACTION_SELECT}
        ...    ${FIREWALL_IP_CONTROL_ACTION_SELECT_ALLOW_LABEL}
    ELSE IF    '${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_ACTION}' == 'block'
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_ACTION_SELECT}
        ...    ${FIREWALL_IP_CONTROL_ACTION_SELECT_BLOCK_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_IP_CONTROL_ACTION_SELECT}
        ...    ${FIREWALL_IP_CONTROL_ACTION_SELECT_BLOCK_LABEL}
    ELSE 
        Fail
        ...    Could not determine DUT factory default firewall action.
    END

    Firewall IP Control Description Should Be "${FIREWALL_IP_CONTROL_FACTORY_DEFAULT_DESCRIPTION}"

    Element Should Be Visible    ${FIREWALL_IP_CONTROL_GROUP_ADDON_INPUT}
    Element Should Be Visible    ${FIREWALL_IP_CONTROL_IP_TABLE}
    Element Should Be Visible    ${FIREWALL_IP_CONTROL_ADD_BUTTON}
    Element Should Be Enabled    ${FIREWALL_IP_CONTROL_ADD_BUTTON}

    Element Should Not Be Visible    ${FIREWALL_IP_CONTROL_RULE_TABLE_CELL_REMOVE_BUTTON}0
