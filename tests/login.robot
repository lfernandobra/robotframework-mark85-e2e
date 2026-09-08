*** Settings ***
Documentation    Cenários de autenticação do usuário

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
