*** Settings ***
Documentation       Discovery Service Resource File
...                 
...                 This resource file contains keywords related to discovery
...                 settings webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${DISCOVERY_SUBMENU}                                                    discovery_submenu

${DISCOVERY_BRUTE_FORCE_PROTECT_CHECKBOX}                               brute_force

${DISCOVERY_LLDP_CHECKBOX}                                              discovery_lldp
${DISCOVERY_LLDP_WAN_ACCESS_CHECKBOX}                                   discovery_lldp_wan

${DISCOVERY_CDP_CHECKBOX}                                               discovery_cdp
${DISCOVERY_CDP_WAN_ACCESS_CHECKBOX}                                    discovery_cdp_wan

${DISCOVERY_INTELBRAS_CHECKBOX}                                         discovery_intelbras
${DISCOVERY_INTELBRAS_WAN_ACCESS_CHECKBOX}                              discovery_intelbras_wan

${DISCOVERY_FACTORY_DEFAULT_BRUTE_FORCE_PROTECT_ENABLED}                ${DUT}[profile][features][discovery][brute_force_protection][factory_default][enabled]
${DISCOVERY_FACTORY_DEFAULT_LLDP_PROTOCOL_ENABLED}                      ${DUT}[profile][features][discovery][lldp][factory_default][enabled]
${DISCOVERY_FACTORY_DEFAULT_LLDP_PROTOCOL_WAN_ACCESS_ENABLED}           ${DUT}[profile][features][discovery][lldp][factory_default][wan_access_enabled]
${DISCOVERY_FACTORY_DEFAULT_CDP_PROTOCOL_ENABLED}                       ${DUT}[profile][features][discovery][cdp][factory_default][enabled]
${DISCOVERY_FACTORY_DEFAULT_CDP_PROTOCOL_WAN_ACCESS_ENABLED}            ${DUT}[profile][features][discovery][cdp][factory_default][wan_access_enabled]
${DISCOVERY_FACTORY_DEFAULT_INTELBRAS_PROTOCOL_ENABLED}                 ${DUT}[profile][features][discovery][intelbras][factory_default][enabled]
${DISCOVERY_FACTORY_DEFAULT_INTELBRAS_PROTOCOL_WAN_ACCESS_ENABLED}      ${DUT}[profile][features][discovery][intelbras][factory_default][wan_access_enabled]

*** Keywords ***
Skip This Test If LLDP Discovery Protocol Is Not Supported By DUT
    IF    ${DUT}[profile][features][discovery][lldp][is_supported] == ${FALSE}
        Skip    DUT does not support LLDP discovery protocol.
    END

Skip This Test If CDP Discovery Protocol Is Not Supported By DUT
    IF    ${DUT}[profile][features][discovery][cdp][is_supported] == ${FALSE}
        Skip    DUT does not support CDP discovery protocol.
    END

Skip This Test If Intelbras Discovery Protocol Is Not Supported By DUT
    IF    ${DUT}[profile][features][discovery][intelbras][is_supported] == ${FALSE}
        Skip    DUT does not support Intelbras discovery protocol.
    END

Access Discovery Service Settings Page
    Open Services Menu
    Wait Until Element Is Visible    ${DISCOVERY_SUBMENU}
    Click Element    ${DISCOVERY_SUBMENU}
    Wait For WEB Message To Disappear
    Wait Until Element Is Visible    ${SAVE_SETTINGS_BUTTON}

Select Brute Force Protection Checkbox
    Select Checkbox    ${DISCOVERY_BRUTE_FORCE_PROTECT_CHECKBOX}

Unselect Brute Force Protection Checkbox
    Unselect Checkbox    ${DISCOVERY_BRUTE_FORCE_PROTECT_CHECKBOX}

Select LLDP Discovery Protocol Checkbox
    Select Checkbox    ${DISCOVERY_LLDP_CHECKBOX}

Unselect LLDP Discovery Protocol Checkbox
    Unselect Checkbox    ${DISCOVERY_LLDP_CHECKBOX}

Select LLDP Discovery Protocol WAN Access Checkbox
    Select Checkbox    ${DISCOVERY_LLDP_WAN_ACCESS_CHECKBOX}

Unselect LLPD Discovery Protocol WAN Access Checkbox
    Unselect Checkbox    ${DISCOVERY_LLDP_WAN_ACCESS_CHECKBOX}

Select CDP Discovery Checkbox Protocol
    Select Checkbox    ${DISCOVERY_CDP_CHECKBOX}

Unselect CDP Discovery Checkbox Protocol
    Unselect Checkbox    ${DISCOVERY_CDP_CHECKBOX}

Select CDP Discovery Protocol WAN Access Checkbox
    Select Checkbox    ${DISCOVERY_CDP_WAN_ACCESS_CHECKBOX}

Unselect Discovery Protocol WAN Access Checkbox
    Unselect Checkbox    ${DISCOVERY_CDP_WAN_ACCESS_CHECKBOX}

Select Intelbras Discovery Protocol Checkbox
    Select Checkbox    ${DISCOVERY_INTELBRAS_CHECKBOX}

Unselect Intelbras Discovery Protocol Checkbox
    Unselect Checkbox    ${DISCOVERY_INTELBRAS_CHECKBOX}

Select Intelbras Discovery Protocol WAN Access Checkbox
    Select Checkbox    ${DISCOVERY_INTELBRAS_WAN_ACCESS_CHECKBOX}

Unselect Intelbras Discovery Protocol WAN Access Checkbox
    Select Checkbox    ${DISCOVERY_INTELBRAS_WAN_ACCESS_CHECKBOX}

Discovery Settings Should Be Factory Default
    IF    ${DUT}[profile][features][discovery][brute_force_protection][is_supported] == ${TRUE}
        IF    ${DISCOVERY_FACTORY_DEFAULT_BRUTE_FORCE_PROTECT_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${DISCOVERY_BRUTE_FORCE_PROTECT_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${DISCOVERY_BRUTE_FORCE_PROTECT_CHECKBOX}
        END
    END

    IF    ${DUT}[profile][features][discovery][lldp][is_supported] == ${TRUE}
        IF    ${DISCOVERY_FACTORY_DEFAULT_LLDP_PROTOCOL_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${DISCOVERY_LLDP_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${DISCOVERY_LLDP_CHECKBOX}
        END

        IF    ${DISCOVERY_FACTORY_DEFAULT_LLDP_PROTOCOL_WAN_ACCESS_ENABLED} == ${True}
            Checkbox Should Be Selected    ${DISCOVERY_LLDP_WAN_ACCESS_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${DISCOVERY_LLDP_WAN_ACCESS_CHECKBOX}
        END
    END

    IF    ${DUT}[profile][features][discovery][cdp][is_supported] == ${TRUE}
        IF    ${DISCOVERY_FACTORY_DEFAULT_CDP_PROTOCOL_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${DISCOVERY_CDP_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${DISCOVERY_CDP_CHECKBOX}
        END

        IF    ${DISCOVERY_FACTORY_DEFAULT_CDP_PROTOCOL_WAN_ACCESS_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${DISCOVERY_CDP_WAN_ACCESS_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${DISCOVERY_CDP_WAN_ACCESS_CHECKBOX}
        END
    END

    IF    ${DUT}[profile][features][discovery][intelbras][is_supported] == ${TRUE}
        IF    ${DISCOVERY_FACTORY_DEFAULT_INTELBRAS_PROTOCOL_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${DISCOVERY_INTELBRAS_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${DISCOVERY_INTELBRAS_CHECKBOX}
        END

        IF    ${DISCOVERY_FACTORY_DEFAULT_INTELBRAS_PROTOCOL_WAN_ACCESS_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${DISCOVERY_INTELBRAS_WAN_ACCESS_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${DISCOVERY_INTELBRAS_WAN_ACCESS_CHECKBOX}
        END
    END
