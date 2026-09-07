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
