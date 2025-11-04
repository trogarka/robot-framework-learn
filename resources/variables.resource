*** Variables ***

# Career page URL - using variable makes it easy to change for different environments
${CAREER_URL}    https://www.continero.com/cs/career

# CSS Selectors - stored as variables for reuse and easy maintenance
${GALLERY_SELECTOR}    css:.TeamGallery__ImageWrapper-sc-4q1is0-3.fkxQUK
${INTRO_SELECTOR}      css:HeroJoin__WeLookForWrapper-fa709w-4.gUhzZA
${IMG_TAG}             css=img

# Browser configuration - headless Chrome for CI/CD, change to False for debugging
${HEADLESS}            ${True}
${BROWSER}             Chrome

# Timeout values - generous but not too long to fail fast when needed
# 10 seconds is good for most modern web apps with reasonable loading times
${WAIT_TIMEOUT}        10s

# Expected counts - makes tests maintainable when requirements change
${EXPECTED_GALLERY_IMAGES}    16