*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=${EXECDIR}${/}screenshots
Resource          variables.resource

*** Keywords ***
# Browser management keywords - reusable setup/teardown for all tests

Open Headless Browser
    [Documentation]    Opens Chrome browser in headless mode
    ...    Using headless for automated testing, set to False for visual debugging
    [Arguments]    ${url}=${CAREER_URL}
    Open Browser    ${url}    browser=${BROWSER}    options=add_argument("--headless=new")
    Set Selenium Speed    0    # Remove artificial delays for faster execution
    Set Selenium Timeout    ${WAIT_TIMEOUT}

Close Browser With Screenshot
    [Documentation]    Closes browser and captures screenshot on failure
    ...    Takes screenshot automatically when test fails for debugging
    Run Keyword If Test Failed    Capture Page Screenshot
    Close Browser

# Page-specific keywords - small, focused functions for better readability and reuse

Scroll To Element
    [Documentation]    Scrolls the page until the specified element is in view
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    ${WAIT_TIMEOUT}
    Scroll Element Into View    ${locator}

Open Career Page
    [Documentation]    Opens the career page using the configured URL
    Go To    ${CAREER_URL}
    Wait Until Element Is Visible    ${INTRO_SELECTOR}    timeout=${WAIT_TIMEOUT}
    ...    error=Career page failed to load within ${WAIT_TIMEOUT}

Count Gallery Images
    [Documentation]    Counts the number of gallery image wrappers
    ...    Returns the count for validation in test cases
    [Return]    ${image_count}
    Wait Until Element Is Visible    ${IMG_SELECTOR}    timeout=${WAIT_TIMEOUT}
    ...    error=Gallery images not visible within ${WAIT_TIMEOUT}
    ${image_count}=    Get Element Count    ${IMG_SELECTOR}
    Log    Found ${image_count} gallery images

Verify Image Srcs
    [Documentation]    Verifies all gallery images have non-empty src attributes
    ...    Ensures images are properly loaded with valid sources
    [Arguments]    ${image_count}
    ${elements}=    Get WebElements    ${IMG_SELECTOR}
    Length Should Be    ${elements}    ${image_count}
    ${idx}=    Set Variable    0
    FOR    ${el}    IN    @{elements}
        ${idx}=    Evaluate    ${idx} + 1
        ${src}=    Get Element Attribute    ${el}    src
        Should Not Be Empty    ${src}    msg=Image ${idx} has empty src attribute
        Log    Image ${idx} src: ${src}
    END

Verify Intro Present
    [Documentation]    Verifies the introduction text element exists and is visible
    ...    Uses dynamic wait to ensure element is loaded before checking
    Wait Until Element Is Visible    ${INTRO_SELECTOR}    timeout=${WAIT_TIMEOUT}
    ...    error=Introduction text not visible within ${WAIT_TIMEOUT}
    Element Should Be Visible    ${INTRO_SELECTOR}    message=Introduction text should be visible
    Log    Introduction text found and verified