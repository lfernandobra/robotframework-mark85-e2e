*** Settings ***
Documentation    Cenários de testes de atualização de tarefas

Resource         ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder marcar uma tarefa como concluída
    [Documentation]    Deve permitir marcar uma tarefa como concluída

    ${DATA}    Get Fixture    tasks    done

    Reset User From Database    ${DATA}[user]

    Create A New Task From API    ${DATA}

    Do Login    ${DATA}[user]

    Mark Task As Completed    ${DATA}[task][name]
    Task Should Be Completed    ${DATA}[task][name]
