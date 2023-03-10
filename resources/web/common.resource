*** Settings ***
Documentation       Common Elements/Keywords WEB Page Resource File
...
...                 This resource file contains keywords related to common WEB
...                 page elements manipulation (page object model).

Library             Collections
Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            header_pom.resource

*** Variables ***
${SAVE_SETTINGS_BUTTON}                     salvar_button

${WEB_MESSAGE_BACKGROUND}                   backdrop
${WEB_MESSAGE_CONTAINER}                    zeusNotify
${WEB_MESSAGE}                              zeusNotifyMessage

${SAVE_SETTINGS_SUCCESS_WEB_MESSAGE}        Alterações salvas com sucesso
${APPLY_SETTINGS_SUCCESS_WEB_MESSAGE}       Alterações salvas com sucesso

${CONFIRMATION_MODAL}                       confirmation_modal
${CONFIRMATION_MODAL_CONTENT}               modal_content
${CONFIRMATION_MODAL_YES_BUTTON}            yes
${CONFIRMATION_MODAL_NO_BUTTON}             no

*** Keywords ***
Element Should Have Class
    [Arguments]    ${locator}    ${classname}
    ${classes}    Get Element Attribute    ${locator}    class
    @{classes}    Split String    ${classes}
    List Should Contain Value    ${classes}    ${classname}    Element ${locator} does not contain class ${classname}.

Element Should Not Have Class
    [Arguments]    ${locator}    ${classname}
    ${classes}    Get Element Attribute    ${locator}    class
    @{classes}    Split String    ${classes}
    List Should Not Contain Value    ${classes}    ${classname}    Element ${locator} contains class ${classname}.

Wait Until Element Has Class
    [Arguments]    ${locator}    ${classname}    ${timeout}
    Register Keyword To Run On Failure    NONE
    Wait Until Keyword Succeeds    ${timeout}    0.2s    Element Should Have Class    ${locator}    ${classname}
    Register Keyword To Run On Failure    Capture Page Screenshot

Wait Until Page Title Is
    [Arguments]    ${page_title}    ${timeout}=${SELENIUM_WAIT_TIMEOUT_SECONDS}
    Wait For Condition    return document.title == "${page_title}"    ${timeout}

Wait Until Element Text Is
    [Arguments]    ${locator}    ${text}    ${timeout}
    Wait For Condition    return document.getElementById("${locator}").textContent == "${text}"    ${timeout}

Click Save Settings Button
    Click Button    ${SAVE_SETTINGS_BUTTON}

Save Settings
    ${status}    Run Keyword And Return Status    Element Should Be Enabled    ${SAVE_SETTINGS_BUTTON}
    IF    ${status} == ${TRUE}
        Click Save Settings Button
        Wait Until WEB Message Is "${SAVE_SETTINGS_SUCCESS_WEB_MESSAGE}" Or Timeout After "70" Seconds
        Wait For WEB Message To Disappear Or Timeout After "5" Seconds
    END

Save Settings And Accept Modal Request If It Contains "${modal_text}"
    ${status}    Run Keyword And Return Status    Element Should Be Enabled    ${SAVE_SETTINGS_BUTTON}
    IF    ${status} == ${TRUE}
        Click Save Settings Button
        Wait Until Element Is Visible    ${CONFIRMATION_MODAL}
        Wait "1" Seconds For WEB Animation To Finish
        ${status}    Run Keyword And Return Status
        ...    Element Should Contain
        ...    ${CONFIRMATION_MODAL_CONTENT}
        ...    ${modal_text}
        IF    ${status} == ${TRUE}
            Click Button    ${CONFIRMATION_MODAL_YES_BUTTON}
        ELSE
            Capture Page Screenshot
            Fail    Modal (pop-up) does not contain expected text '${modal_text}'.
        END
        Wait Until WEB Message Is "${SAVE_SETTINGS_SUCCESS_WEB_MESSAGE}" Or Timeout After "70" Seconds
        Wait For WEB Message To Disappear Or Timeout After "5" Seconds
    END

Apply Settings
    ${visible}    Run Keyword And Return Status    Element Should Be Visible    ${APPLY_SETTINGS_BUTTON}
    ${enabled}    Run Keyword And Return Status    Element Should Be Enabled    ${APPLY_SETTINGS_BUTTON}
    IF    ${visible} == ${TRUE} and ${enabled} == ${TRUE}
        Click Apply Settings Button
        Wait Until WEB Message Is "${APPLY_SETTINGS_SUCCESS_WEB_MESSAGE}" Or Timeout After "70" Seconds
        Wait For WEB Message To Disappear Or Timeout After "5" Seconds
    END

Save And Apply Settings
    Save Settings
    Apply Settings

Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "${message}"
    ${status}    Run Keyword And Return Status    Element Should Be Enabled    ${SAVE_SETTINGS_BUTTON}
    IF    ${status} == ${TRUE}
        Click Save Settings Button
        Wait Until WEB Message Is "${message}" Or Timeout After "5" Seconds
    END

Click Apply Settings Button If It Is Visible And Enabled
    ${visible}    Run Keyword And Return Status    Element Should Be Visible    ${APPLY_SETTINGS_BUTTON}
    ${enabled}    Run Keyword And Return Status    Element Should Be Enabled    ${APPLY_SETTINGS_BUTTON}
    IF    ${visible} == ${TRUE} and ${enabled} == ${TRUE}
        Click Apply Settings Button
        Wait Until WEB Message Is "${APPLY_SETTINGS_SUCCESS_WEB_MESSAGE}" Or Timeout After "70" Seconds
        Wait For WEB Message To Disappear Or Timeout After "5" Seconds
    END

Wait "${time_to_wait}" Seconds For Settings To Take Effect
    Sleep    ${time_to_wait}

Wait For WEB Message To Disappear
    Wait Until Element Is Not Visible    ${WEB_MESSAGE_BACKGROUND}
    Wait Until Element Is Not Visible    ${WEB_MESSAGE_CONTAINER}
    Wait Until Element Is Not Visible    ${WEB_MESSAGE}

Wait For WEB Message To Disappear Or Timeout After "${timeout}" Seconds
    Wait Until Element Is Not Visible    ${WEB_MESSAGE_BACKGROUND}    ${timeout}
    Wait Until Element Is Not Visible    ${WEB_MESSAGE_CONTAINER}    ${timeout}
    Wait Until Element Is Not Visible    ${WEB_MESSAGE}    ${timeout}

Get Current Displayed WEB Message
    ${text}    Get Text    ${WEB_MESSAGE}
    [Return]    ${text}

Current Displayed WEB Message Should Be "${value}"
    Element Text Should Be    ${WEB_MESSAGE}    ${value}

Wait Until WEB Message Is "${message}" Or Timeout After "${timeout}" Seconds
    Register Keyword To Run On Failure    NONE
    ${status}    ${error}    Run Keyword And Ignore Error    Wait Until Keyword Succeeds    ${timeout}s    0.1s
    ...    Element Text Should Be    ${WEB_MESSAGE}    ${message}
    Register Keyword To Run On Failure    Capture Page Screenshot
    IF    '${status}' == 'FAIL'
        Capture Page Screenshot
        Fail    ${error}
    END

Dismiss Current Displayed WEB Message
    Click Element    ${WEB_MESSAGE}
    Wait Until Element Is Not Visible    ${WEB_MESSAGE}
    Wait Until Element Is Not Visible    ${WEB_MESSAGE_CONTAINER}
    Wait Until Element Is Not Visible    ${WEB_MESSAGE_BACKGROUND}

Dismiss WEB Message If It Is Displayed
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${WEB_MESSAGE}    timeout=2s
    IF    ${status} == ${TRUE}
        Dismiss Current Displayed WEB Message
    END

Dismiss WEB Message "${message}" If It Is Displayed
    ${msg_is_visible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${WEB_MESSAGE}    timeout=2s
    ${msg_is_expected}    Run Keyword And Return Status    Element Text Should Be    ${WEB_MESSAGE}    ${message}
    IF    ${msg_is_visible} == ${TRUE} and ${msg_is_expected} == ${TRUE}
        Dismiss Current Displayed WEB Message
    END

Dismiss WEB Message If It Is Displayed And Contains "${text}"
    ${msg_is_visible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${WEB_MESSAGE}    timeout=2s
    ${msg_is_expected}    Run Keyword And Return Status    Element Should Contain    ${WEB_MESSAGE}    ${text}
    IF    ${msg_is_visible} == ${TRUE} and ${msg_is_expected} == ${TRUE}
        Dismiss Current Displayed WEB Message
    END

Wait "${value}" Seconds For WEB Animation To Finish
    Sleep    ${value}

Click Save Settings Button And Expect WEB Message To Be "${SESSION_TIMEOUT_RANGE_ERROR_WEB_MESSAGE}"
    Click Save Settings Button
    Wait Until WEB Message Is "${SESSION_TIMEOUT_RANGE_ERROR_WEB_MESSAGE}" Or Timeout After "5" Seconds

Table Header Text Should Be
    [Arguments]    ${locator}    ${header_column_index}    ${expected_header_text}
    ${header_text}    Get Table Cell
    ...    ${locator}
    ...    1    ${header_column_index}
    Should Match    ${header_text}    ${expected_header_text}
