*** Settings ***
Documentation    Online

Resource         ../resources/base.robot


*** Test Cases ***
WebApp Deve Estar Online
    [Documentation]    Verifica se a aplicação web está online
    Start Session
    Get Title    equal    Mark85 by QAx
