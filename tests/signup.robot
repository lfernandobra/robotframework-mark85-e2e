*** Settings ***
Documentation    Cenários de testes do cadastro de usuários

Resource         ../resources/base.robot

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

    Go To    ${BASE_URL}/signup

    Wait For Elements State    xpath=//h1    visible    5
    Get Text    xpath=//h1    equal    Faça seu cadastro
    Fill Text    css=input[name=name]    ${USER}[name]
    Fill Text    css=input[name=email]    ${USER}[email]
    Fill Text    css=input[name=password]    ${USER}[password]
    Click    css=button[type=submit] >> text=Cadastrar

    Wait For Elements State    css=.notice p    visible    5
    Get Text    .notice p    equal    Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Documentation]    Verifica se não é possível cadastrar um usuário com e-mail duplicado.
    [Tags]    dup

    ${USER}    Create Dictionary
    ...    name=Luis Fernando Brandão
    ...    email=lfernandobra@gmail.com
    ...    password=pwd123

    Remove User From Database    ${USER}[email]
    Insert User From Database    ${USER}

    Go To    ${BASE_URL}/signup

    Wait For Elements State    css=h1    visible    5
    Get Text    css=h1    equal    Faça seu cadastro

    Fill Text    css=input[name=name]    ${USER}[name]
    Fill Text    css=input[name=email]    ${USER}[email]
    Fill Text    css=input[name=password]    ${USER}[password]
    Click    css=button[type=submit] >> text=Cadastrar

    Wait For Elements State    css=.notice p    visible    5
    Get Text    .notice p    equal    Oops! Já existe uma conta com o e-mail informado.
