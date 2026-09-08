*** Settings ***
Documentation    Cenários de cadastro de tarefas

Resource         ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    [Documentation]    Deve permitir cadastrar uma nova tarefa
    ${DATA}    Get Fixture    tasks    create
    Clean User From Database    ${DATA}[user][email]
    Insert User From Database    ${DATA}[user]

    Submit Login Form    ${DATA}[user]
    User Should Be Logged In    ${DATA}[user][name]

    Go To Task Form
    Submit Task Form    ${DATA}[task]
    Task Should Be Registered    ${DATA}[task][name]
