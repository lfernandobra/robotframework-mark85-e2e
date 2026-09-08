*** Settings ***
Documentation    Keywords for creating tasks.

Library          Browser


*** Keywords ***
Submit Task Form
    [Documentation]    Submits the task creation form with the provided task data.
    [Arguments]    ${TASK}
    Fill Text    css=input[placeholder$=tarefa]    ${TASK}[name]

    ${tags_element}    Set Variable    css=input[name=tags]

    FOR    ${tag}    IN    @{TASK}[tags]
        Fill Text    ${tags_element}    ${tag}
        Sleep    1
        Press Keys    ${tags_element}    Enter
    END

    Click    css=button >> text=Cadastrar
