*** Settings ***
Documentation    Ações e elementos do componente de mensagens de alertas

Library          Browser


*** Keywords ***
Alert Should Be
    [Documentation]    Verifica se a mensagem de alerta exibida corresponde ao texto esperado
    [Arguments]    ${expected_text}
    Wait For Elements State    css=.alert-error >> text=${expected_text}
