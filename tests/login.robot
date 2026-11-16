*** Settings ***
Documentation    Cenários de autenticação do usuário

Library          Collections
Resource         ../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado
    [Documentation]    Verifica que um usuário pré-cadastrado consegue logar com sucesso.
    ${USER}    Create Dictionary
    ...    name=Luis Fernando Brandão
    ...    email=lfernandobra@yahoo.com
    ...    password=pwd123

    Remove User From Database    ${USER}[email]
    Insert User From Database    ${USER}

    Submit Login Form    ${USER}
    User Should Be Logged In    ${USER}[name]

Não Deve poder logar com senha inválida
    [Documentation]    Verifica que o sistema exibe erro de autenticação ao informar senha inválida.
    ${USER}    Create Dictionary
    ...    name=Steve Woz
    ...    email=woz@apple.com
    ...    password=123456

    Remove User From Database    ${USER}[email]
    Insert User From Database    ${USER}

    Set To Dictionary    ${USER}    password=abc123

    Submit Login Form    ${USER}
    Notice Should Be    Ocorreu um erro ao fazer login, verifique suas credenciais.
