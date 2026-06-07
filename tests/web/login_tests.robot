*** Settings ***
Documentation     Login page test suite for Sauce Demo.
Library           SeleniumLibrary
Resource          ../../resources/keywords/common.robot
Resource          ../../resources/keywords/web_keywords.robot
Resource          ../../resources/variables/variables.robot

Suite Setup       Open Browser To Site
Suite Teardown    Close Browser Session
Test Teardown     Run Keyword If Test Failed    Take Screenshot On Failure


*** Test Cases ***
Standard User Can Log In
    [Tags]    smoke    login
    Login As Standard User
    Inventory Page Should Be Loaded

Locked Out User Sees Error Message
    [Tags]    regression    login
    Navigate To Login Page
    Login With Credentials    ${LOCKED_USER}    ${STANDARD_PASS}
    Login Error Should Contain    locked out

Invalid Credentials Show Error
    [Tags]    regression    login
    Navigate To Login Page
    Login With Credentials    bad_user    bad_pass
    Login Error Should Contain    Username and password do not match

Empty Username Shows Required Error
    [Tags]    regression    login
    Navigate To Login Page
    Login With Credentials    ${EMPTY}    ${STANDARD_PASS}
    Login Error Should Contain    Username is required

Empty Password Shows Required Error
    [Tags]    regression    login
    Navigate To Login Page
    Login With Credentials    ${STANDARD_USER}    ${EMPTY}
    Login Error Should Contain    Password is required
