/* Stworzyć następujące wyzwalacze:
1. Stworzyć tabelę archiwum_departamentów (id, nazwa, data_zamknięcia, ostatni_manager jako imię i nazwisko).
Po usunięciu departamentu dodać odpowiedni rekord do tej tabeli */


CREATE TABLE archiwum_departamentów (
  id int,
  nazwa VARCHAR2(40),
  data_zamkniecia DATE,
  imie VARCHAR2(15),
  nazwisko VARCHAR2(30)
)

CREATE OR REPLACE TRIGGER t1
AFTER DELETE
ON hr.departamenty
FOR EACH ROW
DECLARE
aimie Varchar(20); 
anazwisko VARCHAR(20);
BEGIN
    SELECT imie, nazwisko INTO aimie, anazwisko FROM pracownicy WHERE pracownicy_id = old.manager_id;
    INSERT INTO archiwum_departamentow (id, nazwa, data_zamkniecia, imie, nazwisko) VALUES(old.id, old.nazwa, SYSDATE, aimie, anazwisko);
END;




/* 2. W razie UPDATE i INSERT na tabeli employees, sprawdzić czy zarobki łapią się w widełkach 2000 - 26000.
Jeśli nie łapią się - zabronić dodania. Dodać tabelę złodziej(id, USER, czas_zmiany), 
której będą wrzucane logi, jeśli będzie próba dodania, bądź zmiany wynagrodzenia poza widełki. */

/*tabela zlodziej*/
CREATE TABLE zlodziej
(
  id int,
  user VARCHAR2(50),
  czas_zmiany DATE  
);	 

/*petla z nowymi id*/
CREATE SEQUENCE zlodziejid
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 9999
CYCLE
CACHE 2;

CREATE OR REPLACE TRIGGER t2
BEFORE INSERT OR UPDATE ON EMPLOYEES FOR EACH ROW
BEGIN
IF :new.zarobki >26000 or :new.zarobki < 2000
THEN INSERT INTO zlodziej(id, user, czas_zmiany) VALUES(zlodziejid.nextval, user, SYSDATE);
RAISE_APPLICATION_ERROR(-20111,'ERROR');
ELSE
DBMS_OUTPUT.PUT_LINE('OK');
END IF;  
END;



/* 3. Stworzyć sekwencję i wyzwalacz, który będzie odpowiadał za auto_increment w tabeli employees. */


CREATE SEQUENCE s1 START WITH 1;
CREATE OR REPLACE TRIGGER t3 
BEFORE INSERT ON EMPLOYEES 
FOR EACH ROW
BEGIN
SELECT s1.NEXTVAL INTO :new.pracownik_id FROM dual;
END;



/* 4. Stworzyć wyzwalacz, który zabroni dowolnej operacji na tabeli JOD_GRADES (INSERT, UPDATE, DELETE) */


CREATE OR REPLACE TRIGGER t4
BEFORE INSERT OR UPDATE OR DELETE ON JOB_GRADES
FOR EACH ROW   
BEGIN
dbms_output.put_line('OPERACJA ZABRONIONA');
RAISE_APPLICATION_ERROR(-20111,'ERROR');    
END;



/* 5. Stworzyć wyzwalacz, który przy próbie zmiany max i min salary w tabeli jobs zostawia stare wartości. */


CREATE OR REPLACE TRIGGER t5
BEFORE INSERT OR UPDATE ON jobs
FOR EACH ROW
DECLARE maxi NUMBER; mini NUMBER;
BEGIN
SELECT maxsalary, minsalary INTO maxi, mini FROM jobs WHERE jobs_id = ROWID;
  IF :new.max_salary<>maxi OR :new.min_salary <> mini THEN dbms_output.put_line('OPERACJA NIEDOZWOLONA');
  RAISE_APPLICATION_ERROR(-20137,'ERROR');    
  END IF;  
END;

