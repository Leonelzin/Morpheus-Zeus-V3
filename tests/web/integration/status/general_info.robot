*** Settings ***
Documentation       Status (General Information)
...                 
...                 This test suite contains tests to verify that status
...                 (general information) WEB interface is correctly populated
...                 and behaves according to the project requirements and
...                 business rules.

Resource            web/common.resource
Resource            web/login_pom.resource
Resource            web/services/autoconfig_pom.resource
Resource            web/services/ntp_pom.resource
Resource            web/status/general_pom.resource
Resource            web/wireless/interface_2ghz_pom.resource
Resource            web/wireless/interface_5ghz_pom.resource
Resource            web/network/operation_mode_pom.resource

Test Teardown       Close Browser

Force Tags          status

*** Test Cases ***
Verify LAN status information (factory default settings)
    [Documentation]
    ...    Verify that all LAN information in Status/General webpage is correct.
    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8571/view/6317/version/26729
    [Tags]    factory-default    smoke    lan
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Status General Information Page
    Open LAN Accordion
    Status General LAN Accordion Settings Should Be Factory Default

Verify WAN status information (factory default settings)
    [Documentation]
    ...    Verify that all WAN information in Status/General webpage is correct.
    [Tags]    factory-default    smoke    wan
    [Setup]    Run Keywords
    ...    Skip This Test If DUT Factory Default Network Operation Mode Is Not Router
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Status General Information Page
    Open WAN Accordion
    Status General WAN Accordion Settings Should Be Factory Default

Verify wireless 5GHz status information (factory default settings)
    [Documentation]
    ...    Verify that all wireless 5GHz information in Status/General webpage is correct.
    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8571/view/6765/version/27092
    [Tags]    factory-default    smoke    wireless-5ghz
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless 5GHz Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Status General Information Page
    Open Wireless 5GHz Accordion
    Status General Wireless 5GHz Accordion Settings Should Be Factory Default

Verify wireless 2GHz status information (factory default settings)
    [Documentation]
    ...    Verify that all wireless 2GHz information in Status/General webpage is correct.
    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8571/view/6767/version/27286
    [Tags]    factory-default    smoke    wireless-2ghz
    [Setup]    Run Keywords
    ...    Skip This Test If Wireless 2GHz Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Status General Information Page
    Open Wireless 2GHz Accordion
    Status General Wireless 2GHz Accordion Settings Should Be Factory Default

Verify system status information (factory default settings)
    [Documentation]
    ...    Verify that all system information in Status/General webpage is correct.
    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8571/view/6771/version/27644
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Status General Information Page
    Open System Accordion
    Status General System Accordion Settings Should Be Factory Default

Verify ethernet status information (factory default settings)
    [Documentation]
    ...    Verify that all ethernet information in Status/General webpage is correct.
    [Tags]    factory-default    smoke    ethernet
    [Setup]    Run Keywords
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Status General Information Page
    Open Ethernet Accordion
    Status General Ethernet Accordion Settings Should Be Factory Default

Verify automatic device configuration information (factory default settings)
    [Documentation]
    ...    Verify that all automatic device configuration information in Status/General webpage is correct.
    [Tags]    factory-default    smoke    auto-configuration
    [Setup]    Run Keywords    Skip This Test If Automatic Device Configuration Is Not Supported By DUT
    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Status General Information Page
    Open Automatic Device Configuration Accordion
    Status General Automatic Device Configuration Settings Should Be Factory Default

Verify NTP client status information when NTP client is enabled
    [Documentation]
    ...    Verify that NTP client status information is correctly updated when it is enabled.
    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8248/view/25563/version/25831
    [Tags]    ntp
    [Setup]    Run Keywords
    ...    Skip This Test If NTP Client Feature Is Not Supported By DUT
    ...    Login To DUT WEB Page Through IPv4 Address
    Access NTP Service Settings Page
    Select NTP Enable Checkbox
    Save And Apply Settings
    Access Status General Information Page
    Status General System NTP Status Should Be "Habilitado"

Verify NTP client status information when NTP client is disabled
    [Documentation]
    ...    Verify that NTP client status information is correctly updated when it is disabled.
    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8248/view/25563/version/25831
    [Tags]    ntp
    [Setup]    Run Keywords
    ...    Skip This Test If NTP Client Feature Is Not Supported By DUT
    ...    Login To DUT WEB Page Through IPv4 Address
    Access NTP Service Settings Page
    Unselect NTP Enable Checkbox
    Save And Apply Settings
    Access Status General Information Page
    Status General System NTP Status Should Be "Desabilitado"
