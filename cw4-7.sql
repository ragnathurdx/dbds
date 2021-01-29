/* 7.Zadeklaruj kursor jako wynagrodzenie, nazwisko dla departamentu o numerze 50.
Dla elementów kursora wypisać na ekran, jeśli wynagrodzenie jest wyższe niż 3100:
nazwisko osoby i tekst ‘nie dawać podwyżki’ w przeciwnym przypadku: nazwisko + ‘dać podwyżkę’ */


DECLARE 
CURSOR zad7 IS
    SELECT wyplata, nazwisko
    FROM employees
    WHERE department_id = 50;
BEGIN
    FOR wiersz IN zad7
    LOOP
    IF wiersz.wyplata > 3100 THEN
        DBMS_OUTPUT.put_line(wiersz.nazwisko || 'nie dawac podwyzki');
    ELSE
        DBMS_OUTPUT.put_line(wiersz.nazwisko || 'dac podwyzke');
    END IF;
    END LOOP;
END;
