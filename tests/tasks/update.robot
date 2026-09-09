*** Settings ***
Documentation    Cenários de testes de atualização de tarefas

Resource         ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder marcar uma tarefa como concluída
    [Documentation]    Deve permitir marcar uma tarefa como concluída

    ${DATA}    Get Fixture    tasks    done

    Clean User From Database    ${DATA}[user][email]
    Insert User From Database    ${DATA}[user]

    POST User Session    ${DATA}[user]
    POST A New Task    ${DATA}[task]

    Submit Login Form    ${DATA}[user]
    User Should Be Logged In    ${DATA}[user][name]
    Mark Task As Completed    ${DATA}[task][name]
    Task Should Be Completed    ${DATA}[task][name]
