*** Settings ***
Documentation    Ações e elementos da página de login

Library          Browser


*** Keywords ***
Submit Login Form
    [Documentation]    Preenche o formulário de login e envia as credenciais.
    [Arguments]    ${USER}
    Fill Text    css=input[placeholder$=mail]    ${USER}[email]
    Fill Text    css=input[placeholder=Senha]    ${USER}[password]

    # Click    xpath=//button[text()="Entrar"]
    Click    css=button >> text=Entrar
