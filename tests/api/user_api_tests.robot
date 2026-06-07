*** Settings ***
Documentation     ReqRes API test suite covering user CRUD and authentication.
Library           RequestsLibrary
Library           Collections
Resource          ../../resources/keywords/api_keywords.robot
Resource          ../../resources/variables/variables.robot

Suite Setup       Create API Session


*** Test Cases ***
List Users Returns 200 With Pagination Fields
    [Tags]    smoke    api    users
    ${resp}=    GET Users    page=1
    Should Be Equal As Integers    ${resp.status_code}    200
    Response Should Have Key    ${resp}    page
    Response Should Have Key    ${resp}    total
    Response Should Have Key    ${resp}    data

Page Parameter Is Respected
    [Tags]    regression    api    users
    ${resp}=    GET Users    page=2
    Response Value Should Equal    ${resp}    page    ${2}

Get Existing User Returns 200
    [Tags]    smoke    api    users
    ${resp}=    GET User By ID    2
    Should Be Equal As Integers    ${resp.status_code}    200
    ${user}=    Get From Dictionary    ${resp.json()}    data
    Should Be Equal As Integers    ${user}[id]    2

Get Nonexistent User Returns 404
    [Tags]    regression    api    users
    ${resp}=    GET User By ID    9999    expected_status=404
    Should Be Equal As Integers    ${resp.status_code}    404

Create User Returns 201 With ID And Timestamp
    [Tags]    smoke    api    users
    ${resp}=    POST Create User    Jane Doe    QA Lead
    Should Be Equal As Integers    ${resp.status_code}    201
    Response Should Have Key    ${resp}    id
    Response Should Have Key    ${resp}    createdAt
    Response Value Should Equal    ${resp}    name    Jane Doe
    Response Value Should Equal    ${resp}    job    QA Lead

Login With Valid Credentials Returns Token
    [Tags]    smoke    api    auth
    ${resp}=    POST Login    eve.holt@reqres.in    cityslicka
    Should Be Equal As Integers    ${resp.status_code}    200
    Response Should Have Key    ${resp}    token
    ${token}=    Get From Dictionary    ${resp.json()}    token
    Should Not Be Empty    ${token}

Login With Missing Password Returns 400
    [Tags]    regression    api    auth
    ${body}=    Create Dictionary    email=eve.holt@reqres.in
    ${resp}=    POST On Session    reqres    /login    json=${body}    expected_status=400
    Should Be Equal As Integers    ${resp.status_code}    400
    Response Should Have Key    ${resp}    error
