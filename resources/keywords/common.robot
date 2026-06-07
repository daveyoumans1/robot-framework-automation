*** Settings ***
Library    SeleniumLibrary    timeout=${ELEMENT_TIMEOUT}    implicit_wait=0
Library    OperatingSystem
Resource   ../variables/variables.robot


*** Keywords ***
Open Browser To Site
    [Documentation]    Opens the browser to the configured base URL.
    [Arguments]    ${url}=${BASE_URL}    ${browser}=${BROWSER}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    IF    ${HEADLESS}
        Call Method    ${options}    add_argument    --headless\=new
    END
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Create Webdriver    Chrome    options=${options}
    Go To    ${url}
    Set Window Size    1280    720

Close Browser Session
    Capture Page Screenshot    EMBED
    Close Browser

Take Screenshot On Failure
    Capture Page Screenshot    EMBED

Element Should Contain Text
    [Arguments]    ${locator}    ${expected_text}
    ${actual}=    Get Text    ${locator}
    Should Contain    ${actual}    ${expected_text}    ignore_case=True
