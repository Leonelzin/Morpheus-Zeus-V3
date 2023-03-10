*** Settings ***
Documentation       Ethernet Resource File
...                 
...                 This resource file contains keywords related to ethernet
...                 settings webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             Dialogs
Resource            web/sidemenu_pom.resource
Resource            web/network/ethernet_pom.resource

*** Variables ***
${ETH_PROFILE_SECTION}                                  ${DUT}[profile][ethernet]

${ETH_IFACE_1_IS_SUPPORTED}                             ${ETH_PROFILE_SECTION}[interface_1][is_supported]
${ETH_IFACE_1_HTML_ID}                                  ${ETH_PROFILE_SECTION}[interface_1][html_id]

${ETH_IFACE_1_FACTORY_DEFAULT_AUTONEG_ENABLED}          ${ETH_PROFILE_SECTION}[interface_1][factory_default][auto_negotiation][enabled]
${ETH_IFACE_1_FACTORY_DEFAULT_AUTONEG_ADV_10_HALF}      ${ETH_PROFILE_SECTION}[interface_1][factory_default][auto_negotiation][advertisement][10_half]
${ETH_IFACE_1_FACTORY_DEFAULT_AUTONEG_ADV_10_FULL}      ${ETH_PROFILE_SECTION}[interface_1][factory_default][auto_negotiation][advertisement][10_full]
${ETH_IFACE_1_FACTORY_DEFAULT_AUTONEG_ADV_100_HALF}     ${ETH_PROFILE_SECTION}[interface_1][factory_default][auto_negotiation][advertisement][100_half]
${ETH_IFACE_1_FACTORY_DEFAULT_AUTONEG_ADV_100_FULL}     ${ETH_PROFILE_SECTION}[interface_1][factory_default][auto_negotiation][advertisement][100_full]
${ETH_IFACE_1_FACTORY_DEFAULT_AUTONEG_ADV_1000_FULL}    ${ETH_PROFILE_SECTION}[interface_1][factory_default][auto_negotiation][advertisement][1000_full]

${ETH_IFACE_1_FACTORY_DEFAULT_MANUAL_PORT_SPEED}        ${ETH_PROFILE_SECTION}[interface_1][factory_default][manual][port_speed]
${ETH_IFACE_1_FACTORY_DEFAULT_MANUAL_DUPLEX_MODE}       ${ETH_PROFILE_SECTION}[interface_1][factory_default][manual][duplex_mode]

${ETH_IFACE_2_IS_SUPPORTED}                             ${ETH_PROFILE_SECTION}[interface_2][is_supported]
${ETH_IFACE_2_HTML_ID}                                  ${ETH_PROFILE_SECTION}[interface_2][html_id]

${ETH_IFACE_2_FACTORY_DEFAULT_AUTONEG_ENABLED}          ${ETH_PROFILE_SECTION}[interface_2][factory_default][auto_negotiation][enabled]
${ETH_IFACE_2_FACTORY_DEFAULT_AUTONEG_ADV_10_HALF}      ${ETH_PROFILE_SECTION}[interface_2][factory_default][auto_negotiation][advertisement][10_half]
${ETH_IFACE_2_FACTORY_DEFAULT_AUTONEG_ADV_10_FULL}      ${ETH_PROFILE_SECTION}[interface_2][factory_default][auto_negotiation][advertisement][10_full]
${ETH_IFACE_2_FACTORY_DEFAULT_AUTONEG_ADV_100_HALF}     ${ETH_PROFILE_SECTION}[interface_2][factory_default][auto_negotiation][advertisement][100_half]
${ETH_IFACE_2_FACTORY_DEFAULT_AUTONEG_ADV_100_FULL}     ${ETH_PROFILE_SECTION}[interface_2][factory_default][auto_negotiation][advertisement][100_full]
${ETH_IFACE_2_FACTORY_DEFAULT_AUTONEG_ADV_1000_FULL}    ${ETH_PROFILE_SECTION}[interface_2][factory_default][auto_negotiation][advertisement][1000_full]

${ETH_IFACE_2_FACTORY_DEFAULT_MANUAL_PORT_SPEED}        ${ETH_PROFILE_SECTION}[interface_2][factory_default][manual][port_speed]
${ETH_IFACE_2_FACTORY_DEFAULT_MANUAL_DUPLEX_MODE}       ${ETH_PROFILE_SECTION}[interface_2][factory_default][manual][duplex_mode]

${ETH_SUBMENU}                                          ethernet_submenu

${ETH_IFACE_1_AUTONEG_CHECKBOX}                         ${ETH_IFACE_1_HTML_ID}_auto
${ETH_IFACE_1_AUTONEG_ADV_10_HALF_CHECKBOX}             ${ETH_IFACE_1_HTML_ID}_10H
${ETH_IFACE_1_AUTONEG_ADV_10_FULL_CHECKBOX}             ${ETH_IFACE_1_HTML_ID}_10F
${ETH_IFACE_1_AUTONEG_ADV_100_HALF_CHECKBOX}            ${ETH_IFACE_1_HTML_ID}_100H
${ETH_IFACE_1_AUTONEG_ADV_100_FULL_CHECKBOX}            ${ETH_IFACE_1_HTML_ID}_100F
${ETH_IFACE_1_AUTONEG_ADV_1000_FULL_CHECKBOX}           ${ETH_IFACE_1_HTML_ID}_1000F

${ETH_IFACE_2_AUTONEG_CHECKBOX}                         ${ETH_IFACE_2_HTML_ID}_auto
${ETH_IFACE_2_AUTONEG_ADV_10_HALF_CHECKBOX}             ${ETH_IFACE_2_HTML_ID}_10H
${ETH_IFACE_2_AUTONEG_ADV_10_FULL_CHECKBOX}             ${ETH_IFACE_2_HTML_ID}_10F
${ETH_IFACE_2_AUTONEG_ADV_100_HALF_CHECKBOX}            ${ETH_IFACE_2_HTML_ID}_100H
${ETH_IFACE_2_AUTONEG_ADV_100_FULL_CHECKBOX}            ${ETH_IFACE_2_HTML_ID}_100F
${ETH_IFACE_2_AUTONEG_ADV_1000_FULL_CHECKBOX}           ${ETH_IFACE_2_HTML_ID}_1000F

${ETH_IFACE_1_PORT_SPEED_SELECT}                        ${ETH_IFACE_1_HTML_ID}_network_speed
${ETH_IFACE_1_PORT_SPEED_SELECT_10_VALUE}               string:10
${ETH_IFACE_1_PORT_SPEED_SELECT_100_VALUE}              string:100

${ETH_IFACE_1_DUPLEX_MODE_SELECT}                       ${ETH_IFACE_1_HTML_ID}_duplex
${ETH_IFACE_1_DUPLEX_MODE_SELECT_FULL_VALUE}            string:F
${ETH_IFACE_1_DUPLEX_MODE_SELECT_HALF_VALUE}            string:H

${ETH_IFACE_2_PORT_SPEED_SELECT}                        ${ETH_IFACE_2_HTML_ID}_network_speed
${ETH_IFACE_2_PORT_SPEED_SELECT_10_VALUE}               string:10
${ETH_IFACE_2_PORT_SPEED_SELECT_100_VALUE}              string:100

${ETH_IFACE_2_DUPLEX_MODE_SELECT}                       ${ETH_IFACE_2_HTML_ID}_duplex
${ETH_IFACE_2_DUPLEX_MODE_SELECT_FULL_VALUE}            string:F
${ETH_IFACE_2_DUPLEX_MODE_SELECT_HALF_VALUE}            string:H

*** Keywords ***
Access Network Ethernet Settings Page
    Open Network Menu
    Wait Until Element Is Visible    ${ETH_SUBMENU}
    Click Element    ${ETH_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${SAVE_SETTINGS_BUTTON}

Ethernet Interface "${iface}" Auto-Negotiation Advertisement Should Be Factory Default
    IF    ${ETH_IFACE_${iface}_FACTORY_DEFAULT_AUTONEG_ADV_10_HALF} == ${TRUE}
        Checkbox Should Be Selected    ${ETH_IFACE_${iface}_AUTONEG_ADV_10_HALF_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${ETH_IFACE_${iface}_AUTONEG_ADV_10_HALF_CHECKBOX}
    END

    IF    ${ETH_IFACE_${iface}_FACTORY_DEFAULT_AUTONEG_ADV_10_FULL} == ${TRUE}
        Checkbox Should Be Selected    ${ETH_IFACE_${iface}_AUTONEG_ADV_10_FULL_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${ETH_IFACE_${iface}_AUTONEG_ADV_10_FULL_CHECKBOX}
    END

    IF    ${ETH_IFACE_${iface}_FACTORY_DEFAULT_AUTONEG_ADV_100_HALF} == ${TRUE}
        Checkbox Should Be Selected    ${ETH_IFACE_${iface}_AUTONEG_ADV_100_HALF_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${ETH_IFACE_${iface}_AUTONEG_ADV_100_HALF_CHECKBOX}
    END

    IF    ${ETH_IFACE_${iface}_FACTORY_DEFAULT_AUTONEG_ADV_100_FULL} == ${TRUE}
        Checkbox Should Be Selected    ${ETH_IFACE_${iface}_AUTONEG_ADV_100_FULL_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${ETH_IFACE_${iface}_AUTONEG_ADV_100_FULL_CHECKBOX}
    END

    IF    ${ETH_IFACE_${iface}_FACTORY_DEFAULT_AUTONEG_ADV_1000_FULL} == ${TRUE}
        Checkbox Should Be Selected    ${ETH_IFACE_${iface}_AUTONEG_ADV_1000_FULL_CHECKBOX}
    ELSE IF    ${ETH_IFACE_${iface}_FACTORY_DEFAULT_AUTONEG_ADV_1000_FULL} == ${FALSE}
        Checkbox Should Not Be Selected    ${ETH_IFACE_${iface}_AUTONEG_ADV_1000_FULL_CHECKBOX}
    ELSE IF    ${ETH_IFACE_${iface}_FACTORY_DEFAULT_AUTONEG_ADV_1000_FULL} == ${NONE}
        Element Should Not Be Visible    ${ETH_IFACE_${iface}_AUTONEG_ADV_1000_FULL_CHECKBOX}
    END

Ethernet Interface "${iface}" Manual Port Speed Should Be Factory Default
    IF    ${ETH_IFACE_${iface}_FACTORY_DEFAULT_MANUAL_PORT_SPEED} == 10
        List Selection Should Be
        ...    ${ETH_IFACE_${iface}_PORT_SPEED_SELECT}
        ...    ${ETH_IFACE_${iface}_PORT_SPEED_SELECT_10_VALUE}
    ELSE IF    ${ETH_IFACE_${iface}_FACTORY_DEFAULT_MANUAL_PORT_SPEED} == 100
        List Selection Should Be
        ...    ${ETH_IFACE_${iface}_PORT_SPEED_SELECT}
        ...    ${ETH_IFACE_${iface}_PORT_SPEED_SELECT_100_VALUE}
    ELSE
        Fail
        ...    Could not determine DUT factory default ethernet (interface ${iface}) manual port speed (check DUT profile).
    END

Ethernet Interface "${iface}" Duplex Mode Should Be Factory Default
    IF    '${ETH_IFACE_${iface}_FACTORY_DEFAULT_MANUAL_DUPLEX_MODE}' == 'full'
        List Selection Should Be
        ...    ${ETH_IFACE_${iface}_DUPLEX_MODE_SELECT}
        ...    ${ETH_IFACE_${iface}_DUPLEX_MODE_SELECT_FULL_VALUE}
    ELSE IF    '${ETH_IFACE_${iface}_FACTORY_DEFAULT_MANUAL_DUPLEX_MODE}' == 'half'
        List Selection Should Be
        ...    ${ETH_IFACE_${iface}_DUPLEX_MODE_SELECT}
        ...    ${ETH_IFACE_${iface}_DUPLEX_MODE_SELECT_HALF_VALUE}
    ELSE
        Fail
        ...    Could not determine DUT factory default ethernet (interface ${iface}) manual duplex mode (check DUT profile).
    END

Ethernet Interface "${iface}" Settings Should Not Be Visible
    Element Should Not Be Visible    ${ETH_IFACE_${iface}_AUTONEG_CHECKBOX}
    Element Should Not Be Visible    ${ETH_IFACE_${iface}_AUTONEG_ADV_10_HALF_CHECKBOX}
    Element Should Not Be Visible    ${ETH_IFACE_${iface}_AUTONEG_ADV_10_FULL_CHECKBOX}
    Element Should Not Be Visible    ${ETH_IFACE_${iface}_AUTONEG_ADV_100_HALF_CHECKBOX}
    Element Should Not Be Visible    ${ETH_IFACE_${iface}_AUTONEG_ADV_100_FULL_CHECKBOX}
    Element Should Not Be Visible    ${ETH_IFACE_${iface}_AUTONEG_ADV_1000_FULL_CHECKBOX}
    Element Should Not Be Visible    ${ETH_IFACE_${iface}_PORT_SPEED_SELECT}
    Element Should Not Be Visible    ${ETH_IFACE_${iface}_DUPLEX_MODE_SELECT}

Ethernet Settings Should Be Factory Default
    IF    ${ETH_IFACE_1_IS_SUPPORTED} == ${TRUE}
        IF    ${ETH_IFACE_1_FACTORY_DEFAULT_AUTONEG_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${ETH_IFACE_1_AUTONEG_CHECKBOX}
            Ethernet Interface "1" Auto-Negotiation Advertisement Should Be Factory Default
            Element Should Not Be Visible    ${ETH_IFACE_1_PORT_SPEED_SELECT}
            Element Should Not Be Visible    ${ETH_IFACE_1_DUPLEX_MODE_SELECT}
        ELSE
            Checkbox Should Not Be Selected    ${ETH_IFACE_1_AUTONEG_CHECKBOX}
            Element Should Be Visible    ${ETH_IFACE_1_PORT_SPEED_SELECT}
            Ethernet Interface "1" Manual Port Speed Should Be Factory Default
            Element Should Be Visible    ${ETH_IFACE_1_DUPLEX_MODE_SELECT}
            Ethernet Interface "1" Duplex Mode Should Be Factory Default
        END
    ELSE
        Ethernet Interface "1" Settings Should Not Be Visible
    END

    IF    ${ETH_IFACE_2_IS_SUPPORTED} == ${TRUE}
        IF    ${ETH_IFACE_2_FACTORY_DEFAULT_AUTONEG_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${ETH_IFACE_2_AUTONEG_CHECKBOX}
            Ethernet Interface "2" Auto-Negotiation Advertisement Should Be Factory Default
            Element Should Not Be Visible    ${ETH_IFACE_2_PORT_SPEED_SELECT}
            Element Should Not Be Visible    ${ETH_IFACE_2_DUPLEX_MODE_SELECT}
        ELSE
            Checkbox Should Not Be Selected    ${ETH_IFACE_2_AUTONEG_CHECKBOX}
            Element Should Be Visible    ${ETH_IFACE_2_PORT_SPEED_SELECT}
            Ethernet Interface "2" Manual Port Speed Should Be Factory Default
            Element Should Be Visible    ${ETH_IFACE_2_DUPLEX_MODE_SELECT}
            Ethernet Interface "2" Duplex Mode Should Be Factory Default
        END
    ELSE
        Ethernet Interface "2" Settings Should Not Be Visible
    END
