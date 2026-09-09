*** Settings ***
Library     libs/database.py
Library     Browser
Library     JSONLibrary
Resource    env.resource
Resource    pages/components/Alert.resource
Resource    pages/components/Header.resource
Resource    pages/components/Notice.resource
Resource    pages/TaskCreatePage.resource
Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource
Resource    pages/TasksPage.resource
Resource    services.resource


*** Keywords ***
Start Session
    [Documentation]    Starts a browser session and opens the application page.
    New Browser    browser=${BROWSER}    headless=True
    New Page    ${BASE_URL}

Short Password
    [Documentation]    Verifica se o cadastro não permite uma senha com menos de 6 dígitos.
    [Arguments]    ${short_pass}
    ${USER}    Create Dictionary
    ...    name=Luis Fernando Brandão
    ...    email=lfernandobra@gmail.com
    ...    password=${short_pass}

    Go To Signup Page
    Submit Signup Form    ${USER}

    Alert Should Be    Informe uma senha com pelo menos 6 digitos

# Helpers

Get Fixture
    [Documentation]    Loads fixture data for the specified scenario.
    [Arguments]    ${file_name}    ${scenario}
    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    utf-8

    RETURN    ${data}[${scenario}]

Reset User From Database
    [Documentation]    Resets the user in the database by removing and reinserting it.
    [Arguments]    ${USER}

    Clean User From Database    ${USER}[email]
    Insert User From Database    ${USER}

Create A New Task From API
    [Documentation]    Creates a new task through the API for the specified user.
    [Arguments]    ${DATA}

    POST User Session    ${DATA}[user]
    POST A New Task    ${DATA}[task]

Do Login
    [Documentation]    Logs in the user and verifies that the user is logged in.
    [Arguments]    ${USER}
    Submit Login Form    ${USER}
    User Should Be Logged In    ${USER}[name]
