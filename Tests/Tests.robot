*** Settings ***
Resource    ../resources/common_resources.resource


Test Setup    Test Setup
Test Teardown    Test Teardown

*** Test Cases ***
Testcase
    Alkalmazas megnyilik    ${HOMEPAGE_URL}
    Menupont aktivalasa Tabla megjelenik    ${PARTNEREK_LOKATOR}    ${UGYFELEK_GRID_ID}    Ügyfelek    Neve
    
    #User adatok bekerese
    ${headers}=  Create Dictionary  Content-Type=application/json
    ${proxies}=  Create Dictionary  http=${PROXY}  https=${PROXY}
    ${response}=  GET  ${BASE_URL}  proxies=${proxies}
    ${body}    Set Variable    ${response.json()}
    #Log    ${body}
    ${UGYFEL_NEV}    Set Variable    ${body}[0][first_name] ${body}[0][last_name]
    ${UGYFEL_EMAIL}    Set Variable    ${body}[0][email]
    ${UGYFEL_ID}    Set Variable    ${body}[0][id]
    Uj Partner rogzitese    ${UGYFEL_NEV}    ${UGYFEL_EMAIL}    ${UGYFEL_ID}
    Ugyfel megjelenik a grid listaban    ${UGYFEL_NEV}    ${UGYFEL_EMAIL}    ${UGYFEL_ID}
    
    Menupont aktivalasa Tabla megjelenik    ${TELEPHELY_LOKATOR}    ${TELEPHELY_GRID_ID}    Telephelyek    Ügyfél
    ${VAROS}    Set Variable    ${body}[0][address][city]
    ${IRANYITOSZAM}    Set Variable    ${body}[0][address][zip_code]
    ${UTCA}    Set Variable    ${body}[0][address][street_name]
    ${HAZSZAM}    Set Variable     

    Uj Telephely rogzitese    ${UGYFEL_NEV}    ${VAROS}    ${IRANYITOSZAM}    ${UTCA}    ${HAZSZAM}
    Telephely megjelenik a grid listaban    ${UGYFEL_NEV}    ${VAROS}    ${IRANYITOSZAM}    ${UTCA}
    #új eszköz
    ${headers}=  Create Dictionary  Content-Type=application/json
    ${proxies}=  Create Dictionary  http=${PROXY}  https=${PROXY}
    ${response}=  GET  ${BASE_URL}  proxies=${proxies}
    ${body}    Set Variable    ${response.json()}
    #Log    ${body}

    Menupont aktivalasa Tabla megjelenik    ${ESZKOZOK_LOKATOR}    $ESZKOZ_GRID_ID    Eszközök    Azonosító