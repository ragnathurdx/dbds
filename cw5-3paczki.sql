/* Stworzyć paczki:
1. Składającą się ze stworzonych procedur i funkcji */



CREATE OR REPLACE PACKAGE p1 AS
--lista funkcji
FUNCTION f4(str VARCHAR)
RETURN VARCHAR;
--itd...
END p1;

CREATE OR REPLACE PACKAGE BODY p1 AS 
-- funkcje
CREATE OR REPLACE FUNCTION f4(str VARCHAR)
RETURN VARCHAR IS
BEGIN
RETURN UPPER(SUBSTR(str, 1, 1)) || LOWER(SUBSTR(str, 2, LENGTH(str) - 2)) || (SUBSTR(str, -1, 1));
END f4;
-- itd...





/* 2. Stworzyć paczkę z procedurami i funkcjami do obsługi tabeli REGIONS (CRUD), gdzie odczyt z różnymi parametrami */


CREATE OR REPLACE PACKAGE p2 AS 
PROCEDURE dodajRegion(regionyid REGIONS.regionid%type, regionynazwa REGIONS.regionnazwa%type); 
PROCEDURE wypiszRegion;
PROCEDURE zmienRegion (regionyid REGIONS.regionid%type, nowanazwa IN VARCHAR );
PROCEDURE usunRegion(regionynazwa REGIONS.regionnazwa%type);
END p2;

CREATE OR REPLACE PACKAGE BODY p2 AS

PROCEDURE dodajRegion(regionyid REGIONS.regionid%type, 
regionynazwa REGIONS.regionnazwa%type) IS
BEGIN 
INSERT INTO REGIONS(regionid,regionnazwa) 
VALUES(regionyid, regionynazwa); 
END dodajRegion;     

PROCEDURE wypiszRegion IS 
CURSOR rregions is 
SELECT regionnazwa FROM REGIONS; 
TYPE listaregionow IS TABLE OF REGIONS.regionnazwa%type; 
nazwalisty listaregionow := listaregionow(); 
COUNTER integer :=0; 
BEGIN 
FOR n IN rregions LOOP 
COUNTER := COUNTER +1; 
nazwalisty.extend; 
nazwalisty(COUNTER) := n.regionnazwa; 
dbms_output.put_line('Region(' ||COUNTER|| ')'||nazwalisty(COUNTER)); 
END LOOP; 
END wypiszRegion;
   
PROCEDURE zmienRegion (regionyid REGIONS.regionid%type, nowa_nazwa IN VARCHAR) AS
COUNTER NUMBER;  
BEGIN
SELECT COUNT(*) INTO COUNTER
FROM REGIONS
WHERE regionid = regionyid; 
IF COUNTER = 1 THEN UPDATE REGIONS
SET regionnazwa = nowa_nazwa
WHERE regionid = regionyid;
dbms_output.put_line('Region zostal zmieniony');
ELSE
dbms_output.put_line('Nie znaleziono');
END IF;
END;
   
PROCEDURE usunRegion(regionynazwa REGIONS.regionnazwa%type) 
IS
BEGIN
DELETE FROM REGIONS WHERE regionnazwa = regionynazwa; 
END usunRegion;

END p2;
