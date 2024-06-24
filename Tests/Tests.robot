*** Settings ***
Resource    ../resources/common_resources.resource


Test Setup    Test Setup
Test Teardown    Test Teardown

*** Test Cases ***
Testcase
    Oldal megnyilik    ${HOMEPAGE_URL}
    Menupont aktivalasa Tabla megjelenik    ${PARTNEREK_LOKATOR}    ${UGYFELEK_GRID_ID}    Ügyfelek    Neve    ${PARTNEREK_URL}
    
    #Partner adatok bekerese
    ${headers}=  Create Dictionary  Content-Type=application/json
    ${proxies}=  Create Dictionary  http=${PROXY}  https=${PROXY}
    ${response}=  GET  ${BASE_URL}  proxies=${proxies}
    ${body}    Set Variable    ${response.json()}
    
    ${UGYFEL_NEV}    Set Variable    ${body}[0][first_name] ${body}[0][last_name]
    ${UGYFEL_EMAIL}    Set Variable    ${body}[0][email]
    ${UGYFEL_ID}    Set Variable    ${body}[0][id]
    Uj Partner rogzitese    ${UGYFEL_NEV}    ${UGYFEL_EMAIL}    ${UGYFEL_ID}
    Ugyfel megjelenik a grid listaban    ${UGYFEL_NEV}    ${UGYFEL_EMAIL}    ${UGYFEL_ID}
    
    #Uj telephely rögzítéséhez adatok beolvasása
    Menupont aktivalasa Tabla megjelenik    ${TELEPHELY_LOKATOR}    ${TELEPHELY_GRID_ID}    Telephelyek    Ügyfél    ${TELEPHELYEK_URL}
    ${VAROS}    Set Variable    ${body}[0][address][city]
    #${iranyitoszam_formazatlan}    Set Variable    ${body}[0][address][zip_code]
    #${IRANYITOSZAM}=    Replace String    ${iranyitoszam_formazatlan}    '-'    ${EMPTY}
    ${IRANYITOSZAM}    Set Variable    ${body}[0][address][zip_code]    
    ${UTCA}    Set Variable    ${body}[0][address][street_name]
    ${HAZSZAM}    Set Variable     

    Uj Telephely rogzitese    ${UGYFEL_NEV}    ${VAROS}    ${IRANYITOSZAM}    ${UTCA}    ${HAZSZAM}
    ${TELEPHELY}    set Variable    ${IRANYITOSZAM} ${VAROS}, ${UTCA}
    Telephely megjelenik a grid listaban    ${UGYFEL_NEV}    ${VAROS}    ${IRANYITOSZAM}    ${UTCA}
   
    Menupont aktivalasa Tabla megjelenik    ${ESZKOZOK_LOKATOR}    ${ESZKOZ_GRID_ID}    Eszközök    Azonosító    ${ESZKOZOK_URL}
    
    #új eszköz
    ${headers_device}=  Create Dictionary  Content-Type=application/json
    ${proxies}=  Create Dictionary  http=${PROXY}  https=${PROXY}
    ${response_device}=  GET  ${BASE_URL_DEVICE}  headers=${headers_device}    proxies=${proxies}
    ${body_device}    Set Variable    ${response_device.json()}
    FOR    ${index}    IN RANGE    0    2    
        
        ${ESZKOZ_NEV}    Set Variable    ${body_device}[${index}][manufacturer] ${body_device}[${index}][model]
        ${LEIRAS}    Set Variable    ${body_device}[${index}][platform]
        ${MEGJEGYZES}    Set Variable    ${body_device}[${index}][serial_number]

        Uj Eszkoz rogzitese    ${ESZKOZ_NEV}    ${UGYFEL_NEV}    ${TELEPHELY}    ${LEIRAS}    ${MEGJEGYZES}
        Eszkoz megjelenik a grid listaban    ${ESZKOZ_NEV}    ${UGYFEL_NEV}    ${TELEPHELY}    ${LEIRAS}    ${MEGJEGYZES}
    END
    Menupont aktivalasa Tabla megjelenik    ${ESZKOZOK_LOKATOR}    ${ESZKOZ_GRID_ID}    Eszközök    Azonosító    ${ESZKOZOK_URL}
    Eszkozok excel fileba exportalasa
    Sleep    5sec
    
    Menupont aktivalasa Tabla megjelenik    ${TELEPHELY_LOKATOR}    ${TELEPHELY_GRID_ID}    Telephelyek    Ügyfél    ${TELEPHELYEK_URL}
    Szures adott elemre    ${TELEPHELY_KERESES_LOKATOR}    ${UGYFEL_NEV}    ${KERESES_INDITASA_LOKATOR}
    Sleep    5sec

    Utca mezore kattintas
    Sleep    5sec
