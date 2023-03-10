*** Settings ***
Documentation     NTP Service Tests Suite
...
...               This test suite contains tests to verify that NTP client WEB
...               interface is correctly populated and can be modified
...               respecting the project requirements and business rules.
Resource          web/login_pom.resource
Resource          web/services/ntp_pom.resource
Test Teardown     Close Browser
Force Tags        services    ntp

*** Test Cases ***
Validate NTP Factory Default Values
    [Documentation]    Verify if NTP factory default settings match those specified by the requirements.
    [Tags]    factory-default
    [Setup]    Run Keywords    Skip This Test If NTP Client Feature Is Not Supported By DUT
    ...                        FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...                        Login To DUT WEB Page Through IPv4 Address
    Access NTP Service Settings Page
    IF    ${NTP_CLIENT_FACTORY_DEFAULT_ENABLED} == ${True}
        NTP Enable Checkbox Should Be Selected
        NTP Server 1 Should Be Enabled
        NTP Server 2 Should Be Enabled
        NTP Zone Select Should Be Enabled
        NTP Daylight Saving Time Checkbox Should Be Enabled
    ELSE
        NTP Enable Checkbox Should Not Be Selected
        NTP Server 1 Should Be Disabled
        NTP Server 2 Should Be Disabled
        NTP Zone Select Should Be Disabled
        NTP Daylight Saving Time Checkbox Should Be Disabled
    END
    NTP Client Server 1 Should Be "${NTP_CLIENT_FACTORY_DEFAULT_SERVER_1}"
    NTP Client Server 2 Should Be "${NTP_CLIENT_FACTORY_DEFAULT_SERVER_2}"
    NTP Client Timezone Should Be "${NTP_CLIENT_FACTORY_DEFAULT_TIMEZONE}"
    IF    ${NTP_CLIENT_FACTORY_DEFAULT_DAYLIGHT_SAVING_TIME} == ${True}
        NTP Daylight Saving Time Checkbox Should Be Selected
    ELSE
        NTP Daylight Saving Time Checkbox Should Not Be Selected
    END
