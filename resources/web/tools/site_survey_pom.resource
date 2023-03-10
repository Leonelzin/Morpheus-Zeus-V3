*** Settings ***
Documentation       Site Survey Resource File
...                 
...                 This resource file contains keywords related to site survey
...                 webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${TOOLS_SITE_SURVEY_FACTORY_DEFAULT}            ${DUT}[profile][tools][site_survey][factory_default]
${TOOLS_SITE_SURVEY_FACTORY_DEFAULT_BAND}       ${TOOLS_SITE_SURVEY_FACTORY_DEFAULT}[frequency_band]

${TOOLS_SITE_SURVEY_SUBMENU}                    sitesurvey_submenu

${TOOLS_SITE_SURVEY_IFACE_SELECT}               radio_filter
${TOOLS_SITE_SURVEY_IFACE_SELECT_5GHZ_VALUE}    string:${DUT}[profile][wireless][5ghz][interface_id]
${TOOLS_SITE_SURVEY_IFACE_SELECT_2GHZ_VALUE}    string:${DUT}[profile][wireless][2ghz][interface_id]
${TOOLS_SITE_SURVEY_IFACE_SELECT_5GHZ_LABEL}    Interface 5 GHz
${TOOLS_SITE_SURVEY_IFACE_SELECT_2GHZ_LABEL}    Interface 2.4 GHz

${TOOLS_SITE_SURVEY_REFRESH_BUTTON}             refresh_button

${TOOLS_SITE_SURVEY_WIRELESS_NETWORKS_TABLE}    xpath://*[@id="main"]/div[2]/div/div/div[2]/div/table

*** Keywords ***
Access Site Survey Settings Page
    Open Tools Menu
    Wait Until Element Is Visible    ${TOOLS_SITE_SURVEY_SUBMENU}
    Click Element    ${TOOLS_SITE_SURVEY_SUBMENU}
    Wait Until WEB Message Is "Atualizando..." Or Timeout After "30" Seconds
    Wait For WEB Message To Disappear Or Timeout After "90" Seconds
    Wait Until Element Is Visible    ${TOOLS_SITE_SURVEY_REFRESH_BUTTON}

Site Survey Settings Should Be Factory Default
    IF    '${TOOLS_SITE_SURVEY_FACTORY_DEFAULT_BAND}' == '5ghz'
        List Selection Should Be
        ...    ${TOOLS_SITE_SURVEY_IFACE_SELECT}
        ...    ${TOOLS_SITE_SURVEY_IFACE_SELECT_5GHZ_VALUE}

        List Selection Should Be
        ...    ${TOOLS_SITE_SURVEY_IFACE_SELECT}
        ...    ${TOOLS_SITE_SURVEY_IFACE_SELECT_5GHZ_LABEL}
    ELSE IF    '${TOOLS_SITE_SURVEY_FACTORY_DEFAULT_BAND}' == '2.4ghz'
        List Selection Should Be
        ...    ${TOOLS_SITE_SURVEY_IFACE_SELECT}
        ...    ${TOOLS_SITE_SURVEY_IFACE_SELECT_2GHZ_VALUE}

        List Selection Should Be
        ...    ${TOOLS_SITE_SURVEY_IFACE_SELECT}
        ...    ${TOOLS_SITE_SURVEY_IFACE_SELECT_2GHZ_LABEL}
    ELSE
        Fail    Could not determine site survey factory default interface (check DUT profile).
    END

    Element Should Be Visible    ${TOOLS_SITE_SURVEY_REFRESH_BUTTON}
    Element Should Be Enabled    ${TOOLS_SITE_SURVEY_REFRESH_BUTTON}

    Element Should Be Visible    ${TOOLS_SITE_SURVEY_WIRELESS_NETWORKS_TABLE}
