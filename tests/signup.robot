*** Settings ***
Documentation    Cenários de testes do cadastro de usuários

Resource         ../resources/base.robot


*** Test Cases ***
Deve poder cadastrar um novo usuário
    [Documentation]    Verifica se um novo usuário pode ser cadastrado com sucesso.
    ${NAME}    Set Variable    Luis Fernando Brandão
    ${EMAIL}    Set Variable    lfernandobra@gmail.com
    ${PASSWORD}    Set Variable    pwd123

    Remove user from database    ${EMAIL}

    Start Session
    Go To    http:localhost:3000/signup

    Wait For Elements State    xpath=//h1    visible    5
    Get Text    xpath=//h1    equal    Faça seu cadastro
    Fill Text    id=name    ${NAME}
    Fill Text    id=email    ${EMAIL}
    Fill Text    id=password    ${PASSWORD}
    Click    id=buttonSignup

    Wait For Elements State    css=.notice p    visible    5
    Get Text    .notice p    equal    Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Documentation]    Verifica se não é possível cadastrar um usuário com e-mail duplicado.
    [Tags]    dup

    ${NAME}    Set Variable    Fernando Luis Brandão
    ${EMAIL}    Set Variable    fernandolbra@gmail.com
    ${PASSWORD}    Set Variable    pwd123

    Remove user from database    ${EMAIL}
    Insert user from database    ${NAME}    ${EMAIL}    ${PASSWORD}

    Start Session

    Go To    http:localhost:3000/signup

    Wait For Elements State    css=h1    visible    5
    Get Text    css=h1    equal    Faça seu cadastro

    Fill Text    id=name    ${NAME}
    Fill Text    id=email    ${EMAIL}
    Fill Text    id=password    ${PASSWORD}
    Click    id=buttonSignup

    Wait For Elements State    css=.notice p    visible    5
    Get Text    .notice p    equal    Oops! Já existe uma conta com o e-mail informado.
