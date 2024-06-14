*** Settings ***
Resource    ../resources/common_resources.resource


Test Setup    Test Setup
Test Teardown    Test Teardown

*** Test Cases ***
Testcase
    Alkalmazas megnyilik    ${HOMEPAGE_URL}
    Partnerek menupont Ugyfelek tabla megjelenik
    #User adatok bekerese
    ${headers}=  Create Dictionary  Content-Type=application/json
    ${proxies}=  Create Dictionary  http=${PROXY}  https=${PROXY}
    ${response}=  GET  ${BASE_URL}  proxies=${proxies}
    ${body}    Set Variable    ${response.json()}
    Log    ${body}
    ${UGYFEL_NEV}    Set Variable    ${body}[0][first_name] ${body}[0][last_name]
    ${UGYFEL_EMAIL}    Set Variable    ${body}[0][email]
    ${UGYFEL_ID}    Set Variable    ${body}[0][id]
    Uj Partner rogzitese    ${UGYFEL_NEV}    ${UGYFEL_EMAIL}    ${UGYFEL_ID}
    Ugyfel megjelenik a grid listaban    ${UGYFEL_NEV}    ${UGYFEL_EMAIL}    ${UGYFEL_ID}
    Telephely menupont Telephely tabla megjelenik
    
    
