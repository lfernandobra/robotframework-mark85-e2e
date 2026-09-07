*** Settings ***
Library    libs/database.py
Library    Browser


*** Variables ***
${BASE_URL}    http://localhost:3000


*** Keywords ***
Start Session
    [Documentation]    Starts a browser session and opens the application page.
    New Browser    browser=chromium    headless=True
    New Page    ${BASE_URL}
