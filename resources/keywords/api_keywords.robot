*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   ../variables/variables.robot


*** Keywords ***
Create API Session
    [Documentation]    Creates a persistent requests session for all API tests.
    Create Session    reqres    ${API_BASE_URL}    verify=True

GET Users
    [Arguments]    ${page}=1
    ${resp}=    GET On Session    reqres    /users    params=page=${page}    expected_status=200
    RETURN    ${resp}

GET User By ID
    [Arguments]    ${user_id}    ${expected_status}=200
    ${resp}=    GET On Session    reqres    /users/${user_id}    expected_status=${expected_status}
    RETURN    ${resp}

POST Create User
    [Arguments]    ${name}    ${job}
    ${body}=    Create Dictionary    name=${name}    job=${job}
    ${resp}=    POST On Session    reqres    /users    json=${body}    expected_status=201
    RETURN    ${resp}

POST Login
    [Arguments]    ${email}    ${password}
    ${body}=    Create Dictionary    email=${email}    password=${password}
    ${resp}=    POST On Session    reqres    /login    json=${body}
    RETURN    ${resp}

Response Should Have Key
    [Arguments]    ${response}    ${key}
    Dictionary Should Contain Key    ${response.json()}    ${key}

Response Value Should Equal
    [Arguments]    ${response}    ${key}    ${expected}
    ${actual}=    Get From Dictionary    ${response.json()}    ${key}
    Should Be Equal    ${actual}    ${expected}
