#First Automated Test Case!

*** Settings ***
Documentation       This set of tests should test if the WEB system operates for a possible Login
and create new resource pom Led.
...
...                 This resource file contains keywords related to network

Library             SeleniumLibrary
Library             Dialogs
Library             RequestsLibrary
Resource            web/login_pom.resource
Resource            web/wireless/interface_2ghz_pom.resource
Resource            web/system/led_pom.resource
Resource            ../../resources/web/services/watchdog_pom.resource
Resource            ../../resources/web/wireless/ssid_pom.resource
Resource            api/fiber/v3/system.resource
#Resource            ../../resources/web/tools/site_survey_pom.resource
#Resource            web/tools/site_survey_pom.resource
#Resource            resources/web/common.resource
#Resource            integration/system/session_timeout.robot
Resource            resources/web/header_pom.resource
Resource            web/system/management_pom.resource
Resource            ../../resources/web/system/settings_pom.resource

Force Tags          wip

*** Variables ***
${LED_SCHEDULE_ENDHOUR_20_VALUE}        string:20
${LED_SCHEDULE_ENDMINUTE_10_VALUE}      string:10
${LED_SCHEDULE_STARTHOUR_05_VALUE}      string:05
${LED_SCHEDULE_STARTMINUTE_03_VALUE}    string:03

*** Test Cases ***
This Test Case verifies the DUT login in the WEB system!
    [Tags]    no-run
    [Setup]    Open Browser    url=192.168.0.10    browser=Chrome    executable_path=/home/leonel/
orpheus/webdrivers/chromedriver
    Wait Until Element Is Visible    usuario
    Input Text    usuario    admin
    Input Text    senha    lockzeus
    Click Button    xm    logar

Test Wireless_2ghz_Pom
    [Tags]    no-run
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    #Access Wireless 2GHz Settings Page
    Save And Apply Settings
    [Teardown]    Close Browser

[Test Watchdog]
    [Tags]    no-run
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access Watchdog Service Settings Page
    Select Watchdog Enable Checkbox
    Set Watchdog IP Address 1 Value To "google.com"
    Set Watchdog IP Address 1 Value To "192.168.0.10"
    Save And Apply Settings
    [Teardown]    Close Browser

Test Led Menu and Modify Led Color Red
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    Set LED Color To Red
    Save And Apply Settings
    [Teardown]    Close Browser

Test Led Menu and Modify Led Color Green
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    Set LED Color To Green
    Save And Apply Settings
    [Teardown]    Close Browser

Test Led Menu and Modify Led Color Blue
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    Set LED Color To Blue
    Save And Apply Settings
    [Teardown]    Close Browser

Test Led Menu and Modify Led Color Cyan
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    Set LED Color To Cyan
    Save And Apply Settings
    [Teardown]    Close Browser

Test Led Menu and Modify Led Color Magenta
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    Set LED Color To Magenta
    Save And Apply Settings
    [Teardown]    Close Browser

Test Led Menu and Modify Led Color Yellow
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    Set LED Color To Yellow
    Save And Apply Settings
    [Teardown]    Close Browser

Test Led Menu and Modify Led Color White
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    Set LED Color To White
    Save And Apply Settings
    [Teardown]    Close Browser

Test Led Menu and Modify Led Color Pink
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    Set LED Color To Pink
    Save And Apply Settings
    [Teardown]    Close Browser

Test Led Menu and Modify Led Color Purple
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    Set LED Color To Purple
    Save And Apply Settings
    [Teardown]    Close Browser

Test Led Menu and Modify Led Color Orange
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access LED Settings Page
    Set LED Color To Orange
    Save And Apply Settings
    [Teardown]    Close Browser

Tests Wireless POM Scheduling
    [Tags]    no-run
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access SSID Settings Page
    Open SSID "AP1250ACMax_9b33" Scheduling Settings
    Set SSID Scheduling To Activated
    Add New SSID Scheduling On Sunday From "13:30" To "18:30"
    Pause Execution
    [Teardown]    Close Browser

Tests Wireless POM WACL
    [Tags]    no-run
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    Access SSID Settings Page
    Open SSID "AP1250ACMax_9b33" MAC ACL Settings
    Set SSID MAC ACL Mode To Allow Listed
    Add SSID MAC ACL Rule For MAC Address "5c:c9:d3:bf:b7:01" With Description "Test WACL1"
    Add SSID MAC ACL Rule For MAC Address "5c:c9:d3:bf:b7:01" With Description "Test WACL2"
    Remove SSID MAC ACL Rule With Description "Test WACL1"

    Pause Execution
    [Teardown]    Close Browser

Test Wizard Router
    [Tags]    no-run
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    #Validate wizard (router) factory default settings
    Page Should Contain    Todas as configurações foram salvas com sucesso.

    [Teardown]    Close Browser

Code Review Tay
    [Tags]    no-run
    [Setup]    Login To DUT WEB Page Through IPv4 Address
    
    Access System Management Page
    #Session timeout clock widget should appear only when session time is < 45 seconds

    Pause Execution
    [Teardown]    Close Browser

Em busca do amor dela
    [Tags]    no-run
    [Setup]    Login To DUT WEB Page Through IPv4 Address

    Access System Settings Page
    Page Should Not Contain Checkbox    ${LED_SCHEDULE_ENDHOUR_20_VALUE}

    Pause Execution
    [Teardown]    Close Browser

Test Internet Connection
    [Tags]    API-REST
    ${internet_connection}    FiberV3 Check If DUT Has Internet Connection
    Log To Console    ${internet_connection}

    IF    ${internet_connection} == ${TRUE}
        Log To Console    batatinha
    ELSE IF    ${internet_connection} == ${FALSE}
        Log To Console    churros pia
    END

--------------------------------------------------------------------------------------------------

Test API Automated Check System API Network Mode [DEVICE STATUS]
    Sleep    3
    [Tags]    test automatization - api
    ${system_network_mode}    FiberV3 Check If DUT System Network Mode
    Log To Console    ${system_network_mode}

Test API Automated Check System API Firmware Version [DEVICE STATUS]
    Sleep    3
    [Tags]    test automatization - api
    ${system_firmware_version}    FiberV3 Get DUT Firmware Version
    Log To Console    ${system_firmware_version}

Test API Automated Check System API Version [DEVICE STATUS]
    Sleep    3
    [Tags]    test automatization - api
    ${system_api_version}    FiberV3 Check If DUT System API Version
    Log To Console    ${system_api_version}

Test API Automated Check System Model [DEVICE STATUS]
    Sleep    3
    [Tags]    test automatization - api
    ${system_model}    FiberV3 Check If DUT System Model
    Log To Console    ${system_model}  

Test API Automated System Is Ready [DEVICE STATUS]
    Sleep    3
    [Tags]    test automatization - api
    ${system_ready}    FiberV3 Check If DUT System Is Ready
    Log To Console    ${system_ready}  

    IF    $${system_ready} == ${TRUE}
        Log To Console    Test OK
    ELSE IF    ${system_ready} == ${FALSE}
        Log To Console    Test NOK
    END

Test API Automated System Network [DEVICE STATUS]
    Sleep    3
    [Tags]    test automatization - api
    ${system_network}    FiberV3 Check If DUT System Network
    Log To Console    ${system_network}  

    IF    ${system_network} == ${TRUE}
        Log To Console    Test OK
    ELSE IF    ${system_network} == ${FALSE}
        Log To Console    Test NOK
    END

Test API Automated System Firewall [DEVICE STATUS]
    Sleep    3
    [Tags]    test automatization - api
    ${system_firewall}    FiberV3 Check If DUT System Firewall
    Log To Console    ${system_firewall}  

    IF    ${system_firewall} == ${TRUE}
        Log To Console    Test OK
    ELSE IF    ${system_firewall} == ${FALSE}
        Log To Console    Test NOK
    END

Test API Automated System Wireless [DEVICE STATUS]
    Sleep    3
    [Tags]    test automatization - api
    ${system_wireless}    FiberV3 Check If DUT System Wireless
    Log To Console    ${system_wireless}  

    IF    ${system_wireless} == ${TRUE}
        Log To Console    Test OK
    ELSE IF    ${system_wireless} == ${FALSE}
        Log To Console    Test NOK
    END

Test API Automated System Settings Hash [DEVICE STATUS]
    Sleep    3
    [Tags]    test automatization - api
    ${settings_hash}    FiberV3 Get DUT Settings Hash
    Log To Console    ${settings_hash}

Test API DUT Name [DEVICE STATUS]
    Sleep    3
    [Tags]    test automatization - api
    ${dut_name}   FiberV3 Get DUT Model Name
    Log To Console    ${dut_name}

Test Internet Connection [DUT INTERNET]
    Sleep    3
    [Tags]    test automatization - api
    ${internet_connection}    FiberV3 Check If DUT Has Internet Connection
    Log To Console    ${internet_connection}

    IF    ${internet_connection} == ${TRUE}
        Log To Console    Test OK
    ELSE IF    ${internet_connection} == ${FALSE}
        Log To Console    Test NOK
    END