*** Settings ***
Documentation    Cenários de cadastro de tarefas

Resource         ../../resources/base.resource


*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    [Documentation]    Deve permitir cadastrar uma nova tarefa
    ${data}    Get Fixture    tasks    create

    Log    ${data}
