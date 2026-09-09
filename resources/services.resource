*** Settings ***
Documentation    Consumindo a API REST do sistema Mark85

Library          RequestsLibrary


*** Keywords ***
POST User Session
    [Documentation]    Cria uma nova tarefa
    [Arguments]    ${USER}

    ${PAYLOAD}    Create Dictionary
    ...    email=${USER}[email]
    ...    password=${USER}[password]

    ${RESP}    POST    url=http://localhost:3333/sessions
    ...    json=${PAYLOAD}
    ...    expected_status=200

    VAR    ${TOKEN}    ${RESP.json()}[token]

    Set Suite Variable    ${TOKEN}    ${RESP.json()}[token]

POST A New Task
    [Documentation]    Cria uma nova tarefa
    [Arguments]    ${PAYLOAD}
    ${HEADERS}    Create Dictionary
    ...    Authorization=${TOKEN}
    POST    url=http://localhost:3333/tasks
    ...    json=${PAYLOAD}
    ...    headers=${HEADERS}
    ...    expected_status=201
