*** Settings ***
Documentation       Wireless SSID Scheduling Settings Resource File
...                 
...                 This resource file contains keywords related to wireless
...                 SSID MAC ACL settings WEB page manipulation (page object
...                 model).

Library             SeleniumLibrary    timeout=${SELENIUM_WAIT_TIMEOUT_SECONDS}
Library             Collections
Library             Dialogs
Resource            web/common.resource
Resource            web/sidemenu_pom.resource

*** Variables ***
${SSID_MAC_ACL_SELECT}                                      ssid_mac_acl
${SSID_MAC_ACL_SELECT_DEACTIVATED_VALUE}                    string:disable
${SSID_MAC_ACL_SELECT_ALLOW_VALUE}                          string:allow
${SSID_MAC_ACL_SELECT_DENY_VALUE}                           string:deny

${SSID_MAC_ACL_RULE_FILTER_INPUT}                           ssid_mac_acl_filter
${SSID_MAC_ACL_RULES_TABLE}                                 ssid_mac_acl_table
${SSID_MAC_ACL_ADD_RULE_BUTTON}                             ssid_mac_acl_add_rule

${SSID_MAC_ACL_RULES_DESCRIPTION_CUSTOM_LOCATOR}            //*[@data-mac-acl-rule-desc-index]
${SSID_MAC_ACL_RULES_ADDRESS_CUSTOM_LOCATOR}                //*[@data-mac-acl-rule-addr-index]
${SSID_MAC_ACL_DESCRIPTION_INPUT_TABLE_CELL_DATA_ATTR}      data-mac-acl-rule-desc-index
${SSID_MAC_ACL_ADDRESS_INPUT_TABLE_CELL_DATA_ATTR}          data-mac-acl-rule-addr-index
${SSID_MAC_ACL_REMOVE_RULE_BUTTON_PREFIX}                   ssid_mac_acl_rule_remove

${SSID_MAC_ACL_RULES_PAGINATION_NEXT_PAGE_WRAPPER}          xpath://*[@ng-class='{disabled: noNext()||ngDisabled}']
${SSID_MAC_ACL_RULES_PAGINATION_NEXT_PAGE_BUTTON}           xpath://*[@ng-click='selectPage(page + 1, $event)']

${SSID_MAC_ACL_RULES_PAGINATION_PREV_PAGE_WRAPPER}          xpath://*[@ng-class='{disabled: noPrevious()||ngDisabled}']
${SSID_MAC_ACL_RULES_PAGINATION_PREV_PAGE_BUTTON}           xpath://*[@ng-click='selectPage(page - 1, $event)']

${SSID_MAC_ACL_CONFIRM_CHANGES_BUTTON}                      ssid_confirm_mac_acl_changes
${SSID_MAC_ACL_DISCARD_CHANGES_BUTTON}                      ssid_discard_mac_acl_changes

*** Keywords ***
Set SSID MAC ACL Mode To Deactivated
    Select From List By Value    ${SSID_MAC_ACL_SELECT}    ${SSID_MAC_ACL_SELECT_DEACTIVATED_VALUE}

Set SSID MAC ACL Mode To Allow Listed
    Select From List By Value    ${SSID_MAC_ACL_SELECT}    ${SSID_MAC_ACL_SELECT_ALLOW_VALUE}

Set SSID MAC ACL Mode To Deny Listed
    Select From List By Value    ${SSID_MAC_ACL_SELECT}    ${SSID_MAC_ACL_SELECT_DENY_VALUE}

Set SSID MAC ACL Filter To "${text}"
    Input Text    ${SSID_MAC_ACL_RULE_FILTER_INPUT}    ${text}

Get All SSID MAC ACL Rule Descriptions In Current Page
    @{descriptions}    Get Webelements    ${SSID_MAC_ACL_RULES_DESCRIPTION_CUSTOM_LOCATOR}
    [Return]    ${descriptions}

Get All SSID MAC ACL Rule Addresses In Current Page
    @{addresses}    Get Webelements    ${SSID_MAC_ACL_RULES_ADDRESS_CUSTOM_LOCATOR}
    [Return]    ${addresses}

Get SSID MAC ACL Rule Index With Description "${description}"
    @{descriptions}    Get All SSID MAC ACL Rule Descriptions In Current Page
    FOR    ${rule}    IN    @{descriptions}
        ${rule_description}    Get Value    ${rule}
        ${rule_index}    Get Element Attribute    ${rule}    ${SSID_MAC_ACL_DESCRIPTION_INPUT_TABLE_CELL_DATA_ATTR}
        Return From Keyword If    '${rule_description}' == '${description}'    ${rule_index}
    END
    Return From Keyword    ${NONE}

Get SSID MAC ACL Rule Index With Address "${address}"
    @{addresses}    Get All SSID MAC ACL Rule Addresses In Current Page
    FOR    ${rule}    IN    @{addresses}
        ${rule_address}    Get Value    ${rule}
        ${rule_index}    Get Element Attribute    ${rule}    ${SSID_MAC_ACL_ADDRESS_INPUT_TABLE_CELL_DATA_ATTR}
        Return From Keyword If    '${rule_address}' == '${address}'    ${rule_index}
    END
    Return From Keyword    ${NONE}

Go To First ACL Rules Page
    FOR    ${counter}    IN RANGE    0    1000
        ${prev_button_visible}    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    ${SSID_MAC_ACL_RULES_PAGINATION_PREV_PAGE_BUTTON}

        ${prev_button_enabled}    Run Keyword And Return Status
        ...    Element Should Not Have Class
        ...    ${SSID_MAC_ACL_RULES_PAGINATION_PREV_PAGE_WRAPPER}
        ...    disabled

        Exit For Loop If    ${prev_button_visible} == ${FALSE} or ${prev_button_enabled} == ${FALSE}
        Click Element    ${SSID_MAC_ACL_RULES_PAGINATION_PREV_PAGE_BUTTON}
    END

Go To Last ACL Rules Page
    FOR    ${counter}    IN RANGE    0    1000
        ${next_button_visible}    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    ${SSID_MAC_ACL_RULES_PAGINATION_NEXT_PAGE_BUTTON}

        ${next_button_enabled}    Run Keyword And Return Status
        ...    Element Should Not Have Class
        ...    ${SSID_MAC_ACL_RULES_PAGINATION_NEXT_PAGE_WRAPPER}
        ...    disabled

        Exit For Loop If    ${next_button_visible} == ${FALSE} or ${next_button_enabled} == ${FALSE}
        Click Element    ${SSID_MAC_ACL_RULES_PAGINATION_NEXT_PAGE_BUTTON}
    END

Go To Next ACL Rules Page
    ${next_button_visible}    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    ${SSID_MAC_ACL_RULES_PAGINATION_NEXT_PAGE_BUTTON}

    ${next_button_enabled}    Run Keyword And Return Status
    ...    Element Should Not Have Class
    ...    ${SSID_MAC_ACL_RULES_PAGINATION_NEXT_PAGE_WRAPPER}
    ...    disabled

    IF    ${next_button_visible} == ${TRUE} and ${next_button_enabled} == ${TRUE}
        Click Element    ${SSID_MAC_ACL_RULES_PAGINATION_NEXT_PAGE_BUTTON}
    END

Add SSID MAC ACL Rule For MAC Address "${mac_address}" With Description "${description}"
    Click Button    ${SSID_MAC_ACL_ADD_RULE_BUTTON}
    Go To Last ACL Rules Page
    ${descriptions}    Get All SSID MAC ACL Rule Descriptions In Current Page
    ${addresses}    Get All SSID MAC ACL Rule Addresses In Current Page
    ${last_rule_description}    Get From List    ${descriptions}    -1
    ${last_rule_address}    Get From List    ${addresses}    -1
    Input Text    ${last_rule_description}    ${description}
    Input Text    ${last_rule_address}    ${mac_address}

Current SSID MAC ACL Rules Page Is The Last One
    ${next_button_visible}    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    ${SSID_MAC_ACL_RULES_PAGINATION_NEXT_PAGE_BUTTON}

    ${next_button_enabled}    Run Keyword And Return Status
    ...    Element Should Not Have Class
    ...    ${SSID_MAC_ACL_RULES_PAGINATION_NEXT_PAGE_WRAPPER}
    ...    disabled

    Return From Keyword If
    ...    ${next_button_visible} == ${TRUE} and ${next_button_enabled} == ${TRUE}
    ...    ${FALSE}

    Return From Keyword If
    ...    ${next_button_visible} == ${TRUE} and ${next_button_enabled} == ${FALSE}
    ...    ${TRUE}

Remove SSID MAC ACL Rule With Description "${description}"
    Go To First ACL Rules Page
    FOR    ${counter}    IN RANGE    0    1000
        ${rule_index}    Get SSID MAC ACL Rule Index With Description "${description}"
        IF    ${rule_index} != ${NONE}
            Click Element    ${SSID_MAC_ACL_REMOVE_RULE_BUTTON_PREFIX}_${rule_index}
            Return From Keyword
        END
        ${is_last_page}    Current SSID MAC ACL Rules Page Is The Last One
        Exit For Loop If    ${is_last_page} == ${TRUE}
        Go To Next ACL Rules Page
    END
    Fail    SSID MAC ACL rule with description '${description}' not found.

Remove SSID MAC ACL Rule With Address "${address}"
    Go To First ACL Rules Page
    FOR    ${counter}    IN RANGE    0    1000
        ${rule_index}    Get SSID MAC ACL Rule Index With Address "${address}"
        IF    ${rule_index} != ${NONE}
            Click Element    ${SSID_MAC_ACL_REMOVE_RULE_BUTTON_PREFIX}_${rule_index}
            Return From Keyword
        END
        ${is_last_page}    Current SSID MAC ACL Rules Page Is The Last One
        Exit For Loop If    ${is_last_page} == ${TRUE}
        Go To Next ACL Rules Page
    END
    Fail    SSID MAC ACL rule with address '${address}' not found.

Discard SSID MAC ACL Changes
    Click Button    ${SSID_MAC_ACL_DISCARD_CHANGES_BUTTON}
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END

Confirm SSID MAC ACL Changes
    Click Button    ${SSID_MAC_ACL_CONFIRM_CHANGES_BUTTON}
    ${status}    Run Keyword And Return Status    Element Should Not Be Visible    ${WEB_MESSAGE}
    IF    ${status} == ${True}
        Wait "2" Seconds For WEB Animation To Finish
    END

SSID MAC ACL Settings Should Be Factory Default
    List Selection Should Be    ${SSID_MAC_ACL_SELECT}    ${SSID_MAC_ACL_SELECT_DEACTIVATED_VALUE}
    Element Should Not Be Visible    ${SSID_MAC_ACL_RULE_FILTER_INPUT}
    Element Should Not Be Visible    ${SSID_MAC_ACL_RULES_TABLE}
    Element Should Not Be Visible    ${SSID_MAC_ACL_ADD_RULE_BUTTON}
