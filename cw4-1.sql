/*1.Stworzyć blok anonimowy wypisujący zmienną numer_max równą maksymalnemu numerowi Departamentu
i dodaj do tabeli departamenty – departament z numerem o 10 wiekszym,
typ pola dla zmiennej z nazwą nowego departamentu (zainicjować na EDUCATION)
ustawić taki jak dla pola department_name w tabeli (%TYPE)*/

DECLARE
numer_max NUMBER;
dept_name departments.department_name%TYPE:='EDUCATION';
BEGIN
SELECT MAX(department_id) INTO numer_max FROM departments;
DBMS_OUTPUT.put_line(numer_max);
INSERT INTO departments
(department_id, department_name, manager_id, location_id)
VALUES
(numer_max+10, dept_name, NULL, NULL);
END;
