/* 8.Zadeklarować kursor zwracający zarobki imię i nazwisko pracownika z parametrami,
gdzie pierwsze dwa parametry określają widełki zarobków a trzeci część imienia pracownika. 
Wypisać na ekran pracowników:
a.z widełkami 1000- 5000 z częścią imienia a (może być również A)
b.z widełkami 5000-20000 z częścią imienia u (może być również U) */


DECLARE 
    CURSOR zad8 (min_wyp NUMBER, max_wyp NUMBER, imie_char VARCHAR) IS
    SELECT wyplata, imie, nazwisko
    FROM pracownicy
    WHERE wyplata > min_wyp AND wyplata < max_wyp AND (imie LIKE LOWER('%' || imie_char || '%')
    OR imie LIKE UPPER('%' || imie_char || '%'));
BEGIN
    /* a.z widełkami 1000- 5000 z częścią imienia a (może być również A) */
    DBMS_OUTPUT.put_line('Z litera a lub A w imieniu');
    FOR wiersz IN zad8(1000, 5000, 'a')
    LOOP
    DBMS_OUTPUT.put_line(wiersz.imie || ' ' || wiersz.nazwisko || ' ' || wiersz.wyplata);
    END LOOP;
    /* b.z widełkami 5000-20000 z częścią imienia u (może być również U) */
    DBMS_OUTPUT.put_line('Z litera u lub U w imieniu');
    FOR wiersz IN zad8(5000, 20000, 'u')
    LOOP
    DBMS_OUTPUT.put_line(wiersz.imie || ' ' || wiersz.nazwisko || ' ' || wiersz.wyplata);
    END LOOP;
END;
