*** Settings ***
Documentation    Keywords for creating tasks.

Library          Browser


*** Keywords ***
Submit Task Form
    [Documentation]    Submits the task creation form with the provided task data.
    [Arguments]    ${task}
    Fill Text    css=input[placeholder$=tarefa]    ${task}[name]
    Click    css=button >> text=Cadastrar
