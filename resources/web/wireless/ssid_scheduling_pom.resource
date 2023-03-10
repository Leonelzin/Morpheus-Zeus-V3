*** Settings ***
Documentation       Wireless SSID Scheduling Settings Resource File
...                 
...                 This resource file contains keywords related to wireless
...                 SSID scheduling settings WEB page manipulation (page object
...                 model).

Library             String
Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Resource            web/common.resource

*** Variables ***
${MAX_SSID_SCHEDULING_INTERVALS_PER_DAY_OF_WEEK}            100

${SSID_SCHEDULING_SELECT}                                   ssid_scheduling
${SSID_SCHEDULING_SELECT_ACTIVATED_VALUE}                   boolean:true
${SSID_SCHEDULING_SELECT_DEACTIVATED_VALUE}                 boolean:false
${SSID_SCHEDULING_ADD_INTERVAL_BUTTON}                      ssid_scheduling_add_interval

${SSID_SCHEDULING_DAY_OF_WEEK_SELECT}                       ssid_scheduling_day
${SSID_SCHEDULING_DAY_OF_WEEK_SELECT_SUNDAY_VALUE}          string:sun
${SSID_SCHEDULING_DAY_OF_WEEK_SELECT_MONDAY_VALUE}          string:mon
${SSID_SCHEDULING_DAY_OF_WEEK_SELECT_TUESDAY_VALUE}         string:tue
${SSID_SCHEDULING_DAY_OF_WEEK_SELECT_WEDNESDAY_VALUE}       string:wed
${SSID_SCHEDULING_DAY_OF_WEEK_SELECT_THURSDAY_VALUE}        string:thu
${SSID_SCHEDULING_DAY_OF_WEEK_SELECT_FRIDAY_VALUE}          string:fri
${SSID_SCHEDULING_DAY_OF_WEEK_SELECT_SATURDAY_VALUE}        string:sat

${SSID_SCHEDULING_SUNDAY_CHECKBOX}                          ssid_scheduling_sun
${SSID_SCHEDULING_MONDAY_CHECKBOX}                          ssid_scheduling_mon
${SSID_SCHEDULING_TUESDAY_CHECKBOX}                         ssid_scheduling_tue
${SSID_SCHEDULING_WEDNESDAY_CHECKBOX}                       ssid_scheduling_wed
${SSID_SCHEDULING_THURSDAY_CHECKBOX}                        ssid_scheduling_thu
${SSID_SCHEDULING_FRIDAY_CHECKBOX}                          ssid_scheduling_fri
${SSID_SCHEDULING_SATURDAY_CHECKBOX}                        ssid_scheduling_sat

${SSID_SCHEDULING_SUNDAY_INTERVAL_PREFIX}                   ssid_scheduling_sun

${SSID_SCHEDULING_REMOVE_SUNDAY_INTERVAL_PREFIX}            ssid_scheduling_remove_interval_sun
${SSID_SCHEDULING_REMOVE_MONDAY_INTERVAL_PREFIX}            ssid_scheduling_remove_interval_mon
${SSID_SCHEDULING_REMOVE_TUESDAY_INTERVAL_PREFIX}           ssid_scheduling_remove_interval_tue
${SSID_SCHEDULING_REMOVE_WEDNESDAY_INTERVAL_PREFIX}         ssid_scheduling_remove_interval_wed
${SSID_SCHEDULING_REMOVE_THURSDAY_INTERVAL_PREFIX}          ssid_scheduling_remove_interval_thu
${SSID_SCHEDULING_REMOVE_FRIDAY_INTERVAL_PREFIX}            ssid_scheduling_remove_interval_fri
${SSID_SCHEDULING_REMOVE_SATURDAY_INTERVAL_PREFIX}          ssid_scheduling_remove_interval_sat

${SSID_SCHEDULING_CONFIRM_CHANGES_BUTTON}                   ssid_confirm_scheduling_changes
${SSID_SCHEDULING_DISCARD_CHANGES_BUTTON}                   ssid_discard_scheduling_changes

*** Keywords ***
Discard SSID Scheduling Changes
    Click Button    ${SSID_SCHEDULING_DISCARD_CHANGES_BUTTON}
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END

Confirm SSID Scheduling Changes
    Click Button    ${SSID_SCHEDULING_CONFIRM_CHANGES_BUTTON}
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END

Set SSID Scheduling To Activated
    Select From List By Value    ${SSID_SCHEDULING_SELECT}    ${SSID_SCHEDULING_SELECT_ACTIVATED_VALUE}

Add New SSID Scheduling On Sunday
    Select From List By Value    ${SSID_SCHEDULING_DAY_OF_WEEK_SELECT}    ${SSID_SCHEDULING_DAY_OF_WEEK_SELECT_SUNDAY_VALUE}
    Click Button    ${SSID_SCHEDULING_ADD_INTERVAL_BUTTON}

    FOR    ${index}    IN RANGE    0    ${MAX_SSID_SCHEDULING_INTERVALS_PER_DAY_OF_WEEK}
        ${status}    Run Keyword And Return Status    Get WebElement    ${SSID_SCHEDULING_SUNDAY_INTERVAL_PREFIX}_${index}
        Exit For Loop If    ${status} != ${TRUE}
    END

    [Return]    ${index-1}

Parse SSID Scheduling Interval Day Of Week Start Time HTML Locator
    [Arguments]    ${day_of_week}    ${index}
    ${day_of_week}    Convert To Lower Case    ${day_of_week}

    Return From Keyword If    '${day_of_week}' == 'sunday'    //*[@id="ssid_scheduling_sun_${index}"]/div/span[5]
    Return From Keyword If    '${day_of_week}' == 'monday'    //*[@id="ssid_scheduling_mon_${index}"]/div/span[5]
    Return From Keyword If    '${day_of_week}' == 'tuesday'    //*[@id="ssid_scheduling_tue_${index}"]/div/span[5]
    Return From Keyword If    '${day_of_week}' == 'wednesday'    //*[@id="ssid_scheduling_wed_${index}"]/div/span[5]
    Return From Keyword If    '${day_of_week}' == 'thursday'    //*[@id="ssid_scheduling_thu_${index}"]/div/span[5]
    Return From Keyword If    '${day_of_week}' == 'friday'    //*[@id="ssid_scheduling_fri_${index}"]/div/span[5]
    Return From Keyword If    '${day_of_week}' == 'saturday'    //*[@id="ssid_scheduling_sat_${index}"]/div/span[5]

    Fail    User provided an invalid SSID scheduling day of week: '${day_of_week}'.

Parse SSID Scheduling Interval Day Of Week End Time HTML Locator
    [Arguments]    ${day_of_week}    ${index}
    ${day_of_week}    Convert To Lower Case    ${day_of_week}

    Return From Keyword If    '${day_of_week}' == 'sunday'    //*[@id="ssid_scheduling_sun_${index}"]/div/span[6]
    Return From Keyword If    '${day_of_week}' == 'monday'    //*[@id="ssid_scheduling_mon_${index}"]/div/span[6]
    Return From Keyword If    '${day_of_week}' == 'tuesday'    //*[@id="ssid_scheduling_tue_${index}"]/div/span[6]
    Return From Keyword If    '${day_of_week}' == 'wednesday'    //*[@id="ssid_scheduling_wed_${index}"]/div/span[6]
    Return From Keyword If    '${day_of_week}' == 'thursday'    //*[@id="ssid_scheduling_thu_${index}"]/div/span[6]
    Return From Keyword If    '${day_of_week}' == 'friday'    //*[@id="ssid_scheduling_fri_${index}"]/div/span[6]
    Return From Keyword If    '${day_of_week}' == 'saturday'    //*[@id="ssid_scheduling_sat_${index}"]/div/span[6]

    Fail    User provided an invalid SSID scheduling day of week: '${day_of_week}'.

Set SSID "${day_of_week}" Scheduling "${index}" Start Time To "${time}"
    ${start_time_locator}    Parse SSID Scheduling Interval Day Of Week Start Time HTML Locator    ${day_of_week}    ${index}

    @{time}    Split String    ${time}    :
    ${desired_hour}    Convert To Integer    ${time}[0]
    ${desired_minute}    Convert To Integer    ${time}[1]

    ${width}    ${height}    Get Element Size    ${start_time_locator}
    ${width}    Evaluate    (-${width}/2)+2
    Click Element At Coordinates    ${start_time_locator}    ${width}    0

    FOR    ${count}    IN RANGE    100
        ${curr_time}    Get Element Attribute    ${start_time_locator}    aria-valuenow
        @{curr_time}    Split String    ${curr_time}    :
        ${curr_hour}    Convert To Integer    ${curr_time}[0]
        ${curr_minute}    Convert To Integer    ${curr_time}[1]

        Exit For Loop If    ${curr_hour} == ${desired_hour} and ${curr_minute} == ${desired_minute}

        IF    ${curr_hour} < ${desired_hour} or (${curr_hour} == ${desired_hour} and ${curr_minute} < ${desired_minute})
            Press Keys    None    ARROW_RIGHT
        ELSE
            Press Keys    None    ARROW_LEFT
        END
    END
    Click Element At Coordinates    ${start_time_locator}    ${width}    0

Set SSID "${day_of_week}" Scheduling "${index}" End Time To "${time}"
    ${end_time_locator}    Parse SSID Scheduling Interval Day Of Week End Time HTML Locator    ${day_of_week}    ${index}

    @{time}    Split String    ${time}    :
    ${desired_hour}    Convert To Integer    ${time}[0]
    ${desired_minute}    Convert To Integer    ${time}[1]

    ${width}    ${height}    Get Element Size    ${end_time_locator}
    ${width}    Evaluate    (${width}/2)-2
    Click Element At Coordinates    ${end_time_locator}    ${width}    0

    FOR    ${count}    IN RANGE    100
        ${curr_time}    Get Element Attribute    ${end_time_locator}    aria-valuenow
        @{curr_time}    Split String    ${curr_time}    :
        ${curr_hour}    Convert To Integer    ${curr_time}[0]
        ${curr_minute}    Convert To Integer    ${curr_time}[1]

        Exit For Loop If    ${curr_hour} == ${desired_hour} and ${curr_minute} == ${desired_minute}

        IF    ${curr_hour} < ${desired_hour} or (${curr_hour} == ${desired_hour} and ${curr_minute} < ${desired_minute})
            Press Keys    None    ARROW_RIGHT
        ELSE
            Press Keys    None    ARROW_LEFT
        END
    END
    Click Element At Coordinates    ${end_time_locator}    ${width}    0

Add New SSID Scheduling On Sunday From "${start_time}" To "${end_time}"
    ${index}    Add New SSID Scheduling On Sunday
    Set SSID "sunday" Scheduling "${index}" Start Time To "${start_time}"
    Set SSID "sunday" Scheduling "${index}" End Time To "${end_time}"

SSID Scheduling Settings Should Be Factory Default
    List Selection Should Be    ${SSID_SCHEDULING_SELECT}    ${SSID_SCHEDULING_SELECT_DEACTIVATED_VALUE}
    Element Should Not Be Visible    ${SSID_SCHEDULING_ADD_INTERVAL_BUTTON}
    Element Should Not Be Visible    ${SSID_SCHEDULING_DAY_OF_WEEK_SELECT}
