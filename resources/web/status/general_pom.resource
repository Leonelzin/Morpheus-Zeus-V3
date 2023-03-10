*** Settings ***
Documentation       Status (General DUT Information) Resource File
...                 
...                 This resource file contains keywords related to status
...                 (general information) WEB page manipulation (page object
...                 model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/services/autoconfig_pom.resource
Resource            web/wireless/interface_2ghz_pom.resource
Resource            web/wireless/interface_5ghz_pom.resource

*** Variables ***
${WIRELESS_2GHZ_HTML_ID}                                                            ${DUT}[profile][wireless][2ghz][interface_id]
${WIRELESS_5GHZ_HTML_ID}                                                            ${DUT}[profile][wireless][5ghz][interface_id]
${ETHERNET_INTERFACE_1_HTML_ID}                                                     ${DUT}[profile][ethernet][interface_1][html_id]
${ETHERNET_INTERFACE_2_HTML_ID}                                                     ${DUT}[profile][ethernet][interface_2][html_id]

${STATUS_GENERAL_SUBMENU}                                                           statusGeral_submenu

#TODO: this xpath locator should be replaced by a new ID locator
# that was requested in https://intelbras.atlassian.net/browse/PZ-7753
${CRONOS_FIRMWARE_UPGRADE_REQUEST_MODAL_REJECT_BUTTON}                              xpath:/html/body/div[4]/div/div/div[3]/button[2]

${STATUS_GENERAL_SYSTEM_ACCORDION_HEADER}                                           system_accordion_header
${STATUS_GENERAL_SYSTEM_ACCORDION_BODY}                                             system_accordion_body
${STATUS_GENERAL_SYSTEM_ACCORDION_MODEL_TABLE_CELL}                                 device_model
${STATUS_GENERAL_SYSTEM_ACCORDION_HOSTNAME_TABLE_CELL}                              device_hostname
${STATUS_GENERAL_SYSTEM_ACCORDION_UPTIME_TABLE_CELL}                                device_uptime
${STATUS_GENERAL_SYSTEM_ACCORDION_FIRMWARE_VERSION_TABLE_CELL}                      device_version
${STATUS_GENERAL_SYSTEM_ACCORDION_NTP_STATUS_TABLE_CELL}                            ntp
${STATUS_GENERAL_SYSTEM_ACCORDION_DATETIME_TABLE_CELL}                              data_hora
${STATUS_GENERAL_SYSTEM_ACCORDION_TERMS_OF_USE_TABLE_CELL}                          compliance
${STATUS_GENERAL_SYSTEM_ACCORDION_NETWORK_OPMODE_TABLE_CELL}                        operation_mode

${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_HEADER}                                    ${WIRELESS_2GHZ_HTML_ID}_wireless_accordion_header
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_BODY}                                      ${WIRELESS_2GHZ_HTML_ID}_wireless_accordion_body
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_OPMODE_TABLE_CELL}                         op_mode_${WIRELESS_2GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_SSID_TABLE_CELL}                           ssid_${WIRELESS_2GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_IEEE_MODE_TABLE_CELL}                      mode_ieee_${WIRELESS_2GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_BANDWIDTH_TABLE_CELL}                      bandwidth_${WIRELESS_2GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CHANNEL_TABLE_CELL}                        channel_${WIRELESS_2GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CLIENTS_TABLE_CELL}                        clients_${WIRELESS_2GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_TX_POWER_TABLE_CELL}                       dbm_${WIRELESS_2GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_MAC_ADDRESS_TABLE_CELL}                    wireless_mac_${WIRELESS_2GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CHANNEL_VALUE_REGEX}                       ^Automático \\[ ([1-9]|1[0-1]) \\]$
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CLIENTS_VALUE_REGEX}                       ^\\d{1,3}$
${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CLIENTS_MAGNIFIER_ICON}                    clients_button_[object Object]

${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_HEADER}                                    ${WIRELESS_5GHZ_HTML_ID}_wireless_accordion_header
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_BODY}                                      ${WIRELESS_5GHZ_HTML_ID}_wireless_accordion_body
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_OPMODE_TABLE_CELL}                         op_mode_${WIRELESS_5GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_SSID_TABLE_CELL}                           ssid_${WIRELESS_5GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_IEEE_MODE_TABLE_CELL}                      mode_ieee_${WIRELESS_5GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_BANDWIDTH_TABLE_CELL}                      bandwidth_${WIRELESS_5GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CHANNEL_TABLE_CELL}                        channel_${WIRELESS_5GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CLIENTS_TABLE_CELL}                        clients_${WIRELESS_5GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_TX_POWER_TABLE_CELL}                       dbm_${WIRELESS_5GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_MAC_ADDRESS_TABLE_CELL}                    wireless_mac_${WIRELESS_5GHZ_HTML_ID}
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CHANNEL_VALUE_REGEX}                       ^Automático \\[ (3[6-9]|[4-9][0-9]|1[0-5][0-9]|1[0-6][0-5]) \\]$
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CLIENTS_VALUE_REGEX}                       ^\\d{1,3}$
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CLIENTS_MAGNIFIER_ICON}                    clients_button_[object Object]
${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_TX_POWER_VALUE_REGEX}                      ^\\d{1,2} dBm$

${STATUS_GENERAL_LAN_ACCORDION_HEADER}                                              lan_accordion_header
${STATUS_GENERAL_LAN_ACCORDION_BODY}                                                lan_accordion_body
${STATUS_GENERAL_LAN_ACCORDION_IPV4_ADDRESS_TABLE_CELL}                             lan_ip_address
${STATUS_GENERAL_LAN_ACCORDION_IPV4_NETMASK_TABLE_CELL}                             lan_netmask
${STATUS_GENERAL_LAN_ACCORDION_IPV4_GATEWAY_TABLE_CELL}                             lan_gateway
${STATUS_GENERAL_LAN_ACCORDION_IPV6_LINK_LOCAL_TABLE_CELL}                          lan_link_local_ipv6
${STATUS_GENERAL_LAN_ACCORDION_IPV6_ADDRESS_TABLE_CELL}                             lan_ip_address_ipv6
${STATUS_GENERAL_LAN_ACCORDION_IPV6_GATEWAY_TABLE_CELL}                             lan_gateway_ipv6
${STATUS_GENERAL_LAN_ACCORDION_MAC_ADDRESS_TABLE_CELL}                              lan_mac_address

${STATUS_GENERAL_WAN_ACCORDION_HEADER}                                              wan_accordion_header
${STATUS_GENERAL_WAN_ACCORDION_BODY}                                                wan_accordion_body
${STATUS_GENERAL_WAN_ACCORDION_IPV4_ADDR_TYPE_TABLE_CELL}                           wan_type
${STATUS_GENERAL_WAN_ACCORDION_IPV4_IP_ADDRESS_TABLE_CELL}                          wan_ip_address
${STATUS_GENERAL_WAN_ACCORDION_IPV4_NETMASK_TABLE_CELL}                             wan_netmask
${STATUS_GENERAL_WAN_ACCORDION_IPV4_GATEWAY_TABLE_CELL}                             wan_gateway
${STATUS_GENERAL_WAN_ACCORDION_IPV6_LINK_LOCAL_TABLE_CELL}                          wan_link_local_ipv6
${STATUS_GENERAL_WAN_ACCORDION_IPV6_GATEWAY_TABLE_CELL}                             wan_gateway_ipv6
${STATUS_GENERAL_WAN_ACCORDION_MAC_ADDRESS_TABLE_CELL}                              wan_mac_address
${STATUS_GENERAL_WAN_ACCORDION_MTU_TABLE_CELL}                                      wan_mtu

${STATUS_GENERAL_ETHERNET_ACCORDION_HEADER}                                         ethernet_accordion_header
${STATUS_GENERAL_ETHERNET_ACCORDION_BODY}                                           ethernet_accordion_body
${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_1_LINK_STATUS_TABLE_CELL}             ethernet_status_${ETHERNET_INTERFACE_1_HTML_ID}
${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_1_AUTO_NEGOTIATION_TABLE_CELL}        ethernet_auto_${ETHERNET_INTERFACE_1_HTML_ID}
${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_1_SPEED_TABLE_CELL}                   ethernet_speed_${ETHERNET_INTERFACE_1_HTML_ID}
${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_1_DUPLEX_TABLE_CELL}                  ethernet_duplex_${ETHERNET_INTERFACE_1_HTML_ID}

${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_2_LINK_STATUS_TABLE_CELL}             ethernet_status_${ETHERNET_INTERFACE_2_HTML_ID}
${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_2_AUTO_NEGOTIATION_TABLE_CELL}        ethernet_auto_${ETHERNET_INTERFACE_2_HTML_ID}
${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_2_SPEED_TABLE_CELL}                   ethernet_speed_${ETHERNET_INTERFACE_2_HTML_ID}
${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_2_DUPLEX_TABLE_CELL}                  ethernet_duplex_${ETHERNET_INTERFACE_2_HTML_ID}

${STATUS_GENERAL_AUTOCONFIG_ACCORDION_HEADER}                                       accordion_auto_config
${STATUS_GENERAL_AUTOCONFIG_ACCORDION_BODY}                                         auto_config_accordion_body
${STATUS_GENERAL_AUTOCONFIG_ACCORDION_STATUS_TABLE_CELL}                            auto_config_status
${STATUS_GENERAL_AUTOCONFIG_ACCORDION_AUTH_MODE_TABLE_CELL}                         auto_config_require_auth
${STATUS_GENERAL_AUTOCONFIG_ACCORDION_DEVICES_AWAITING_AUTH_TABLE_CELL}             auto_config_devices_awaiting_auth
${STATUS_GENERAL_AUTOCONFIG_ACCORDION_DEVICES_AWAITING_AUTH_LOOKUP_TABLE_CELL}      auto_config_devices_awaiting_auth_lookup

*** Keywords ***
Access Status General Information Page
    Open Status Menu
    Wait Until Element Is Visible    ${STATUS_GENERAL_SUBMENU}
    Click Element    ${STATUS_GENERAL_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "60" Seconds
    Wait "2" Seconds For WEB Animation To Finish

Reject Cronos Firmware Upgrade Request
    Wait Until Element Is Visible    ${CRONOS_FIRMWARE_UPGRADE_REQUEST_MODAL_REJECT_BUTTON}
    Click Button    ${CRONOS_FIRMWARE_UPGRADE_REQUEST_MODAL_REJECT_BUTTON}

Open System Accordion
    Wait Until Element Is Visible    ${STATUS_GENERAL_SYSTEM_ACCORDION_HEADER}
    Register Keyword To Run On Failure    NONE
    ${status}    Run Keyword And Return Status
    ...    Element Should Be Visible    ${STATUS_GENERAL_SYSTEM_ACCORDION_BODY}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    ${status} == ${FALSE}
        Click Element    ${STATUS_GENERAL_SYSTEM_ACCORDION_HEADER}
        Wait "2" Seconds For WEB Animation To Finish
    END

Status General System Model Should Be "${model}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_SYSTEM_ACCORDION_MODEL_TABLE_CELL}
    ...    innerText    ${model}

Status General System Hostname Should Be "${hostname}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_SYSTEM_ACCORDION_HOSTNAME_TABLE_CELL}
    ...    innerText    ${hostname}

Status General System Uptime Format Should Be Correct
    ${uptime_regex}    Set Variable
    ...    ^(([1-9]+[0-9]+|[1-9]+)d )?((2[0-3]|1[0-9]|[1-9])h )?([0-5]?[0-9]m )?([0-5]?[0-9]s)$
    ${uptime}    Get Text    ${STATUS_GENERAL_SYSTEM_ACCORDION_UPTIME_TABLE_CELL}
    Should Match Regexp    ${uptime}    ${uptime_regex}

Status General System Firmware Version Should Be "${version}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_SYSTEM_ACCORDION_FIRMWARE_VERSION_TABLE_CELL}
    ...    innerText    ${version}

Status General System NTP Status Should Be "${status}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_SYSTEM_ACCORDION_NTP_STATUS_TABLE_CELL}
    ...    innerText    ${status}

Status General System Datetime Format Should Be Correct
    ${datetime_regex}    Set Variable
    ...    ^(0[1-9]|[1-2][0-9]|3[0-1])\/(0[1-9]|1[0-2])\/(\\d+) ([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$
    ${datetime}    Get Text    ${STATUS_GENERAL_SYSTEM_ACCORDION_DATETIME_TABLE_CELL}
    Should Match Regexp    ${datetime}    ${datetime_regex}

Status General System Terms Of Use Should Be "${value}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_SYSTEM_ACCORDION_TERMS_OF_USE_TABLE_CELL}
    ...    innerText    ${value}

Status General System Network Operation Mode Should Be "${opmode}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_SYSTEM_ACCORDION_NETWORK_OPMODE_TABLE_CELL}
    ...    innerText    ${opmode}

Status General System Accordion Settings Should Be Factory Default
    Status General System Model Should Be "${DUT}[profile][general][model_name]"
    Status General System Hostname Should Be "${DUT}[profile][network][factory_default][hostname]"
    Status General System Uptime Format Should Be Correct
    Status General System Firmware Version Should Be "${DUT}[env][firmware][version]"

    IF    ${DUT}[profile][features][ntp_client][factory_default][enabled] == ${TRUE}
        Status General System NTP Status Should Be "Habilitado"
    ELSE
        Status General System NTP Status Should Be "Desabilitado"
    END

    Status General System Terms Of Use Should Be "Habilitado"
    Status General System Datetime Format Should Be Correct

    IF    '${DUT}[profile][network][factory_default][operation_mode]' == 'bridge'
        Status General System Network Operation Mode Should Be "Bridge"
    ELSE IF    '${DUT}[profile][network][factory_default][operation_mode]' == 'router'
        Status General System Network Operation Mode Should Be "Roteador"
    ELSE
        Fail    Could not determine DUT factory default network operation mode (check DUT profile).
    END

Open LAN Accordion
    Wait Until Element Is Visible    ${STATUS_GENERAL_LAN_ACCORDION_HEADER}
    Register Keyword To Run On Failure    NONE
    ${status}    Run Keyword And Return Status
    ...    Element Should Be Visible    ${STATUS_GENERAL_LAN_ACCORDION_BODY}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    ${status} == ${FALSE}
        Click Element    ${STATUS_GENERAL_LAN_ACCORDION_HEADER}
        Wait "2" Seconds For WEB Animation To Finish
    END

Status General LAN IPv4 Address Should Be "${address}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_LAN_ACCORDION_IPV4_ADDRESS_TABLE_CELL}
    ...    innerText    ${address}

Status General LAN IPv4 Netmask Should Be "${netmask}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_LAN_ACCORDION_IPV4_NETMASK_TABLE_CELL}
    ...    innerText
    ...    ${netmask}

Status General LAN IPv4 Gateway Should Be "${gateway}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_LAN_ACCORDION_IPV4_GATEWAY_TABLE_CELL}
    ...    innerText    ${gateway}

Status General LAN IPv6 Link Local Should Be "${address}"
    #TODO: DUT can (and probably will) assign multiple IPv6 addresses to its LAN
    # interface depending on its network environment.
    # We should implement some keywords to handle that when needed.
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_LAN_ACCORDION_IPV6_LINK_LOCAL_TABLE_CELL}
    ...    innerText    ${address}

Status General LAN IPv6 Address Should Be "${address}"
    ${string}    Get Text    ${STATUS_GENERAL_LAN_ACCORDION_IPV6_ADDRESS_TABLE_CELL}
    ${stripped_string}    Strip String    ${string}
    ${status}    Run Keyword And Return Status
    ...    Should Be Equal As Strings
    ...    ${stripped_string}    ${address}
    IF    ${status} == ${FALSE}
        Capture Page Screenshot
        ${message}    Catenate    Element '${STATUS_GENERAL_LAN_ACCORDION_IPV6_ADDRESS_TABLE_CELL}'
        ...    attribute should have value '${address}' but its value was '${stripped_string}'.
        Fail    ${message}
    END

Status General LAN IPv6 Gateway Should Be "${gateway}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_LAN_ACCORDION_IPV6_GATEWAY_TABLE_CELL}
    ...    innerText    ${gateway}

Status General LAN MAC Address Should Be "${mac_address}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_LAN_ACCORDION_MAC_ADDRESS_TABLE_CELL}
    ...    innerText    ${mac_address}

Status General LAN Accordion Settings Should Be Factory Default
    Status General LAN IPv4 Address Should Be "${DUT}[env][network][lan][ipv4][address]"
    Status General LAN IPv4 Netmask Should Be "${DUT}[env][network][lan][ipv4][netmask]"
    Status General LAN IPv6 Link Local Should Be "${DUT}[env][network][lan][ipv6][link_local]"
    Status General LAN IPv6 Address Should Be "${DUT}[env][network][lan][ipv6][addresses][0]"

    IF    '${DUT}[profile][network][factory_default][operation_mode]' == 'bridge'
        Status General LAN IPv4 Gateway Should Be "${DUT}[env][network][lan][ipv4][gateway]"
        Status General LAN IPv6 Gateway Should Be "${DUT}[env][network][lan][ipv6][gateway]"
    ELSE IF    '${DUT}[profile][network][factory_default][operation_mode]' == 'router'
        Element Should Not Be Visible    ${STATUS_GENERAL_LAN_ACCORDION_IPV4_GATEWAY_TABLE_CELL}
        Element Should Not Be Visible    ${STATUS_GENERAL_LAN_ACCORDION_IPV6_GATEWAY_TABLE_CELL}
    ELSE
        Fail    Could not determine DUT factory default network operation mode (check DUT profile).
    END

    Status General LAN MAC Address Should Be "${DUT}[env][network][lan][mac_address]"

Open WAN Accordion
    Wait Until Element Is Visible    ${STATUS_GENERAL_WAN_ACCORDION_HEADER}
    Register Keyword To Run On Failure    NONE
    ${status}    Run Keyword And Return Status
    ...    Element Should Be Visible    ${STATUS_GENERAL_WAN_ACCORDION_BODY}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    ${status} == ${FALSE}
        Click Element    ${STATUS_GENERAL_WAN_ACCORDION_HEADER}
        Wait "2" Seconds For WEB Animation To Finish
    END

Status General WAN IPv4 Addressing Type Should Be "${addressing_type}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WAN_ACCORDION_IPV4_ADDR_TYPE_TABLE_CELL}
    ...    innerText    ${addressing_type}

Status General WAN IPv4 Address Should Be "${address}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WAN_ACCORDION_IPV4_IP_ADDRESS_TABLE_CELL}
    ...    innerText    ${address}

Status General WAN IPv4 Netmask Should Be "${netmask}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WAN_ACCORDION_IPV4_NETMASK_TABLE_CELL}
    ...    innerText    ${netmask}

Status General WAN IPv4 Gateway Should Be "${gateway}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WAN_ACCORDION_IPV4_GATEWAY_TABLE_CELL}
    ...    innerText    ${gateway}

Status General WAN IPv6 Link Local Should Be "${address}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WAN_ACCORDION_IPV6_LINK_LOCAL_TABLE_CELL}
    ...    innerText    ${address}

Status General WAN IPv6 Gateway Should Be "${gateway}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WAN_ACCORDION_IPV6_GATEWAY_TABLE_CELL}
    ...    innerText    ${gateway}

Status General WAN MAC Address Should Be "${mac_address}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WAN_ACCORDION_MAC_ADDRESS_TABLE_CELL}
    ...    innerText    ${mac_address}

Status General WAN MTU Should Be "${mtu}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WAN_ACCORDION_MTU_TABLE_CELL}
    ...    innerText    ${mtu}

Status General WAN Accordion Settings Should Be Factory Default
    IF    '${DUT}[profile][network][factory_default][wan][ipv4_addressing_type]' == 'dhcp_client'
        Status General WAN IPv4 Addressing Type Should Be "Cliente DHCP"
    ELSE IF    '${DUT}[profile][network][factory_default][wan][ipv4_addressing_type]' == 'static_ip'
        Status General WAN IPv4 Addressing Type Should Be "IP Fixo"
    ELSE IF    '${DUT}[profile][network][factory_default][wan][ipv4_addressing_type]' == 'pppoe'
        Status General WAN IPv4 Addressing Type Should Be "PPPoE"
    ELSE
        Fail    Could not determine WAN network factory default IPv4 addressing type (check DUT profile).
    END

    Status General WAN IPv4 Address Should Be "${DUT}[env][network][wan][ipv4][address]"
    Status General WAN IPv4 Netmask Should Be "${DUT}[env][network][wan][ipv4][netmask]"
    Status General WAN IPv4 Gateway Should Be "${DUT}[env][network][wan][ipv4][gateway]"
    Status General WAN IPv6 Link Local Should Be "${DUT}[env][network][wan][ipv6][link_local]"
    Status General WAN IPv6 Gateway Should Be "${DUT}[env][network][wan][ipv6][gateway]"
    Status General WAN MAC Address Should Be "${DUT}[env][network][wan][mac_address]"
    Status General WAN MTU Should Be "${DUT}[profile][network][factory_default][wan][mtu]"

Open Wireless 2GHz Accordion
    Wait Until Element Is Visible    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_HEADER}
    Register Keyword To Run On Failure    NONE
    ${status}    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_BODY}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    ${status} == ${FALSE}
        Click Element    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_HEADER}
        Wait "2" Seconds For WEB Animation To Finish
    END

Open Wireless 5GHz Accordion
    Wait Until Element Is Visible    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_HEADER}
    Register Keyword To Run On Failure    NONE
    ${status}    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_BODY}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    ${status} == ${FALSE}
        Click Element    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_HEADER}
        Wait "2" Seconds For WEB Animation To Finish
    END

Status General Wireless 5GHz Operation Mode Should Be "${opmode}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_OPMODE_TABLE_CELL}
    ...    innerText    ${opmode}

Status General Wireless 5GHz SSID Should Be "${ssid}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_SSID_TABLE_CELL}
    ...    innerText    ${ssid}

Status General Wireless 5GHz IEEE Mode Should Be "${ieee_mode}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_IEEE_MODE_TABLE_CELL}
    ...    innerText    ${ieee_mode}

Status General Wireless 5GHz Bandwidth Should Be "${bandwidth}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_BANDWIDTH_TABLE_CELL}
    ...    innerText    ${bandwidth}

Status General Wireless 5GHz TX Power Should Be "${tx_power}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_TX_POWER_TABLE_CELL}
    ...    innerText    ${tx_power}

Status General Wireless 5GHz MAC Address Should Be "${mac_address}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_MAC_ADDRESS_TABLE_CELL}
    ...    innerText    ${mac_address}

Status General Wireless 5GHz Accordion Settings Should Be Factory Default
    IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_OP_MODE}' == 'access_point'
        Status General Wireless 5GHz Operation Mode Should Be "AP"
    ELSE IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_OP_MODE}' == 'repeater'
        Status General Wireless 5GHz Operation Mode Should Be "Repetidor"
    ELSE IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_OP_MODE}' == 'client'
        Status General Wireless 5GHz Operation Mode Should Be "Cliente"
    ELSE
        Fail    Could not determine DUT wireless 5GHz operation mode (check DUT profile).
    END

    Status General Wireless 5GHz SSID Should Be "${DUT}[env][wireless][5ghz][default_ssid][name]"

    Status General Wireless 5GHz IEEE Mode Should Be "${WIRELESS_5GHZ_FACTORY_DEFAULT_IEEE_MODE}"

    Status General Wireless 5GHz Bandwidth Should Be "${WIRELESS_5GHZ_FACTORY_DEFAULT_BANDWIDTH}"

    IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_CHANNEL}' == 'automatic'
        ${5ghz_channel}    Get Text    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CHANNEL_TABLE_CELL}
        Should Match Regexp    ${5ghz_channel}    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CHANNEL_VALUE_REGEX}
    ELSE
        Element Attribute Value Should Be
        ...    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CHANNEL_TABLE_CELL}
        ...    innerText    ${WIRELESS_5GHZ_FACTORY_DEFAULT_CHANNEL}
    END

    ${5ghz_conn_clients}    Get Text    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CLIENTS_TABLE_CELL}
    Should Match Regexp    ${5ghz_conn_clients}    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CLIENTS_VALUE_REGEX}

    ${5ghz_conn_clients}    Convert To Integer    ${5ghz_conn_clients}

    IF    ${5ghz_conn_clients} == 0
        Element Attribute Value Should Be
        ...    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CLIENTS_MAGNIFIER_ICON}
        ...    ng-disabled
        ...    true
    ELSE
        Element Attribute Value Should Be
        ...    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_CLIENTS_MAGNIFIER_ICON}
        ...    ng-disabled
        ...    false
    END

    ${5ghz_tx_power}    Get Text    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_TX_POWER_TABLE_CELL}
    Should Match Regexp    ${5ghz_tx_power}    ${STATUS_GENERAL_WIRELESS_5GHZ_ACCORDION_TX_POWER_VALUE_REGEX}

    IF    '${WIRELESS_5GHZ_FACTORY_DEFAULT_OP_MODE}' == 'access_point'
        Status General Wireless 5GHz SSID Should Be "${DUT}[env][wireless][5ghz][default_ssid][name]"
        Status General Wireless 5GHz MAC Address Should Be "${DUT}[env][wireless][5ghz][default_ssid][mac_address]"
    END

Status General Wireless 2GHz Operation Mode Should Be "${opmode}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_OPMODE_TABLE_CELL}
    ...    innerText    ${opmode}

Status General Wireless 2GHz SSID Should Be "${ssid}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_SSID_TABLE_CELL}
    ...    innerText    ${ssid}

Status General Wireless 2GHz IEEE Mode Should Be "${ieee_mode}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_IEEE_MODE_TABLE_CELL}
    ...    innerText    ${ieee_mode}

Status General Wireless 2GHz Bandwidth Should Be "${bandwidth}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_BANDWIDTH_TABLE_CELL}
    ...    innerText    ${bandwidth}

Status General Wireless 2GHz TX Power Should Be "${tx_power}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_TX_POWER_TABLE_CELL}
    ...    innerText    ${tx_power}

Status General Wireless 2GHz MAC Address Should Be "${mac_address}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_MAC_ADDRESS_TABLE_CELL}
    ...    innerText    ${mac_address}

Status General Wireless 2GHz Accordion Settings Should Be Factory Default
    IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_OP_MODE}' == 'access_point'
        Status General Wireless 2GHz Operation Mode Should Be "AP"
    ELSE IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_OP_MODE}' == 'repeater'
        Status General Wireless 2GHz Operation Mode Should Be "Repetidor"
    ELSE IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_OP_MODE}' == 'client'
        Status General Wireless 2GHz Operation Mode Should Be "Cliente"
    ELSE
        Fail    Could not determine DUT wireless 2GHz operation mode (check DUT profile).
    END

    Status General Wireless 2GHz IEEE Mode Should Be "${WIRELESS_2GHZ_FACTORY_DEFAULT_IEEE_MODE}"
    Status General Wireless 2GHz Bandwidth Should Be "${WIRELESS_2GHZ_FACTORY_DEFAULT_BANDWIDTH}"

    IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_CHANNEL}' == 'automatic'
        ${2ghz_channel}    Get Text    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CHANNEL_TABLE_CELL}
        Should Match Regexp    ${2ghz_channel}    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CHANNEL_VALUE_REGEX}
    ELSE
        Element Attribute Value Should Be
        ...    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CHANNEL_TABLE_CELL}
        ...    innerText    ${WIRELESS_2GHZ_FACTORY_DEFAULT_CHANNEL}
    END

    ${2ghz_conn_clients}    Get Text    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CLIENTS_TABLE_CELL}
    Should Match Regexp    ${2ghz_conn_clients}    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CLIENTS_VALUE_REGEX}

    ${2ghz_conn_clients}    Convert To Integer    ${2ghz_conn_clients}

    IF    ${2ghz_conn_clients} == 0
        Element Attribute Value Should Be
        ...    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CLIENTS_MAGNIFIER_ICON}
        ...    ng-disabled
        ...    true
    ELSE
        Element Attribute Value Should Be
        ...    ${STATUS_GENERAL_WIRELESS_2GHZ_ACCORDION_CLIENTS_MAGNIFIER_ICON}
        ...    ng-disabled
        ...    false
    END

    Status General Wireless 2GHz TX Power Should Be "${WIRELESS_2GHZ_FACTORY_DEFAULT_TX_POWER} dBm"

    IF    '${WIRELESS_2GHZ_FACTORY_DEFAULT_OP_MODE}' == 'access_point'
        Status General Wireless 2GHz SSID Should Be "${DUT}[env][wireless][2ghz][default_ssid][name]"
        Status General Wireless 2GHz MAC Address Should Be "${DUT}[env][wireless][2ghz][default_ssid][mac_address]"
    END

Open Ethernet Accordion
    Wait Until Element Is Visible    ${STATUS_GENERAL_ETHERNET_ACCORDION_HEADER}
    Register Keyword To Run On Failure    NONE
    ${status}    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    ${STATUS_GENERAL_ETHERNET_ACCORDION_BODY}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    ${status} == ${FALSE}
        Click Element    ${STATUS_GENERAL_ETHERNET_ACCORDION_HEADER}
        Wait "2" Seconds For WEB Animation To Finish
    END

Status General Ethernet Status Link (Interface 1) Should Be "${status}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_1_LINK_STATUS_TABLE_CELL}
    ...    innerText    ${status}

Status General Ethernet Auto Negotiation (Interface 1) Should Be "${auto_negotiation}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_1_AUTO_NEGOTIATION_TABLE_CELL}
    ...    innerText    ${auto_negotiation}

Status General Ethernet Speed (Interface 1) Should Be "${speed}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_1_SPEED_TABLE_CELL}
    ...    innerText    ${speed}

Status General Ethernet Duplex (Interface 1) Should Be "${duplex}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_1_DUPLEX_TABLE_CELL}
    ...    innerText    ${duplex}

Status General Ethernet Status Link (Interface 2) Should Be "${status}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_2_LINK_STATUS_TABLE_CELL}
    ...    innerText    ${status}

Status General Ethernet Auto Negotiation (Interface 2) Should Be "${auto_negotiation}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_2_AUTO_NEGOTIATION_TABLE_CELL}
    ...    innerText    ${auto_negotiation}

Status General Ethernet Speed (Interface 2) Should Be "${speed}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_2_SPEED_TABLE_CELL}
    ...    innerText    ${speed}

Status General Ethernet Duplex (Interface 2) Should Be "${duplex}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_ETHERNET_ACCORDION_INTERFACE_2_DUPLEX_TABLE_CELL}
    ...    innerText    ${duplex}

Status General Ethernet Accordion Settings Should Be Factory Default
    Status General Ethernet Status Link (Interface 1) Should Be "${DUT}[env][ethernet][interface_1][link_status]"

    IF    ${DUT}[profile][ethernet][interface_1][factory_default][auto_negotiation][enabled] == ${TRUE}
        Status General Ethernet Auto Negotiation (Interface 1) Should Be "Ativado"
    ELSE
        Status General Ethernet Auto Negotiation (Interface 1) Should Be "Desativado"
    END

    Status General Ethernet Speed (Interface 1) Should Be "${DUT}[env][ethernet][interface_1][speed]"
    Status General Ethernet Duplex (Interface 1) Should Be "${DUT}[env][ethernet][interface_1][duplex]"

    IF    ${DUT}[profile][ethernet][interface_2][is_supported] == ${TRUE}
        Status General Ethernet Status Link (Interface 2) Should Be "${DUT}[env][ethernet][interface_2][link_status]"
        IF    ${DUT}[profile][ethernet][interface_2][factory_default][auto_negotiation][enabled] == ${TRUE}
            Status General Ethernet Auto Negotiation (Interface 2) Should Be "Ativado"
        ELSE
            Status General Ethernet Auto Negotiation (Interface 2) Should Be "Desativado"
        END
        Status General Ethernet Speed (Interface 2) Should Be "${DUT}[env][ethernet][interface_2][speed]"
        Status General Ethernet Duplex (Interface 2) Should Be "${DUT}[env][ethernet][interface_2][duplex]"
    END

Open Automatic Device Configuration Accordion
    Wait Until Element Is Visible    ${STATUS_GENERAL_AUTOCONFIG_ACCORDION_HEADER}
    Register Keyword To Run On Failure    NONE
    ${status}    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    ${STATUS_GENERAL_AUTOCONFIG_ACCORDION_BODY}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    ${status} == ${FALSE}
        Click Element    ${STATUS_GENERAL_AUTOCONFIG_ACCORDION_HEADER}
        Wait "2" Seconds For WEB Animation To Finish
    END

Status General Automatic Device Configuration Status Should Be "${status}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_AUTOCONFIG_ACCORDION_STATUS_TABLE_CELL}
    ...    innerText    ${status}

Status General Automatic Device Configuration Authorization Mode Should Be "${auth_mode}"
    Element Attribute Value Should Be
    ...    ${STATUS_GENERAL_AUTOCONFIG_ACCORDION_AUTH_MODE_TABLE_CELL}
    ...    innerText    ${auth_mode}

Status General Automatic Device Configuration Devices Awaiting Authorization Should Be "${value}"
    ${string}    Get Text    ${STATUS_GENERAL_AUTOCONFIG_ACCORDION_DEVICES_AWAITING_AUTH_TABLE_CELL}
    ${stripped_string}    Strip String    ${string}
    ${status}    Run Keyword And Return Status
    ...    Should Be Equal As Strings
    ...    ${stripped_string}    ${value}
    IF    ${status} == ${FALSE}
        Capture Page Screenshot
        ${message}    Catenate    Element '${STATUS_GENERAL_AUTOCONFIG_ACCORDION_DEVICES_AWAITING_AUTH_TABLE_CELL}'
        ...    attribute should have value '${value}' but its value was '${stripped_string}'.
        Fail    ${message}
    END

Status General Automatic Device Configuration Devices Awaiting Authorization Should Be An Integer Value
    ${string}    Get Text    ${STATUS_GENERAL_AUTOCONFIG_ACCORDION_DEVICES_AWAITING_AUTH_TABLE_CELL}
    ${stripped_string}    Strip String    ${string}
    ${status}    Run Keyword And Return Status
    ...    Convert To Integer    ${stripped_string}
    IF    ${status} == ${FALSE}
        Capture Page Screenshot
        ${message}    Catenate    Element '${STATUS_GENERAL_AUTOCONFIG_ACCORDION_DEVICES_AWAITING_AUTH_TABLE_CELL}'
        ...    attribute should be an integer value but its value was '${stripped_string}'.
        Fail    ${message}
    END

Status General Automatic Device Configuration Settings Should Be Factory Default
    IF    ${AUTOCONFIG_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Status General Automatic Device Configuration Status Should Be "Ativado"
    ELSE
        Status General Automatic Device Configuration Status Should Be "Desativado"
    END

    IF    ${AUTOCONFIG_FACTORY_DEFAULT_AUTO_AUTHORIZATION_ENABLED} == ${TRUE}
        Status General Automatic Device Configuration Authorization Mode Should Be "Automático"
    ELSE
        Status General Automatic Device Configuration Authorization Mode Should Be "Moderada"
        Status General Automatic Device Configuration Devices Awaiting Authorization Should Be An Integer Value
    END
