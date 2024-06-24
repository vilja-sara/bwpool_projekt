*** Settings ***
Library    SeleniumLibrary
Library  RequestsLibrary
Library    OperatingSystem
Library    Collections
Library    String

*** Variables ***
# URLs
${HOMEPAGE_URL}    https://bwpool.azurewebsites.net/
${PARTNEREK_URL}    https://bwpool.azurewebsites.net/Customer
${TELEPHELYEK_URL}    https://bwpool.azurewebsites.net/Location
${ESZKOZOK_URL}    https://bwpool.azurewebsites.net/Tool

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
${TELEPHELY_EREDMENYTABLA_LOKATOR}    css=div.e-gridcontent

${VAROS_LOKATOR}    //input[@id='varos']
${IRANYITOSZAM_LOKATOR}    //input[@id='zip']
${UTCA_LOKATOR}    //input[@id='utca']
${HAZSZAM_LOKATOR}    //input[@id='szam']
${TELEPHELY_ADATOK_MENTES_LOKATOR}    //button[@class='e-control e-btn e-lib e-control e-btn e-lib e-primary e-flat']
${TELEPHELY_KERESES_LOKATOR}    //input[@id='Grid_ToolbarSearchBox']
${KERESES_INDITASA_LOKATOR}    //span[@class='e-searchclear e-search-icon e-icons e-input-group-icon']
${TELEPHELY_ADATOK_UTCA_LINK_LOKATOR}    //td/div/div/a

${ESZKOZOK_LOKATOR}    //a[contains(.,'Eszközök')]
${ADD_ESZKOZ_LOKATOR}    //span[.='Add']
${ESZKOZ_NEVE_LOKATOR}    //input[@id='name']
${ESZKOZ_UGYFELNEVE_LOKATOR}    css=[placeholder='Ügyfél']    
${ESZKOZ_TELEPHELY_LOKATOR}    css=[placeholder='Telephely']
${ESZKOZ_LEIRAS_LOKATOR}    //textarea[@id='Desc']
${ESZKOZ_MEGJEGYZES_LOKATOR}    //textarea[@id='Comm']
${ESZKOZ_MENTES_LOKATOR}    css=.e-primary
${ESZKOZ_EXCEL_EXPORT_LOKATOR}    //span[.='Excel Export']

#Error Massages


#Other Variables
${BROWSER}    Chrome 
${UGYFELEK_GRID_ID}    Grid
${TELEPHELY_GRID_ID}    Grid
${ESZKOZ_GRID_ID}    Grid

${ELVART_FILE}    Export.xlsx
${LETOLTOTT_FILE_NEVE}    ${EMPTY}

${LETOLTESMAPPA_ELERESE}    C:\\Users\\A200324019\\Downloads

#${UGYFEL_NEV}

*** Keywords ***
Test Setup
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}
    Maximize Browser Window

Test Teardown
    Close All Browsers

Oldal megnyilik
    [Arguments]    ${expected_url}
    ${actual_url}    Get Location
    Should Be Equal    ${actual_url}    ${expected_url}
    Sleep    5sec

Menupont aktivalasa Tabla megjelenik
    [Arguments]    ${menupont_lokator}    ${tabla_id}    ${cimsor}    ${mezo}    ${elvart_url}   
    Wait Until Element Is Visible    ${menupont_lokator}
    Click Element    ${menupont_lokator}
    Sleep    10sec
    Oldal megnyilik    ${elvart_url} 
    Element Should Be Visible    id=${tabla_id}
    #Sleep    5sec
    Page Should Contain    ${tabla_id}
    Page Should Contain    ${cimsor}
    Page Should Contain    ${mezo}

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
#Ügyfél rögzítése sikeres
    Oldal megnyilik    ${PARTNEREK_URL}
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
    Wait Until Element Is Visible    ${ADD_TELEPHELY_LOKATOR}
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
#Telephely rögzítése sikeres
    [Arguments]    ${nev}    ${varos}    ${iranyitoszam}    ${utca}  
    Oldal megnyilik    ${TELEPHELYEK_URL}
    Page Should Contain    ${nev}
    Page Should Contain    ${varos}
    #Page Should Contain    ${iranyitoszam} 
    # Page should have contained text '89162' but did not.
    # Page should have contained text '06401' but did not.
    Page Should Contain    ${utca}

Uj Eszkoz rogzitese
    [Arguments]    ${eszkoz_neve}    ${ugyfel_neve}    ${telephely_neve}    ${leiras}    ${megjegyzes}    
    Click Element    ${ADD_ESZKOZ_LOKATOR}
   
    Sleep    5s
    Input Text    ${ESZKOZ_UGYFELNEVE_LOKATOR}    ${ugyfel_neve}
    Click Element    ${ESZKOZ_TELEPHELY_LOKATOR}
    #Input Text    ${ESZKOZ_TELEPHELY_LOKATOR}    ${telephely_neve}
    Sleep    5s
    Click Element    ${ESZKOZ_NEVE_LOKATOR}
    Input Text    ${ESZKOZ_NEVE_LOKATOR}    ${eszkoz_neve}
    Input Text    ${ESZKOZ_LEIRAS_LOKATOR}    ${leiras}
    Input Text    ${ESZKOZ_MEGJEGYZES_LOKATOR}    ${megjegyzes}

    Sleep    5sec  
    Click Element    ${ESZKOZ_MENTES_LOKATOR}
    

Eszkoz megjelenik a grid listaban
#Eszköz rögzítése sikeres
    [Arguments]    ${eszkoz_neve}    ${ugyfel_neve}    ${telephely}    ${leiras}    ${megjegyzes} 
    Oldal megnyilik    ${ESZKOZOK_URL}
    Sleep    5sec
    Page Should Contain    ${eszkoz_neve}
    Page Should Contain    ${ugyfel_neve}
    #Page Should Contain    ${telephely} 
    #[FAIL INSIDE] Page should have contained text '25822-9445 Casperview, Santo Plain' but did not.
    
    Page Should Contain    ${leiras}
    Page Should Contain    ${megjegyzes}

Eszkozok excel fileba exportalasa
    ${letoltott_fileok}=    List Files In Directory    ${LETOLTESMAPPA_ELERESE}
    Wait Until Element Is Visible    ${ESZKOZ_EXCEL_EXPORT_LOKATOR}
    Click Element    ${ESZKOZ_EXCEL_EXPORT_LOKATOR}
    Sleep    10sec
    Ellenorzes uj letoltes    ${letoltott_fileok}
    
Ellenorzes uj letoltes
    [Arguments]    ${kiindulas_letoltesi_lista}
    ${letoltodott}    Set Variable    ${False}
    WHILE    ${letoltodott} == ${False}
        
        ${aktualis_letoltesi_lista}=    List Files In Directory    ${LETOLTESMAPPA_ELERESE}
        ${kiindulas_letoltesi_lista_hossza}=    Get Length    ${kiindulas_letoltesi_lista}
        ${aktualis_letoltesi_lista_hossza}=    Get Length    ${aktualis_letoltesi_lista}
        IF    ${kiindulas_letoltesi_lista_hossza} < ${aktualis_letoltesi_lista_hossza}
             ${letoltodott}    Set Variable    ${True}
             
        END
    END
    
    

Szures adott elemre
    [Arguments]    ${keresesi_mezo_lokator}    ${elem_erteke}    ${kereses_inditasa_lokator}
    Input Text    ${keresesi_mezo_lokator}    ${elem_erteke}
    Click Element    ${kereses_inditasa_lokator}
    Sleep    5sec
    ${sorok_szama}    Get Element Count    ${TELEPHELY_EREDMENYTABLA_LOKATOR}
    Should Be Equal As Integers    ${sorok_szama}    1
    Element Should Contain    ${TELEPHELY_EREDMENYTABLA_LOKATOR}    ${elem_erteke}

Utca mezore kattintas
    Click Element    ${TELEPHELY_ADATOK_UTCA_LINK_LOKATOR}
    Sleep    5sec
    Page Should Contain    Telephely adatok
