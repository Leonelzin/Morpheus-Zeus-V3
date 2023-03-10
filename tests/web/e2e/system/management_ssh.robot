*** Settings ***
Documentation       DUT Management (SSH protocol) Tests Suite
...                 
...                 This test suite contains tests to verify that it is
...                 possible to enable/disable SSH access, send commands and
...                 read output. It also contains tests to verify that session
...                 timeout is working as expected.

Resource            web/login_pom.resource
Resource            web/system/management_pom.resource

Test Setup          Login To DUT WEB Page Through IPv4 Address
Test Teardown       Run Keywords
...                     Close Browser
...                     Close DUT SSH Connections

Force Tags          system    system-management    ssh

*** Test Cases ***
Enable SSH service and validate that connection can be established
    Access System Management Page
    Select System Management SSH Enable Checkbox
    System Management SSH Port Input Should Be Enabled
    Set System Management SSH Port To "22"
    Save And Apply Settings
    Open DUT SSH Connection On Port "22" And Log In

Disable SSH service and validate that connection cannot be established
    Access System Management Page
    Unselect System Management SSH Enable Checkbox
    System Management SSH Port Input Should Be Disabled
    Save And Apply Settings
    It Should Not Be Possible To Open DUT SSH Connection On Port "22"

Change SSH service port and validate that connection can be established
    Access System Management Page
    Select System Management SSH Enable Checkbox
    System Management SSH Port Input Should Be Enabled
    Set System Management SSH Port To "26"
    Save And Apply Settings
    It Should Not Be Possible To Open DUT SSH Connection On Port "22"
    Open DUT SSH Connection On Port "26" And Log In
    Close DUT SSH Connections
    Set System Management SSH Port To "22"
    Save And Apply Settings
    Open DUT SSH Connection On Port "22" And Log In

Connect to DUT via SSH and execute command (ping localhost)
    Access System Management Page
    Select System Management SSH Enable Checkbox
    System Management SSH Port Input Should Be Enabled
    Set System Management SSH Port To "22"
    Save And Apply Settings
    Open DUT SSH Connection On Port "22" And Log In
    Execute Command "ping -c1 -w3 127.0.0.1" Via Open SSH Connection And Expect Output To Contain "time="

Validate session timeout via SSH
    Access System Management Page
    Set System Management Session Timeout To "60"
    Select System Management SSH Enable Checkbox
    System Management SSH Port Input Should Be Enabled
    Set System Management SSH Port To "22"
    Save And Apply Settings
    Open DUT SSH Connection On Port "22" And Log In
    Execute Command "ping -c1 -w3 127.0.0.1" Via Open SSH Connection And Expect Output To Contain "time="
    Wait "61" Seconds
    Run Keyword And Expect Error    OSError: Socket is closed
    ...    Execute Command "ping -c1 -w3 127.0.0.1" via Open SSH Connection
    [Teardown]    Run Keywords
    ...    Close Browser
    ...    Close DUT SSH Connections
    ...    Login To DUT WEB Page Through IPv4 Address
    ...    Access System Management Page
    ...    Set System Management Session Timeout To "300"
    ...    Save And Apply Settings
    ...    Close Browser
