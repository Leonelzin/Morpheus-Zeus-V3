*** Settings ***
Documentation       Network (WAN) Resource File
...                 
...                 This resource file contains keywords related to network WAN
...                 settings webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${NETWORK_WAN_FACTORY_DEFAULT}                              ${DUT}[profile][network][factory_default][wan]
${NETWORK_WAN_FACTORY_DEFAULT_IPV4_ADDR_TYPE}               ${NETWORK_WAN_FACTORY_DEFAULT}[ipv4_addressing_type]
${NETWORK_WAN_FACTORY_DEFAULT_MAC_ADDR_CLONE}               ${NETWORK_WAN_FACTORY_DEFAULT}[mac_address_clone]
${NETWORK_WAN_FACTORY_DEFAULT_VLAN_ENABLED}                 ${NETWORK_WAN_FACTORY_DEFAULT}[vlan_enabled]
${NETWORK_WAN_FACTORY_DEFAULT_VLAN_ID}                      ${NETWORK_WAN_FACTORY_DEFAULT}[vlan_id]
${NETWORK_WAN_FACTORY_DEFAULT_MTU}                          ${NETWORK_WAN_FACTORY_DEFAULT}[mtu]
${NETWORK_WAN_FACTORY_DEFAULT_IPV6_ADDR_TYPE}               ${NETWORK_WAN_FACTORY_DEFAULT}[ipv6_addressing_type]

${NETWORK_WAN_MTU_MIN_VALUE}                                ${DUT}[profile][network][wan][min_mtu]
${NETWORK_WAN_MTU_MAX_VALUE}                                ${DUT}[profile][network][wan][max_mtu]

${NETWORK_WAN_SUBMENU}                                      wan_submenu

${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT}                        wan_config_type
${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT_DHCP_CLIENT_VALUE}      string:dhcp
${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT_STATIC_IP_VALUE}        string:static
${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT_PPPOE_VALUE}            string:pppoe

${NETWORK_WAN_CLONE_MAC_INPUT}                              wan_clone_mac

${NETWORK_WAN_ENABLE_VLAN_CHECKBOX}                         wan_enable_vlan
${NETWORK_WAN_VLAN_ID_INPUT}                                wan_vlan_id

${NETWORK_WAN_MTU_SLIDER_MIN_VALUE}                         //*[@id="wan_mtu_slider"]/span[7]
${NETWORK_WAN_MTU_SLIDER_VALUE}                             //*[@id="wan_mtu_slider"]/span[9]
${NETWORK_WAN_MTU_SLIDER_MAX_VALUE}                         //*[@id="wan_mtu_slider"]/span[8]
${NETWORK_WAN_MTU_INPUT}                                    wan_mtu

${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT}                        wan_ipv6_tipo_config
${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT_LINK_LOCAL_VALUE}       string:link-local
${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT_MANUAL_VALUE}           string:static
${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT_AUTO_VALUE}             string:dhcpv6
${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT_DEACTIVATED_VALUE}      string:disabled

# Some DUT firmware versions do not have HTML ID 'ipv6_link_local_address'.
# WEB element XPATH is used when ID is not available.
# https://intelbras.atlassian.net/browse/PZ-8178
${NETWORK_WAN_IPV6_LINK_LOCAL_ADDRESS_HTML_ID}              ipv6_link_local_address
${NETWORK_WAN_IPV6_LINK_LOCAL_ADDRESS_HTML_XPATH}           xpath://*[@id="main"]/div[2]/div/div/div/div[1]/div[13]/div[1]/div
${NETWORK_WAN_IPV6_LINK_LOCAL}                              ${DUT}[env][network][wan][ipv6][link_local]
${NETWORK_WAN_IPV6_LINK_LOCAL_ADDRESS_PATTERN}              Endereço IPv6 link-local: ${NETWORK_WAN_IPV6_LINK_LOCAL}

*** Keywords ***
Access Network WAN Settings Page
    Open Network Menu
    Wait Until Element Is Visible    ${NETWORK_WAN_SUBMENU}
    Click Element    ${NETWORK_WAN_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT}

Network WAN Router IPv4 Addressing Type Should Be "${wan_ipv4_addr_type}"
    List Selection Should Be
    ...    ${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT}
    ...    ${wan_ipv4_addr_type}

Network WAN Clone MAC Address Should Be "${wan_clone_mac}"
    Element Attribute Value Should Be
    ...    ${NETWORK_WAN_CLONE_MAC_INPUT}
    ...    value    ${wan_clone_mac}

Network WAN VLAN ID Should Be "${vlan_id}"
    Element Attribute Value Should Be
    ...    ${NETWORK_WAN_VLAN_ID_INPUT}
    ...    value    ${vlan_id}

Network WAN Minimum MTU Slider Value Should Be "${value}"
    Element Text Should Be
    ...    ${NETWORK_WAN_MTU_SLIDER_MIN_VALUE}
    ...    ${value}

Network WAN Maximum MTU Slider Value Should Be "${value}"
    Element Text Should Be
    ...    ${NETWORK_WAN_MTU_SLIDER_MAX_VALUE}
    ...    ${value}

Network WAN MTU Slider Value Should Be "${value}"
    Element Text Should Be
    ...    ${NETWORK_WAN_MTU_SLIDER_VALUE}
    ...    ${value}

WAN Settings Should Be Factory Default
    IF    '${NETWORK_WAN_FACTORY_DEFAULT_IPV4_ADDR_TYPE}' == 'dhcp_client'
        List Selection Should Be
        ...    ${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT}
        ...    ${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT_DHCP_CLIENT_VALUE}
    ELSE IF    '${NETWORK_WAN_FACTORY_DEFAULT_CONFIG_TYPE}' == 'static_ip'
        List Selection Should Be
        ...    ${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT}
        ...    ${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT_STATIC_IP_VALUE}
    ELSE IF    '${NETWORK_WAN_FACTORY_DEFAULT_CONFIG_TYPE}' == 'pppoe'
        List Selection Should Be
        ...    ${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT}
        ...    ${NETWORK_WAN_IPV4_ADDR_TYPE_SELECT_PPPOE_VALUE}
    ELSE
        Fail    Could not determine WAN network factory default IPv4 addressing type (check DUT profile).
    END

    Network WAN Clone MAC Address Should Be "${NETWORK_WAN_FACTORY_DEFAULT_MAC_ADDR_CLONE}"

    IF    ${NETWORK_WAN_FACTORY_DEFAULT_VLAN_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${NETWORK_WAN_ENABLE_VLAN_CHECKBOX}
        Element Should Be Enabled    ${NETWORK_WAN_VLAN_ID_INPUT}
    ELSE
        Checkbox Should Not Be Selected    ${NETWORK_WAN_ENABLE_VLAN_CHECKBOX}
        Element Should Be Disabled    ${NETWORK_WAN_VLAN_ID_INPUT}
    END

    Network WAN VLAN ID Should Be "${NETWORK_WAN_FACTORY_DEFAULT_VLAN_ID}"

    Network WAN Minimum MTU Slider Value Should Be "${NETWORK_WAN_MTU_MIN_VALUE}"
    Network WAN Maximum MTU Slider Value Should Be "${NETWORK_WAN_MTU_MAX_VALUE}"
    Network WAN MTU Slider Value Should Be "${NETWORK_WAN_FACTORY_DEFAULT_MTU}"

    ${status}    Run Keyword And Return Status
    ...    Page Should Contain Element    ${NETWORK_WAN_IPV6_LINK_LOCAL_ADDRESS_HTML_ID}

    IF    ${status} == ${TRUE}
        Element Attribute Value Should Be
        ...    ${NETWORK_WAN_IPV6_LINK_LOCAL_ADDRESS_HTML_ID}
        ...    innerText    ${NETWORK_WAN_IPV6_LINK_LOCAL}
    ELSE
        ${ipv6_link_local_pattern}    Set Variable    ${NETWORK_WAN_IPV6_LINK_LOCAL_ADDRESS_PATTERN}
        ${ipv6_link_local}    Get Text    ${NETWORK_WAN_IPV6_LINK_LOCAL_ADDRESS_HTML_XPATH}
        Should Match    ${ipv6_link_local}    ${ipv6_link_local_pattern}
    END

    IF    '${NETWORK_WAN_FACTORY_DEFAULT_IPV6_ADDR_TYPE}' == 'link_local'
        List Selection Should Be
        ...    ${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT}
        ...    ${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT_LINK_LOCAL_VALUE}
    ELSE IF    '${NETWORK_WAN_FACTORY_DEFAULT_IPV6_ADDR_TYPE}' == 'static'
        List Selection Should Be
        ...    ${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT}
        ...    ${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT_MANUAL_VALUE}
    ELSE IF    '${NETWORK_WAN_FACTORY_DEFAULT_IPV6_ADDR_TYPE}' == 'automatic'
        List Selection Should Be
        ...    ${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT}
        ...    ${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT_AUTO_VALUE}
    ELSE IF    '${NETWORK_WAN_FACTORY_DEFAULT_IPV6_ADDR_TYPE}' == 'deactivated'
        List Selection Should Be
        ...    ${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT}
        ...    ${NETWORK_WAN_IPV6_ADDR_TYPE_SELECT_DEACTIVATED_VALUE}
    ELSE
        Fail    Could not determine DUT network WAN IPv6 addressing type (check DUT profile).
    END
