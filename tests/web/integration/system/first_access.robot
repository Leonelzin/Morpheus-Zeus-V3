*** Settings ***
Documentation     First User Access Tests (Password Change)
...
...               This test suite contains DUT first access tests that check
...               initial password change and acceptance of 'terms of use'.
...               It also validates that all WEB pages involved behave in
...               accordance with the project requirements and business rules.
Resource          web/common.resource
Resource          web/login_pom.resource
Resource          web/system/management_pom.resource
Suite Setup       Skip This Test If DUT Firmware Stage Is Not Production
Test Setup        FiberV3 Reset DUT Settings To Factory Default
Test Teardown     Close Browser
Force Tags        system    first-access

*** Test Cases ***
Empty new password confirmation
    [Documentation]    Do not enter the password confirmation.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22445/version/24596
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "Simpsons19@" And Confirmation Password ""
    Wait Until WEB Message Is "Insira a confirmação da nova senha" Or Timeout After "10" Seconds
    Dismiss Current Displayed WEB Message

Empty new password
    [Documentation]    Do not enter the new password.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22444/version/22523
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "" And Confirmation Password "Simpsons19@"
    Wait Until WEB Message Is "Insira uma nova senha" Or Timeout After "10" Seconds
    Dismiss Current Displayed WEB Message

Check minimum security standards
    [Documentation]    Enter new password and different password confirmation.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/4837/version/24598
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "admin" And Confirmation Password "admin"
    Wait Until WEB Message Is "Nova senha fora do formato aceitável" Or Timeout After "10" Seconds
    Dismiss Current Displayed WEB Message

New password and new password confirmation mismatch
    [Documentation]    Enter new password and different password confirmation.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22443/version/24599
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "SimpSons20@" And Confirmation Password "Simpsons19@"
    Wait Until WEB Message Is "Nova senha e confirmação da senha não coincidem" Or Timeout After "10" Seconds
    Dismiss Current Displayed WEB Message

New password does not meet minimum security standards: less than 8 characters
    [Documentation]    Enter a new password with 7 characters.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22437/version/24600
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "SimpS1@" And Confirmation Password "SimpS1@"
    Wait Until WEB Message Is "Nova senha fora do formato aceitável" Or Timeout After "10" Seconds
    Dismiss Current Displayed WEB Message

New password does not meet minimum security standards: missing special character
    [Documentation]    Enter a new password without special characters.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22438/version/24601
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "SimpSons19" And Confirmation Password "SimpSons19"
    Wait Until WEB Message Is "Nova senha fora do formato aceitável" Or Timeout After "10" Seconds
    Dismiss Current Displayed WEB Message

New password does not meet minimum security standards: missing upper case letter
    [Documentation]    Enter a new password without an upper case letter.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22440/version/24602
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "simpsons19@" And Confirmation Password "simpsons19@"
    Wait Until WEB Message Is "Nova senha fora do formato aceitável" Or Timeout After "10" Seconds
    Dismiss Current Displayed WEB Message

New password does not meet minimum security standards: missing lower case letter
    [Documentation]    Enter a new password without a lower case letter.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22439/version/24603
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "SIMPSONS19@" And Confirmation Password "SIMPSONS19@"
    Wait Until WEB Message Is "Nova senha fora do formato aceitável" Or Timeout After "10" Seconds
    Dismiss Current Displayed WEB Message

New password does not meet minimum security standards: missing number
    [Documentation]    Enter a new password without a number.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22441/version/24604
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "SimpSons@" And Confirmation Password "SimpSons@"
    Wait Until WEB Message Is "Nova senha fora do formato aceitável" Or Timeout After "10" Seconds
    Dismiss Current Displayed WEB Message

First access password cannot be changed if terms of use are not accepted
    [Documentation]    Try to change password without accepting terms of use and privacy policy.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/27788/version/27808
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Wait Until User First Access Page Is Displayed
    Set New Login Password To "Citeb21@"
    Set New Login Password Confirmation To "Citeb21@"
    Unselect Login Compliance Checkbox
    First Access Change Password Button Should Be Disabled

Valid password with 8 characters
    [Documentation]    Enter a valid 8-character password.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22435/version/24606
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "Citeb21@" And Confirmation Password "Citeb21@"
    Wait Until WEB Message Is "Senha alterada com sucesso" Or Timeout After "5" Seconds
    Set To Dictionary    ${DUT}[env][management][login]    password    Citeb21@
    Wait Until Wizard First Step Page Is Displayed
    [Teardown]    Run Keywords    Close Browser
    ...                           FiberV3 Reset DUT Settings To Factory Default

Valid password with 9 characters
    [Documentation]    Enter a valid 9-character password.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22436/version/24606
    Access DUT WEB Login Page Through IPv4 Address
    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
    Perform DUT WEB First Access Password Change With Password "Citeb21@!" And Confirmation Password "Citeb21@!"
    Wait Until WEB Message Is "Senha alterada com sucesso" Or Timeout After "5" Seconds
    Wait Until Wizard First Step Page Is Displayed
    Set To Dictionary    ${DUT}[env][management][login]    password    Citeb21@!
    [Teardown]    Run Keywords    Close Browser
    ...                           FiberV3 Reset DUT Settings To Factory Default

#SSH Access With New Password
#    [Documentation]    Access DUT via SSH after first access password change.
#    ...    \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/26045/view/22446/version/27807
#    #TODO: complete test with SSH implementations
#    Restore System Settings To Factory Default
#    Access DUT WEB Login Page Through IPv4 Address
#    Login To DUT With Username "${DUT}[profile][login][factory_default][production_firmware][username]" And Password "${DUT}[profile][login][factory_default][production_firmware][password]"
#    Perform DUT WEB First Access Password Change With Password "Citeb21@" And Confirmation Password "Citeb21@"
#    Wait Until WEB Message Is "Senha alterada com sucesso" Or Timeout After "10" Seconds
#    Wait For WEB Message To Disappear Or Timeout After "5" Seconds
#    Access System Management Page
#    Select System Management SSH Enable Checkbox
#    Save And Apply Settings
