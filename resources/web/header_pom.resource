*** Settings ***
Documentation       WEB Header Resource File
...
...                 This resource file contains keywords related to WEB header
...                 manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            common.resource
Resource            sidemenu_pom.resource
Resource            login_pom.resource
Resource            web/system/management_pom.resource

*** Variables ***
${SIDE_MENU_WRAPPER}                        wrapper
${SIDE_MENU_TOGGLE_BUTTON}                  buttonToggle

${REFRESH_SESSION_BUTTON}                   sessionTimeout

${APPLY_SETTINGS_BUTTON}                    apply_config_button

${APPLY_SETTINGS_DROPDOWN_BUTTON}           dropdown_button
${DROPDOWN_DISCARD_SETTINGS_BUTTON}         dropdown_discard_changes_button_link
${DROPDOWN_LOGOUT_BUTTON}                   dropdown_exit_button_link

${LOGOUT_BUTTON}                            exit_button

${LOGOUT_CONFIRMATION_MODAL}                confirmation_modal
${LOGOUT_CONFIRMATION_MODAL_YES_BUTTON}     yes
${LOGOUT_CONFIRMATION_MODAL_NO_BUTTON}      no

*** Keywords ***
Open Side Menu
    Wait Until Element Is Visible    ${SIDE_MENU_TOGGLE_BUTTON}
    ${sidemenu_class}    Get Element Attribute    ${SIDE_MENU_WRAPPER}    class
    IF    '${sidemenu_class}' == 'toggled'
        Click Element    ${SIDE_MENU_TOGGLE_BUTTON}
    END
    Wait Until Keyword Succeeds    5    1 sec
    ...    Element Attribute Value Should Be    ${SIDE_MENU_WRAPPER}    class
    ...    ${EMPTY}

Close Side Menu
    Wait Until Element Is Visible    ${SIDE_MENU_TOGGLE_BUTTON}
    ${sidemenu_class}    Get Element Attribute    ${SIDE_MENU_WRAPPER}    class
    IF    '${sidemenu_class}' == ''
        Click Element    ${SIDE_MENU_TOGGLE_BUTTON}
    END
    Wait Until Keyword Succeeds    5    1 sec
    ...    Element Attribute Value Should Be    ${SIDE_MENU_WRAPPER}    class
    ...    toggled

Click Refresh Session Button
    Click Element    ${REFRESH_SESSION_BUTTON}
    Wait Until Element Is Not Visible    ${REFRESH_SESSION_BUTTON}

Session Timeout Clock Widget Should Be Visible
    Element Should Be Visible    ${REFRESH_SESSION_BUTTON}

Session Timeout Clock Widget Should Not Be Visible
    Element Should Not Be Visible    ${REFRESH_SESSION_BUTTON}

Set System Management Session Timeout Minimum And Relog DUT
    Access System Management Page
    Set System Management Session Timeout To "60"
    Save And Apply Settings
    Logout From DUT WEB Management And Login Again

Click Apply Settings Button
    Click Button    ${APPLY_SETTINGS_BUTTON}

Discard Saved Settings
    Wait Until Element Is Visible    ${APPLY_SETTINGS_BUTTON}
    Click Button    ${APPLY_SETTINGS_DROPDOWN_BUTTON}
    Wait Until Element Is Visible    ${DROPDOWN_DISCARD_SETTINGS_BUTTON}
    Click Element    ${DROPDOWN_DISCARD_SETTINGS_BUTTON}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${STATUS_MENU}    timeout=60s

Discard Saved Settings If There Are Changes
    Register Keyword To Run On Failure    NONE
    ${status}    Run Keyword And Return Status
    ...    Element Should Be Visible    ${APPLY_SETTINGS_BUTTON}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    ${status} == ${TRUE}
        Discard Saved Settings
    END

Logout From DUT WEB Management
    ${apply_dropdown_is_visible}    Run Keyword And Return Status
    ...    Element Should Be Visible    ${APPLY_SETTINGS_DROPDOWN_BUTTON}

    IF    ${apply_dropdown_is_visible} == ${TRUE}
        Click Button    ${APPLY_SETTINGS_DROPDOWN_BUTTON}
        Wait Until Element Is Visible    ${DROPDOWN_LOGOUT_BUTTON}
        Click Button    ${DROPDOWN_LOGOUT_BUTTON}
    ELSE
        Click Button    ${LOGOUT_BUTTON}
    END

    Wait Until Element Is Visible    ${LOGOUT_CONFIRMATION_MODAL}
    Click Button    ${LOGOUT_CONFIRMATION_MODAL_YES_BUTTON}
    Wait Until Login Page Is Displayed Or Timeout After "30" Seconds
