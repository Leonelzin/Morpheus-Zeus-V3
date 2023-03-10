*** Settings ***
Documentation       System Management Resource File
...                 
...                 This resource file contains keywords related to system
...                 management webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             SSHLibrary
Resource            web/common.resource
Resource            web/sidemenu_pom.resource
Resource            web/network/operation_mode_pom.resource

*** Variables ***
${DUT_MGMT_IPV4_ADDRESS}                                            ${DUT}[env][management][ipv4_address]

${SYSTEM_MANAGEMENT_PROFILE_SECTION}                                ${DUT}[profile][system][management]
${SYSTEM_MANAGEMENT_SESSION_TIMEOUT_MIN_VALUE}                      ${SYSTEM_MANAGEMENT_PROFILE_SECTION}[session_timeout][min_value]
${SYSTEM_MANAGEMENT_SESSION_TIMEOUT_MAX_VALUE}                      ${SYSTEM_MANAGEMENT_PROFILE_SECTION}[session_timeout][max_value]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_PROD_FW_SESSION_TIMEOUT}        ${SYSTEM_MANAGEMENT_PROFILE_SECTION}[session_timeout][factory_default][production_firmware][timeout]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_DEV_FW_SESSION_TIMEOUT}         ${SYSTEM_MANAGEMENT_PROFILE_SECTION}[session_timeout][factory_default][development_firmware][timeout]

${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP}                           ${SYSTEM_MANAGEMENT_PROFILE_SECTION}[http][factory_default]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP_ENABLED}                   ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP}[enabled]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP_BRUTE_FORCE_ENABLED}       ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP}[brute_force_protection]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP_WAN_ACCESS_ENABLED}        ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP}[wan_access_enabled]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP_PORT}                      ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP}[port]

${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTPS}                          ${SYSTEM_MANAGEMENT_PROFILE_SECTION}[https][factory_default]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTPS_BRUTE_FORCE_ENABLED}      ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTPS}[brute_force_protection]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTPS_WAN_ACCESS_ENABLED}       ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTPS}[wan_access_enabled]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTPS_PORT}                     ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTPS}[port]

${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH}                            ${SYSTEM_MANAGEMENT_PROFILE_SECTION}[ssh][factory_default]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_PROD_FW_SSH_ENABLED}            ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH}[production_firmware][enabled]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_DEV_FW_SSH_ENABLED}             ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH}[development_firmware][enabled]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH_WAN_ACCESS_ENABLED}         ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH}[wan_access_enabled]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH_BRUTE_FORCE}                ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH}[brute_force_protection]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH_PORT}                       ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH}[port]

${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN}                           ${SYSTEM_MANAGEMENT_PROFILE_SECTION}[vlan][factory_default]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN_ENABLED}                   ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN}[enabled]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN_INTERFACE}                 ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN}[interface]
${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN_ID}                        ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN}[id]

${SYSTEM_MANAGEMENT_SUBMENU}                                        management_submenu

${SYSTEM_MANAGEMENT_SESSION_TIMEOUT_INPUT}                          access_timeout

${SYSTEM_MANAGEMENT_HTTP_ENABLE_CHECKBOX}                           access_http_enabled
${SYSTEM_MANAGEMENT_HTTP_BRUTE_FORCE_CHECKBOX}                      brute_force_http
${SYSTEM_MANAGEMENT_HTTP_WAN_ACCESS_CHECKBOX}                       wan_access_http
${SYSTEM_MANAGEMENT_HTTP_PORT_INPUT}                                access_http_port

${SYSTEM_MANAGEMENT_HTTPS_WAN_ACCESS_CHECKBOX}                      wan_access_https
${SYSTEM_MANAGEMENT_HTTPS_BRUTE_FORCE_CHECKBOX}                     brute_force_https
${SYSTEM_MANAGEMENT_HTTPS_PORT_INPUT}                               access_https_port

${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_SELECT}                       access_https_cert
${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_SELECT_DEFAULT_VALUE}         boolean:false
${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_SELECT_CUSTOM_VALUE}          boolean:true
${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_UPLOAD_FILE_BUTTON}           data_cert
${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_UPLOAD_FILE_INPUT}            data_cert_filename
${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_KEY_UPLOAD_FILE_BUTTON}       data_certKey
${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_KEY_UPLOAD_FILE_INPUT}        data_certKey_filename

${SYSTEM_MANAGEMENT_SSH_ENABLE_CHECKBOX}                            access_ssh_enabled
${SYSTEM_MANAGEMENT_SSH_BRUTE_FORCE_CHECKBOX}                       brute_force_ssh
${SYSTEM_MANAGEMENT_SSH_PORT_INPUT}                                 access_ssh_port
${SYSTEM_MANAGEMENT_SSH_WAN_ACCESS_CHECKBOX}                        wan_access_ssh

${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}                              access_vlan_value
${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_DEACTIVATED_VALUE}            string:disabled
${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_ETHERNET_WIRELESS_VALUE}      string:all
${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_WIRELESS_VALUE}               string:wlan
${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_ETHERNET_VALUE}               string:eth
${SYSTEM_MANAGEMENT_VLAN_ID_INPUT}                                  access_vlan_vid

*** Keywords ***
Access System Management Page
    Open System Menu
    Wait Until Element Is Visible    ${SYSTEM_MANAGEMENT_SUBMENU}
    Click Element    ${SYSTEM_MANAGEMENT_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${SYSTEM_MANAGEMENT_SESSION_TIMEOUT_INPUT}

### Session Timeout Input ###

Set System Management Session Timeout To "${value}"
    Input Text    ${SYSTEM_MANAGEMENT_SESSION_TIMEOUT_INPUT}    ${value}

System Management Session Timeout Should Be "${value}"
    Element Attribute Value Should Be
    ...    ${SYSTEM_MANAGEMENT_SESSION_TIMEOUT_INPUT}
    ...    value    ${value}

Set System Management Session Timeout To A Value Below The Lower Limit
    ${session_timeout}    Evaluate    ${SYSTEM_MANAGEMENT_SESSION_TIMEOUT_MIN_VALUE} - 1
    Set System Management Session Timeout To "${session_timeout}"

Set System Management Session Timeout To A Value Above The Upper Limit
    ${session_timeout}    Evaluate    ${SYSTEM_MANAGEMENT_SESSION_TIMEOUT_MAX_VALUE} + 1
    Set System Management Session Timeout To "${session_timeout}"

### HTTP Enable Checkbox ###

Select System Management HTTP Enable Checkbox
    Select Checkbox    ${SYSTEM_MANAGEMENT_HTTP_ENABLE_CHECKBOX}

Unselect System Management HTTP Enable Checkbox
    Unselect Checkbox    ${SYSTEM_MANAGEMENT_HTTP_ENABLE_CHECKBOX}

### HTTP Brute Force Checkbox ###

Select System Management HTTP Brute Force Checkbox
    Select Checkbox    ${SYSTEM_MANAGEMENT_HTTP_BRUTE_FORCE_CHECKBOX}

Unselect System Management HTTP Brute Force Checkbox
    Unselect Checkbox    ${SYSTEM_MANAGEMENT_HTTP_BRUTE_FORCE_CHECKBOX}

### HTTP WAN Checkbox ###

Select System Management HTTP WAN Access Checkbox
    Select Checkbox    ${SYSTEM_MANAGEMENT_HTTP_WAN_ACCESS_CHECKBOX}

Unselect System Management HTTP WAN Access Checkbox
    Unselect Checkbox    ${SYSTEM_MANAGEMENT_HTTP_WAN_ACCESS_CHECKBOX}

### HTTP Port Input ###

Set System Management HTTP Port To "${value}"
    Input Text    ${SYSTEM_MANAGEMENT_HTTP_PORT_INPUT}    ${value}

System Management HTTP Port Should Be "${value}"
    Element Attribute Value Should Be
    ...    ${SYSTEM_MANAGEMENT_HTTP_PORT_INPUT}
    ...    value    ${value}

### HTTPS WAN Checkbox ###

Select System Management HTTPS WAN Access Checkbox
    Select Checkbox    ${SYSTEM_MANAGEMENT_HTTPS_WAN_ACCESS_CHECKBOX}

Unselect System Management HTTPS WAN Access Checkbox
    Unselect Checkbox    ${SYSTEM_MANAGEMENT_HTTPS_WAN_ACCESS_CHECKBOX}

### HTTPS Brute Force Checkbox ###

Select System Management HTTPS Brute Force Checkbox
    Select Checkbox    ${SYSTEM_MANAGEMENT_HTTPS_BRUTE_FORCE_CHECKBOX}

Unselect System Management HTTPS Brute Force Checkbox
    Unselect Checkbox    ${SYSTEM_MANAGEMENT_HTTPS_BRUTE_FORCE_CHECKBOX}

### HTTPS Port Input ###

Set System Management HTTPS Port To "${value}"
    Input Text    ${SYSTEM_MANAGEMENT_HTTPS_PORT_INPUT}    ${value}

System Management HTTPS Port Should Be "${value}"
    Element Attribute Value Should Be
    ...    ${SYSTEM_MANAGEMENT_HTTPS_PORT_INPUT}
    ...    value    ${value}

### HTTPS Certificate/Key Select ###

Set System Management HTTPS Certificate Select To Default
    Select From List By Value
    ...    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_SELECT}
    ...    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_SELECT_DEFAULT_VALUE}

Set System Management HTTPS Certificate Select To Custom
    Select From List By Value
    ...    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_SELECT}
    ...    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_SELECT_CUSTOM_VALUE}

System Management HTTPS Certificate Select Should Be "${value}"
    List Selection Should Be
    ...    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_SELECT}
    ...    ${value}

### HTTPS Certificate Button ###

Set System Management HTTPS Certificate File Upload To "${value}"
    Choose File
    ...    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_UPLOAD_FILE_BUTTON}
    ...    ${value}

### HTTPS Key Button ###

Set System Management HTTPS Key Button File Upload To "${value}"
    Choose File
    ...    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_KEY_UPLOAD_FILE_BUTTON}
    ...    ${value}

### SSH Enable Checkbox ###

Select System Management SSH Enable Checkbox
    Select Checkbox    ${SYSTEM_MANAGEMENT_SSH_ENABLE_CHECKBOX}

Unselect System Management SSH Enable Checkbox
    Unselect Checkbox    ${SYSTEM_MANAGEMENT_SSH_ENABLE_CHECKBOX}

### SSH Brute Force Checkbox ###

Select System Management SSH Brute Force Checkbox
    Select Checkbox    ${SYSTEM_MANAGEMENT_SSH_BRUTE_FORCE_CHECKBOX}

Unselect System Management SSH Brute Force Checkbox
    Unselect Checkbox    ${SYSTEM_MANAGEMENT_SSH_BRUTE_FORCE_CHECKBOX}

### SSH WAN Checkbox ###

Select System Management SSH WAN Access Checkbox
    Select Checkbox    ${SYSTEM_MANAGEMENT_SSH_WAN_ACCESS_CHECKBOX}

Unselect System Management SSH WAN Access Checkbox
    Unselect Checkbox    ${SYSTEM_MANAGEMENT_SSH_WAN_ACCESS_CHECKBOX}

### SSH Port Input ###

Set System Management SSH Port To "${value}"
    Input Text    ${SYSTEM_MANAGEMENT_SSH_PORT_INPUT}    ${value}

System Management SSH Port Should Be "${value}"
    Element Attribute Value Should Be
    ...    ${SYSTEM_MANAGEMENT_SSH_PORT_INPUT}
    ...    value    ${value}

System Management SSH Port Input Should Be Enabled
    Element Should Be Enabled    ${SYSTEM_MANAGEMENT_SSH_PORT_INPUT}

System Management SSH Port Input Should Be Disabled
    Element Should Be Disabled    ${SYSTEM_MANAGEMENT_SSH_PORT_INPUT}

### VLAN Interface Select ###

Set System Management VLAN Interface Select To LAN
    Select From List By Value
    ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}
    ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_LAN_VALUE}

Set System Management VLAN Interface Select To Deactivated
    Select From List By Value
    ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}
    ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_DEACTIVATED_VALUE}

System Management VLAN Interface Select Should Be LAN
    Element Attribute Value Should Be
    ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}    value
    ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_LAN_VALUE}

System Management VLAN Interface Select Should Be Deactivated
    Element Attribute Value Should Be
    ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}    value
    ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_DEACTIVATED_VALUE}

System Management VLAN Interface Select Should Be "${value}"
    List Selection Should Be
    ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}
    ...    ${value}

### VLAN Interface input ###

Set System Management VLAN ID To "${value}"
    Input Text    ${SYSTEM_MANAGEMENT_VLAN_ID_INPUT}    ${value}

System Management VLAN ID Should Be "${value}"
    Element Attribute Value Should Be
    ...    ${SYSTEM_MANAGEMENT_VLAN_ID_INPUT}
    ...    value    ${value}

### SSH Connection ###

Open DUT SSH Connection On Port "${port}" And Log In
    Wait Until Keyword Succeeds    3min    30sec
    ...    Open Connection    ${DUT_MGMT_IPV4_ADDRESS}    port=${port}
    Wait Until Keyword Succeeds    3min    30sec
    ...    Login    ${DUT}[env][management][login][username]    ${DUT}[env][management][login][password]

It Should Not Be Possible To Open DUT SSH Connection On Port "${port}"
    ${conn}    Open Connection    ${DUT_MGMT_IPV4_ADDRESS}    port=${port}
    Should Not Be Equal As Integers    ${conn}    0

Execute Command "${command}" Via Open SSH Connection
    Write    ${command}
    ${stdout}    Read    delay=1s
    [Return]    ${stdout}

Execute Command "${command}" Via Open SSH Connection And Expect Output To Contain "${output}"
    Write    ${command}
    ${stdout}    Read    delay=1s
    Should Contain    ${stdout}    ${output}

Close DUT SSH Connections
    Close All Connections

System Management Settings Should Be Factory Default
    Element Should Be Enabled    ${SYSTEM_MANAGEMENT_SESSION_TIMEOUT_INPUT}
    IF    '${DUT_FIRMWARE_STAGE}' == '${FIRMWARE_STAGE_PRODUCTION}'
        System Management Session Timeout Should Be "${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_PROD_FW_SESSION_TIMEOUT}"
    ELSE
        System Management Session Timeout Should Be "${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_DEV_FW_SESSION_TIMEOUT}"
    END

    IF    ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${SYSTEM_MANAGEMENT_HTTP_ENABLE_CHECKBOX}
        Element Should Be Enabled    ${SYSTEM_MANAGEMENT_HTTP_PORT_INPUT}
    ELSE
        Checkbox Should Not Be Selected    ${SYSTEM_MANAGEMENT_HTTP_ENABLE_CHECKBOX}
        Element Should Be Disabled    ${SYSTEM_MANAGEMENT_HTTP_PORT_INPUT}
    END

    IF    ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP_BRUTE_FORCE_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${SYSTEM_MANAGEMENT_HTTP_BRUTE_FORCE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${SYSTEM_MANAGEMENT_HTTP_BRUTE_FORCE_CHECKBOX}
    END

    System Management HTTP Port Should Be "${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP_PORT}"

    IF    ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTPS_BRUTE_FORCE_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${SYSTEM_MANAGEMENT_HTTPS_BRUTE_FORCE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${SYSTEM_MANAGEMENT_HTTPS_BRUTE_FORCE_CHECKBOX}
    END

    Element Should Be Enabled    ${SYSTEM_MANAGEMENT_HTTPS_PORT_INPUT}
    System Management HTTPS Port Should Be "${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTPS_PORT}"

    List Selection Should Be
    ...    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_SELECT}
    ...    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_SELECT_DEFAULT_VALUE}

    Element Should Be Disabled    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_UPLOAD_FILE_BUTTON}
    Element Should Be Disabled    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_UPLOAD_FILE_INPUT}

    Element Should Be Disabled    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_KEY_UPLOAD_FILE_BUTTON}
    Element Should Be Disabled    ${SYSTEM_MANAGEMENT_HTTPS_CERTIFICATE_KEY_UPLOAD_FILE_INPUT}

    IF    '${DUT_FIRMWARE_STAGE}' == '${FIRMWARE_STAGE_PRODUCTION}'
        IF    ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_PROD_FW_SSH_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${SYSTEM_MANAGEMENT_SSH_ENABLE_CHECKBOX}
            Element Should Be Enabled    ${SYSTEM_MANAGEMENT_SSH_PORT_INPUT}
        ELSE
            Checkbox Should Not Be Selected    ${SYSTEM_MANAGEMENT_SSH_ENABLE_CHECKBOX}
            Element Should Be Disabled    ${SYSTEM_MANAGEMENT_SSH_PORT_INPUT}
        END
    ELSE IF    '${DUT_FIRMWARE_STAGE}' == '${FIRMWARE_STAGE_DEVELOPMENT}'
        IF    ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_DEV_FW_SSH_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${SYSTEM_MANAGEMENT_SSH_ENABLE_CHECKBOX}
            Element Should Be Enabled    ${SYSTEM_MANAGEMENT_SSH_PORT_INPUT}
        ELSE
            Checkbox Should Not Be Selected    ${SYSTEM_MANAGEMENT_SSH_ENABLE_CHECKBOX}
            Element Should Be Disabled    ${SYSTEM_MANAGEMENT_SSH_PORT_INPUT}
        END
    END

    System Management SSH Port Should Be "${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH_PORT}"

    IF    ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH_BRUTE_FORCE} == ${TRUE}
        Checkbox Should Be Selected    ${SYSTEM_MANAGEMENT_SSH_BRUTE_FORCE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${SYSTEM_MANAGEMENT_SSH_BRUTE_FORCE_CHECKBOX}
    END

    IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'bridge'
        Element Should Not Be Visible    ${SYSTEM_MANAGEMENT_HTTP_WAN_ACCESS_CHECKBOX}
        Element Should Not Be Visible    ${SYSTEM_MANAGEMENT_HTTPS_WAN_ACCESS_CHECKBOX}
        Element Should Not Be Visible    ${SYSTEM_MANAGEMENT_SSH_WAN_ACCESS_CHECKBOX}
        System Management VLAN ID Should Be "${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN_ID}"

        IF    ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN_ENABLED} == ${TRUE}
            IF    '${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN_INTERFACE}' == 'ethernet_and_wireless'
                List Selection Should Be
                ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}
                ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_ETHERNET_WIRELESS_VALUE}
            ELSE IF    '${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN_INTERFACE}' == 'ethernet'
                List Selection Should Be
                ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}
                ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_ETHERNET_VALUE}
            ELSE IF    '${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_VLAN_INTERFACE}' == 'wireless'
                List Selection Should Be
                ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}
                ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_WIRELESS_VALUE}
            ELSE
                Fail    Could not determine DUT factory default management VLAN interface (check DUT profile).
            END

            Element Should Be Enabled    ${SYSTEM_MANAGEMENT_VLAN_ID_INPUT}
        ELSE
            List Selection Should Be
            ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}
            ...    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT_DEACTIVATED_VALUE}
            Element Should Be Disabled    ${SYSTEM_MANAGEMENT_VLAN_ID_INPUT}
        END
    ELSE IF    '${NETWORK_FACTORY_DEFAULT_OPMODE}' == 'router'
        Element Should Be Visible    ${SYSTEM_MANAGEMENT_HTTP_WAN_ACCESS_CHECKBOX}
        IF    ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTP_WAN_ACCESS_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${SYSTEM_MANAGEMENT_HTTP_WAN_ACCESS_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${SYSTEM_MANAGEMENT_HTTP_WAN_ACCESS_CHECKBOX}
        END

        Element Should Be Visible    ${SYSTEM_MANAGEMENT_HTTPS_WAN_ACCESS_CHECKBOX}
        IF    ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_HTTPS_WAN_ACCESS_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${SYSTEM_MANAGEMENT_HTTPS_WAN_ACCESS_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${SYSTEM_MANAGEMENT_HTTPS_WAN_ACCESS_CHECKBOX}
        END

        Element Should Be Visible    ${SYSTEM_MANAGEMENT_SSH_WAN_ACCESS_CHECKBOX}
        IF    ${SYSTEM_MANAGEMENT_FACTORY_DEFAULT_SSH_WAN_ACCESS_ENABLED} == ${TRUE}
            Checkbox Should Be Selected    ${SYSTEM_MANAGEMENT_SSH_WAN_ACCESS_CHECKBOX}
        ELSE
            Checkbox Should Not Be Selected    ${SYSTEM_MANAGEMENT_SSH_WAN_ACCESS_CHECKBOX}
        END

        Element Should Not Be Visible    ${SYSTEM_MANAGEMENT_VLAN_IFACE_SELECT}
        Element Should Not Be Visible    ${SYSTEM_MANAGEMENT_VLAN_ID_INPUT}
    END
