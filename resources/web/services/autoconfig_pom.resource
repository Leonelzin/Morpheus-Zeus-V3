*** Settings ***
Documentation       Automatic Device Configuration Service Resource File
...                 
...                 This resource file contains keywords related to automatic
...                 device configuration WEB page manipulation (page object
...                 model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${AUTOCONFIG_FACTORY_DEFAULT}                                       ${DUT}[profile][features][auto_configuration][factory_default]
${AUTOCONFIG_FACTORY_DEFAULT_ENABLED}                               ${AUTOCONFIG_FACTORY_DEFAULT}[enabled]
${AUTOCONFIG_FACTORY_DEFAULT_AUTO_AUTHORIZATION_ENABLED}            ${AUTOCONFIG_FACTORY_DEFAULT}[auto_authorization_enabled]

${AUTOCONFIG_SUBMENU}                                               auto_config_submenu

${AUTOCONFIG_AUTOMATIC_AUTH_ENABLE_CHECKBOX}                        auth_mode_auto
${AUTOCONFIG_MODERATE_AUTH_ENABLE_CHECKBOX}                         auth_mode_moderate

${AUTOCONFIG_AUTHORIZED_DEVICES_ACCORDION_HEADER}                   devices_awaiting_auth_accordion_header

${AUTOCONFIG_REMOVE_AUTHORIZED_DEVICES_BUTTON}                      remove_devices_button
${AUTOCONFIG_REFRESH_AUTHORIZED_DEVICES_BUTTON}                     refresh_devices_button
${AUTOCONFIG_AUTHORIZE_NEW_DEVICES_BUTTON}                          authorize_selected_devices_button

${AUTOCONFIG_AUTHORIZED_DEVICES_TABLE}                              devices_authorization_table

${AUTOCONFIG_AUTHORIZE_SELECTED_DEVICES_MODAL_BUTTON}               authorize_selected_devices_modal_button
${AUTOCONFIG_REFRESH_DEVICES_AWAITING_AUTH_MODAL_BUTTON}            refresh_devices_modal_button
${AUTOCONFIG_SELECT_ALL_DEVICES_AWAITING_AUTH_MODAL_CHECKBOX}       head_devices_waiting_auth_all_check

${AUTOCONFIG_CANCEL_MODAL_BUTTON}                                   cancel_modal_button

*** Keywords ***
Skip This Test If Automatic Device Configuration Is Not Supported By DUT
    IF    ${DUT}[profile][features][auto_configuration][is_supported] == ${False}
        Skip    DUT does not support automatic device configuration.
    END

Access Automatic Device Configuration Service Settings Page
    Open Services Menu
    Wait Until Element Is Visible    ${AUTOCONFIG_SUBMENU}
    Click Element    ${AUTOCONFIG_SUBMENU}
    Wait For WEB Message To Disappear
    Wait Until Element Is Visible    ${AUTOCONFIG_AUTOMATIC_AUTH_ENABLE_CHECKBOX}

Select Automatic Authorization Checkbox
    Select Checkbox    ${AUTOCONFIG_AUTOMATIC_AUTH_ENABLE_CHECKBOX}
    Wait "2" Seconds For WEB Animation To Finish

Select Moderate Authorization Checkbox
    Select Checkbox    ${AUTOCONFIG_MODERATE_AUTH_ENABLE_CHECKBOX}
    Wait "2" Seconds For WEB Animation To Finish

Open Devices Awaiting Authorization Modal
    Click Button    ${AUTOCONFIG_AUTHORIZE_NEW_DEVICES_BUTTON}
    Wait Until Element Is Visible    ${AUTOCONFIG_CANCEL_MODAL_BUTTON}
    Wait "2" Seconds For Settings To Take Effect

Click Refresh Devices Awaiting Authorization Modal Button
    Click Button    ${AUTOCONFIG_REFRESH_DEVICES_AWAITING_AUTH_MODAL_BUTTON}

Authorized Devices Accordion Should Be Visible
    Element Should Be Visible    ${AUTOCONFIG_AUTHORIZED_DEVICES_ACCORDION_HEADER}

Automatic Device Configuration Settings Should Be Factory Default
    IF    ${AUTOCONFIG_FACTORY_DEFAULT_AUTO_AUTHORIZATION_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${AUTOCONFIG_AUTOMATIC_AUTH_ENABLE_CHECKBOX}
        Checkbox Should Not Be Selected    ${AUTOCONFIG_MODERATE_AUTH_ENABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${AUTOCONFIG_AUTOMATIC_AUTH_ENABLE_CHECKBOX}
        Checkbox Should Be Selected    ${AUTOCONFIG_MODERATE_AUTH_ENABLE_CHECKBOX}
        Element Should Be Visible    ${AUTOCONFIG_REMOVE_AUTHORIZED_DEVICES_BUTTON}
        Element Should Be Visible    ${AUTOCONFIG_AUTHORIZE_NEW_DEVICES_BUTTON}
        Element Should Be Enabled    ${AUTOCONFIG_AUTHORIZE_NEW_DEVICES_BUTTON}
    END
    Element Should Be Visible    ${AUTOCONFIG_AUTHORIZED_DEVICES_ACCORDION_HEADER}
