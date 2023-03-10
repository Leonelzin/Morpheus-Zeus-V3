*** Settings ***
Documentation       DDNS Service Resource File
...                 
...                 This resource file contains keywords related to DDNS
...                 service settings webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/sidemenu_pom.resource

*** Variables ***
${DDNS_FACTORY_DEFAULT}                     ${DUT}[profile][features][ddns][factory_default]
${DDNS_FACTORY_DEFAULT_ENABLED}             ${DDNS_FACTORY_DEFAULT}[enabled]
${DDNS_FACTORY_DEFAULT_SERVICE}             ${DDNS_FACTORY_DEFAULT}[service]
${DDNS_FACTORY_DEFAULT_DOMAIN}              ${DDNS_FACTORY_DEFAULT}[domain]
${DDNS_FACTORY_DEFAULT_USER}                ${DDNS_FACTORY_DEFAULT}[username]
${DDNS_FACTORY_DEFAULT_PASSWORD}            ${DDNS_FACTORY_DEFAULT}[password]

${DDNS_SUBMENU}                             ddns_submenu

${DDNS_ENABLE_CHECKBOX}                     enabled_ddns

${DDNS_SERVICE_SELECT}                      ddns_service
${DDNS_SERVICE_SELECT_INTELBRAS_VALUE}      string:ddns-intelbras
${DDNS_SERVICE_SELECT_NO_IP_VALUE}          string:no-ip
${DDNS_SERVICE_SELECT_DYNDNS_VALUE}         string:dyndns

${DDNS_DOMAIN_INPUT}                        ddns_domain
${DDNS_USER_INPUT}                          ddns_user
${DDNS_PASSWORD_INPUT}                      id:ddns_password
${DDNS_SHOW_PASSWORD_CHECKBOX}              ddns_password_checkbox

*** Keywords ***
Access DDNS Service Settings Page
    Open Services Menu
    Wait Until Element Is Visible    ${DDNS_SUBMENU}
    Click Element    ${DDNS_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${DDNS_ENABLE_CHECKBOX}

DDNS Service Select Should Be "${service}"
    List Selection Should Be
    ...    ${DDNS_SERVICE_SELECT}
    ...    ${service}

DDNS Domain Should Be "${domain}"
    Element Attribute Value Should Be
    ...    ${DDNS_DOMAIN_INPUT}
    ...    value    ${domain}

DDNS User Should Be "${user}"
    Element Attribute Value Should Be
    ...    ${DDNS_USER_INPUT}
    ...    value    ${user}

DDNS Password Should Be "${password}"
    Element Attribute Value Should Be
    ...    ${DDNS_PASSWORD_INPUT}
    ...    value    ${password}

DDNS Settings Should Be Factory Default
    IF    ${DDNS_FACTORY_DEFAULT_ENABLED} == ${TRUE}
        Checkbox Should Be Selected    ${DDNS_ENABLE_CHECKBOX}
    ELSE
        Checkbox Should Not Be Selected    ${DDNS_ENABLE_CHECKBOX}
        Element Should Be Disabled    ${DDNS_SERVICE_SELECT}
        Element Should Be Disabled    ${DDNS_DOMAIN_INPUT}
        Element Should Be Disabled    ${DDNS_USER_INPUT}
        IF    '${DDNS_FACTORY_DEFAULT_SERVICE}' != 'intelbras'
            Element Should Be Disabled    ${DDNS_PASSWORD_INPUT}
        END
    END

    IF    '${DDNS_FACTORY_DEFAULT_SERVICE}' == 'intelbras'
        List Selection Should Be
        ...    ${DDNS_SERVICE_SELECT}
        ...    ${DDNS_SERVICE_SELECT_INTELBRAS_VALUE}
        Element Should Not Be Visible    ${DDNS_PASSWORD_INPUT}
        Element Should Not Be Visible    ${DDNS_SHOW_PASSWORD_CHECKBOX}
    ELSE IF    '${DDNS_FACTORY_DEFAULT_SERVICE}' == 'no_ip'
        List Selection Should Be
        ...    ${DDNS_SERVICE_SELECT}
        ...    ${DDNS_SERVICE_SELECT_NO_IP_VALUE}
    ELSE IF    '${DDNS_FACTORY_DEFAULT_SERVICE}' == 'dyndns'
        List Selection Should Be
        ...    ${DDNS_SERVICE_SELECT}
        ...    ${DDNS_SERVICE_SELECT_DYNDNS_VALUE}
    ELSE
        Fail    Could not determine DUT DDNS service factory default settings (check DUT profile).
    END

    DDNS Domain Should Be "${DDNS_FACTORY_DEFAULT_DOMAIN}"
    DDNS User Should Be "${DDNS_FACTORY_DEFAULT_USER}"
    DDNS Password Should Be "${DDNS_FACTORY_DEFAULT_PASSWORD}"

    IF    '${DDNS_FACTORY_DEFAULT_SERVICE}' != 'intelbras'
        Checkbox Should Not Be Selected    ${DDNS_SHOW_PASSWORD_CHECKBOX}
    END
