*** Settings ***
Documentation    Cenários de testes do cadastro de usuários

Resource         ../resources/base.resource

# Suite Setup    Log    Tudo aqui ocorre antes da Suite (antes de todos os testes)
# Suite Teardown    Log    Tudo aqui ocorre depois da Suite (depois de todos os testes)
Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder cadastrar um novo usuário
    [Documentation]    Verifica se um novo usuário pode ser cadastrado com sucesso.
    ${USER}    Create Dictionary
    ...    name=Luis Fernando Brandão
    ...    email=lfernandobra@gmail.com
    ...    password=pwd123

    Remove User From Database    ${USER}[email]

    Go To Signup Page
    Submit Signup Form    ${USER}
    Notice Should Be    Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Documentation]    Verifica se não é possível cadastrar um usuário com e-mail duplicado.
    [Tags]    dup

    ${USER}    Create Dictionary
    ...    name=Luis Fernando Brandão
    ...    email=lfernandobra@gmail.com
    ...    password=pwd123

    Remove User From Database    ${USER}[email]
    Insert User From Database    ${USER}

    Go To Signup Page
    Submit Signup Form    ${USER}
    Notice Should Be    Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Documentation]    Verifica se o cadastro não permite o envio de campos obrigatórios vazios.
    [Tags]    required
    ${USER}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=${EMPTY}

    Go To Signup Page
    Submit Signup Form    ${USER}

    Alert Should Be    Informe seu nome completo
    Alert Should Be    Informe seu e-email
    Alert Should Be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com senha de 1 digito
    [Documentation]    Verifica se o cadastro não permite o envio de campos obrigatórios vazios.
    [Tags]    short_pass
    ${USER}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=1

    Go To Signup Page
    Submit Signup Form    ${USER}

    Alert Should Be    Informe seu nome completo
    Alert Should Be    Informe seu e-email
    Alert Should Be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com senha de 2 digitos
    [Documentation]    Verifica se o cadastro não permite o envio de campos obrigatórios vazios.
    [Tags]    short_pass
    ${USER}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=2

    Go To Signup Page
    Submit Signup Form    ${USER}

    Alert Should Be    Informe seu nome completo
    Alert Should Be    Informe seu e-email
    Alert Should Be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com senha de 3 digitos
    [Documentation]    Verifica se o cadastro não permite o envio de campos obrigatórios vazios.
    [Tags]    short_pass
    ${USER}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=3

    Go To Signup Page
    Submit Signup Form    ${USER}

    Alert Should Be    Informe seu nome completo
    Alert Should Be    Informe seu e-email
    Alert Should Be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com senha de 4 digitos
    [Documentation]    Verifica se o cadastro não permite o envio de campos obrigatórios vazios.
    [Tags]    short_pass
    ${USER}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=4

    Go To Signup Page
    Submit Signup Form    ${USER}

    Alert Should Be    Informe seu nome completo
    Alert Should Be    Informe seu e-email
    Alert Should Be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com senha de 5 digitos
    [Documentation]    Verifica se o cadastro não permite o envio de campos obrigatórios vazios.
    [Tags]    short_pass
    ${USER}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=5

    Go To Signup Page
    Submit Signup Form    ${USER}

    Alert Should Be    Informe seu nome completo
    Alert Should Be    Informe seu e-email
    Alert Should Be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com email incorreto
    [Documentation]    Verifica se o cadastro não permite o envio de email incorreto.
    [Tags]    inv_email
    ${USER}    Create Dictionary
    ...    name=Charles Xavier
    ...    email=xavier.com.br
    ...    password=pwd123

    Go To Signup Page
    Submit Signup Form    ${USER}

    Alert Should Be    Digite um e-mail válido
