*** Settings ***
Documentation       Discovery Service Tests Suite
...                 
...                 This test suite contains tests to verify if discovery
...                 protocols (Intelbras, LLDP and CDP) are correctly operating
...                 in the DUT.

Library             Testberry    ${DUT}
Resource            utils.resource
Resource            web/login_pom.resource
Resource            web/services/discovery_pom.resource

Test Teardown       Close Browser

Force Tags          services    discovery

*** Test Cases ***
Disable Intelbras discovery protocol
    [Documentation]
    ...    Validate that DUT stop replying to Intelbras discovery protocol
    ...    multicast messages when support to it is disabled.
    [Tags]    discovery-intelbras
    [Setup]    Run Keywords
    ...    Skip This Test If Testberry "\${TESTBERRY_1}" Is Not Active
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Discovery Service Settings Page
    Unselect Intelbras Discovery Protocol Checkbox
    Save And Apply Settings
    Through Testberry "${TESTBERRY_1}" Check That DUT Does Not Reply To Intelbras Discovery

Enable Intelbras discovery protocol
    [Documentation]
    ...    Validate that DUT replies to Intelbras discovery protocol multicast
    ...    messages.
    [Tags]    discovery-intelbras
    [Setup]    Run Keywords
    ...    Skip This Test If Testberry "\${TESTBERRY_1}" Is Not Active
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Discovery Service Settings Page
    Select Intelbras Discovery Protocol Checkbox
    Save And Apply Settings
    Through Testberry "${TESTBERRY_1}" Check That DUT Replies To Intelbras Discovery
