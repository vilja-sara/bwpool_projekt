##BWP Tool
Rendszer bemutató
https://bwpool.azurewebsites.net/
Azure App service dev környezetben fut, mindenki számára elérhető. Nincs dedikált erőforrása ezért
pár másodpercig eltarthat az első megjelenés. Mögötte Azure SQL a kiszolgáló.
Blazor serverside app, minden szerver oldalon kerül feldolgozásra, SignalR segítségével kerül
megjelenítésre UI oldalon.
Minden böngészőben működik, mobilon is.


## Előfeltételek
- Python 3.x (Robot Framework is Python-based)
- Robot Framework (Installation: ```pip install robotframework```)
- Robot Framework SeleniumLibrary (Installation: ```pip install --upgrade robotframework-seleniumlibrary```)

## Installálás
1. Klónozd a repository-t:
2. A projekt mappában futtast a tests.robot filet
3. Installáld a szükséges Python könyvtárakat:
```
pip install -r requirements.txt

## Tesztesetek
A feladat egy tesztesetet tartalmaz