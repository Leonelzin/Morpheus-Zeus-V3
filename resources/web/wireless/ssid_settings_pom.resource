*** Settings ***
Documentation       Wireless SSID Settings Resource File
...                 
...                 This resource file contains keywords related to wireless
...                 SSID settings WEB page manipulation (page object model).

Library             Collections
Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${SSID_NAME_INPUT}                                  ssid_name

${SSID_BAND_SELECT}                                 ssid_band
${SSID_BAND_SELECT_DUAL_BAND_VALUE}                 string:Dual band
${SSID_BAND_SELECT_2GHZ_VALUE}                      string:2.4 GHz
${SSID_BAND_SELECT_5GHZ_VALUE}                      string:5 GHz

${SSID_AUTH_TYPE_SELECT}                            ssid_auth
${SSID_AUTH_TYPE_SELECT_OPEN_VALUE}                 string:none
${SSID_AUTH_TYPE_SELECT_WPA_PSK_VALUE}              string:psk
${SSID_AUTH_TYPE_SELECT_WPA2_PSK_VALUE}             string:psk2
${SSID_AUTH_TYPE_SELECT_WPA_EPRISE_VALUE}           string:wpa
${SSID_AUTH_TYPE_SELECT_WPA2_EPRISE_VALUE}          string:wpa2
${SSID_AUTH_TYPE_SELECT_FACEBOOK_WIFI_VALUE}        string:facebook_wifi

${SSID_ENCRYPTION_TYPE_SELECT}                      ssid_encryption
${SSID_ENCRYPTION_TYPE_SELECT_CCMP_VALUE}           string:ccmp
${SSID_ENCRYPTION_TYPE_SELECT_CCMP_TKIP_VALUE}      string:tkip+ccmp

${SSID_PSK_PASSWORD_INPUT}                          id:ssid_psk_password
${SSID_SHOW_PSK_PASSWORD_CHECKBOX}                  ssid_psk_show_password

${SSID_WPA_EPRISE_NAS_ID_INPUT}                     ssid_wpa_eprise_nas_id
${SSID_WPA_EPRISE_SERVER_PORT_INPUT}                ssid_wpa_eprise_port
${SSID_WPA_EPRISE_SERVER_ADDRESS_INPUT}             ssid_wpa_eprise_server
${SSID_WPA_EPRISE_NAS_PASSWORD_INPUT}               id:ssid_wpa_eprise_password
${SSID_SHOW_WPA_EPRISE_NAS_PASSWORD_CHECKBOX}       ssid_wpa_eprise_show_password

${SSID_HIDE_CHECKBOX}                               ssid_broadcast
${SSID_ISOLATE_CHECKBOX}                            ssid_isolation
${SSID_ISOLATE_CLIENTS_CHECKBOX}                    ssid_clients_isolation
${SSID_INTERNET_ONLY_CHECKBOX}                      ssid_internet_only

${SSID_MAX_CLIENT_ASSOC_SLIDER}                     xpath://*[@id="ssid_max_assoc"]/span[5]
${SSID_MIN_CLIENT_SIGNAL_SLIDER}                    xpath://*[@id="ssid_sensibility"]/span[5]

${SSID_VLAN_ENABLE_CHECKBOX}                        ssid_vlan
${SSID_VLAN_ID_INPUT}                               ssid_vlan_id

${SSID_DISCARD_CHANGES_BUTTON}                      ssid_discard_changes
${SSID_CONFIRM_CHANGES_BUTTON}                      ssid_confirm_changes

${SSID_FACTORY_DEFAULT}                             ${DUT}[profile][wireless][ssid][factory_default]
${SSID_FACTORY_DEFAULT_BAND}                        ${SSID_FACTORY_DEFAULT}[band]
${SSID_FACTORY_DEFAULT_AUTH}                        ${SSID_FACTORY_DEFAULT}[auth]
${SSID_FACTORY_DEFAULT_BROADCAST_OFF}               ${SSID_FACTORY_DEFAULT}[broadcast_off]
${SSID_FACTORY_DEFAULT_SSID_ISOLATION}              ${SSID_FACTORY_DEFAULT}[ssid_isolation]
${SSID_FACTORY_DEFAULT_CLIENTS_ISOLATION}           ${SSID_FACTORY_DEFAULT}[clients_isolation]
${SSID_FACTORY_DEFAULT_INTERNET_ONLY}               ${SSID_FACTORY_DEFAULT}[internet_only]
${SSID_FACTORY_DEFAULT_MAX_CLIENT_ASSOC}            ${SSID_FACTORY_DEFAULT}[max_client_assoc]
${SSID_FACTORY_DEFAULT_MIN_CLIENT_SIGNAL}           ${SSID_FACTORY_DEFAULT}[min_client_signal]
${SSID_FACTORY_DEFAULT_VLAN_ENABLED}                ${SSID_FACTORY_DEFAULT}[vlan]
${SSID_FACTORY_DEFAULT_VLAN_ID}                     ${SSID_FACTORY_DEFAULT}[vlan_id]

*** Keywords ***
Set SSID Name To "${ssid_name}"
    Input Text    ${SSID_NAME_INPUT}    ${ssid_name}

Set SSID Band To Dual Band
    Select From List By Value    ${SSID_BAND_SELECT}    ${SSID_BAND_SELECT_DUAL_BAND_VALUE}

Set SSID Band To 2.4GHz
    Select From List By Value    ${SSID_BAND_SELECT}    ${SSID_BAND_SELECT_2GHZ_VALUE}

Set SSID Band To 5GHz
    Select From List By Value    ${SSID_BAND_SELECT}    ${SSID_BAND_SELECT_5GHZ_VALUE}

Set SSID Authentication Type To Open
    Select From List By Value    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_OPEN_VALUE}

Set SSID Authentication Type To WPA-PSK
    Select From List By Value    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_WPA_PSK_VALUE}

Set SSID Authentication Type To WPA2-PSK
    Select From List By Value    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_WPA2_PSK_VALUE}

Set SSID Authentication Type To WPA (Enterprise)
    Select From List By Value    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_WPA_EPRISE_VALUE}

Set SSID Authentication Type To WPA2 (Enterprise)
    Select From List By Value    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_WPA2_EPRISE_VALUE}

Set SSID Encryption Type To AES (CCMP)
    Select From List By Value    ${SSID_ENCRYPTION_TYPE_SELECT}    ${SSID_ENCRYPTION_TYPE_SELECT_CCMP_VALUE}

Set SSID Encryption Type To AES/TKIP (CCMP/TKIP)
    Select From List By Value    ${SSID_ENCRYPTION_TYPE_SELECT}    ${SSID_ENCRYPTION_TYPE_SELECT_CCMP_TKIP_VALUE}

Set SSID PSK Password To "${password}"
    Input Text    ${SSID_PSK_PASSWORD_INPUT}    ${password}

Select SSID Show PSK Password Checkbox
    Select Checkbox    ${SSID_SHOW_PSK_PASSWORD_CHECKBOX}

Unselect SSID Show PSK Password Checkbox
    Unselect Checkbox    ${SSID_SHOW_PSK_PASSWORD_CHECKBOX}

Set SSID WPA Enterprise NAS ID To "${nas_id}"
    Input Text    ${SSID_WPA_EPRISE_NAS_ID_INPUT}    ${nas_id}

Set SSID WPA Enterprise Server Port To "${port}"
    Input Text    ${SSID_WPA_EPRISE_SERVER_PORT_INPUT}    ${port}

Set SSID WPA Enterprise Server Address To "${server_address}"
    Input Text    ${SSID_WPA_EPRISE_SERVER_ADDRESS_INPUT}    ${server_address}

Set SSID WPA Enterprise NAS Password To "${password}"
    Input Text    ${SSID_WPA_EPRISE_NAS_PASSWORD_INPUT}    ${password}

Select SSID Show WPA Enterprise NAS Password Checkbox
    Select Checkbox    ${SSID_SHOW_WPA_EPRISE_NAS_PASSWORD_CHECKBOX}

Unselect SSID Show WPA Enterprise NAS Password Checkbox
    Unselect Checkbox    ${SSID_SHOW_WPA_EPRISE_NAS_PASSWORD_CHECKBOX}

SSID WPA Enterprise Settings Should Be Visible
    Element Should Be Visible    ${SSID_WPA_EPRISE_NAS_ID_INPUT}
    Element Should Be Visible    ${SSID_WPA_EPRISE_SERVER_PORT_INPUT}
    Element Should Be Visible    ${SSID_WPA_EPRISE_SERVER_ADDRESS_INPUT}
    Element Should Be Visible    ${SSID_WPA_EPRISE_NAS_PASSWORD_INPUT}

SSID WPA Enterprise Settings Should Not Be Visible
    Element Should Not Be Visible    ${SSID_WPA_EPRISE_NAS_ID_INPUT}
    Element Should Not Be Visible    ${SSID_WPA_EPRISE_SERVER_PORT_INPUT}
    Element Should Not Be Visible    ${SSID_WPA_EPRISE_SERVER_ADDRESS_INPUT}
    Element Should Not Be Visible    ${SSID_WPA_EPRISE_NAS_PASSWORD_INPUT}

Select SSID Hide Checkbox
    Select Checkbox    ${SSID_HIDE_CHECKBOX}

Unselect SSID Hide Checkbox
    Unselect Checkbox    ${SSID_HIDE_CHECKBOX}

Select SSID Isolation Checkbox
    Select Checkbox    ${SSID_ISOLATE_CHECKBOX}

Unselect SSID Isolation Checkbox
    Unselect Checkbox    ${SSID_ISOLATE_CHECKBOX}

Select SSID Clients Isolation Checkbox
    Select Checkbox    ${SSID_ISOLATE_CLIENTS_CHECKBOX}

Unselect SSID Clients Isolation Checkbox
    Unselect Checkbox    ${SSID_ISOLATE_CLIENTS_CHECKBOX}

Select SSID Internet Only Checkbox
    Select Checkbox    ${SSID_INTERNET_ONLY_CHECKBOX}

Unselect SSID Internet Only Checkbox
    Unselect Checkbox    ${SSID_INTERNET_ONLY_CHECKBOX}

Set SSID Maximum Clients Association To "${max_assoc}"
    ${curr_max_assoc}    Get Element Attribute    ${SSID_MAX_CLIENT_ASSOC_SLIDER}    aria-valuenow
    ${curr_max_assoc}    Convert To Integer    ${curr_max_assoc}
    ${max_assoc_diff}    Evaluate    ${curr_max_assoc} - ${max_assoc}

    IF    ${max_assoc_diff} < 0
        ${key_to_press}    Set Variable    ARROW_RIGHT
    ELSE
        ${key_to_press}    Set Variable    ARROW_LEFT
    END

    ${max_assoc_diff}    Evaluate    abs(${max_assoc_diff})
    @{keys_to_press}    Create List

    FOR    ${counter}    IN RANGE    ${max_assoc_diff}
        Append To List    ${keys_to_press}    ${key_to_press}
    END

    ${keys_to_press_length}    Get Length    ${keys_to_press}

    IF    ${keys_to_press_length} > 0
        Press Keys    ${SSID_MAX_CLIENT_ASSOC_SLIDER}    @{keys_to_press}
    END

    ${curr_max_assoc}    Get Element Attribute    ${SSID_MAX_CLIENT_ASSOC_SLIDER}    aria-valuenow

    IF    ${curr_max_assoc} != ${max_assoc}
        Capture Page Screenshot
        Fail    Error while trying to set value '${max_assoc}' (SSID maximum clients association slider).
    END

Set SSID Minimum Client Singal To "${min_client_signal}" dBm
    ${curr_min_client_signal}    Get Element Attribute    ${SSID_MIN_CLIENT_SIGNAL_SLIDER}    aria-valuenow
    ${curr_min_client_signal}    Convert To Integer    ${curr_min_client_signal}
    ${min_client_signal_diff}    Evaluate    ${curr_min_client_signal} - ${min_client_signal}

    IF    ${min_client_signal_diff} < 0
        ${key_to_press}    Set Variable    ARROW_RIGHT
    ELSE
        ${key_to_press}    Set Variable    ARROW_LEFT
    END

    ${min_client_signal_diff}    Evaluate    abs(${min_client_signal_diff})
    @{keys_to_press}    Create List

    FOR    ${counter}    IN RANGE    ${min_client_signal_diff}
        Append To List    ${keys_to_press}    ${key_to_press}
    END

    Press Keys    ${SSID_MIN_CLIENT_SIGNAL_SLIDER}    @{keys_to_press}

    ${curr_min_client_signal}    Get Element Attribute    ${SSID_MIN_CLIENT_SIGNAL_SLIDER}    aria-valuenow

    IF    ${curr_min_client_signal} != ${min_client_signal}
        Capture Page Screenshot
        Fail    Error while trying to set value '${min_client_signal}' (SSID minimum client signal slider).
    END

Select SSID VLAN Checkbox
    Select Checkbox    ${SSID_VLAN_ENABLE_CHECKBOX}

Unselect SSID VLAN Checkbox
    Unselect Checkbox    ${SSID_VLAN_ENABLE_CHECKBOX}

Set SSID VLAN ID To "${vlan_id}"
    Input Text    ${SSID_VLAN_ID_INPUT}    ${vlan_id}

Discard SSID Settings Changes
    Click Button    ${SSID_DISCARD_CHANGES_BUTTON}
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END

Confirm SSID Settings Changes
    Click Button    ${SSID_CONFIRM_CHANGES_BUTTON}
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END

Maximum SSID Clients Association Should Be "${max_clients_assoc}"
    ${curr_max_assoc}    Get Element Attribute    ${SSID_MAX_CLIENT_ASSOC_SLIDER}    aria-valuenow
    ${curr_max_assoc}    Convert To Integer    ${curr_max_assoc}
    Should Be Equal As Integers    ${curr_max_assoc}    ${max_clients_assoc}

Minimum SSID Clients Signal Should Be "${min_clients_signal}"
    ${curr_min_client_signal}    Get Element Attribute    ${SSID_MIN_CLIENT_SIGNAL_SLIDER}    aria-valuenow
    ${curr_min_client_signal}    Convert To Integer    ${curr_min_client_signal}
    Should Be Equal As Integers    ${curr_min_client_signal}    ${min_clients_signal}

SSID Settings Should Be Factory Default
    IF    ${DUT}[profile][wireless][2ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be    ${SSID_NAME_INPUT}    value
        ...    ${DUT}[env][wireless][2ghz][default_ssid][name]
    ELSE IF    ${DUT}[profile][wireless][5ghz][is_supported] == ${TRUE}
        Element Attribute Value Should Be    ${SSID_NAME_INPUT}    value
        ...    ${DUT}[env][wireless][5ghz][default_ssid][name]
    END

    IF    '${SSID_FACTORY_DEFAULT_BAND}' == 'dual_band'
        List Selection Should Be    ${SSID_BAND_SELECT}    ${SSID_BAND_SELECT_DUAL_BAND_VALUE}
    ELSE IF    '${SSID_FACTORY_DEFAULT_BAND}' == '2.4ghz'
        List Selection Should Be    ${SSID_BAND_SELECT}    ${SSID_BAND_SELECT_2GHZ_VALUE}
    ELSE IF    '${SSID_FACTORY_DEFAULT_BAND}' == '5ghz'
        List Selection Should Be    ${SSID_BAND_SELECT}    ${SSID_BAND_SELECT_5GHZ_VALUE}
    ELSE
        Fail    Could not determine SSID band. Check DUT profile (SSID band information).
    END

    IF    '${SSID_FACTORY_DEFAULT_AUTH}' == 'open'
        List Selection Should Be    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_OPEN_VALUE}
    ELSE IF    '${SSID_FACTORY_DEFAULT_BAND}' == 'wpa-psk'
        List Selection Should Be    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_WPA_PSK_VALUE}
    ELSE IF    '${SSID_FACTORY_DEFAULT_BAND}' == 'wpa2-psk'
        List Selection Should Be    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_WPA2_PSK_VALUE}
    ELSE IF    '${SSID_FACTORY_DEFAULT_BAND}' == 'wpa'
        List Selection Should Be    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_WPA_EPRISE_VALUE}
    ELSE IF    '${SSID_FACTORY_DEFAULT_BAND}' == 'wpa2'
        List Selection Should Be    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_WPA2_EPRISE_VALUE}
    ELSE IF    '${SSID_FACTORY_DEFAULT_BAND}' == 'facebook-wifi'
        List Selection Should Be    ${SSID_AUTH_TYPE_SELECT}    ${SSID_AUTH_TYPE_SELECT_FACEBOOK_WIFI_VALUE}
    ELSE
        Fail    Could not determine SSID authentication. Check DUT profile (SSID auth information).
    END

    IF    ${SSID_FACTORY_DEFAULT_BROADCAST_OFF} == ${FALSE}
        Checkbox Should Not Be Selected    ${SSID_HIDE_CHECKBOX}
    ELSE
        Checkbox Should Be Selected    ${SSID_HIDE_CHECKBOX}
    END

    IF    ${SSID_FACTORY_DEFAULT_SSID_ISOLATION} == ${FALSE}
        Checkbox Should Not Be Selected    ${SSID_ISOLATE_CHECKBOX}
    ELSE
        Checkbox Should Be Selected    ${SSID_ISOLATE_CHECKBOX}
    END

    IF    ${SSID_FACTORY_DEFAULT_CLIENTS_ISOLATION} == ${FALSE}
        Checkbox Should Not Be Selected    ${SSID_ISOLATE_CLIENTS_CHECKBOX}
    ELSE
        Checkbox Should Be Selected    ${SSID_ISOLATE_CLIENTS_CHECKBOX}
    END

    IF    ${SSID_FACTORY_DEFAULT_INTERNET_ONLY} == ${FALSE}
        Checkbox Should Not Be Selected    ${SSID_INTERNET_ONLY_CHECKBOX}
    ELSE
        Checkbox Should Be Selected    ${SSID_INTERNET_ONLY_CHECKBOX}
    END

    Maximum SSID Clients Association Should Be "${SSID_FACTORY_DEFAULT_MAX_CLIENT_ASSOC}"
    Minimum SSID Clients Signal Should Be "${SSID_FACTORY_DEFAULT_MIN_CLIENT_SIGNAL}"

    IF    ${SSID_FACTORY_DEFAULT_VLAN_ENABLED} == ${FALSE}
        Checkbox Should Not Be Selected    ${SSID_VLAN_ENABLE_CHECKBOX}
        Element Should Be Disabled    ${SSID_VLAN_ID_INPUT}
    ELSE
        Checkbox Should Be Selected    ${SSID_VLAN_ENABLE_CHECKBOX}
        Element Should Be Enabled    ${SSID_VLAN_ID_INPUT}
    END

    Element Attribute Value Should Be    ${SSID_VLAN_ID_INPUT}    value    ${SSID_FACTORY_DEFAULT_VLAN_ID}
