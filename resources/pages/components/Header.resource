*** Settings ***
Documentation    Ações e elementos do cabeçalho do Mark85

Library          String
Library          Browser


*** Keywords ***
User Should Be Logged In
    [Documentation]    Verifica se o usuário está autenticado e vê o nome no cabeçalho.
    [Arguments]    ${name}
    @{splited_name}    Split String    ${name}
    ${element}    Set Variable    css=header .right small
    Wait For Elements State    ${element}
    ...    visible    5
    Get Text    ${element}    equal    Olá, ${splited_name}[0]

Go To Task Form
    [Documentation]    Abre o formulário de criação de tarefas.
    Click    css=.button-add
