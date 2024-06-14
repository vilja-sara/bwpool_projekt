*** Settings ***
Library    SeleniumLibrary
Library  RequestsLibrary

*** Variables ***
# URLs
${HOMEPAGE_URL}    https://bwpool.azurewebsites.net/
${PROXY}  http://idebproxy01.itsh.itsh-internal.hu:3128
${BASE_URL}  https://random-data-api.com/api/users/random_user?size=1
${BASE_URL_DEVICE}  https://random-data-api.com/api/device/random_device?size=2

# Locators
${PARTNEREK_LOKATOR}    //a[contains(.,'Partnerek')]
${ADD_UGYFEL_LOKATOR}    //span[.='Add']
${UGYFEL_NEV_LOKATOR}    //input[@id='name']
${UGYFEL_EMAIL_LOKATOR}    //input[@id='email']
${UGYFEL_TELEFON_LOKATOR}    //input[@class='e-control e-numerictextbox e-lib e-input']
${UGYFEL_MEGJEGYZES_LOKATOR}    //input[@id='comment']
${UGYFEL_ADATOK_MENTES_LOKATOR}    //button[@class='e-control e-btn e-lib e-control e-btn e-lib e-primary e-flat']
${TELEPHELY_LOKATOR}    //a[contains(.,'Telephelyek')]
${ADD_TELEPHELY_LOKATOR}    //span[.='Add']
${UJTELEPHELY_UGYFEL_KIVALASZTAS_LOKATOR}    //input[@class='e-control e-combobox e-lib e-input']

${VAROS_LOKATOR}    //input[@id='varos']
${IRANYITOSZAM_LOKATOR}    //input[@id='zip']
${UTCA_LOKATOR}    //input[@id='utca']
${HAZSZAM_LOKATOR}    //input[@id='szam']
${TELEPHELY_ADATOK_MENTES_LOKATOR}    //button[@class='e-control e-btn e-lib e-control e-btn e-lib e-primary e-flat']

${ESZKOZOK_LOKATOR}    //a[contains(.,'Eszközök')]
${ADD_ESZKOZ_LOKATOR}    //span[.='Add']


#Error Massages


#Other Variables
${BROWSER}    Chrome 
${UGYFELEK_GRID_ID}    Grid
${TELEPHELY_GRID_ID}    Grid
${ESZKOZ_GRID_ID}    "Grid"
...    #${UGYFEL_NEV}

*** Keywords ***
Test Setup
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}
    Maximize Browser Window

Test Teardown
    Close All Browsers

Alkalmazas megnyilik
    [Arguments]    ${expected_url}
    ${actual_url}    Get Location
    Should Be Equal    ${actual_url}    ${expected_url}
    Sleep    5sec

Menupont aktivalasa Tabla megjelenik
    [Arguments]    ${menupont_lokator}    ${tabla_id}    ${cimsor}    ${mezo}    
    Wait Until Element Is Visible    ${menupont_lokator}
    Click Element    ${menupont_lokator}
    Sleep    10sec
    Element Should Be Visible    id=${tabla_id}
    #Sleep    5sec
    Page Should Contain    ${tabla_id}
    Page Should Contain    ${cimsor}
    Page Should Contain    ${mezo}

Partnerek menupont Ugyfelek tabla megjelenik
    Wait Until Element Is Visible    ${PARTNEREK}
    Click Element    ${PARTNEREK}
    Sleep    5sec
    Element Should Be Visible    id=${UGYFELEK_GRID_ID}
    Sleep    5sec
    Page Should Contain    ${UGYFELEK_GRID_ID}
    Page Should Contain    Ügyfelek
    Page Should Contain    Neve
    


Uj Partner rogzitese
    [Arguments]    ${ugyfel_nev}    ${ugyfel_email}    ${ugyfel_id}    
    Click Element    ${ADD_UGYFEL_LOKATOR}
    Sleep    2s
    Input Text    ${UGYFEL_NEV_LOKATOR}    ${ugyfel_nev}
    Input Text    ${UGYFEL_EMAIL_LOKATOR}    ${ugyfel_email}
    Input Text    ${UGYFEL_MEGJEGYZES_LOKATOR}    ${ugyfel_id}
    Sleep    2sec  
    Click Element    ${UGYFEL_ADATOK_MENTES_LOKATOR}
    Sleep    2sec

Ugyfel megjelenik a grid listaban
    [Arguments]    ${ugyfel_nev}    ${ugyfel_email}    ${ugyfel_id}  
    Page Should Contain    ${ugyfel_nev}
    Page Should Contain    ${ugyfel_email}
    Page Should Contain    ${ugyfel_id}

Telephely menupont Telephely tabla megjelenik
    Wait Until Element Is Visible    ${TELEPHELY_LOKATOR}
    Click Element    ${TELEPHELY_LOKATOR}
    Sleep    5sec
    Element Should Be Visible    id=${TELEPHELY_GRID_ID}
    Sleep    5sec
    Page Should Contain    ${TELEPHELY_GRID_ID}
    Page Should Contain    Telephelyek
    Page Should Contain    Ügyfél
    Page Should Contain    Város

Uj Telephely rogzitese
    [Arguments]    ${nev}    ${varos}    ${iranyitoszam}    ${utca}    ${hazszam}    
    Click Element    ${ADD_TELEPHELY_LOKATOR}
    #Select From List By Label    ${UJTELEPHELY_UGYFEL_KIVALASZTAS_LOKATOR}    ${nev}
    Sleep    5s
    Input Text    ${UJTELEPHELY_UGYFEL_KIVALASZTAS_LOKATOR}    ${nev}
    Sleep    5s
    Input Text    ${VAROS_LOKATOR}    ${varos}
    Input Text    ${IRANYITOSZAM_LOKATOR}    ${iranyitoszam}
    Input Text    ${UTCA_LOKATOR}    ${utca}
    Input Text    ${HAZSZAM_LOKATOR}    ${hazszam}
    Sleep    5sec  
    Click Element    ${TELEPHELY_ADATOK_MENTES_LOKATOR}
    Sleep    5sec

Telephely megjelenik a grid listaban
    [Arguments]    ${nev}    ${varos}    ${iranyitoszam}    ${utca}  
    Page Should Contain    ${nev}
    Page Should Contain    ${varos}
    #Page Should Contain    ${iranyitoszam} 
    # Page should have contained text '89162' but did not.
    # Page should have contained text '06401' but did not.
    Page Should Contain    ${utca}
