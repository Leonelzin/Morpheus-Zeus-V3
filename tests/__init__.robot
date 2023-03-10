*** Settings ***
Documentation     Tests Initialization File
Library           Process
Resource          resources/api/fiber/v3/system.resource
Resource          resources/utils.resource
Suite Setup       Test Startup Check

*** Keywords ***
Test Startup Check
    Initialize DUT Variable
    Initialize DUT URL Variable
    Initialize Suite Metadata
    Initialize Firmware Stage Variables
    Validate DUT Firmware Version
    Validate DUT Firmware Stage
    Check Testberries Communication
    Set Global Variable    ${FIRST_ACCESS_PASSWORD_CONFIG_HASH}    ${NONE}

Initialize Suite Metadata
    ${dut_firmware_version}    FiberV3 Get DUT Firmware Version
    ${dut_model_name}    FiberV3 Get DUT Model Name
    Set Suite Metadata    Firmware Version    *${dut_firmware_version}*
    Set Suite Metadata    Product Model Name    *${dut_model_name}*

Initialize DUT Variable
    &{DUT}    Create Dictionary    env=${DUT_ENV}    profile=${DUT_PROFILE}
    Set Global Variable    ${DUT}
    Log JSON    ${DUT}

Initialize DUT URL Variable
    IF    ${DUT}[env][management][http][secure] == ${True}
        Set Local Variable    ${protocol}    https
    ELSE
        Set Local Variable    ${protocol}    http
    END
    Set Local Variable    ${ipv4_address}    ${DUT}[env][management][ipv4_address]
    Set Local Variable    ${port}    ${DUT}[env][management][http][port]
    Set Global Variable    ${DUT_URL}    ${protocol}://${ipv4_address}:${port}
    Log    DUT URL: ${DUT_URL}

Validate DUT Firmware Version
    ${dut_firmware_version}    FiberV3 Get DUT Firmware Version
    Log    ${dut_firmware_version}
    IF    """${dut_firmware_version}""" != """${DUT}[env][firmware][version]"""
        ${message}    Catenate
        ...    Current DUT firmware version is "${dut_firmware_version}"
        ...    but Morpheus was expecting it to be "${DUT}[env][firmware][version]".
        ...    \nAborting test execution.
        Fatal Error    ${message}
    END

Initialize Firmware Stage Variables
    Set Global Variable    ${FIRMWARE_STAGE_PRODUCTION}    firmware_stage_production
    Set Global Variable    ${FIRMWARE_STAGE_DEVELOPMENT}    firmware_stage_development
    Set Global Variable    ${FIRMWARE_STAGE_UNKNOWN}    firmware_stage_unknown

Validate DUT Firmware Stage
    ${dut_firmware_stage}    FiberV3 Get DUT Firmware Stage
    Log    ${dut_firmware_stage}
    IF    '${dut_firmware_stage}' == '${FIRMWARE_STAGE_UNKNOWN}'
        ${message}    Catenate
        ...    Current DUT firmware version stage is UNKNOWN.
        ...    \nAborting test execution.
        Fatal Error    ${message}
    END
    Set Global Variable    ${DUT_FIRMWARE_STAGE}    ${dut_firmware_stage}

Check Testberries Communication
    IF    ${TESTBERRY_1}[is_active] == ${TRUE}
        ${result}    Run Process    ping    ${TESTBERRY_1}[management][ipv4_address]    -c3    timeout=5s
        ${error_msg}    Catenate
        ...    TESTBERRY_1 is set to 'active' but is not reachable.
        ...    Tip: check its IPv4 management address (environment.py)
        Should Be Equal As Integers    ${result.rc}    0    ${error_msg}
    END
    IF    ${TESTBERRY_2}[is_active] == ${TRUE}
        ${result}    Run Process    ping    ${TESTBERRY_2}[management][ipv4_address]    -c3    timeout=5s
        ${error_msg}    Catenate
        ...    TESTBERRY_2 is set to 'active' but is not reachable.
        ...    Tip: check its IPv4 management address (environment.py)
        Should Be Equal As Integers    ${result.rc}    0    ${error_msg}
    END
