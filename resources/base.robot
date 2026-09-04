*** Settings ***
Library    Browser


*** Keywords ***
Start Session
    [Documentation]    Starts a browser session and opens the application page.
    New Browser    browser=chromium    headless=True
    New Page    http://localhost:3000
