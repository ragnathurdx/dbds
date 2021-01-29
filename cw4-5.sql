/* 5.Za pomocą tabeli INDEX BY wyciągnąć informacje
o nazwach departamentów i wypisać na ekran 10 (numery 10,20,…,100) */

DECLARE
    TYPE temp5 IS TABLE OF departments.department_name%TYPE INDEX BY pls_integer;
    departments__list temp_table;
    id_numbers NUMBER:=10;
BEGIN
    FOR i IN 1..10
        LOOP
        SELECT department_name INTO departments__list(i) FROM departments 
        WHERE department_id = id_numbers;
        id_numbers := id_numbers + 10;
        dbms_output.put_line(departments__list(i));
        END LOOP;
END;
