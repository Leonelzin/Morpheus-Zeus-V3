*** Settings ***
Documentation       Wizard (Common Initial Steps) Resource File
...                 
...                 This resource file contains keywords related to wizard
...                 common initial steps webpage manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             String
Library             Collections
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${WIZ_HOSTNAME_INPUT}                   wan_alias

${WIZ_COUNTRY_SELECT}                   country
${WIZ_COUNTRY_SELECT_BRAZIL_VALUE}      string:BR
${WIZ_COUNTRY_SELECT_BRAZIL_LABEL}      Brasil

${WIZ_PREV_STEP_BUTTON}                 button_back
${WIZ_NEXT_STEP_BUTTON}                 button_next
${WIZ_LAST_STEP_CONFIRMATION_BUTTON}    button_next

${WIZ_PRESET_FACEBOOK_BUTTON}           op_mode_option_facebook
${WIZ_PRESET_SPLASH_PAGE_BUTTON}        op_mode_option_splash
${WIZ_PRESET_ACCESS_POINT_BUTTON}       op_mode_option_access_point
${WIZ_PRESET_ROUTER_BUTTON}             op_mode_option_router
${WIZ_PRESET_REPEATER_BUTTON}           op_mode_option_repeater

*** Keywords ***
Access Wizard Settings Page
    Open Wizard Menu
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${WIZ_HOSTNAME_INPUT}

Go To Next Wizard Step
    Click Button    ${WIZ_NEXT_STEP_BUTTON}

Click Router Preset Button
    Click Button    ${WIZ_PRESET_ROUTER_BUTTON}

Click Access Point Preset Button
    Click Button    ${WIZ_PRESET_ACCESS_POINT_BUTTON}

Click Repeater Preset Button
    Click Button    ${WIZ_PRESET_REPEATER_BUTTON}

Click Splash Page Preset Button
    Click Button    ${WIZ_PRESET_SPLASH_PAGE_BUTTON}

Wizard Common First Step Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Attribute Value Should Be
    ...    ${WIZ_HOSTNAME_INPUT}
    ...    value    ${DUT}[profile][network][factory_default][hostname]

    List Selection Should Be
    ...    ${WIZ_COUNTRY_SELECT}
    ...    ${WIZ_COUNTRY_SELECT_BRAZIL_VALUE}

    List Selection Should Be
    ...    ${WIZ_COUNTRY_SELECT}
    ...    ${WIZ_COUNTRY_SELECT_BRAZIL_LABEL}

Wizard Preset (Operation Mode) Should Be Factory Default
    Wait Until Element Is Visible    ${WIZ_NEXT_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_NEXT_STEP_BUTTON}

    Element Should Be Visible    ${WIZ_PREV_STEP_BUTTON}
    Element Should Be Enabled    ${WIZ_PREV_STEP_BUTTON}

    IF    '${DUT}[profile][wizard][default_preset]' == 'facebook'
        Element Should Have Class
        ...    ${WIZ_PRESET_FACEBOOK_BUTTON}
        ...    btn-intelbras
    ELSE IF    '${DUT}[profile][wizard][default_preset]' == 'splash_page'
        Element Should Have Class
        ...    ${WIZ_PRESET_SPLASH_PAGE_BUTTON}
        ...    btn-intelbras
    ELSE IF    '${DUT}[profile][wizard][default_preset]' == 'access_point'
        Element Should Have Class
        ...    ${WIZ_PRESET_ACCESS_POINT_BUTTON}
        ...    btn-intelbras
    ELSE IF    '${DUT}[profile][wizard][default_preset]' == 'router'
        Element Should Have Class
        ...    ${WIZ_PRESET_ROUTER_BUTTON}
        ...    btn-intelbras
    ELSE IF    '${DUT}[profile][wizard][default_preset]' == 'repeater'
        Element Should Have Class
        ...    ${WIZ_PRESET_REPEATER_BUTTON}
        ...    btn-intelbras
    ELSE
        Fail    Could not determine DUT wizard factory default preset (check DUT profile).
    END
