*** Settings ***
Documentation    Cenários de cadastro de tarefas

Resource         ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    [Documentation]    Deve permitir cadastrar uma nova tarefa
    ${DATA}    Get Fixture    tasks    create

    Reset User From Database    ${DATA}[user]

    Do Login    ${DATA}[user]

    Go To Task Form
    Submit Task Form    ${DATA}[task]
    Task Should Be Registered    ${DATA}[task][name]

Não deve cadastrar tarefa com nome duplicado
    [Documentation]    Não deve permitir cadastrar uma tarefa com nome duplicado
    [Tags]    dup
    ${DATA}    Get Fixture    tasks    duplicate

    Reset User From Database    ${DATA}[user]

    Create A New Task From API    ${DATA}

    Do Login    ${DATA}[user]

    Go To Task Form
    Submit Task Form    ${DATA}[task]

    Notice Should Be    Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Documentation]    Não deve permitir cadastrar uma tarefa quando atinge o limite de tags
    ${DATA}    Get Fixture    tasks    tags_limit

    Reset User From Database    ${DATA}[user]

    POST User Session    ${DATA}[user]

    Do Login    ${DATA}[user]

    Go To Task Form
    Submit Task Form    ${DATA}[task]

    Notice Should Be    Oops! Limite de tags atingido.
