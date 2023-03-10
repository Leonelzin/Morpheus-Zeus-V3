*** Settings ***
Documentation       Firewall DMZ (Delimitarized Zone) Tests Suite
...
...                 This test suite contains tests to verify that firewall DMZ
...                 WEB interface is correctly populated and can be modified
...                 respecting the project requirements and business rules.

Resource            web/login_pom.resource
Resource            web/firewall/port_forwarding_dmz.resource
Resource            web/common.resource
Resource            web/network/operation_mode_pom.resource


Test Setup          Login To DUT WEB Page Through IPv4 Address
Test Teardown       Run Keywords
...                     Discard Saved Settings If There Are Changes
...                     Close Browser

Force Tags          firewall    dmz

*** Test Cases ***
Firewall DMZ is not available in bridge network operating mode
    [Documentation]    Verify that firewall DMZ settings are only available when DUT network operation mode is 'router'.
    Access Network Operation Mode Settings Page
    Set Network Operation Mode To Bridge
    Save Settings
    Access Firewall Port Forwarding Settings Page    wait_for_element_visibility=${FALSE}
    Set Test Variable    ${message}    Esta funcionalidade está disponível apenas quando Modo de Operação for Roteador
    Wait Until WEB Message Is "${message}" Or Timeout After "5" Seconds
    Dismiss Current Displayed WEB Message

Firewall DMZ can be configured
    [Documentation]    Verify that it is possible to configure and save firewall DMZ settings with valid values.
    Access Network Operation Mode Settings Page
    Set Network Operation Mode To Router
    Dismiss WEB Message If It Is Displayed And Contains "Seu IP será alterado para estático"
    Save Settings And Accept Modal Request If It Contains "O serviço de auto configuração está habilitado."
    Access Firewall Port Forwarding Settings Page
    Set Firewall DMZ Description To "DMZ test"
    Set Firewall DMZ Forwarding IP Address To "10.0.0.123"
    Save Settings

Validate Firewall Port Forwarding DMZ factory default settings
    [Documentation]
    ...    Validate that firewall port forwarding dmz factory default settings match
    ...    those specified by the requirements.
    [Tags]    factory-default    smoke
    [Setup]    Run Keywords
#    ...    Skip This Test If DUT Factory Default Network Operation Mode Is Not Router
#    ...    FiberV3 Reset DUT Settings To Factory Default If There Are Changes Other Than First Access Password Change
    ...    Login To DUT WEB Page Through IPv4 Address
    Access Firewall Port Forwarding Settings Page
    Firewall Port Forwarding DMZ Settings Should Be Factory Default
