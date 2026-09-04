*** Settings ***
Documentation    Cenários de testes do cadastro de usuários

Library          Browser


*** Test Cases ***
Deve poder cadastrar um novo usuário
    [Documentation]    Verifica se um novo usuário pode ser cadastrado com sucesso.
    New Browser    chromium    headless=True
    New Page    http://localhost:3000/signup

    Wait For Elements State    xpath=//h1    visible    5
    Get Text    xpath=//h1    equal    Faça seu cadastro
    Fill Text    id=name    Luis Fernando Brandão
    Fill Text    id=email    lfernandobra@gmail.com
    Fill Text    id=password    pwd123
    Click    id=buttonSignup
