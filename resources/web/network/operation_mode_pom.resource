*** Settings ***
Documentation       Network Operation Mode Resource File
...                 
...                 This resource file contains keywords related to network
...                 operation mode webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${NETWORK_OPMODE_SUBMENU}                   operationMode_submenu

${NETWORK_HOSTNAME_INPUT}                   alias

${NETWORK_OPMODE_SELECT}                    operation_mode
${NETWORK_OPMODE_SELECT_BRIDGE_VALUE}       string:bridge
${NETWORK_OPMODE_SELECT_ROUTER_VALUE}       string:router

${NETWORK_NAT_ENABLE_CHECKBOX}              nat_enable

${NETWORK_FACTORY_DEFAULT}                  ${DUT}[profile][network][factory_default]
${NETWORK_FACTORY_DEFAULT_OPMODE}           ${DUT}[profile][network][factory_default][operation_mode]
${NETWORK_FACTORY_DEFAULT_HOSTNAME}         ${DUT}[profile][network][factory_default][hostname]

*** Keywords ***
Skip This Test If DUT Factory Default Network Operation Mode Is Not Router
    IF    '${DUT}[profile][network][factory_default][operation_mode]' != 'router'
        Skip    DUT factory default network operation mode is not router.
    END

Access Network Operation Mode Settings Page
    Open Network Menu
    Wait Until Element Is Visible    ${NETWORK_OPMODE_SUBMENU}
    Click Element    ${NETWORK_OPMODE_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${NETWORK_HOSTNAME_INPUT}

Network Hostname Should Be "${hostname}"
    Element Attribute Value Should Be
    ...    ${NETWORK_HOSTNAME_INPUT}
    ...    value    ${hostname}

Set Network Hostname To "${hostname}"
    Input Text
    ...    ${NETWORK_HOSTNAME_INPUT}
    ...    ${hostname}

Set Network Operation Mode To Bridge
    Select From List By Value
    ...    ${NETWORK_OPMODE_SELECT}
    ...    ${NETWORK_OPMODE_SELECT_BRIDGE_VALUE}

Set Network Operation Mode To Router
    Select From List By Value
    ...    ${NETWORK_OPMODE_SELECT}
    ...    ${NETWORK_OPMODE_SELECT_ROUTER_VALUE}

Select NAT Enable Checkbox
    Select Checkbox    ${NETWORK_NAT_ENABLE_CHECKBOX}

Unselect NAT Enable Checkbox
    Unselect Checkbox    ${NETWORK_NAT_ENABLE_CHECKBOX}

Network Operation Mode Settings Should Be Factory Default
    Network Hostname Should Be "${NETWORK_FACTORY_DEFAULT_HOSTNAME}"

    IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'bridge'
        List Selection Should Be
        ...    ${NETWORK_OPMODE_SELECT}
        ...    ${NETWORK_OPMODE_SELECT_BRIDGE_VALUE}
        Element Should Not Be Visible    ${NETWORK_NAT_ENABLE_CHECKBOX}
    ELSE IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'router'
        List Selection Should Be
        ...    ${NETWORK_OPMODE_SELECT}
        ...    ${NETWORK_OPMODE_SELECT_ROUTER_VALUE}
        Element Should Be Visible    ${NETWORK_NAT_ENABLE_CHECKBOX}
        Checkbox Should Be Selected    ${NETWORK_NAT_ENABLE_CHECKBOX}
    ELSE
        Fail    Could not determine DUT factory default network operation mode (check DUT profile).
    END
