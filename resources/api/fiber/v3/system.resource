*** Settings ***
Documentation       Fiber API (v3) System Resource File

Library             Collections
Library             RequestsLibrary
Resource            utils.resource

*** Variables ***
${FIBERV3_ENDPOINT_SYSTEM_DEVICE_INFO}                  /cgi-bin/api/v3/system/device/info
${FIBERV3_ENDPOINT_SYSTEM_DEVICE_STATUS}                /cgi-bin/api/v3/system/device/status
${FIBERV3_ENDPOINT_SYSTEM_LOGIN}                        /cgi-bin/api/v3/system/login
${FIBERV3_ENDPOINT_SYSTEM_SETTINGS_FACTORY_DEFAULT}     /cgi-bin/api/v3/system/config
${FIBERV3_ENDPOINT_SYSTEM_STATUS_INTERNET}              /cgi-bin/api/v3/system/status/internet  

*** Keywords ***
FiberV3 Get DUT Firmware Version
    ${url}    Set Variable    ${DUT_URL}${FIBERV3_ENDPOINT_SYSTEM_DEVICE_INFO}
    ${response}    Get    ${url}    timeout=5
    [Teardown]    Delete All Sessions
    [Return]    ${response.json()}[data][version]

FiberV3 Get DUT Model Name
    ${url}    Set Variable    ${DUT_URL}${FIBERV3_ENDPOINT_SYSTEM_DEVICE_INFO}
    ${response}    Get    ${url}    timeout=5
    [Teardown]    Delete All Sessions
    [Return]    ${response.json()}[data][model]

FiberV3 Get DUT Firmware Stage
    ${fw_version}    FiberV3 Get DUT Firmware Version
    #TODO: this implementation can be improved when https://intelbras.atlassian.net/browse/PZ-7526
    # gets resolved. For now we are using regex to determine if firmware
    # version stage is 'production' or 'development'.
    # 0.0.0 -> production stage
    # 0.0.0.0 -> development stage
    ${prod_stage_fw}    Run Keyword And Return Status
    ...    Should Match Regexp    ${fw_version}    ^\\d+\.\\d+\.\\d+$

    IF    ${prod_stage_fw} == ${TRUE}
        Return From Keyword    ${FIRMWARE_STAGE_PRODUCTION}
    END

    ${dev_stage_fw}    Run Keyword And Return Status
    ...    Should Match Regexp    ${fw_version}    ^\\d+\.\\d+\.\\d+\.\\d+$

    IF    ${dev_stage_fw} == ${TRUE}
        Return From Keyword    ${FIRMWARE_STAGE_DEVELOPMENT}
    END
    Return From Keyword    ${FIRMWARE_STAGE_UNKNOWN}
    [Teardown]    Delete All Sessions

FiberV3 Get API Authorization Token
    ${json}    Catenate
    ...    {
    ...    \    "data": {
    ...    \    \    "username": "${DUT}[env][management][login][username]",
    ...    \    \    "password": "${DUT}[env][management][login][password]"
    ...    \    }
    ...    }
    ${json}    Evaluate    json.loads('${json}')
    ${url}    Set Variable    ${DUT_URL}${FIBERV3_ENDPOINT_SYSTEM_LOGIN}
    ${response}    Post    ${url}    json=${json}    timeout=5
    [Teardown]    Delete All Sessions
    [Return]    ${response.json()}[data][Token]

FiberV3 Get DUT Settings Hash
    ${token}    FiberV3 Get API Authorization Token
    &{headers}    Create Dictionary    Authorization=Token ${token}
    ${url}    Set Variable    ${DUT_URL}${FIBERV3_ENDPOINT_SYSTEM_DEVICE_STATUS}
    ${response}    Get    ${url}    headers=${headers}    timeout=5
    [Teardown]    Delete All Sessions
    [Return]    ${response.json()}[data][config_hash]

FiberV3 Check If DUT Is In Factory Default State
    ${hash}    FiberV3 Get DUT Settings Hash
    IF    '''${hash}''' == '''default'''
        Return From Keyword    ${TRUE}
    END
    Return From Keyword    ${FALSE}
    [Teardown]    Delete All Sessions

FiberV3 Reset DUT Settings To Factory Default
    ${factory_default}    FiberV3 Check If DUT Is In Factory Default State
    IF    ${factory_default} == ${FALSE}
        ${token}    FiberV3 Get API Authorization Token
        &{headers}    Create Dictionary    Authorization=Token ${token}
        ${url}    Set Variable    ${DUT_URL}${FIBERV3_ENDPOINT_SYSTEM_SETTINGS_FACTORY_DEFAULT}
        ${response}    Delete    ${url}    headers=${headers}    timeout=5
        IF    '${DUT_FIRMWARE_STAGE}' == '${FIRMWARE_STAGE_PRODUCTION}'
            Set To Dictionary    ${DUT}[env][management][login]    password
            ...    ${DUT}[profile][login][factory_default][production_firmware][password]
        ELSE IF    '${DUT_FIRMWARE_STAGE}' == '${FIRMWARE_STAGE_DEVELOPMENT}'
            Set To Dictionary    ${DUT}[env][management][login]    password
            ...    ${DUT}[profile][login][factory_default][development_firmware][password]
        END
        Sleep    30s
        FiberV3 Wait Until DUT API Starts
        FiberV3 Wait Until DUT System Is Ready
    END
    [Teardown]    Delete All Sessions

FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ${curr_config_hash}    FiberV3 Get DUT Settings Hash
    Return From Keyword If    '''${curr_config_hash}''' == '''default'''
    Log    curr_config_hash: ${curr_config_hash}
    Log    FIRST_ACCESS_PASSWORD_CONFIG_HASH: ${FIRST_ACCESS_PASSWORD_CONFIG_HASH}
    IF    '''${curr_config_hash}''' != '''${FIRST_ACCESS_PASSWORD_CONFIG_HASH}'''
        FiberV3 Reset DUT Settings To Factory Default
    END

FiberV3 Wait Until DUT API Starts
    Wait Until Keyword Succeeds
    ...    ${DUT}[profile][general][max_reset_time]s    10s
    ...    FiberV3 Get DUT Firmware Version

FiberV3 Check If DUT System Is Ready
    ${token}    FiberV3 Get API Authorization Token
    &{headers}    Create Dictionary    Authorization=Token ${token}
    ${url}    Set Variable    ${DUT_URL}${FIBERV3_ENDPOINT_SYSTEM_DEVICE_STATUS}
    ${response}    Get    ${url}    headers=${headers}    timeout=5
    ${system_ready}    Set Variable    ${response.json()}[data][status][ready]
    [Teardown]    Delete All Sessions
    [Return]    ${system_ready}

FiberV3 Wait Until DUT System Is Ready
    Wait Until Keyword Returns True    70s    5s    FiberV3 Check If DUT System Is Ready

FiberV3 Check If DUT Has Internet Connection
    ${token}    FiberV3 Get API Authorization Token
    &{headers}    Create Dictionary    Authorization=Token ${token}
    ${response}    Get    ${DUT_URL}${FIBERV3_ENDPOINT_SYSTEM_STATUS_INTERNET}        headers=${headers}    timeout=5
    [Teardown]    Delete All Sessions
    [Return]    ${response.json()}[data]
