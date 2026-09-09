*** Settings ***
Documentation    Cenários de testes de remoção de tarefas

Resource         ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder apagar uma tarefa indesejada
    [Documentation]    Deve permitir marcar uma tarefa como concluída

    ${DATA}    Get Fixture    tasks    delete

    Clean User From Database    ${DATA}[user][email]
    Insert User From Database    ${DATA}[user]

    POST User Session    ${DATA}[user]
    POST A New Task    ${DATA}[task]

    Submit Login Form    ${DATA}[user]
    User Should Be Logged In    ${DATA}[user][name]

    Request Removal    ${DATA}[task][name]
    Task Should Not Exist    ${DATA}[task][name]
