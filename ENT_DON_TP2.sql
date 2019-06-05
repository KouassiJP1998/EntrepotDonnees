----- Question 1

SELECT t.NCLI, t.NOM_CLI,j.DUREEJOUR, j.NBAPPJOUR,j.DATEJOUR
FROM CONSOTEL_JOUR j, TELCLIENT t
WHERE j.NCLI = t.NCLI
and t.NOM_CLI='Versere'
AND j.DATEJOUR BETWEEN '01/09/2018' AND '15/09/2018'
GROUP BY t.NCLI,t.NOM_CLI,j.DUREEJOUR,j.NBAPPJOUR,j.DATEJOUR;

--CONSOTEL
SELECT t.NCLI,t.NOM_CLI,j.DATEHEURE, count(*) AS NBAPPEL_PAR_JOUR, SUM(DUREE)
FROM CONSOTEL j, TELCLIENT t
WHERE j.NCLI = t.NCLI
AND t.NOM_CLI='Versere'
AND j.DATEHEURE BETWEEN '01/09/2018' AND '15/09/2018'
group by t.NCLI,t.NOM_CLI,j.DATEHEURE;

----- Question 2
select substr(j.NOTEL, 1,2),NBAPPJOUR, DUREEMOYENNE, DUREEJOUR
from CONSOTEL_JOUR j
where substr(j.NOTEL, 1,2)='05'
GROUP BY substr(j.NOTEL, 1,2), NBAPPJOUR, DUREEMOYENNE, DUREEJOUR;

---CONSOTEL
select SUBSTR(notel,0,2),count(NCLI), avg(DUREE), sum(DUREE), c.NOTEL
from CONSOTEL c
where SUBSTR(notel,0,2) = '05'
group by SUBSTR(notel,0,2), trunc(DATEHEURE), c.NOTEL
order by trunc(DATEHEURE);




--  Question 3

SELECT DISTINCT t.nom_cli, j.datejour, dureemaxi
FROM  CONSOTEL_JOUR j, TELCLIENT T
WHERE j.NCLI=T.NCLI
AND j.dureemaxi=(select  max(t.dureemaxi)
                from  CONSOTEL_JOUR t
                where t.datejour=j.datejour
                group by datejour
)
order by datejour;


---- Constel
select t.NOM_CLI, trunc(c.DATEHEURE)
from CONSOTEL c, TELCLIENT t
where upper(c.NCLI) = upper(t.NCLI)
group by t.NOM_CLI, trunc(c.DATEHEURE) 
having sum(c.DUREE) = (select max(sum(c1.DUREE))
                        from CONSOTEL c1
                        where trunc(c1.DATEHEURE)=trunc(c.DATEHEURE)
                        group by NCLI, trunc(DATEHEURE))
order by trunc(DATEHEURE);

--  Question 4
---Consotel
SELECT TO_CHAR(DATEHEURE, 'DAY'), COUNT(NOAPPELE) ,SUM(DUREE)
FROM CONSOTEL
GROUP BY TO_CHAR(DATEHEURE, 'DAY') , TO_CHAR(DATEHEURE, 'D')
ORDER BY TO_CHAR(DATEHEURE, 'D');
---CONSOTEL_JOUR
SELECT TO_CHAR(DATEJOUR, 'DAY'), COUNT(NBAPPJOUR) ,SUM(DUREEMAXI)
FROM CONSOTEL_JOUR
GROUP BY TO_CHAR(DATEJOUR, 'DAY') , TO_CHAR(DATEJOUR, 'D')
ORDER BY TO_CHAR(DATEJOUR, 'D');

--  Question 5

SELECT DATEJOUR
FROM CONSOTEL_JOUR
WHERE (NBAPPJOUR < 6 OR DUREEJOUR< 350)
AND DATEJOUR BETWEEN to_date('01/09/18')
AND to_date('20/09/18');


---Constel
select NOTEL, count(NOTEL), trunc(DATEHEURE), sum(DUREE)
from CONSOTEL
where DATEHEURE BETWEEN to_date('01/09/18')
AND to_date('21/09/18')
group by NOTEL, trunc(DATEHEURE)
having count(NOTEL) < 6 or sum(DUREE) < 350;


