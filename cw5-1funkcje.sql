/* Stwórz funkcje:
1. Zwracającą nazwę pracy dla podanego parametru id, dodaj wyjątek, jeśli taka praca nie istnieje */


CREATE OR REPLACE FUNCTION f1 (job IN jobs.job_id%TYPE)
    RETURN VARCHAR2 IS
    title jobs.job_title%TYPE;
BEGIN
    SELECT job_title into title FROM jobs WHERE job_id = job;
    dbms_output.put_line(title);
    RETURN title;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN 'Nie znaleziono';
    WHEN OTHERS THEN dbms_output.put_line('Error');
END;



/* 2. zwracającą roczne zarobki (wynagrodzenie 12-to miesięczne plus premia jako wynagrodzenie * commission_pct) dla pracownika o podanym id */


CREATE OR REPLACE FUNCTION f2 (prac_id pracownicy.pracownik_id%TYPE)
RETURN NUMBER IS
wyplata NUMBER;
BEGIN 
    SELECT (pracownicy.salary * 12)+(pracownicy.salary*pracownicy.commission_pct) INTO wyplata FROM pracownicy WHERE pracownik_id = prac_id;
    return wyplata;
END;



/* 3. biorącą w nawias numer kierunkowy z numeru telefonu podanego jako varchar */


CREATE OR REPLACE f3 kierunkowy(numer VARCHAR)
RETURN VARCHAR IS
BEGIN
    RETURN '(' || SUBSTR(numer, 1, 2) || ')' || SUBSTR(numer, 3);
END kierunkowy;



/* 4. Dla podanego w parametrze ciągu znaków zmieniającą pierwszą i ostatnią literę na wielką – pozostałe na małe */


CREATE OR REPLACE FUNCTION f4(str VARCHAR)
RETURN VARCHAR IS
BEGIN
RETURN UPPER(SUBSTR(str, 1, 1)) || LOWER(SUBSTR(str, 2, LENGTH(str) - 2)) || (SUBSTR(str, -1, 1));
END f4;



/* 5. Dla podanego peselu - przerabiającą pesel na datę urodzenia w formacie ‘yyyy-mm-dd’ */


CREATE OR REPLACE FUNCTION f5(pesel VARCHAR)
RETURN DATE IS
BEGIN
RETURN TO_DATE('19' || SUBSTR(pesel, 1, 2) || '-' || SUBSTR(pesel, 3, 2) || '-' || SUBSTR(pesel, 5, 2));
END f5;



/* 6. Zwracającą liczbę pracowników oraz liczbę departamentów które znajdują się w kraju podanym jako parametr (nazwa kraju). W przypadku braku kraju - odpowiedni wyjątek */


/* poczatek
CREATE OR REPLACE FUNCTION f6(select_country VARCHAR) 
RETURN VARCHAR IS
nrdepartamentu NUMBER;
nrpracownika NUMBER;
*/

/*nie wiem :((*/


/*wyjatek
RETURN nrdepartamentu || ' ' || nrpracownika;
EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 'Nie znaleziono';
END f6;
*/
