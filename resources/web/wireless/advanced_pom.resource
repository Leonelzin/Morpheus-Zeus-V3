*** Settings ***
Documentation       Wireless Advanced Features Resource File
...                 
...                 This resource file contains keywords related to wireless
...                 advanced settings WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource

*** Variables ***
${WIRELESS_ADVANCED_SUBMENU}                            advanced_submenu

${ROAMING_ACCORDION_HEADER}                             roaming_accordion_header
${ASSISTED_ROAMING_802_11_KV_ENABLE_CHECKBOX}           assisted_roaming
${FAST_ROAMING_802_11_R_ENABLE_CHECKBOX}                fast_roaming

${QCA_SMART_HANDOVER_ENABLE_CHECKBOX}                   smart_handover
${QCA_SMART_HANDOVER_SET_AS_MAIN_CHECKBOX}              smart_handover_main

${BAND_STEERING_ACCORDION_HEADER}                       band_steering_accordion_header
${BAND_STEERING_ENABLE_CHECKBOX}                        band_steering
${BAND_STEERING_METHOD_SELECT}                          band_steering_type
${BAND_STEERING_METHOD_SELECT_5G_PRIORIZATION_VALUE}    string:5g_prioritization
${BAND_STEERING_METHOD_SELECT_LOAD_BALANCE_VALUE}       string:loadbalance

${MU_MIMO_ACCORDION_HEADER}                             mu_mimo_accordion_header
${MU_MIMO_ENABLE_CHECKBOX}                              mu_mimo

${BEAMFORMING_ACCORDION_HEADER}                         beamforming_accordion_header
${BEAMFORMING_ENABLE_CHECKBOX}                          beamforming

${ASSISTED_ROAMING_FACTORY_DEFAULT}                     ${DUT}[profile][wireless][assisted_roaming][factory_default]
${ASSISTED_ROAMING_FACTORY_DEFAULT_ENABLED}             ${ASSISTED_ROAMING_FACTORY_DEFAULT}[enabled]

${FAST_ROAMING_FACTORY_DEFAULT}                         ${DUT}[profile][wireless][fast_roaming][factory_default]
${FAST_ROAMING_FACTORY_DEFAULT_ENABLED}                 ${FAST_ROAMING_FACTORY_DEFAULT}[enabled]

${QCA_SMART_HANDOVER_FACTORY_DEFAULT}                   ${DUT}[profile][wireless][qca_smart_handover][factory_default]
${QCA_SMART_HANDOVER_FACTORY_DEFAULT_ENABLED}           ${QCA_SMART_HANDOVER_FACTORY_DEFAULT}[enabled]
${QCA_SMART_HANDOVER_FACTORY_DEFAULT_IS_MAIN_AP}        ${QCA_SMART_HANDOVER_FACTORY_DEFAULT}[is_main_ap]

${BAND_STEERING_FACTORY_DEFAULT}                        ${DUT}[profile][wireless][band_steering][factory_default]
${BAND_STEERING_FACTORY_DEFAULT_ENABLED}                ${BAND_STEERING_FACTORY_DEFAULT}[enabled]
${BAND_STEERING_FACTORY_DEFAULT_METHOD}                 ${BAND_STEERING_FACTORY_DEFAULT}[method]

${MU_MIMO_FACTORY_DEFAULT}                              ${DUT}[profile][wireless][mu_mimo][factory_default]
${MU_MIMO_FACTORY_DEFAULT_ENABLED}                      ${MU_MIMO_FACTORY_DEFAULT}[enabled]

${BEAMFORMING_FACTORY_DEFAULT}                          ${DUT}[profile][wireless][beamforming][factory_default]
${BEAMFORMING_FACTORY_DEFAULT_ENABLED}                  ${BEAMFORMING_FACTORY_DEFAULT}[enabled]

*** Keywords ***
Skip This Test If Wireless Assisted Roaming Feature Is Not Supported By DUT
    IF    ${DUT}[profile][wireless][assisted_roaming][is_supported] == ${FALSE}
        Skip    DUT does not support wireless assisted roaming (802.11k/v).
    END

Skip This Test If Wireless Fast Roaming Feature Is Not Supported By DUT
    IF    ${DUT}[profile][wireless][fast_roaming][is_supported] == ${FALSE}
        Skip    DUT does not support wireless fast roaming (802.11r).
    END

Skip This Test If Qualcomm Smart Handover Feature Is Not Supported By DUT
    IF    ${DUT}[profile][wireless][qca_smart_handover][is_supported] == ${FALSE}
        Skip    DUT does not support Qualcomm smart handover.
    END

Skip This Test If Band Steering Feature Is Not Supported By DUT
    IF    ${DUT}[profile][wireless][band_steering][is_supported] == ${FALSE}
        Skip    DUT does not support band steering.
    END

Skip This Test If MU-MIMO Feature Is Not Supported By DUT
    IF    ${DUT}[profile][wireless][mu_mimo][is_supported] == ${FALSE}
        Skip    DUT does not support MU-MIMO.
    END

Skip This Test If Beamforming Feature Is Not Supported By DUT
    IF    ${DUT}[profile][wireless][beamforming][is_supported] == ${FALSE}
        Skip    DUT does not support Beamforming.
    END

Access Wireless Advanced Settings Page
    Open Wireless Menu
    Wait Until Element Is Visible    ${WIRELESS_ADVANCED_SUBMENU}
    Click Element    ${WIRELESS_ADVANCED_SUBMENU}
    Wait For WEB Message To Disappear
    Wait "2" Seconds For WEB Animation To Finish

Select Wireless Advanced Assisted Roaming Enable Checkbox
    Select Checkbox    ${ASSISTED_ROAMING_802_11_KV_ENABLE_CHECKBOX}

Unselect Wireless Advanced Assisted Roaming Enable Checkbox
    Unselect Checkbox    ${ASSISTED_ROAMING_802_11_KV_ENABLE_CHECKBOX}

Select Wireless Advanced Smart Handover Enable Checkbox
    Select Checkbox    ${QCA_SMART_HANDOVER_ENABLE_CHECKBOX}

Unselect Wireless Advanced Smart Handover Enable Checkbox
    Unselect Checkbox    ${QCA_SMART_HANDOVER_ENABLE_CHECKBOX}

Select Wireless Advanced Smart Handover Set AP As Main Checkbox
    Select Checkbox    ${QCA_SMART_HANDOVER_SET_AS_MAIN_CHECKBOX}

Unselect Wireless Advanced Smart Handover Set AP As Main Checkbox
    Unselect Checkbox    ${QCA_SMART_HANDOVER_SET_AS_MAIN_CHECKBOX}

Select Wireless Advanced Band Steering Enable Checkbox
    Select Checkbox    ${BAND_STEERING_ENABLE_CHECKBOX}

Unselect Wireless Advanced Band Steering Enable Checkbox
    Unselect Checkbox    ${BAND_STEERING_ENABLE_CHECKBOX}

Set Wireless Advanced Band Steering Method To 5GHz Priorization
    Select From List By Value
    ...    ${BAND_STEERING_METHOD_SELECT}
    ...    ${BAND_STEERING_METHOD_SELECT_5G_PRIORIZATION_VALUE}

Set Wireless Advanced Band Steering Method To Load Balance
    Select From List By Value
    ...    ${BAND_STEERING_METHOD_SELECT}
    ...    ${BAND_STEERING_METHOD_SELECT_LOAD_BALANCE_VALUE}

Select Wireless Advanced Multi-User MIMO Enable Checkbox
    Select Checkbox    ${MU_MIMO_ENABLE_CHECKBOX}

Unselect Wireless Advanced Multi-User MIMO Enable Checkbox
    Unselect Checkbox    ${MU_MIMO_ENABLE_CHECKBOX}

Select Wireless Advanced Beamforming Enable Checkbox
    Select Checkbox    ${BEAMFORMING_ENABLE_CHECKBOX}

Unselect Wireless Advanced Beamforming Enable Checkbox
    Unselect Checkbox    ${BEAMFORMING_ENABLE_CHECKBOX}

Assisted Roaming Settings Should Be Factory Default
    IF    ${ASSISTED_ROAMING_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${ASSISTED_ROAMING_802_11_KV_ENABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${ASSISTED_ROAMING_802_11_KV_ENABLE_CHECKBOX}
    END

Fast Roaming Settings Should Be Factory Default
    IF    ${FAST_ROAMING_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${FAST_ROAMING_802_11_R_ENABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${FAST_ROAMING_802_11_R_ENABLE_CHECKBOX}
    END

Qualcomm Smart Handover Settings Should Be Factory Default
    IF    ${QCA_SMART_HANDOVER_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${QCA_SMART_HANDOVER_ENABLE_CHECKBOX}
        Element Should Be Enabled    ${QCA_SMART_HANDOVER_SET_AS_MAIN_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${QCA_SMART_HANDOVER_ENABLE_CHECKBOX}
        Element Should Be Disabled    ${QCA_SMART_HANDOVER_SET_AS_MAIN_CHECKBOX}
    END

    IF    ${QCA_SMART_HANDOVER_FACTORY_DEFAULT_IS_MAIN_AP} == ${TRUE}
        Checkbox Should Be Selected    ${QCA_SMART_HANDOVER_SET_AS_MAIN_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${QCA_SMART_HANDOVER_SET_AS_MAIN_CHECKBOX}
    END

Band Steering Handover Settings Should Be Factory Default
    IF    ${BAND_STEERING_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${BAND_STEERING_ENABLE_CHECKBOX}
        Element Should Be Visible    ${BAND_STEERING_METHOD_SELECT}
    ELSE
        Checkbox Should Not Be Selected    ${BAND_STEERING_ENABLE_CHECKBOX}
        Element Should Not Be Visible    ${BAND_STEERING_METHOD_SELECT}
    END

    IF    '${BAND_STEERING_FACTORY_DEFAULT_METHOD}' == 'load_balance'
        List Selection Should Be
        ...    ${BAND_STEERING_METHOD_SELECT}
        ...    ${BAND_STEERING_METHOD_SELECT_LOAD_BALANCE_VALUE}
    ELSE IF    '${BAND_STEERING_FACTORY_DEFAULT_METHOD}' == '5ghz_priorization'
        List Selection Should Be
        ...    ${BAND_STEERING_METHOD_SELECT}
        ...    ${BAND_STEERING_METHOD_SELECT_5G_PRIORIZATION_VALUE}
    END

MU-MIMO Settings Should Be Factory Default
    IF    ${MU_MIMO_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${MU_MIMO_ENABLE_CHECKBOX}
        IF    ${DUT}[profile][wireless][beamforming][is_supported] == ${TRUE}
            Element Should Be Disabled    ${BEAMFORMING_ENABLE_CHECKBOX}
            Checkbox Should Be Selected    ${BEAMFORMING_ENABLE_CHECKBOX}
        END
    ELSE
        Checkbox Should Not Be Selected    ${MU_MIMO_ENABLE_CHECKBOX}
        IF    ${DUT}[profile][wireless][beamforming][is_supported] == ${TRUE}
            Element Should Be Enabled    ${BEAMFORMING_ENABLE_CHECKBOX}
        END
    END

Beamforming Settings Should Be Factory Default
    IF    ${BEAMFORMING_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${BEAMFORMING_ENABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${BEAMFORMING_ENABLE_CHECKBOX}
    END
