*** Settings ***
Documentation    Cenários de testes de remoção de tarefas

Resource         ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder apagar uma tarefa indesejada
    [Documentation]    Deve permitir remover uma tarefa indesejada.

    ${DATA}    Get Fixture    tasks    delete

    Reset User From Database    ${DATA}[user]

    Create A New Task From API    ${DATA}

    Do Login    ${DATA}[user]

    Request Removal    ${DATA}[task][name]
    Task Should Not Exist    ${DATA}[task][name]
