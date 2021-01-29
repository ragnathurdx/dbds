/* 6.Zmienić skrypt z 5 tak aby pojawiały się
wszystkie informacje na ekranie (wstawić %ROWTYPE do tabeli) */


DECLARE
   TYPE temp5 IS TABLE OF departments%ROWTYPE INDEX BY PLS_INTEGER;
   department_list zad_5;
   id_numbers NUMBER:=10;
BEGIN
     FOR i IN 1..10
     LOOP
       SELECT * INTO department_list(i) FROM departments 
       WHERE department_id = id_numbers;
       id_numbers := id_numbers + 10;
       DBMS_OUTPUT.put_line(department_list(i).department_name || ' ' || department_list(i).department_id);
     END LOOP;
END;
