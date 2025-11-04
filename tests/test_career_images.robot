*** Settings ***
Resource          ../resources/variables.resource
Resource          ../resources/keywords.resource

Test Setup        Open Headless Browser
Test Teardown     Close Browser With Screenshot
Force Tags        regression

*** Test Cases ***
Verify Gallery Image Count And Sources
    [Documentation]    Test that exactly 16 gallery images are present
    ...    and each image has a non-empty src attribute.
    ...    This verifies the photo gallery displays correctly.
    [Tags]    regression    gallery    images
    Open Career Page
    Scroll To Element    ${GALLERY_SELECTOR}

    # Count the gallery images
    ${image_count}=    Count Gallery Images

    # Verify we have exactly 16 images as expected
    Should Be Equal As Numbers    ${image_count}    ${EXPECTED_GALLERY_IMAGES}
    ...    msg=Expected ${EXPECTED_GALLERY_IMAGES} gallery images, but found ${image_count}

    # Verify all images have valid src attributes
    Verify Image Srcs    ${image_count}

    Log    Gallery image verification completed successfully