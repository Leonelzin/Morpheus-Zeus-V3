*** Settings ***
Documentation       Firewall Advanced Resource File
...
...                 This resource file contains keywords related
...                 to firewall advanced WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${FIREWALL_ADVANCED_SUBMENU}                                firewallAdvanced_submenu
${FIREWALL_ADVANCED_MESSAGE}                                zeusNotifyMessage
${FIREWALL_ADVANCED_WEB_MESSAGE}                            Atenção: as configurações a seguir exigem um grau avançado de conhecimento sobre redes. Apenas altere as opções de firewall se tiver plena ciência dos efeitos em sua rede.

${FIREWALL_ADVANCED_FACTORY_DEFAULT}                        ${DUT}[profile][firewall][advanced][factory_default]
${FIREWALL_ADVANCED_FACTORY_DEFAULT_DESCRIPTION}            ${FIREWALL_ADVANCED_FACTORY_DEFAULT}[description]
${FIREWALL_ADVANCED_FACTORY_DEFAULT_SOURCE_IP}              ${FIREWALL_ADVANCED_FACTORY_DEFAULT}[source_ip]
${FIREWALL_ADVANCED_FACTORY_DEFAULT_SOURCE_PORT}            ${FIREWALL_ADVANCED_FACTORY_DEFAULT}[source_port]
${FIREWALL_ADVANCED_FACTORY_DEFAULT_DESTINATION_IP}         ${FIREWALL_ADVANCED_FACTORY_DEFAULT}[destination_ip]
${FIREWALL_ADVANCED_FACTORY_DEFAULT_DESTINATION_PORT}       ${FIREWALL_ADVANCED_FACTORY_DEFAULT}[destination_port]
${FIREWALL_ADVANCED_FACTORY_DEFAULT_PROTOCOL}               ${FIREWALL_ADVANCED_FACTORY_DEFAULT}[protocol]
${FIREWALL_ADVANCED_FACTORY_DEFAULT_ACTION}                 ${FIREWALL_ADVANCED_FACTORY_DEFAULT}[action]

${FIREWALL_ADVANCED_DESCRIPTION_INPUT}                      description
${FIREWALL_ADVANCED_IP_SOURCE_NETWORK_CHECKBOX}             denial_ip_source_network
${FIREWALL_ADVANCED_IP_SOURCE_NETWORK_INPUT}                ip_source_network
${FIREWALL_ADVANCED_SOURCE_PORT_CHECKBOX}                   denial_source_port
${FIREWALL_ADVANCED_SOURCE_PORT_INPUT}                      source_port
${FIREWALL_ADVANCED_IP_DESTINATION_NETWORK_CHECKBOX}        denial_ip_destiny_network
${FIREWALL_ADVANCED_IP_DESTINATION_NETWORK_INPUT}           ip_destiny_network
${FIREWALL_ADVANCED_DESTINATION_PORT_CHECKBOX}              denial_destiny_port
${FIREWALL_ADVANCED_DESTINATION_PORT_INPUT}                 destiny_port

${FIREWALL_ADVANCED_PROTOCOL_INPUT}                         protocol
${FIREWALL_ADVANCED_PROTOCOL_BUTTON}                        protocol_button
${FIREWALL_ADVANCED_SELECTION_PROTOCOL_INPUT}               xpath:/html/body/div[4]/div/div/div[2]/input
${FIREWALL_ADVANCED_SELECTION_PROTOCOL_TABLE}               xpath:/html/body/div[4]/div/div/div[2]/table
${FIREWALL_ADVANCED_SELECTION_PROTOCOL_CANCEL_BUTTON}       xpath:/html/body/div[4]/div/div/div[3]/button

${FIREWALL_ADVANCED_ACTION_SELECT}                          action
${FIREWALL_ADVANCED_ACTION_SELECT_ALLOW_VALUE}              string:accept
${FIREWALL_ADVANCED_ACTION_SELECT_ALLOW_LABEL}              Liberar
${FIREWALL_ADVANCED_ACTION_SELECT_BLOCK_VALUE}              string:reject
${FIREWALL_ADVANCED_ACTION_SELECT_BLOCK_LABEL}              Bloquear

${FIREWALL_ADVANCED_TABLE}                                  xpath://*[@id="main"]/div[2]/div/div/div/div/div/form/div
${FIREWALL_ADVANCED_TABLE_REMOVE_BUTTON}                    xpath://*[@id="mac_table"]/tbody/tr/td[9]/button
${FIREWALL_ADVANCED_ADD_BUTTON}                             add_button
${FIREWALL_ADVANCED_SAVE_BUTTON}                            salvar_button




*** Keywords ***
Access Firewall Advanced Settings Page
    Open Firewall Menu
    Wait Until Element Is Visible    ${FIREWALL_ADVANCED_SUBMENU}
    Click Element    ${FIREWALL_ADVANCED_SUBMENU}
    Wait Until WEB Message Is "${FIREWALL_ADVANCED_WEB_MESSAGE}" Or Timeout After "60" Seconds
    Dismiss Current Displayed WEB Message
    Wait Until Element Is Visible    ${FIREWALL_ADVANCED_DESCRIPTION_INPUT}

Firewall Advanced Should Be Any Rule in Factory Default
    Element Should Not Be Visible    ${FIREWALL_ADVANCED_TABLE_REMOVE_BUTTON} 

Firewall Advanced Should Be Factory Default
    Element Should Be Visible    ${FIREWALL_ADVANCED_DESCRIPTION_INPUT}
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_DESCRIPTION_INPUT}
    ...    value    ${EMPTY}

    Element Should Be Visible    ${FIREWALL_ADVANCED_IP_SOURCE_NETWORK_CHECKBOX}
    Checkbox Should Not Be Selected    ${FIREWALL_ADVANCED_IP_SOURCE_NETWORK_CHECKBOX}
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_IP_SOURCE_NETWORK_INPUT}
    ...    value    ${EMPTY}

    Element Should Be Visible    ${FIREWALL_ADVANCED_SOURCE_PORT_CHECKBOX}
    Checkbox Should Not Be Selected    ${FIREWALL_ADVANCED_SOURCE_PORT_CHECKBOX}
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_SOURCE_PORT_INPUT}
    ...    value    ${EMPTY}
    
    Element Should Be Visible    ${FIREWALL_ADVANCED_IP_DESTINATION_NETWORK_CHECKBOX}
    Checkbox Should Not Be Selected    ${FIREWALL_ADVANCED_IP_DESTINATION_NETWORK_CHECKBOX}
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_IP_DESTINATION_NETWORK_INPUT}
    ...    value    ${EMPTY}

    Element Should Be Visible    ${FIREWALL_ADVANCED_DESTINATION_PORT_CHECKBOX}
    Checkbox Should Not Be Selected    ${FIREWALL_ADVANCED_DESTINATION_PORT_CHECKBOX}
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_DESTINATION_PORT_INPUT}
    ...    value    ${EMPTY}

    Element Should Be Visible    ${FIREWALL_ADVANCED_PROTOCOL_INPUT}
    Element Should Be Disabled    ${FIREWALL_ADVANCED_PROTOCOL_INPUT}
    Element Should Be Visible    ${FIREWALL_ADVANCED_PROTOCOL_BUTTON}

    Element Should Be Visible    ${FIREWALL_ADVANCED_ACTION_SELECT}
    IF    '${FIREWALL_ADVANCED_FACTORY_DEFAULT_ACTION}' == 'allow'
        List Selection Should Be
        ...    ${FIREWALL_ADVANCED_ACTION_SELECT}
        ...    ${FIREWALL_ADVANCED_ACTION_SELECT_ALLOW_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_ADVANCED_ACTION_SELECT}
        ...    ${FIREWALL_ADVANCED_ACTION_SELECT_ALLOW_LABEL}

    ELSE IF    '${FIREWALL_ADVANCED_FACTORY_DEFAULT_ACTION}' == 'block'
        List Selection Should Be
        ...    ${FIREWALL_ADVANCED_ACTION_SELECT}
        ...    ${FIREWALL_ADVANCED_ACTION_SELECT_BLOCK_VALUE}
        List Selection Should Be
        ...    ${FIREWALL_ADVANCED_ACTION_SELECT}
        ...    ${FIREWALL_ADVANCED_ACTION_SELECT_BLOCK_LABEL}
    ELSE 
        Fail
        ...    Could not determine DUT factory default advanced action.
    END

    Element Should Be Visible    ${FIREWALL_ADVANCED_TABLE}
    Element Should Be Visible    ${FIREWALL_ADVANCED_ADD_BUTTON}
    Element Should Be Disabled    ${FIREWALL_ADVANCED_SAVE_BUTTON}
    Firewall Advanced Should Be Any Rule in Factory Default

    Click Button    ${FIREWALL_ADVANCED_PROTOCOL_BUTTON}
    Wait Until Element Is Visible    ${FIREWALL_ADVANCED_SELECTION_PROTOCOL_TABLE}
    Element Should Be Visible    ${FIREWALL_ADVANCED_SELECTION_PROTOCOL_CANCEL_BUTTON}
    Element Attribute Value Should Be
    ...    ${FIREWALL_ADVANCED_SELECTION_PROTOCOL_INPUT}
    ...    value    ${EMPTY}

