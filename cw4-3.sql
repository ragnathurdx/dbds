/*3.Stwórz tabelę nowa z jednym polem typu varchar,
a następnie wpisz do niej za pomocą pętli liczby od 1 do 10 bez liczb 4 i 6*/


CREATE TABLE tabela (pole varchar(10))
BEGIN
    FOR i IN 1..10
    LOOP
        IF (NOT (i=4 OR i=6)) THEN INSERT INTO tabela VALUES (i);
        END IF
    END LOOP;
END;
