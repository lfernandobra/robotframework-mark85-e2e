*** Settings ***
Documentation    Ações e elementos da página de login

Library          String
Library          Browser


*** Keywords ***
Submit Login Form
    [Documentation]    Preenche o formulário de login e envia as credenciais.
    [Arguments]    ${USER}
    Fill Text    css=input[placeholder$=mail]    ${USER}[email]
    Fill Text    css=input[placeholder=Senha]    ${USER}[password]

    # Click    xpath=//button[text()="Entrar"]
    Click    css=button >> text=Entrar

User Should Be Logged In
    [Documentation]    Verifica se o usuário está autenticado e vê o nome no cabeçalho.
    [Arguments]    ${name}
    @{splited_name}    Split String    ${name}
    ${element}    Set Variable    css=header .right small
    Wait For Elements State    ${element}
    ...    visible    5
    Get Text    ${element}    equal    Olá, ${splited_name}[0]
