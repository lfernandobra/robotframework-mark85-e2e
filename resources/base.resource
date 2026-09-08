*** Settings ***
Library     libs/database.py
Library     Browser
Library     JSONLibrary
Resource    env.resource
Resource    pages/components/Alert.resource
Resource    pages/components/Header.resource
Resource    pages/components/Notice.resource
Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource


*** Keywords ***
Start Session
    [Documentation]    Starts a browser session and opens the application page.
    New Browser    browser=chromium    headless=True
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
