*** Settings ***
Documentation    Ações e elementos da página de listagem de tarefas

Library          Browser


*** Keywords ***
Task Should Be Registered
    [Documentation]    Verifica se a tarefa está registrada na lista de tarefas.
    [Arguments]    ${task_name}

    Wait For Elements State    css=.task-todo >> text=${task_name}
    ...    visible    5

Task Should Be Completed
    [Documentation]    Verifica se a tarefa está registrada na lista de tarefas.
    [Arguments]    ${task_name}

    ${element}    Set Variable    css=.task-done >> text=${task_name}

    Wait For Elements State
    ...    ${element}
    ...    visible
    ...    5

    Get Style    ${element}    text-decoration-line    equal    line-through

Mark Task As Completed
    [Documentation]    Marca a tarefa como concluída.
    [Arguments]    ${task_name}
    ${element}    Set Variable
    ...    xpath=//strong[text()="${task_name}"]/..//button[@class="item-toggle"]
    Wait For Elements State    ${element}    visible    5
    Click    ${element}

Request Removal
    [Documentation]    Marca a tarefa como concluída.
    [Arguments]    ${task_name}
    ${element}    Set Variable
    ...    xpath=//strong[text()="${task_name}"]/..//button[@class="task-remove"]
    Wait For Elements State    ${element}    visible    5
    Click    ${element}

Task Should Not Exist
    [Documentation]    Verifica se a tarefa está registrada na lista de tarefas.
    [Arguments]    ${task_name}

    Wait For Elements State    css=.task-todo >> text=${task_name}
    ...    detached    5
