*** Settings ***
Documentation       System Log Resource File
...                 
...                 This resource file contains keywords related to system log
...                 webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Resource            web/common.resource

*** Variables ***
${LOG_IS_SUPPORTED}                             ${DUT}[profile][features][log][is_supported]

${LOG_FACTORY_DEFAULT}                          ${DUT}[profile][features][log][factory_default]
${LOG_FACTORY_DEFAULT_ENABLED}                  ${LOG_FACTORY_DEFAULT}[enabled]
${LOG_FACTORY_DEFAULT_LEVEL}                    ${LOG_FACTORY_DEFAULT}[level]
${LOG_FACTORY_DEFAULT_REMOTE_SERVER_ENABLED}    ${LOG_FACTORY_DEFAULT}[send_log_to_remote_server]
${LOG_FACTORY_DEFAULT_REMOTE_SERVER_IP}         ${LOG_FACTORY_DEFAULT}[remote_server_ip]
${LOG_FACTORY_DEFAULT_REMOTE_SERVER_PORT}       ${LOG_FACTORY_DEFAULT}[port]

${LOG_SUBMENU}                                  log_submenu

${LOG_LEVEL_SELECT}                             log_level
${LOG_LEVEL_SELECT_OFF_VALUE}                   string:LOG_OFF
${LOG_LEVEL_SELECT_ERROR_VALUE}                 string:LOG_ERR
${LOG_LEVEL_SELECT_WARNING_VALUE}               string:LOG_WARNING
${LOG_LEVEL_SELECT_INFO_VALUE}                  string:LOG_INFO
${LOG_LEVEL_SELECT_DEBUG_VALUE}                 string:LOG_DEBUG

${LOG_REMOTE_SERVER_ENABLE_CHECKBOX}            log_remote
${LOG_REMOTE_SERVER_IP_ADDRESS_INPUT}           log_ip_address
${LOG_REMOTE_SERVER_PORT_INPUT}                 log_port

${LOG_TERMINAL_TEXTAREA}                        comment

${LOG_EXPORT_BUTTON}                            export_button

*** Keywords ***
Skip This Test If Log Service Is Not Supported By DUT
    IF    ${LOG_IS_SUPPORTED} == ${FALSE}
        Skip    DUT does not support log service settings.
    END

Access Log Service Settings Page
    Open Services Menu
    Wait Until Element Is Visible    ${LOG_SUBMENU}
    Click Element    ${LOG_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${LOG_LEVEL_SELECT}

Get Log Current Level Value
    ${value}    Get Value    ${LOG_LEVEL_SELECT}
    [Return]    ${value}

Set Log Level To Off
    Select From List By Value
    ...    ${LOG_LEVEL_SELECT}
    ...    ${LOG_LEVEL_SELECT_OFF_VALUE}

Set Log Level To Error
    Select From List By Value
    ...    ${LOG_LEVEL_SELECT}
    ...    ${LOG_LEVEL_SELECT_ERROR_VALUE}

Set Log Level To Warning
    Select From List By Value
    ...    ${LOG_LEVEL_SELECT}
    ...    ${LOG_LEVEL_SELECT_WARNING_VALUE}

Set Log Level To Info
    Select From List By Value
    ...    ${LOG_LEVEL_SELECT}
    ...    ${LOG_LEVEL_SELECT_INFO_VALUE}

Set Log Level To Debug
    Select From List By Value
    ...    ${LOG_LEVEL_SELECT}
    ...    ${LOG_LEVEL_SELECT_DEBUG_VALUE}

Log Level Should Be "${value}"
    List Selection Should Be
    ...    ${LOG_LEVEL_SELECT}
    ...    ${value}

Select Log Send To Remote Server Checkbox
    Select Checkbox    ${LOG_REMOTE_SERVER_ENABLE_CHECKBOX}

Unselect Log Send To Remote Server Checkbox
    Unselect Checkbox    ${LOG_REMOTE_SERVER_ENABLE_CHECKBOX}

Set Remote Server IP Address To "${value}"
    Input Text
    ...    ${LOG_REMOTE_SERVER_IP_ADDRESS_INPUT}
    ...    ${value}

Get Current Remote Server IP Address Value
    ${value}    Get Value    ${LOG_REMOTE_SERVER_IP_ADDRESS_INPUT}
    [Return]    ${value}

Set Remote Server Port To "${value}"
    Input Text
    ...    ${LOG_REMOTE_SERVER_PORT_INPUT}
    ...    ${value}

Get Current Remote Server Port Value
    ${value}    Get Value    ${LOG_REMOTE_SERVER_PORT_INPUT}
    [Return]    ${value}

Get Current Terminal Value
    ${value}    Get Value    ${LOG_TERMINAL_TEXTAREA}
    [Return]    ${value}

Log Remote Server IP Address Should Be "${value}"
    Element Attribute Value Should Be
    ...    ${LOG_REMOTE_SERVER_IP_ADDRESS_INPUT}
    ...    value    ${value}

Log Remote Server Port Should Be "${value}"
    Element Attribute Value Should Be
    ...    ${LOG_REMOTE_SERVER_PORT_INPUT}
    ...    value    ${value}

Get Line "${value}" Of Terminal Log
    ${console}    Get Current Terminal Value
    ${line_value}    Get Line    ${console}    ${value}
    [Return]    ${line_value}

Search For Line With "${value}" String In Terminal Log
    ${console}    Get Current Terminal Value
    ${lines}    Get Lines Matching Pattern    ${console}    ${value}
    [Return]    ${lines}

Log Settings Should Be Factory Default
    IF    '${DUT_FIRMWARE_STAGE}' == '${FIRMWARE_STAGE_PRODUCTION}'
        IF    '${LOG_FACTORY_DEFAULT_LEVEL}' == 'off'
            Log Level Should Be "${LOG_LEVEL_SELECT_OFF_VALUE}"
        ELSE IF    '${LOG_FACTORY_DEFAULT_LEVEL}' == 'error'
            Log Level Should Be "${LOG_LEVEL_SELECT_ERROR_VALUE}"
        ELSE IF    '${LOG_FACTORY_DEFAULT_LEVEL}' == 'warning'
            Log Level Should Be "${LOG_LEVEL_SELECT_WARNING_VALUE}"
        ELSE IF    '${LOG_FACTORY_DEFAULT_LEVEL}' == 'info'
            Log Level Should Be "${LOG_LEVEL_SELECT_INFO_VALUE}"
        ELSE IF    '${LOG_FACTORY_DEFAULT_LEVEL}' == 'debug'
            Log Level Should Be "${LOG_LEVEL_SELECT_DEBUG_VALUE}"
        ELSE
            Fail    Could not determine DUT factory default log level (check DUT profile).
        END
    ELSE IF    '${DUT_FIRMWARE_STAGE}' == '${FIRMWARE_STAGE_DEVELOPMENT}'
        List Selection Should Be    ${LOG_LEVEL_SELECT}    ${LOG_LEVEL_SELECT_DEBUG_VALUE}
    END

    IF    ${LOG_FACTORY_DEFAULT_REMOTE_SERVER_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${LOG_REMOTE_SERVER_ENABLE_CHECKBOX}
        Element Should Be Enabled    ${LOG_REMOTE_SERVER_IP_ADDRESS_INPUT}
        Element Should Be Enabled    ${LOG_FACTORY_DEFAULT_REMOTE_SERVER_PORT}
    ELSE
        Checkbox Should Not Be Selected    ${LOG_REMOTE_SERVER_ENABLE_CHECKBOX}
        Element Should Be Disabled    ${LOG_REMOTE_SERVER_IP_ADDRESS_INPUT}
        Element Should Be Disabled    ${LOG_REMOTE_SERVER_PORT_INPUT}
    END

    Log Remote Server IP Address Should Be "${LOG_FACTORY_DEFAULT_REMOTE_SERVER_IP}"
    Log Remote Server Port Should Be "${LOG_FACTORY_DEFAULT_REMOTE_SERVER_PORT}"
    Element Should Be Visible    ${LOG_TERMINAL_TEXTAREA}
    Element Should Be Visible    ${LOG_EXPORT_BUTTON}
    Element Should Be Enabled    ${LOG_EXPORT_BUTTON}
