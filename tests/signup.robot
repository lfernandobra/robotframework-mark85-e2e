*** Settings ***
Documentation    Cenários de testes do cadastro de usuários

Resource         ../resources/base.robot


*** Test Cases ***
Deve poder cadastrar um novo usuário
    [Documentation]    Verifica se um novo usuário pode ser cadastrado com sucesso.
    ${name}    Set Variable    Luis Fernando Brandão
    ${email}    Set Variable    lfernandobra@gmail.com
    ${password}    Set Variable    pwd123

    Remove user from database    ${email}

    Start Session
    Go To    http:localhost:3000/signup

    Wait For Elements State    xpath=//h1    visible    5
    Get Text    xpath=//h1    equal    Faça seu cadastro
    Fill Text    id=name    ${name}
    Fill Text    id=email    ${email}
    Fill Text    id=password    ${password}
    Click    id=buttonSignup

    Wait For Elements State    css=.notice p    visible    5
    Get Text    .notice p    equal    Boas vindas ao Mark85, o seu gerenciador de tarefas.
