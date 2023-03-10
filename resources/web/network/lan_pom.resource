*** Settings ***
Documentation       Network (LAN) Resource File
...                 
...                 This resource file contains keywords related to network LAN
...                 settings webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/network/operation_mode_pom.resource

*** Variables ***
${NETWORK_LAN_FACTORY_DEFAULT}                              ${DUT}[profile][network][factory_default][lan]
${NETWORK_LAN_FACTORY_DEFAULT_IPV4_DYNAMIC_ADDR_ENABLED}    ${NETWORK_LAN_FACTORY_DEFAULT}[ipv4_dynamic_addressing_enabled]
${NETWORK_LAN_FACTORY_DEFAULT_IPV4_ADDR}                    ${NETWORK_LAN_FACTORY_DEFAULT}[ipv4_address]
${NETWORK_LAN_FACTORY_DEFAULT_IPV4_SUBNET_MASK}             ${NETWORK_LAN_FACTORY_DEFAULT}[ipv4_subnet_mask]
${NETWORK_LAN_FACTORY_DEFAULT_IPV4_DEFAULT_GATEWAY}         ${NETWORK_LAN_FACTORY_DEFAULT}[ipv4_default_gateway]
${NETWORK_LAN_FACTORY_DEFAULT_IPV6_ADDR_TYPE}               ${NETWORK_LAN_FACTORY_DEFAULT}[ipv6_addressing_type]
${NETWORK_LAN_FACTORY_DEFAULT_SPANNING_TREE_ENABLED}        ${NETWORK_LAN_FACTORY_DEFAULT}[spanning_tree_enabled]

${NETWORK_LAN_SUBMENU}                                      lan_submenu

${NETWORK_LAN_IPV4_DYNAMIC_ADDR_ENABLE_CHECKBOX}            network_mode

${NETWORK_LAN_IPV4_ADDR_INPUT}                              network_ip_address
${NETWORK_LAN_IPV4_SUBNET_MASK_INPUT}                       network_netmask
${NETWORK_LAN_IPV4_DEFAULT_GATEWAY_INPUT}                   network_gateway

# Some DUT firmware versions do not have HTML ID 'ipv6_link_local_address'.
# WEB element XPATH is used when ID is not available.
# https://intelbras.atlassian.net/browse/PZ-8178
${NETWORK_LAN_IPV6_LINK_LOCAL_ADDRESS_HTML_ID}              ipv6_link_local_address
${NETWORK_LAN_IPV6_LINK_LOCAL_ADDRESS_HTML_XPATH}           xpath://*[@id="main"]/div[2]/div/div/div/div/div[5]/div[1]/div
${NETWORK_LAN_IPV6_LINK_LOCAL}                              ${DUT}[env][network][lan][ipv6][link_local]
${NETWORK_LAN_IPV6_LINK_LOCAL_ADDRESS_PATTERN}              Endereço IPv6 link-local: ${NETWORK_LAN_IPV6_LINK_LOCAL}

${NETWORK_LAN_IPV6_ADDR_TYPE_SELECT}                        lan_ipv6_tipo_config
${NETWORK_LAN_IPV6_ADDR_TYPE_SELECT_LINK_LOCAL_VALUE}       string:link-local
${NETWORK_LAN_IPV6_ADDR_TYPE_SELECT_MANUAL_VALUE}           string:static
${NETWORK_LAN_IPV6_ADDR_TYPE_SELECT_AUTOMATIC_VALUE}        string:dhcpv6
${NETWORK_LAN_IPV6_ADDR_TYPE_SELECT_DEACTIVATED_VALUE}      string:disabled

${NETWORK_LAN_SPANNING_TREE_SELECT}                         network_spanning
${NETWORK_LAN_SPANNING_TREE_SELECT_ACTIVATED_VALUE}         boolean:true
${NETWORK_LAN_SPANNING_TREE_SELECT_DEACTIVATED_VALUE}       boolean:false

*** Keywords ***
Access Network LAN Settings Page
    Open Network Menu
    Wait Until Element Is Visible    ${NETWORK_LAN_SUBMENU}
    Click Element    ${NETWORK_LAN_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${SAVE_SETTINGS_BUTTON}

Network LAN IPv4 Address Should Be "${ipv4_address}"
    Element Attribute Value Should Be
    ...    ${NETWORK_LAN_IPV4_ADDR_INPUT}
    ...    value    ${ipv4_address}

Network LAN IPv4 Subnet Mask Should Be "${ipv4_subnet_mask}"
    Element Attribute Value Should Be
    ...    ${NETWORK_LAN_IPV4_SUBNET_MASK_INPUT}
    ...    value    ${ipv4_subnet_mask}

Network LAN IPv4 Default Gateway Address Should Be "${ipv4_default_gateway}"
    Element Attribute Value Should Be
    ...    ${NETWORK_LAN_IPV4_DEFAULT_GATEWAY_INPUT}
    ...    value    ${ipv4_default_gateway}

Network LAN IPv6 Addressing Type Should Be "${ipv6_addressing_type}"
    List Selection Should Be
    ...    ${NETWORK_LAN_IPV6_ADDR_TYPE_SELECT}
    ...    ${ipv6_addressing_type}

LAN Settings Should Be Factory Default
    IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'bridge'
        Element Should Be Visible    ${NETWORK_LAN_IPV4_DYNAMIC_ADDR_ENABLE_CHECKBOX}

        IF    ${NETWORK_LAN_FACTORY_DEFAULT_IPV4_DYNAMIC_ADDR_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${NETWORK_LAN_IPV4_DYNAMIC_ADDR_ENABLE_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${NETWORK_LAN_IPV4_DYNAMIC_ADDR_ENABLE_CHECKBOX}
        END

        Element Should Be Visible    ${NETWORK_LAN_IPV4_DEFAULT_GATEWAY_INPUT}
        Network LAN IPv4 Default Gateway Address Should Be "${NETWORK_LAN_FACTORY_DEFAULT_IPV4_DEFAULT_GATEWAY}"
    ELSE IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'router'
        Element Should Not Be Visible    ${NETWORK_LAN_IPV4_DYNAMIC_ADDR_ENABLE_CHECKBOX}
        Element Should Not Be Visible    ${NETWORK_LAN_IPV4_DEFAULT_GATEWAY_INPUT}
    ELSE
        Fail    Could not determine DUT factory default network operation mode (check DUT profile).
    END

    Network LAN IPv4 Address Should Be "${NETWORK_LAN_FACTORY_DEFAULT_IPV4_ADDR}"
    Network LAN IPv4 Subnet Mask Should Be "${NETWORK_LAN_FACTORY_DEFAULT_IPV4_SUBNET_MASK}"

    ${status}    Run Keyword And Return Status
    ...    Page Should Contain Element    ${NETWORK_LAN_IPV6_LINK_LOCAL_ADDRESS_HTML_ID}

    IF    ${status} == ${TRUE}
        Element Attribute Value Should Be
        ...    ${NETWORK_LAN_IPV6_LINK_LOCAL_ADDRESS_HTML_ID}
        ...    innerText    ${NETWORK_LAN_IPV6_LINK_LOCAL}
    ELSE
        ${ipv6_link_local_pattern}    Set Variable    ${NETWORK_LAN_IPV6_LINK_LOCAL_ADDRESS_PATTERN}
        ${ipv6_link_local}    Get Text    ${NETWORK_LAN_IPV6_LINK_LOCAL_ADDRESS_HTML_XPATH}
        Should Match    ${ipv6_link_local}    ${ipv6_link_local_pattern}
    END

    IF    '${NETWORK_LAN_FACTORY_DEFAULT_IPV6_ADDR_TYPE}' == 'link_local'
        Network LAN IPv6 Addressing Type Should Be "${NETWORK_LAN_IPV6_ADDR_TYPE_SELECT_LINK_LOCAL_VALUE}"
    ELSE IF    '${NETWORK_LAN_FACTORY_DEFAULT_IPV6_ADDR_TYPE}' == 'manual'
        Network LAN IPv6 Addressing Type Should Be "${NETWORK_LAN_IPV6_ADDR_TYPE_SELECT_MANUAL_VALUE}"
    ELSE IF    '${NETWORK_LAN_FACTORY_DEFAULT_IPV6_ADDR_TYPE}' == 'automatic'
        Network LAN IPv6 Addressing Type Should Be "${NETWORK_LAN_IPV6_ADDR_TYPE_SELECT_AUTOMATIC_VALUE}"
    ELSE IF    '${NETWORK_LAN_FACTORY_DEFAULT_IPV6_ADDR_TYPE}' == 'disabled'
        Network LAN IPv6 Addressing Type Should Be "${NETWORK_LAN_IPV6_ADDR_TYPE_SELECT_DEACTIVATED_VALUE}"
    ELSE
        Fail    Could not determine DUT factory default LAN network IPv6 addressing type (check DUT profile).
    END

    IF    ${NETWORK_LAN_FACTORY_DEFAULT_SPANNING_TREE_ENABLED} == ${TRUE}
        List Selection Should Be
        ...    ${NETWORK_LAN_SPANNING_TREE_SELECT}
        ...    ${NETWORK_LAN_SPANNING_TREE_SELECT_ACTIVATED_VALUE}
    ELSE
        List Selection Should Be
        ...    ${NETWORK_LAN_SPANNING_TREE_SELECT}
        ...    ${NETWORK_LAN_SPANNING_TREE_SELECT_DEACTIVATED_VALUE}
    END
