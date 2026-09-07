*** Settings ***
Documentation    Cenários de tentativa de cadastro com senha muito curta

Resource         ../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot
Test Template    Short Password


*** Test Cases ***
Não deve logar com senha de 1 digito    1
Não deve logar com senha de 2 digitos    12
Não deve logar com senha de 3 digitos    123
Não deve logar com senha de 4 digitos    1234
Não deve logar com senha de 5 digitos    12345

# *** Keywords ***
# Short Password
#    [Documentation]    Verifica se o cadastro não permite uma senha com menos de 6 dígitos.
#    [Arguments]    ${short_pass}
#    ${USER}    Create Dictionary
#    ...    name=Luis Fernando Brandão
#    ...    email=lfernandobra@gmail.com
#    ...    password=${short_pass}

#    Go To Signup Page
#    Submit Signup Form    ${USER}

#    Alert Should Be    Informe uma senha com pelo menos 6 digitos
