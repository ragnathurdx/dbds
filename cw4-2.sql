/*2.Do poprzedniego skryptu dodaj instrukcje
zmieniającą location_id (3000) dla dodanego departamentu.*/


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
-- DODANA INSTRUKCJA:
UPDATE departments SET location_id = 3000 WHERE department_id=numer_max+10;
END;
