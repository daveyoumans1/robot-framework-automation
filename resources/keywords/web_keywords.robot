*** Settings ***
Library    SeleniumLibrary
Resource   ../variables/variables.robot
Resource   common.robot


*** Variables ***
# Login page locators
${USERNAME_INPUT}       id:user-name
${PASSWORD_INPUT}       id:password
${LOGIN_BUTTON}         id:login-button
${ERROR_MESSAGE}        css:[data-test='error']

# Inventory page locators
${PAGE_TITLE}           class:title
${INVENTORY_ITEMS}      class:inventory_item
${ITEM_NAMES}           class:inventory_item_name
${ITEM_PRICES}          class:inventory_item_price
${SORT_DROPDOWN}        class:product_sort_container
${CART_BADGE}           class:shopping_cart_badge
${ADD_TO_CART_BTNS}     css:[data-test^='add-to-cart']
${CART_LINK}            class:shopping_cart_link


*** Keywords ***
Navigate To Login Page
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${LOGIN_BUTTON}

Login As Standard User
    Navigate To Login Page
    Login With Credentials    ${STANDARD_USER}    ${STANDARD_PASS}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Clear Element Text    ${USERNAME_INPUT}
    Input Text    ${USERNAME_INPUT}    ${username}
    Clear Element Text    ${PASSWORD_INPUT}
    Input Text    ${PASSWORD_INPUT}    ${password}
    Click Button    ${LOGIN_BUTTON}

Login Error Should Be Visible
    Wait Until Element Is Visible    ${ERROR_MESSAGE}

Login Error Should Contain
    [Arguments]    ${expected_text}
    Login Error Should Be Visible
    Element Should Contain Text    ${ERROR_MESSAGE}    ${expected_text}

Inventory Page Should Be Loaded
    Wait Until Element Is Visible    ${PAGE_TITLE}
    Element Text Should Be    ${PAGE_TITLE}    Products

Get Inventory Item Count
    ${items}=    Get WebElements    ${INVENTORY_ITEMS}
    RETURN    ${items.__len__()}

Sort Products By
    [Arguments]    ${sort_value}
    Select From List By Value    ${SORT_DROPDOWN}    ${sort_value}

Get Product Names
    ${elements}=    Get WebElements    ${ITEM_NAMES}
    ${names}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        Append To List    ${names}    ${text}
    END
    RETURN    ${names}

Get Product Prices
    ${elements}=    Get WebElements    ${ITEM_PRICES}
    ${prices}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        ${price}=    Evaluate    float("${text}".replace("$", ""))
        Append To List    ${prices}    ${price}
    END
    RETURN    ${prices}

Add Item To Cart By Index
    [Arguments]    ${index}=0
    ${buttons}=    Get WebElements    ${ADD_TO_CART_BTNS}
    Click Element    ${buttons}[${index}]

Get Cart Badge Count
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${CART_BADGE}
    IF    not ${visible}    RETURN    ${0}
    ${text}=    Get Text    ${CART_BADGE}
    RETURN    ${int(text)}
