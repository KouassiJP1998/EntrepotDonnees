--personnes ayant le même code sur 7 caractères dans les 2 tables
--lignes correcte Question3
SELECT code_pers, NCLI
 FROM
     PERSONNNES p ,CLIENTS c
 WHERE 
    SUBSTR(TRIM(p.code_pers),1,7)=SUBSTR(TRIM(c.ncli),1,7);

--lignes incorrecte Question3
SELECT SUBSTR(TRIM(code_pers),1,7)
FROM PERSONNNES p
WHERE (p.code_pers) NOT IN (	SELECT SUBSTR(TRIM(p2.code_pers),1,7)
							FROM PERSONNNES p2,CLIENTS c2
							WHERE SUBSTR(TRIM(p2.code_pers),1,7)=SUBSTR(TRIM(c2.ncli),1,7)
							);
                            
SELECT SUBSTR(TRIM(NCLI),1,7)
FROM CLIENTS c
WHERE (c.NCLI) NOT IN (	SELECT SUBSTR(TRIM(c2.ncli),1,7)
							FROM PERSONNNES p2,CLIENTS c2
							WHERE SUBSTR(TRIM(p2.code_pers),1,7)=SUBSTR(TRIM(c2.ncli),1,7)
							);
							


--q4

CREATE TABLE TELCLIENT AS
SELECT c.NCLI, c.NOM_CLI, c.PRENOM_CLI, c.CODEPOSTAL, c.adr_vill, c.SEXE, c.DATENAISS,p.PROFESSION
FROM PERSONNNES p, CLIENTS c
WHERE length(rtrim(c.NCLI, ' ')) = 7 AND
substr(upper(trim(c.NCLI)), 0,5) = substr(upper(trim(p.CODE_PERS)),0,5);

ALTER TABLE TELCLIENT ADD CONSTRAINT PK_TELCLIENT PRIMARY KEY(NCLI);


INSERT INTO TELCLIENT
SELECT concat(rtrim(NCLI, ' '), '1A'), c.NOM_CLI, c.PRENOM_CLI, c.CODEPOSTAL, c.ADR_VILL,c.SEXE, c.DATENAISS, p.PROFESSION
FROM teste.PERSONNES P, teste.CLIENTS C
WHERE length(rtrim(c.NCLI, ' ')) = 5 
AND length(rtrim(p.CODE_PERS, ' ')) = 5
AND upper(c.NCLI) = upper(p.CODE_PERS);


INSERT INTO TELCLIENT
SELECT concat(rtrim(c.NCLI, ' '), '1A'), c.NOM_CLI, c.PRENOM_CLI, c.CODEPOSTAL, c.ADR_VILL,c.SEXE, c.DATENAISS, c.PROF
FROM teste.CLIENTS c, teste.CLIENTS cc
WHERE substr(upper(trim(c.NCLI)), 0,5) <> substr(upper(trim(cc.NCLI)),0,5) AND upper(c.NOM_CLI) = upper(cc.NOM_CLI) 
AND upper(c.PRENOM_CLI) = upper(cc.PRENOM_CLI) 
AND (length(rtrim(c.NOM_CLI, ' ')) = 7);
   
ALTER TABLE TELCLIENT ADD CONSTRAINT PK_TELCLIENT PRIMARY KEY(NCLI);


INSERT INTO TELCLIENT (NCLI, NOM, PRENOM,CPOST, VILLE, PROFESSION)
VALUES
( SELECT DISTINCT(ncli) AS "ncli", nom_cli AS "nom", prenom_cli AS "prenom",codepostal AS "cpost", adr_vill AS "ville",sexe,datenaiss AS "datnaiss", prof AS "profession"
  FROM teste.clients
  WHERE length(trim(ncli)) = 7);
                            
INSERT INTO TELCLIENT (NCLI, NOM, PRENOM, VILLE, PROFESSION)
VALUES
( SELECT DISTINCT(code_pers) AS "ncli", nom_pers AS "nom", prenom_pers AS "prenom", adresse_ville AS "ville", profession
 FROM teste.personnes
 WHERE length(trim(code_pers)) = 7);

--5

select CLIENTS.NOM_CLI, CLIENTS.PRENOM_CLI
from CLIENTS
minus
select TELCLIENT.NOM_CLI, TELCLIENT.PRENOM_CLI
from TELCLIENT



insert into TELCLIENT
select concat(rtrim(c.NCLI, ' '), '1A'), c.NOM_CLI, c.PRENOM_CLI, c.CODEPOSTAL, c.ADR_VILL,
c.SEXE, c.DATENAISS, c.PROF
from CLIENTS c
where c.NOM_CLI = 'Manbu' or
c.NOM_CLI = 'Pasbienfaur' or
(c.NOM_CLI = 'Therieur' and c.PRENOM_CLI = 'Alex')	



--6
SELECT distinct t.NOM_CLI, t.PRENOM_CLI
FROM TELCLIENT t, COMMUNICATIONS c
WHERE upper(t.NCLI) = upper(c.NCLI);
				
							

--Question 7
CREATE TABLE CONSOTEL AS 
SELECT NCLI,NOTEL,DEBUT AS DATEHEURE,SUBSTR(NOAPPELE,1,6) AS NOAPPELE,(FIN-DEBUT*24*3600) AS DUREE,TYPAPPEL,PRIX
FROM communications;

DROP TABLE CONSOTEL;


--QUESTION 8

create table CONSOTEL_JOUR as 
select ncli, 
notel,
trunc(dateheure,'dd') as datejour ,  
sum(duree) as dureejour
, 
max(duree) as dureemaxi,
min(duree) as dureemini,
trunc(avg(duree) ) as dureemoyenne,
count(*) as nbappjour  
from consotel
group by ncli, notel, trunc(dateheure,'dd');

DROP TABLE CONSOTEL;
