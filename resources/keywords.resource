*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
# Browser management keywords - reusable setup/teardown for all tests

Open Headless Browser
    [Documentation]    Opens Chrome browser in headless mode
    ...    Using headless for automated testing, set to False for visual debugging
    [Arguments]    ${url}=${CAREER_URL}
    Open Browser    ${url}    browser=${BROWSER}    options=add_argument("--headless=new"); add_argument("--no-sandbox"); add_argument("--disable-dev-shm-usage")
    Set Selenium Speed    0    # Remove artificial delays for faster execution
    Set Selenium Timeout    ${WAIT_TIMEOUT}

Close Browser With Screenshot
    [Documentation]    Closes browser and captures screenshot on failure
    ...    Takes screenshot automatically when test fails for debugging
    Run Keyword If Test Failed    Capture Page Screenshot
    Close Browser

# Page-specific keywords - small, focused functions for better readability and reuse

Open Career Page
    [Documentation]    Opens the career page using the configured URL
    Go To    ${CAREER_URL}
    Wait Until Page Contains    Career    timeout=${WAIT_TIMEOUT}
    ...    msg=Career page failed to load within ${WAIT_TIMEOUT}

Count Gallery Images
    [Documentation]    Counts the number of gallery image wrappers
    ...    Returns the count for validation in test cases
    [Return]    ${image_count}
    Wait Until Element Is Visible    ${GALLERY_SELECTOR}    timeout=${WAIT_TIMEOUT}
    ...    msg=Gallery images not visible within ${WAIT_TIMEOUT}
    ${image_count}=    Get Element Count    ${GALLERY_SELECTOR}
    Log    Found ${image_count} gallery images

Verify Image Srcs
    [Documentation]    Verifies all gallery images have non-empty src attributes
    ...    Ensures images are properly loaded with valid sources
    [Arguments]    ${image_count}
    FOR    ${index}    IN RANGE    0    ${image_count}
        ${img_element}=    Get WebElement    ${GALLERY_SELECTOR}:${index+1}    # Robot uses 1-based indexing
        ${img_tag}=    Get WebElement    ${IMG_TAG}    parent=${img_element}
        ${src}=    Get Element Attribute    ${img_tag}    src
        Should Not Be Empty    ${src}    msg=Image ${index+1} has empty src attribute
        Log    Image ${index+1} src: ${src}
    END

Verify Intro Present
    [Documentation]    Verifies the introduction text element exists and is visible
    ...    Uses dynamic wait to ensure element is loaded before checking
    Wait Until Element Is Visible    ${INTRO_SELECTOR}    timeout=${WAIT_TIMEOUT}
    ...    msg=Introduction text not visible within ${WAIT_TIMEOUT}
    Element Should Be Visible    ${INTRO_SELECTOR}    msg=Introduction text should be visible
    Log    Introduction text found and verified