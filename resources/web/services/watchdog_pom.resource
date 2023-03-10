*** Settings ***
Documentation     Watchdog Resource File
...
...               This resource file contains keywords related to watchdog
...               WEB page manipulation (page object model).
Library           SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource          web/common.resource

*** Variables ***
${WATCHDOG_SUBMENU}                             watchdog_submenu
${WATCHDOG_ENABLE_CHECKBOX}                     watchdog_enabled
${WATCHDOG_IP_ADDRESS_1_INPUT}                  watchdog_ip_address_1
${WATCHDOG_IP_ADDRESS_2_INPUT}                  watchdog_ip_address_2
${WATCHDOG_CHECK_INTERVAL_INPUT}                watchdog_interval
${WATCHDOG_FACTORY_DEFAULT}                     ${DUT}[profile][features][watchdog][factory_default]
${WATCHDOG_FACTORY_DEFAULT_ENABLED}             ${WATCHDOG_FACTORY_DEFAULT}[enabled]
${WATCHDOG_FACTORY_DEFAULT_IP_ADDRESS_1}        ${WATCHDOG_FACTORY_DEFAULT}[ip_addr_1]
${WATCHDOG_FACTORY_DEFAULT_IP_ADDRESS_2}        ${WATCHDOG_FACTORY_DEFAULT}[ip_addr_2]
${WATCHDOG_FACTORY_DEFAULT_CHECK_INTERVAL}      ${WATCHDOG_FACTORY_DEFAULT}[check_interval]

*** Keywords ***
Skip This Test If Watchdog Feature Is Not Supported By DUT
    IF    ${DUT}[profile][features][watchdog][is_supported] == ${False}
        Open Services Menu
        Element Should Not Be Visible    ${WATCHDOG_SUBMENU}
        Skip    DUT does not support Watchdog.
    END

Access Watchdog Service Settings Page
    Open Services Menu
    Wait Until Element Is Visible    ${WATCHDOG_SUBMENU}
    Click Element    ${WATCHDOG_SUBMENU}
    Wait For WEB Message To Disappear
    Wait Until Element Is Visible    ${WATCHDOG_ENABLE_CHECKBOX}

Select Watchdog Enable Checkbox
    Select Checkbox    ${WATCHDOG_ENABLE_CHECKBOX}

Unselect Watchdog Enable Checkbox
    Unselect Checkbox    ${WATCHDOG_ENABLE_CHECKBOX}

Watchdog Enable Checkbox Should Be Selected
    Checkbox Should Be Selected    ${WATCHDOG_ENABLE_CHECKBOX}

Watchdog Enable Checkbox Should Not Be Selected
    Checkbox Should Not Be Selected    ${WATCHDOG_ENABLE_CHECKBOX}

Get Current Watchdog IP Address 1 Value
    ${value}    Get Value    ${WATCHDOG_IP_ADDRESS_1_INPUT}
    [Return]    ${value}

Set Watchdog IP Address 1 Value To "${value}"
    Input Text    ${WATCHDOG_IP_ADDRESS_1_INPUT}    ${value}

Watchdog IP Address 1 Should Be Disabled
    Element Should Be Disabled    ${WATCHDOG_IP_ADDRESS_1_INPUT}

Watchdog IP Address 1 Should Be Enabled
    Element Should Be Enabled    ${WATCHDOG_IP_ADDRESS_1_INPUT}

Get Current Watchdog IP Address 2 Value
    ${value}    Get Value    ${WATCHDOG_IP_ADDRESS_2_INPUT}
    [Return]    ${value}

Set Watchdog IP Address 2 Value To "${value}"
    Input Text    ${WATCHDOG_IP_ADDRESS_2_INPUT}    ${value}

Watchdog IP Address 2 Should Be Disabled
    Element Should Be Disabled    ${WATCHDOG_IP_ADDRESS_2_INPUT}

Watchdog IP Address 2 Should Be Enabled
    Element Should Be Enabled    ${WATCHDOG_IP_ADDRESS_2_INPUT}

Get Current Watchdog Check Interval Value
    ${value}    Get Value    ${WATCHDOG_CHECK_INTERVAL_INPUT}
    [Return]    ${value}

Set Watchdog Check Interval Value To "${value}"
    Input Text    ${WATCHDOG_CHECK_INTERVAL_INPUT}    ${value}

Watchdog Check Interval Should Be Disabled
    Element Should Be Disabled    ${WATCHDOG_CHECK_INTERVAL_INPUT}

Watchdog Check Interval Should Be Enabled
    Element Should Be Enabled    ${WATCHDOG_CHECK_INTERVAL_INPUT}

Watchdog Check Interval Should Be "${value}"
    Element Attribute Value Should Be    ${WATCHDOG_CHECK_INTERVAL_INPUT}    value    ${value}

Watchdog IP Address 1 Should Be "${value}"
    Element Attribute Value Should Be    ${WATCHDOG_IP_ADDRESS_1_INPUT}    value    ${value}

Watchdog IP Address 2 Should Be "${value}"
    Element Attribute Value Should Be    ${WATCHDOG_IP_ADDRESS_2_INPUT}    value    ${value}
