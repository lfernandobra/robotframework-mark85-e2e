*** Settings ***
Documentation    Ações e elementos da página de listagem de tarefas

Library          Browser


*** Keywords ***
Task Should Be Registered
    [Documentation]    Verifica se a tarefa está registrada na lista de tarefas.
    [Arguments]    ${task_name}

    Wait For Elements State    css=.task-todo >> text=${task_name}
    ...    visible    5

    # Get Text    css=.task-todo    equal    ${task_name}
