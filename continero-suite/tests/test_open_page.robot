*** Settings ***
Resource          ../resources/variables.resource
Resource          ../resources/keywords.resource

Test Setup        Open Headless Browser
Test Teardown     Close Browser With Screenshot
Force Tags        regression

*** Test Cases ***
Open Career Page Successfully
    [Documentation]    Test that the career page opens and loads correctly
    ...    This is a basic smoke test to ensure the page is accessible
    ...    and loads without errors.
    [Tags]    regression    smoke
    Open Career Page

    # Basic verification that page loaded successfully
    Location Should Contain    continero.com    msg=URL should contain continero.com
    Location Should Contain    /career    msg=URL path should contain '/career'

    Log    Career page opened successfully