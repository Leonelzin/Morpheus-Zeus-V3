*** Settings ***
Documentation     Password Change Tests Suite
...
...               This test suite contains tests to validate that DUT
...               management password can be changed only to passwords that
...               meet minimimum security standards and that comply with the
...               project business rules.
Resource          web/common.resource
Resource          web/system/password_pom.resource
Resource          web/login_pom.resource
Test Setup        Login To DUT WEB Page Through IPv4 Address
Test Teardown     Close Browser
Force Tags        system    password

*** Test Cases ***
New password does not meet minimum security standards: less than 8 characters
    [Documentation]    Change current password to new password outside of accepted standards.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8574/view/26290/version/26946
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Set System New Password To "Ab123!@"
    Set System New Password Confirmation To "Ab123!@"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Nova senha fora do formato aceitável"
    Dismiss Current Displayed WEB Message

New password does not meet minimum security standards: missing number
    [Documentation]    Change current password to new password outside of accepted standards.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8574/view/26290/version/26946
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Set System New Password To "ABCdef!@"
    Set System New Password Confirmation To "ABCdef!@"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Nova senha fora do formato aceitável"
    Dismiss Current Displayed WEB Message

New password does not meet minimum security standards: missing upper case letter
    [Documentation]    Change current password to new password outside of accepted standards.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8574/view/26290/version/26946
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Set System New Password To "abcde1!@"
    Set System New Password Confirmation To "abcde1!@"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Nova senha fora do formato aceitável"
    Dismiss Current Displayed WEB Message

New password does not meet minimum security standards: missing lower case letter
    [Documentation]    Change current password to new password outside of accepted standards.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8574/view/26290/version/26946
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Set System New Password To "ABCDE1!@"
    Set System New Password Confirmation To "ABCDE1!@"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Nova senha fora do formato aceitável"
    Dismiss Current Displayed WEB Message

New password does not meet minimum security standards: missing special character
    [Documentation]    Change current password to new password outside of accepted standards.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8574/view/26290/version/26946
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Set System New Password To "ABCdef12"
    Set System New Password Confirmation To "ABCdef12"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Nova senha fora do formato aceitável"
    Dismiss Current Displayed WEB Message

#TODO: Change current password to a new password that meet minimum security standards
    #[Documentation]    Change current password to new password within accepted standards.
    #...    \n*QAP Link*: TODO
    #[Tags]    no-run
    #Access System Password Page
    #Set System Current Password To "${DUT}[env][management][login][password]"
    #Set System New Password To "Simpsons2021@"
    #Set System New Password Confirmation To "Simpsons2021@"
    #Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Senha alterada com sucesso"
    #Wait For WEB Message To Disappear Or Timeout After "10" Seconds
    #Wait Until Login Page Is Displayed Or Timeout After "15" Seconds
    #TODO: try to login with old password and check WEB message
    #TODO: login with new password
    #TODO: change password to its original value (password that is set in morpheus/environment.py)

Incorrect current password
    [Documentation]    Input wrong current password when trying to change password.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8574/view/26295/version/26948
    Access System Password Page
    Set System Current Password To "admin"
    Set System New Password To "Simpsons2021@"
    Set System New Password Confirmation To "Simpsons2021@"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Senha atual inválida"
    Dismiss Current Displayed WEB Message

Empty new password and empty new password confirmation
    [Documentation]    Enter correct current password and leave the new password and confirm new password fields blank.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8574/view/26296/version/26944
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Insira uma nova senha"
    Dismiss Current Displayed WEB Message

Empty new password confirmation
    [Documentation]    Enter the correct current password, enter the new password, and keep the confirm new password field blank.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8574/view/26297/version/26943
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Set System New Password To "Simpsons2021@"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Insira a confirmação da nova senha"
    Dismiss Current Displayed WEB Message

Empty new password
    [Documentation]    Enter the correct current password, keep the new password field blank, and enter the new password confirmation.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8574/view/26298/version/26942
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Set System New Password Confirmation To "Simpsons2021@"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Insira uma nova senha"
    Dismiss Current Displayed WEB Message

New password and new password confirmation mismatch
    [Documentation]    Enter the current password, enter the new password, and enter the deviating password confirmation.
    ...                \n*QAP Link*: http://qap.apps.intelbras.com.br/#/project/1/test-specification/8574/view/26301/version/26945
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Set System New Password To "Simpsons2021@"
    Set System New Password Confirmation To "simpsons2021@"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Nova senha e confirmação da senha não coincidem"
    Dismiss Current Displayed WEB Message

New password cannot be the same as current password
    [Setup]    Run Keywords    Skip This Test If DUT Firmware Stage Is Not Production
    ...                        Login To DUT WEB Page Through IPv4 Address
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Set System New Password To "${DUT}[env][management][login][password]"
    Set System New Password Confirmation To "${DUT}[env][management][login][password]"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Senha atual não pode ser igual a nova senha"
    Dismiss Current Displayed WEB Message

Password cannot have more than 63 characters
    Access System Password Page
    Set System Current Password To "${DUT}[env][management][login][password]"
    Set System New Password To "ABCdef1!ABCdef1!ABCdef1!ABCdef1!ABCdef1!ABCdef1!ABCdef1!ABCdef1!"
    Set System New Password Confirmation To "ABCdef1!ABCdef1!ABCdef1!ABCdef1!ABCdef1!ABCdef1!ABCdef1!ABCdef1!"
    Click Save Settings Button If It Is Enabled And Expect WEB Message To Be "Nova senha fora do formato aceitável"
    Dismiss Current Displayed WEB Message
