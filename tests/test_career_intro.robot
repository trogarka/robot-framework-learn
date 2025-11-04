*** Settings ***
Resource          ../resources/variables.resource
Resource          ../resources/keywords.resource

Test Setup        Open Headless Browser
Test Teardown     Close Browser With Screenshot
Force Tags        regression

*** Test Cases ***
Verify Introduction Text Is Present
    [Documentation]    Test that the introduction text element exists and is visible
    ...    This verifies the career page content loads correctly.
    [Tags]    regression    content    introduction
    Open Career Page

    # Verify the introduction text element is present and visible
    Verify Intro Present

    Log    Introduction text verification completed successfully