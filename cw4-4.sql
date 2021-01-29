/* 4.Wyciągnąć informacje z tabeli countries do jednej zmiennej (%ROWTYPE)
dla kraju o identyfikatorze ‘CA’. Wypisać nazwę i region_id na ekran */


DECLARE
row_value countries%ROWTYPE;
BEGIN
SELECT * into row_value FROM countries WHERE country_id = 'CA';
DBMS_OUTPUT.PUT_LINE(row_value.country_name);
DBMS_OUTPUT.PUT_LINE(row_value.region_id);
END;
