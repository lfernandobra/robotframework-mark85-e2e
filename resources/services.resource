*** Settings ***
Documentation    Consumindo a API REST do sistema Mark85

Library          RequestsLibrary
Resource         env.resource


*** Keywords ***
POST User Session
    [Documentation]    Autentica o usuário na API e armazena o token na suíte.
    [Arguments]    ${USER}

    ${PAYLOAD}    Create Dictionary
    ...    email=${USER}[email]
    ...    password=${USER}[password]

    ${RESP}    POST    url=${API_URL}/sessions
    ...    json=${PAYLOAD}
    ...    expected_status=200

    VAR    ${TOKEN}    ${RESP.json()}[token]    scope=SUITE

POST A New Task
    [Documentation]    Cria uma nova tarefa via API usando o token da suíte.
    [Arguments]    ${PAYLOAD}
    ${HEADERS}    Create Dictionary
    ...    Authorization=${TOKEN}
    POST    url=${API_URL}/tasks
    ...    json=${PAYLOAD}
    ...    headers=${HEADERS}
    ...    expected_status=201
