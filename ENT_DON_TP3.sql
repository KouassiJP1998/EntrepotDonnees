-- Création des tables --
CREATE TABLE CONSOTEL_RECAP(
    IDI INTEGER not null,
	NCLI CHAR(7),
    NOTEL CHAR(10),
	DATEJOUR DATE ,
	DUREEJOUR number,
	NBAPPJOUR number,
	constraint pk_CONSOTEL_RECAP primary key(IDI)
);
DESC TESTE.consotel_jour_b;
--ALTER TABLE CONSOTEL_RECAP DROP COLUMN IDI;

insert into CONSOTEL_RECAP(IDI,NCLI,NOTEL,DATEJOUR, DUREEJOUR, NBAPPJOUR)
            SELECT SEQ.nextval, C.NCLI,C.NOTEL,C.DATEJOUR,C.DUREEJOUR,C.NBAPPJOUR
            FROM (SELECT DISTINCT NCLI,NOTEL,DATEJOUR, DUREEJOUR, NBAPPJOUR FROM CONSOTEL_JOUR) C;


MERGE INTO CONSOTEL_RECAP CR  USING TESTE.CONSOTEL_JOUR_B B 
ON (CR.NCLI=B.NCLI AND CR.NOTEL=B.NOTEL AND CR.DATEJOUR=B.DATEJOUR)
WHEN MATCHED THEN
    UPDATE SET CR.DUREEJOUR=B.DUREEJOUR+CR.DUREEJOUR
WHEN NOT MATCHED THEN
INSERT VALUES(SEQ.nextval, B.NCLI,B.NOTEL,B.DATEJOUR,B.DUREEJOUR,B.NBAPPJOUR);

SELECT * FROM CONSOTEL_RECAP;