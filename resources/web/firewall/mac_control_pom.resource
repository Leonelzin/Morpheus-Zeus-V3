*** Settings ***
Documentation       Firewall MAC Control Resource File
...
...                 This resource file contains keywords related
...                 to firewall MAC control WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT}                         ${DUT}[profile][firewall][mac_control][factory_default]
${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT_ACTION}                  ${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT}[action]
${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT_DESCRIPTION}             ${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT}[description]
${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT_MAC}                     ${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT}[mac]

${FIREWALL_MAC_CONTROL_SUBMENU}                                 controlByMAC_submenu
${FIREWALL_MAC_CONTROL_ACTION_SELECT}                           mac_action
${FIREWALL_MAC_CONTROL_ACTION_SELECT_ALLOW_VALUE}               string:accept
${FIREWALL_MAC_CONTROL_ACTION_SELECT_BLOCK_VALUE}               string:reject
${FIREWALL_MAC_CONTROL_DESCRIPTION_INPUT}                       mac_descrition
${FIREWALL_MAC_CONTROL_MAC_ADDRESS_INPUT}                       mac
${FIREWALL_MAC_CONTROL_MAC_RULES_TABLE}                         mac_table
${FIREWALL_MAC_CONTROL_ADD_RULE_BUTTON}                         add_button
#TODO: map firewall rules table variables below
${FIREWALL_MAC_CONTROL_RULE_ENABLE_TABLE_CELL_CHECKBOX}         TODO
${FIREWALL_MAC_CONTROL_RULE_DESCRIPTION_TABLE_CELL_INPUT}       TODO
${FIREWALL_MAC_CONTROL_RULE_MAC_ADDRESS_TABLE_CELL_INPUT}       TODO
${FIREWALL_MAC_CONTROL_RULE_ACTION_TABLE_CELL_SELECT}           TODO

${FIREWALL_MAC_CONTROL_ACTION_SELECT}                           mac_action
${FIREWALL_MAC_CONTROL_ACTION_SELECT_ALLOW_VALUE}               string:accept
${FIREWALL_MAC_CONTROL_ACTION_SELECT_BLOCK_VALUE}               string:reject
${FIREWALL_MAC_CONTROL_ACTION_SELECT_ALLOW_LABEL}               Liberar
${FIREWALL_MAC_CONTROL_ACTION_SELECT_BLOCK_LABEL}               Bloquear

${FIREWALL_MAC_CONTROL_DESCRIPTION_INPUT}                       mac_descrition
${FIREWALL_MAC_CONTROL_MAC_INPUT}                               mac

${FIREWALL_MAC_CONTROL_MAC_TABLE}                               mac_table

${FIREWALL_MAC_CONTROL_ADD_BUTTON}                              add_button
${FIREWALL_MAC_CONTROL_REMOVE_RULE_BUTTON}                      xpath://*[@id="mac_table"]/tbody/tr/td[5]/button

*** Keywords ***
Access Firewall MAC Control Settings Page
    Open Firewall Menu
    Wait Until Element Is Visible    ${FIREWALL_MAC_CONTROL_SUBMENU}
    Click Element    ${FIREWALL_MAC_CONTROL_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "20" Seconds
    Wait Until Element Is Visible    ${FIREWALL_MAC_CONTROL_ACTION_SELECT}

Set Firewall Action To Allow
    Select from list by value    ${FIREWALL_MAC_CONTROL_ACTION_SELECT}
    ...    ${FIREWALL_MAC_CONTROL_ACTION_SELECT_ALLOW_VALUE}

Set Firewall Action To Block
    Select from list by value    ${FIREWALL_MAC_CONTROL_ACTION_SELECT}
    ...    ${FIREWALL_MAC_CONTROL_ACTION_SELECT_BLOCK_VALUE}

Set Firewall Description To "${value}"
    Input text    ${FIREWALL_MAC_CONTROL_DESCRIPTION_INPUT}    ${value}

Set Firewall MAC Address To "${value}"
    Input text    ${FIREWALL_MAC_CONTROL_MAC_ADDRESS_INPUT}    ${value}

Click Add Rule Button
    Click Button    ${FIREWALL_MAC_CONTROL_ADD_RULE_BUTTON}

Firewall MAC Control Description Should Be "${description}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_MAC_CONTROL_DESCRIPTION_INPUT}
    ...    value    ${description}

Firewall MAC Control MAC Should Be "${mac}"
    Element Attribute Value Should Be
    ...    ${FIREWALL_MAC_CONTROL_MAC_INPUT}
    ...    value    ${mac}

Firewall MAC Control Settings Should Be Factory Default
    IF    '${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT_ACTION}' == 'allow'
        List Selection Should Be
        ...    ${FIREWALL_MAC_CONTROL_ACTION_SELECT}
        ...    ${FIREWALL_MAC_CONTROL_ACTION_SELECT_ALLOW_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_MAC_CONTROL_ACTION_SELECT}
        ...    ${FIREWALL_MAC_CONTROL_ACTION_SELECT_ALLOW_LABEL}
    ELSE IF    '${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT_ACTION}' == 'block'
        List Selection Should Be
        ...    ${FIREWALL_MAC_CONTROL_ACTION_SELECT}
        ...    ${FIREWALL_MAC_CONTROL_ACTION_SELECT_BLOCK_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_MAC_CONTROL_ACTION_SELECT}
        ...    ${FIREWALL_MAC_CONTROL_ACTION_SELECT_BLOCK_LABEL}
    ELSE 
        Fail
        ...    Could not determine DUT factory default firewall action.
    END

    Firewall MAC Control Description Should Be "${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT_DESCRIPTION}"
    Firewall MAC Control MAC Should Be "${FIREWALL_MAC_CONTROL_FACTORY_DEFAULT_MAC}"

    Element Should Be Visible    ${FIREWALL_MAC_CONTROL_MAC_TABLE}

    Element Should Be Visible    ${FIREWALL_MAC_CONTROL_ADD_BUTTON}
    Element Should Be Enabled    ${FIREWALL_MAC_CONTROL_ADD_BUTTON}
    Element Should Not Be Visible    ${FIREWALL_MAC_CONTROL_REMOVE_RULE_BUTTON}  
