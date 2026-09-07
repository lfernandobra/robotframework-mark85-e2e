*** Settings ***
Documentation    Elementos e ações da página de cadastro

Library          Browser
Resource         ../env.resource


*** Keywords ***
Go To Signup Page
    [Documentation]    Acessa a página de cadastro
    Go To    ${BASE_URL}/signup

    Wait For Elements State    xpath=//h1    visible    5
    Get Text    xpath=//h1    equal    Faça seu cadastro

Submit Signup Form
    [Documentation]    Preenche e envia o formulário de cadastro
    [Arguments]    ${USER}
    Fill Text    css=input[name=name]    ${USER}[name]
    Fill Text    css=input[name=email]    ${USER}[email]
    Fill Text    css=input[name=password]    ${USER}[password]
    Click    css=button[type=submit] >> text=Cadastrar

Notice Should Be
    [Documentation]    Verifica se a mensagem exibida corresponde ao texto esperado
    [Arguments]    ${expected_text}

    ${element}    Set Variable    css=.notice p
    Wait For Elements State    ${element}    visible    5
    Get Text    ${element}    equal    ${expected_text}
