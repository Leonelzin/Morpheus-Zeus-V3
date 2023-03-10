*** Settings ***
Documentation       System LED Resource File
...                 
...                 This resource file contains keywords related to system LED
...                 settings WEB page manipulation (page object model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/sidemenu_pom.resource

*** Variables ***
${LED_PROFILE_SECTION}                                  ${DUT}[profile][features][led]
${LED_STATUS_IS_SUPPORTED}                              ${LED_PROFILE_SECTION}[status_led][is_supported]
${LED_STATUS_FACTORY_DEFAULT_MODE}                      ${LED_PROFILE_SECTION}[status_led][factory_default][mode]
${LED_LOCATE_DEVICE_IS_SUPPORTED}                       ${LED_PROFILE_SECTION}[locate_device][is_supported]
${LED_COLOR_SETTINGS_IS_SUPPORTED}                      ${LED_PROFILE_SECTION}[color_settings][is_supported]
${LED_COLOR_SETTINGS_FACTORY_DEFAULT_COLOR}             ${LED_PROFILE_SECTION}[color_settings][factory_default][color]

${SYSTEM_LED_SUBMENU}                                   led_submenu

${LED_STATUS_SELECT}                                    status_led
${LED_STATUS_SELECT_OFF_VALUE}                          string:OFF
${LED_STATUS_SELECT_ON_VALUE}                           string:ON
${LED_STATUS_SELECT_SCHEDULING_VALUE}                   string:SCHEDULING

${LED_NORMAL_OPERATING_COLOR_SELECT}                    normal_operating_mode
${LED_NORMAL_OPERATING_COLOR_SELECT_RED_VALUE}          string:red
${LED_NORMAL_OPERATING_COLOR_SELECT_GREEN_VALUE}        string:green
${LED_NORMAL_OPERATING_COLOR_SELECT_BLUE_VALUE}         string:blue
${LED_NORMAL_OPERATING_COLOR_SELECT_CYAN_VALUE}         string:cyan
${LED_NORMAL_OPERATING_COLOR_SELECT_MAGENTA_VALUE}      string:magenta
${LED_NORMAL_OPERATING_COLOR_SELECT_YELLOW_VALUE}       string:yellow
${LED_NORMAL_OPERATING_COLOR_SELECT_WHITE_VALUE}        string:white
${LED_NORMAL_OPERATING_COLOR_SELECT_PINK_VALUE}         string:pink
${LED_NORMAL_OPERATING_COLOR_SELECT_PURPLE_VALUE}       string:purple
${LED_NORMAL_OPERATING_COLOR_SELECT_ORANGE_VALUE}       string:orange

${LED_SEARCH_BUTTON}                                    buscar

${LED_SCHEDULE_SUNDAY_BUTTON}                           sunday
${LED_SCHEDULE_MONDAY_BUTTON}                           monday
${LED_SCHEDULE_TUESDAY_BUTTON}                          tuesday
${LED_SCHEDULE_WEDNESDAY_BUTTON}                        wednesday
${LED_SCHEDULE_THURSDAY_BUTTON}                         thursday
${LED_SCHEDULE_FRIDAY_BUTTON}                           friday
${LED_SCHEDULE_SATURDAY_BUTTON}                         saturday
${LED_SCHEDULE_SELECT_ALL_BUTTON}                       select_all

${LED_SCHEDULE_ADD_INTERVAL_BUTTON}                     add_SSID_button
${LED_SCHEDULE_START_HOUR_SELECT}                       start_hour
${LED_SCHEDULE_START_MINUTE_SELECT}                     start_minute
${LED_SCHEDULE_END_HOUR_SELECT}                         end_hour
${LED_SCHEDULE_END_MINUTE_SELECT}                       end_minute

${LED_SCHEDULE_CONFIRM_CHANGES_BUTTON}                  confirm_button
${LED_SCHEDULE_DISCARD_CHANGES_BUTTON}                  cancel_button

${LED_SCHEDULE_REMOVE_BUTTON}                           remove_button

*** Keywords ***
Access LED Settings Page
    Open System Menu
    Wait Until Element Is Visible    ${SYSTEM_LED_SUBMENU}
    Click Element    ${SYSTEM_LED_SUBMENU}
    Wait For WEB Message To Disappear Or Timeout After "30" Seconds
    Wait Until Element Is Visible    ${LED_STATUS_SELECT}

Skip This Test If LED Settings Are Not Supported By DUT
    IF    ${LED_STATUS_IS_SUPPORTED} == ${FALSE} and ${LED_LOCATE_DEVICE_IS_SUPPORTED} == ${FALSE} and ${LED_COLOR_SETTINGS_IS_SUPPORTED} == ${FALSE}
        Skip    DUT does not support any LED settings.
    END

Set LED Status To Off
    Select From List By Value
    ...    ${LED_STATUS_SELECT}
    ...    ${LED_STATUS_SELECT_OFF_VALUE}

Set LED Status To On
    Select From List By Value
    ...    ${LED_STATUS_SELECT}
    ...    ${LED_STATUS_SELECT_ON_VALUE}

Set LED Status To Scheduling
    Select From List By Value
    ...    ${LED_STATUS_SELECT}
    ...    ${LED_STATUS_SELECT_SCHEDULING_VALUE}

Click Search Device Button
    Click Element    ${LED_SEARCH_BUTTON}

Set LED Color To Red
    Select From List By Value
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_RED_VALUE}

Set LED Color To Green
    Select From List By Value
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_GREEN_VALUE}

Set LED Color To Blue
    Select From List By Value
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_BLUE_VALUE}

Set LED Color To Cyan
    Select From List By Value
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_CYAN_VALUE}

Set LED Color To Magenta
    Select From List By Value
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_MAGENTA_VALUE}

Set LED Color To Yellow
    Select From List By Value
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_YELLOW_VALUE}

Set LED Color To White
    Select From List By Value
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_WHITE_VALUE}

Set LED Color To Pink
    Select From List By Value
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_PINK_VALUE}

Set LED Color To Purple
    Select From List By Value
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_PURPLE_VALUE}

Set LED Color To Orange
    Select From List By Value
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_ORANGE_VALUE}

LED Status Should Be Enabled
    List Selection Should Be
    ...    ${LED_STATUS_SELECT}
    ...    ${LED_STATUS_SELECT_ON_VALUE}

LED Color Should Be Green
    List Selection Should Be
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
    ...    ${LED_NORMAL_OPERATING_COLOR_SELECT_GREEN_VALUE}

LED Search Button Should Be Visible
    Element Should Be Visible    ${LED_SEARCH_BUTTON}

LED Search Button Should Not Be Visible
    Element Should Not Be Visible    ${LED_SEARCH_BUTTON}

LED Settings Should Be Factory Default
    IF    ${LED_STATUS_IS_SUPPORTED} == ${TRUE}
        List Selection Should Be
        ...    ${LED_STATUS_SELECT}
        ...    ${LED_STATUS_FACTORY_DEFAULT_MODE}
    END

    IF    ${LED_COLOR_SETTINGS_IS_SUPPORTED} == ${TRUE}
        List Selection Should Be
        ...    ${LED_NORMAL_OPERATING_COLOR_SELECT}
        ...    ${LED_COLOR_SETTINGS_FACTORY_DEFAULT_COLOR}
    END

    IF    ${LED_LOCATE_DEVICE_IS_SUPPORTED} == ${TRUE}
        LED Search Button Should Be Visible
    ELSE
        LED Search Button Should Not Be Visible
    END
