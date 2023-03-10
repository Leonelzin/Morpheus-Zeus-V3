*** Settings ***
Documentation     Watchdog Service Tests Suite
...
...               This test suite contains tests to verify that Watchdog WEB
...               interface is correctly populated and can be modified
...               respecting the project requirements and business rules.
Resource          web/login_pom.resource
Resource          web/services/watchdog_pom.resource
Test Teardown     Close Browser
Force Tags        services    watchdog

*** Test Cases ***
Validate Watchdog Factory Default Values
    [Documentation]    Verify if watchdog factory default settings match those specified by the requirements.
    [Tags]    factory-default
    [Setup]    Run Keywords    Skip This Test If Watchdog Feature Is Not Supported By DUT
    ...                        FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...                        Login To DUT WEB Page Through IPv4 Address
    Access Watchdog Service Settings Page
    IF    ${WATCHDOG_FACTORY_DEFAULT_ENABLED} == ${True}
        Watchdog Enable Checkbox Should Be Selected
        Watchdog IP Address 1 Should Be Enabled
        Watchdog IP Address 2 Should Be Enabled
        Watchdog Check Interval Should Be Enabled
    ELSE
        Watchdog Enable Checkbox Should Not Be Selected
        Watchdog IP Address 1 Should Be Disabled
        Watchdog IP Address 2 Should Be Disabled
        Watchdog Check Interval Should Be Disabled
    END
    Watchdog Check Interval Should Be "${WATCHDOG_FACTORY_DEFAULT_CHECK_INTERVAL}"
    Watchdog IP Address 1 Should Be "${WATCHDOG_FACTORY_DEFAULT_IP_ADDRESS_1}"
    Watchdog IP Address 2 Should Be "${WATCHDOG_FACTORY_DEFAULT_IP_ADDRESS_2}"
