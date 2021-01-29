/* 9.    Stwórz procedury:
a.   dodającą wiersz do tabeli Jobs – z dwoma parametrami wejściowymi
określającymi Job_id, Job_title, przetestuj działanie wrzuć wyjątki – co najmniej when others */


  
CREATE OR REPLACE PROCEDURE proc9a(Job_id varchar2, Job_title varchar2) IS
wiersz jobs%ROWTYPE;
wyjatek EXCEPTION;
BEGIN
INSERT INTO jobs VALUES(Job_id, Job_title, NULL, NULL);
dbms_output.put_line('OK');
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line('Error');
END
BEGIN
proc_9a('test','test2');
END




/* b.   modyfikującą title w  tabeli Jobs – z dwoma parametrami id dla którego ma być modyfikacja
oraz nową wartość dla Job_title – przetestować działanie, dodać swój wyjątek dla no Jobs updated – najpierw sprawdzić numer błędu */


CREATE OR REPLACE PROCEDURE proc9b(edit_job_id IN VARCHAR, edit_job_title IN VARCHAR) IS
wiersz jobs%ROWTYPE;
wyjatek EXCEPTION;
BEGIN
  SELECT * INTO wiersz FROM jobs WHERE job_id=edit_job_id;
  UPDATE jobs SET job_title = edit_job_title WHERE job_id = edit_job_id;
  dbms_output.put_line('Updated');
  EXCEPTION
  WHEN NO_DATA_FOUND THEN dbms_output.put_line('Nie znaleziono');
  WHEN OTHERS THEN dbms_output.put_line('Error');
END;




/* c.   usuwającą wiersz z tabeli Jobs  o podanym Job_id– przetestować działanie, dodaj wyjątek dla no Jobs deleted */


CREATE OR REPLACE PROCEDURE proc9c(jobid IN VARCHAR2) IS
wiersz jobs%ROWTYPE;
wyjatek EXCEPTION;
BEGIN
    SELECT * INTO wiersz FROM jobs WHERE job_id=jobid;
    DELETE FROM jobs WHERE job_id=jobid;
    dbms_output.put_line('OK');
EXCEPTION
    WHEN NO_DATA_FOUND THEN dbms_output.put_line('Nie znaleziono');
    WHEN OTHERS THEN dbms_output.put_line('Error');
END;



/* d.   Wyciągającą zarobki i nazwisko (parametry zwracane przez procedurę) z tabeli employees dla pracownika o przekazanym jako parametr id */


CREATE OR REPLACE PROCEDURE proc9d(znajdzprac_id IN VARCHAR, zarobki OUT NUMBER, nazw OUT VARCHAR) IS
wiersz jobs%ROWTYPE;
wyjatek EXCEPTION;
BEGIN
    SELECT wyplata, nazwisko INTO zarobki, nazw FROM employees WHERE employee_id=znajdzprac_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN dbms_output.put_line('Nie znaleziono');
    WHEN OTHERS THEN dbms_output.put_line('Error');
END;



/* e.   dodającą do tabeli employees wiersz – większość parametrów ustawić na domyślne (id poprzez sekwencję),
stworzyć wyjątek jeśli wynagrodzenie dodawanego pracownika jest wyższe niż 20000 */


CREATE OR REPLACE PROCEDURE proc9e(
pracownikid IN NUMBER DEFAULT employeeid_seq.nextval,
imie IN VARCHAR2 DEFAULT 'Imie',
nazwiko IN VARCHAR2 DEFAULT 'Nazwisko',
mail IN VARCHAR2 DEFAULT 'Email',
tel IN VARCHAR2 DEFAULT 'Telefon',
datazatr IN DATE DEFAULT SYSDATE,
idpraca IN VARCHAR2 DEFAULT 'pracownik',
wyplata IN NUMBER DEFAULT 1900,
prowizja IN NUMBER DEFAULT 3,
menadzer IN NUMBER DEFAULT 22,
wydzial IN NUMBER DEFAULT 1) IS
wiersz jobs%ROWTYPE;
wyjatek EXCEPTION;
BEGIN
    IF wyplata>20000 THEN RAISE wyjatek;
    END IF;
    INSERT INTO employees VALUES (pracownikid, imie, nazwisko, mail, tel, datazatr, idpraca, wyplata, prowizja, menadzer, wydzial);
    dbms_output.put_line('OK');
EXCEPTION
    WHEN wyjatek THEN dbms_output.put_line('Wyplata ponad 20000');
    WHEN NO_DATA_FOUND THEN dbms_output.put_line('No employee found - error code 01403');
    WHEN OTHERS THEN dbms_output.put_line('Error');
END;
