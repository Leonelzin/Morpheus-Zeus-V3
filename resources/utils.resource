*** Settings ***
Documentation       General Utilities Resource File

Library             String

*** Keywords ***
Wait "${time}" Seconds
    Sleep    ${time}

Log JSON
    [Arguments]    ${json}
    Evaluate    print(json.dumps(${json}, indent=4))

Keyword Should Return True
    [Arguments]    ${keyword}    @{args}
    ${return_value}    Run Keyword    ${keyword}    @{args}
    Should Be True    ${return_value}

Wait Until Keyword Returns True
    [Arguments]    ${timeout}    ${retry_interval}    ${keyword}    @{args}
    Wait Until Keyword Succeeds
    ...    ${timeout}    ${retry_interval}
    ...    Keyword Should Return True    ${keyword}    @{args}

Skip This Test If Testberry "${testberry}" Is Not Active
    IF    ${testberry}[is_active] == ${FALSE}
        Skip    Testberry is not active (environment.py).
    END

Skip This Test If DUT Firmware Stage Is Not Production
    IF    '${DUT_FIRMWARE_STAGE}' != '${FIRMWARE_STAGE_PRODUCTION}'
        Skip    This test is set to run only on production firmwares.
    END

Throughput "${throughput_in_bps}" Should Be Lower Than "${value}" Mbps
    Should Be True    ${throughput_in_bps} < ${value} * 1000000

Throughput "${throughput_in_bps}" Should Be Higher Than "${percentage}"% Of "${value}" Mbps
    Should Be True    ${throughput_in_bps} > ${value} * 1000000 * ${percentage} / 100

Version "${version_a}" Is Newer Than Version "${version_b}"
    @{version_a}    Split String    ${version_a}    separator=.
    @{version_b}    Split String    ${version_b}    separator=.

    Return From Keyword If
    ...    ${version_a}[0] > ${version_b}[0]
    ...    ${TRUE}

    Return From Keyword If
    ...    ${version_a}[0] == ${version_b}[0] and ${version_a}[1] > ${version_b}[1]
    ...    ${TRUE}

    Return From Keyword If
    ...    ${version_a}[0] == ${version_b}[0] and ${version_a}[1] == ${version_b}[1] and ${version_a}[2] > ${version_b}[2]
    ...    ${TRUE}

    Return From Keyword    ${FALSE}
