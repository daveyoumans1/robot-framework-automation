*** Settings ***
Documentation     Inventory page test suite for Sauce Demo.
Library           SeleniumLibrary
Library           Collections
Resource          ../../resources/keywords/common.robot
Resource          ../../resources/keywords/web_keywords.robot
Resource          ../../resources/variables/variables.robot

Suite Setup       Run Keywords
...               Open Browser To Site
...               AND    Login As Standard User
Suite Teardown    Close Browser Session
Test Teardown     Run Keyword If Test Failed    Take Screenshot On Failure


*** Test Cases ***
Inventory Page Displays Six Products
    [Tags]    smoke    inventory
    Inventory Page Should Be Loaded
    ${count}=    Get Inventory Item Count
    Should Be Equal As Integers    ${count}    6

Sort By Name Ascending
    [Tags]    regression    sorting
    Sort Products By    az
    ${names}=    Get Product Names
    ${sorted}=    Evaluate    sorted($names)
    Lists Should Be Equal    ${names}    ${sorted}

Sort By Name Descending
    [Tags]    regression    sorting
    Sort Products By    za
    ${names}=    Get Product Names
    ${sorted}=    Evaluate    sorted($names, reverse=True)
    Lists Should Be Equal    ${names}    ${sorted}

Sort By Price Low To High
    [Tags]    regression    sorting
    Sort Products By    lohi
    ${prices}=    Get Product Prices
    ${sorted}=    Evaluate    sorted($prices)
    Lists Should Be Equal    ${prices}    ${sorted}

Sort By Price High To Low
    [Tags]    regression    sorting
    Sort Products By    hilo
    ${prices}=    Get Product Prices
    ${sorted}=    Evaluate    sorted($prices, reverse=True)
    Lists Should Be Equal    ${prices}    ${sorted}

Adding Item Updates Cart Badge
    [Tags]    smoke    cart
    Add Item To Cart By Index    0
    ${count}=    Get Cart Badge Count
    Should Be Equal As Integers    ${count}    1
