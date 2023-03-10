*** Settings ***
Documentation       SNMP Resource File
...                 
...                 This resource file contains keywords related to SNMP
...                 settings webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/network/operation_mode_pom.resource

*** Variables ***
${SNMP_FACTORY_DEFAULT}                         ${DUT}[profile][features][snmp][factory_default]
${SNMP_FACTORY_DEFAULT_ENABLED}                 ${SNMP_FACTORY_DEFAULT}[enabled]
${SNMP_FACTORY_DEFAULT_WAN_ACCESS_ENABLED}      ${SNMP_FACTORY_DEFAULT}[wan_access_enabled]
${SNMP_FACTORY_DEFAULT_COMMUNITY}               ${SNMP_FACTORY_DEFAULT}[community]
${SNMP_FACTORY_DEFAULT_PORT}                    ${SNMP_FACTORY_DEFAULT}[port]
${SNMP_FACTORY_DEFAULT_LOCATION}                ${SNMP_FACTORY_DEFAULT}[location]
${SNMP_FACTORY_DEFAULT_CONTACT}                 ${SNMP_FACTORY_DEFAULT}[contact]
${SNMP_FACTORY_DEFAULT_NAME}                    ${SNMP_FACTORY_DEFAULT}[name]

${SNMP_SUBMENU}                                 snmp_submenu
${SNMP_ENABLE_CHECKBOX}                         snmp_snmp
${SNMP_WAN_ACCESS_CHECKBOX}                     wan_access_snmp
${SNMP_COMMUNITY_INPUT}                         snmp_community
${SNMP_PORT_INPUT}                              snmp_port
${SNMP_LOCATION_INPUT}                          snmp_location
${SNMP_CONTACT_INPUT}                           snmp_contact
${SNMP_NAME_INPUT}                              snmp_name

*** Keywords ***
Skip This Test If SNMP Feature Is Not Supported By DUT
    IF    ${DUT}[profile][features][snmp][is_supported] == ${FALSE}
        Skip    DUT does not support SNMP.
    END

Access SNMP Service Settings Page
    Open Services Menu
    Wait Until Element Is Visible    ${SNMP_SUBMENU}
    Click Element    ${SNMP_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${SNMP_ENABLE_CHECKBOX}

Select SNMP Enable Checkbox
    Select Checkbox    ${SNMP_ENABLE_CHECKBOX}

Unselect SNMP Enable Checkbox
    Unselect Checkbox    ${SNMP_ENABLE_CHECKBOX}

Select SNMP WAN Access Checkbox
    Select Checkbox    ${SNMP_WAN_ACCESS_CHECKBOX}

Unselect SNMP WAN Access Checkbox
    Unselect Checkbox    ${SNMP_WAN_ACCESS_CHECKBOX}

Set SNMP Community To "${community}"
    Input Text    ${SNMP_COMMUNITY_INPUT}    ${community}

Set SNMP Port To "${port}"
    Input Text    ${SNMP_PORT_INPUT}    ${port}

Set SNMP Location To "${location}"
    Input Text    ${SNMP_LOCATION_INPUT}    ${location}

Set SNMP Contact To "${contact}"
    Input Text    ${SNMP_CONTACT_INPUT}    ${contact}

Set SNMP Name To "${name}"
    Input Text    ${SNMP_NAME_INPUT}    ${name}

SNMP Community Should Be "${community}"
    Element Attribute Value Should Be
    ...    ${SNMP_COMMUNITY_INPUT}
    ...    value    ${community}

SNMP Port Should Be "${port}"
    Element Attribute Value Should Be
    ...    ${SNMP_PORT_INPUT}
    ...    value    ${port}

SNMP Location Should Be "${location}"
    Element Attribute Value Should Be
    ...    ${SNMP_LOCATION_INPUT}
    ...    value    ${location}

SNMP Contact Should Be "${contact}"
    Element Attribute Value Should Be
    ...    ${SNMP_CONTACT_INPUT}
    ...    value    ${contact}

SNMP Name Should Be "${name}"
    Element Attribute Value Should Be
    ...    ${SNMP_NAME_INPUT}
    ...    value    ${name}

SNMP Settings Should Be Factory Default
    IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'bridge'
        Element Should Not Be Visible    ${SNMP_WAN_ACCESS_CHECKBOX}
    END

    IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'router'
        IF    ${SNMP_FACTORY_DEFAULT_WAN_ACCESS_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${SNMP_WAN_ACCESS_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${SNMP_WAN_ACCESS_CHECKBOX}
        END
    END

    SNMP Community Should Be "${SNMP_FACTORY_DEFAULT_COMMUNITY}"
    SNMP Port Should Be "${SNMP_FACTORY_DEFAULT_PORT}"
    SNMP Location Should Be "${SNMP_FACTORY_DEFAULT_LOCATION}"
    SNMP Contact Should Be "${SNMP_FACTORY_DEFAULT_CONTACT}"
    SNMP Name Should Be "${SNMP_FACTORY_DEFAULT_NAME}"

    IF    ${SNMP_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'router'
            Element Should Be Enabled    ${SNMP_WAN_ACCESS_CHECKBOX}
        END
        Element Should Be Enabled    ${SNMP_COMMUNITY_INPUT}
        Element Should Be Enabled    ${SNMP_PORT_INPUT}
        Element Should Be Enabled    ${SNMP_LOCATION_INPUT}
        Element Should Be Enabled    ${SNMP_CONTACT_INPUT}
        Element Should Be Enabled    ${SNMP_NAME_INPUT}
    ELSE
        IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'router'
            Element Should Be Disabled    ${SNMP_WAN_ACCESS_CHECKBOX}
        END
        Element Should Be Disabled    ${SNMP_COMMUNITY_INPUT}
        Element Should Be Disabled    ${SNMP_PORT_INPUT}
        Element Should Be Disabled    ${SNMP_LOCATION_INPUT}
        Element Should Be Disabled    ${SNMP_CONTACT_INPUT}
        Element Should Be Disabled    ${SNMP_NAME_INPUT}
    END
