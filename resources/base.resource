*** Settings ***
Library     libs/database.py
Library     Browser
Resource    env.resource
Resource    pages/SignupPage.resource


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
