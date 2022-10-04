/*
  ROUND: �ݿø� / TRUNC: ���� / MOD(M, N): ������ / ABS: ���밪
  FLOOR: �ش� �� ���� �۰ų� ���� ���� �� ���� ū �������� ����
  CEIL: �ش� �� ���� ũ�ų� ���� ���� �� ���� ���� �������� ����
  SIGN: ��ȣ / POWER(M, N): M�� N����
*/

--Q1) ROUND
SELECT ROUND(4567.678) 
FROM DUAL;

SELECT ROUND(4567.678, 0)
FROM DUAL;

SELECT ROUND(4567.678, 2)
FROM DUAL;

SELECT ROUND(4567.678, -2)
FROM DUAL;

--Q2) TRUNC
SELECT TRUNC(4567.678), TRUNC(4567.678, 0), TRUNC(4567.678, 2), TRUNC(4567.678, -2)
FROM DUAL;

--Q3) ������̺��� �޿��� 30���� ���� ������, �޿�, �̸� ���
SELECT E.ENAME, SAL, MOD(SAL, 30) RESULT
FROM SCOTT.EMP E;

--Q4) ��¥ �Լ��� ���� Ȯ��
SELECT VALUE
FROM NLS_SESSION_PARAMETERS
WHERE PARAMETER ='NLS_DATE_FORMAT';
--RR/MM/DD(00~49:2000���), DD/MON/RR(50~99: 1900���)
--NLS_SESSION_PARAMETERS: KEY, VALUE���� �ʱ� ������ ���̽��� FORMAT�� �����ϴ� TABLE
SELECT PARAMETER, VALUE 
FROM NLS_SESSION_PARAMETERS;

--7Bytes ���� ǥ�� / �ð�, ��¥���� ����� ����
--CENTURY, YEAR, MONTH, DAY, HOURS, MINUTES, SECONDS
/*
  2011�� 6�� 7�� ���� 3�� 15�� 47��
  CENTURY, YEAR, MONTH, DAY, HOURS, MINUTES, SECONDS
  20       11    06     07   3      15       47
*/

--Q5) ��¥ ������ ��������� �����ϴ�. 20�� �μ��� ����̸�, �Ի���, �Ի����� 3�� ���� ���
SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY"��" MM"��" DD"��" DAY') �Ի���, TO_CHAR(HIREDATE+3, 'YYYY"��" MM"��" DD"��" DAY') "�Ի���+3"
FROM SCOTT.EMP
WHERE DEPTNO = 20;

SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY"��" MM"��" DD"��" Dy') �Ի���, TO_CHAR(HIREDATE+3, 'YYYY"��" MM"��" DD"��" DAY') "�Ի���+3"
FROM SCOTT.EMP
WHERE DEPTNO = 20;

SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY"��" MM"��" DD"��" D')
FROM SCOTT.EMP;

--Q6) EXTRACT �Լ�: ���� ��¥ �� �⵵�� ��ȸ�ϰ� �ʹ�
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;
-- ��� ���̺��� ����� �̸�, �Ի����ڿ��� ���� ��ȸ
SELECT ENAME, EXTRACT(MONTH FROM HIREDATE)
FROM SCOTT.EMP;

--Q7) ������̺��� ����� ��������� �ٹ��ϼ��� ���� ��ĥ���� ��ȸ
/*
MONTHS_BETWEEN(D1, D2): D1�� D2���� ������ (���� ����)
ADD_MONTHS(D1, N): D1 + N 
NEXT_DAY(D1, 'CHAR'): D1���� ���� ��¥�� ������ ���Ͽ� �ش��ϴ� ��¥
LAST_DAY: �ش���� ������ ��¥�� ����
*/
SELECT MONTHS_BETWEEN (TO_DATE('02-02-1995','MM-DD-YYYY'), TO_DATE('01-01-1995','MM-DD-YYYY') )
FROM DUAL;

SELECT ENAME, HIREDATE, SYSDATE, TRUNC(SYSDATE-HIREDATE)||'��' AS "TOTAL DAYS", 
TRUNC((SYSDATE-HIREDATE) / 7)||'��' AS "TOTAL WEEKS", TRUNC(MOD((SYSDATE-HIREDATE), 7))||'��' AS "DAYS"  
FROM SCOTT.EMP
ORDER BY 4 DESC;

--Q8) ������̺��� 10�� �μ��� ������� ��������� �ٹ� ������ ����ؼ� ����
SELECT ENAME "�̸�", HIREDATE, SYSDATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS "�ٹ� ������",
TRUNC(MONTHS_BETWEEN(TO_DATE(SYSDATE,'RR-MM-DD'),TO_DATE(HIREDATE,'RR-MM-DD'))) AS "�ٹ� ������",
TRUNC(MONTHS_BETWEEN(TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD')),TO_DATE(TO_CHAR(HIREDATE,'YYYY-MM-DD')))) AS "�ٹ� ������",
DEPTNO "�μ���ȣ"
FROM SCOTT.EMP
WHERE DEPTNO = 10
ORDER BY 4;

SELECT TO_DATE('02-02-1995', 'MM-DD-YYYY')
FROM DUAL;

SELECT TO_DATE(HIREDATE, 'RR-MM-DD')
FROM SCOTT.EMP;

SELECT TO_DATE(HIREDATE, 'YYYY-MM-DD')
FROM SCOTT.EMP;

--Q9) ������̺��� 10�� �μ��� ������� �Ի��Ϸκ��� 5������ ���� �� ��¥�� ����ؼ� ���
SELECT ENAME, HIREDATE AS "�Ի���", ADD_MONTHS(HIREDATE, 5) AS "�Ի� 5���� ��", DEPTNO
FROM SCOTT.EMP
WHERE DEPTNO = 10;

--Q10) ������̺��� 10�� �μ� ������� �Ի��Ϸκ��� ���ƿ��� �ݿ����� ����ؼ� ����
SELECT ENAME, HIREDATE AS "�Ի���", NEXT_DAY(HIREDATE, '��') AS "���ƿ��� �ݿ���"
,NEXT_DAY(HIREDATE, 6) AS "���ƿ��� �ݿ���"
FROM SCOTT.EMP
WHERE DEPTNO = 10;

--Q11)  ���� ������ ���� ����� �˾ƺ���.
--��¥�� ����ϸ� �������� �𵨿� ���� �Լ��� �ݿø��ǰų� �������Ƿ� ��¥�� ���� ����� ���� �Ǵ� �޷� �ݿø��� �� �ִ�.
/*
ROUND : ���� �ݿø� �Ҷ� ������ ������ ������ ������ �����ϰ�, ���� ������ �׳� ������ �����Ѵ�. 
        �� : 15�� �̻��̸� ������ 1�� ��� / ���� ������  ���� �� 1�� ����
        �⵵: 6���� ������ ������ 1��1�� ���� / ���� ������ ���� 1�� 1�� ����
        
TRUNC : ���� �����ϸ� �׳� �������, ���� ���� �� �� 1�����, �⵵�� �����ϸ� �ݳ� 1��1�� ����          

*/
SELECT   TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') NORMAL, 
          TO_CHAR(TRUNC(SYSDATE), 'YY/MM/DD HH24:MI:SS') TRUNC, 
          TO_CHAR(ROUND(SYSDATE), 'YY/MM/DD HH24:MI:SS') ROUND 
FROM  DUAL;

SELECT TO_CHAR(HIREDATE, 'YY/MM/DD HH24:MI:SS') HIREDATE, 
TO_CHAR(ROUND(HIREDATE,'dd'), 'YY/MM/DD') ROUND_DD, 
TO_CHAR(ROUND(HIREDATE,'MM'), 'YY/MM/DD') ROUND_MM, 
TO_CHAR(ROUND(HIREDATE,'YY'), 'YY/MM/DD') ROUND_YY
FROM  SCOTT.EMP     
WHERE  ENAME='SCOTT';

SELECT TO_CHAR(TO_DATE('98','RR'),'YYYY') TEST1, 
TO_CHAR(TO_DATE('05','RR'),'YYYY') TEST2, 
TO_CHAR(TO_DATE('98','YY'),'YYYY') TEST3, 
TO_CHAR(TO_DATE('05','YY'),'YYYY') TEST4 
FROM  DUAL;

SELECT '000123', TO_NUMBER('000123') FROM DUAL;

--Q12)  ���� ������ ���� ����� �˾ƺ���. ORACLE ���� FUNCTION
SELECT TO_TIMESTAMP_TZ('2004-8-20 1:30:00 -3:00', 'YYYY-MM-DD HH:MI:SS TZH:TZM')
FROM DUAL;-- CHAR, VARCHAR2 ������ Ÿ���� TIMESTAMP WITH TIME ZONE ������ Ÿ������ ����  

SELECT TO_TIMESTAMP('2004-8-20 1:30:00', 'YYYY-MM-DD HH:MI:SS') 
FROM DUAL;-- CHAR, VARCHAR2 ������ Ÿ���� TIMESTAMP ������ Ÿ������ ���� 

SELECT SYSDATE, SYSDATE+TO_YMINTERVAL('01-03') "15Months later" 
FROM  DUAL;  ---- CHAR, VARCHAR2 ������ Ÿ���� INTERVAL YEAR TO MONTH ������ Ÿ������ ���� 
--01: 1yr / 03: 3months

SELECT  SYSDATE, SYSDATE+TO_DSINTERVAL('003 17:00:00') AS "3days 17hours later" 
FROM DUAL; ---- CHAR, VARCHAR2 ������ Ÿ���� INTERVAL DAY TO SECOND ������ Ÿ������ ���� 

--Q13) ���� ������ ���� ����� �˾ƺ���.
--EMP ���̺��� ����̸�, �Ŵ��� ��ȣ, �Ŵ�����ȣ�� null�̸� ����ǥ�� �� ǥ���ϰ�, �Ŵ�����ȣ�� ������ '����'���� ǥ��. 
SELECT ENAME, MGR, NVL2(MGR, MGR||'����','��ǥ') 
FROM SCOTT.EMP;

--Q14) EMP ���̺��� ����̸� , ����, ������ 'CLERK�� �� ��� NULL�� �������� ����.
SELECT ENAME, JOB, NULLIF(JOB,'CLERK') AS RESULT 
FROM SCOTT.EMP;

--Q15)EMP���̺��� �̸�, ���ʽ�, �޿�, ���ʽ��� null �ƴ� ��� ���ʽ���, ���ʽ��� null�� ��쿣 �޿���
--COALESCE(COL1, COL2, COL3,,,,) NULL�� �ƴ� COL�� ������ �� ���� ��ȯ
--��� null�� ��쿣 50���� ����.
SELECT ENAME, COMM, SAL, COALESCE(COMM,SAL,50) RESULT 
FROM SCOTT.EMP;

--Q16) DECODE �Լ��� �̿��Ͽ� �޿��� 1000���� ������ ��A��, 1000�̻� 2500�̸��̸� ��B��, 2500�̻��̸� ��C���� ǥ���϶�.
SELECT ENAME, SAL, DECODE(SIGN(SAL-1000),-1,'A', DECODE(SIGN(SAL-2500),-1,'B','C')) GRADE 
FROM SCOTT.EMP;

--Q17) CASE �Լ��� �̿��Ͽ� �޿��� 1000���� ������ ��A��, 1000�̻� 2500�̸��̸� ��B��, 2500�̻��̸� ��C���� ǥ���϶�. 
SELECT ENAME,SAL, 
        CASE WHEN SAL < 1000 THEN 'A' 
             WHEN SAL >= 1000 AND SAL < 2500 THEN 'B' 
             ELSE 'C' END AS GRADE 
FROM SCOTT.EMP ORDER BY GRADE;

--Q18) ROLLUP, CUBE: GROUPING�� ����� ��ȣ �������� ���� ���� ���踦 ���� �۾�
/*
  ROLLUP
  ���� �׷�ȭ ��, ���� ������ �����ؼ� ����� ����
  ������ ���� �ۼ�, ���տ��� ��� �� ��������� �����ϴµ� ���
  GROUP BY ���� ()�� �̿��ؼ� ������ �� ����� ���� �����ʿ��� ���� �������� �ϳ��� �׷��� �����
  �� ���� GROUP �Լ��� ������ GROUP�� ����
  �Ѱ踦 �����Ϸ��� N+1 ���� SELECT���� UNION ALL�� �����Ѵ�
  
  CUBE
  ROLLUP ����� ���� ��ǥȭ�ؼ� ���� �����ϴ� ��� ������ ����
  GROUP BY Ȯ�� ���
  ���� �Լ��� ����ϰ� �Ǹ� ������տ� �߰� ���� ���������
  GROUP BY ���� N���� ���� ���� ��� ���� ���� ���ռ��� 2�� N���� ���̴�
*/
--��� ���̺��� �μ����� �޿��� ���� ��ȸ�� ROLLUP���� ���踦 ������
SELECT DEPTNO, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY ROLLUP(DEPTNO);

SELECT DEPTNO, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

--Q19) ��� ���̺��� �μ���, ������ �޿��� �� ��ȸ�� ROLLUP ���踦 ������
SELECT DEPTNO, JOB, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY ROLLUP(DEPTNO, JOB);

SELECT DEPTNO, JOB, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY ROLLUP((DEPTNO, JOB));

SELECT DEPTNO, JOB, SUM(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO, ROLLUP(JOB);

SELECT DEPTNO, JOB, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY ROLLUP(JOB, DEPTNO);

SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM SCOTT.EMP
GROUP BY ROLLUP(DEPTNO, JOB, MGR);

--Q20) ��� ���̺��� �μ���, ������ �޿��� �� ��ȸ�� CUBE ���踦 ������
SELECT DEPTNO, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY CUBE(DEPTNO);

SELECT DEPTNO, JOB, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY CUBE(DEPTNO, JOB);

SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM SCOTT.EMP
GROUP BY CUBE(DEPTNO, JOB, MGR); --> 2^3���� �׷�ȭ�� ���

--Q21) GROUPING �Լ��� ROLLUP, CUBE�� �Բ� ����Ѵ�.
/*
  �ϳ��� ���� �μ��� ���´�
  �μ��� GROUP BY ���� �÷��� ���ƾ� �Ѵ�
  0 �Ǵ� 1�� ��ȯ�Ѵ�
  0�� ���: �ش� ���� �״�� ����Ͽ� ���� ���� ��� �߰ų� �ش� ���� ������ NULL���� ����� ���� �ǹ�
  1�� ���: �ش� ���� ������� �ʰ� ���� ���� ��� �߰ų� NULL���� �׷�ȭ�� �����
           ROLLUP, CUBE�� ���� ������ ������ ���� �ǹ��Ѵ�.
  SELECT�� �ڿ� �����Ѵ�
  �࿡�� ���� �Ѱ踦 ������ �׷��� ã�� �� �ִ�
*/
SELECT DEPTNO, JOB, SUM(SAL), GROUPING(DEPTNO), GROUPING(JOB)
FROM SCOTT.EMP
GROUP BY ROLLUP(DEPTNO, JOB);

SELECT DEPTNO, JOB, SUM(SAL), GROUPING(DEPTNO), GROUPING(JOB)
FROM SCOTT.EMP
GROUP BY CUBE(DEPTNO, JOB);

--Q22) GROUPING SETS
--GROUP BY �ڿ� ����Ǵ� �Լ� / �������� �׷�ȭ �� �� �ִ�
--(DEPTNO, JOB, MGR) (DEPTNO, MGR) (JOB, MGR) �̷� ������ 
--CASE1) �׷� ������ UNION ALL
SELECT DEPTNO, JOB, MGR, AVG(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO, JOB, MGR
UNION ALL
SELECT DEPTNO, NULL, MGR, AVG(SAL) --NULL�� COLUMN�� ���߱�
FROM SCOTT.EMP
GROUP BY DEPTNO, MGR
UNION ALL
SELECT NULL, JOB, MGR, AVG(SAL)
FROM SCOTT.EMP
GROUP BY JOB, MGR;

--CASE2) GROUPING SETS
SELECT DEPTNO, JOB, MGR, AVG(SAL)
FROM SCOTT.EMP
GROUP BY GROUPING SETS((DEPTNO, JOB, MGR), (DEPTNO, MGR), (JOB, MGR));

--Q23) ���տ�
SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM SCOTT.EMP
GROUP BY ROLLUP(DEPTNO, (JOB, MGR));

/*
1) GROUP BY GROUPING SETS(A, B, C) = GROUP BY A UNION ALL
                                     GROUP BY B UNION ALL
                                     GROUP BY C 
                                     
2) GROUP BY GROUPING SETS(A, B, (B,C)) = GROUP BY A UNION ALL
                                         GROUP BY B UNION ALL
                                         GROUP BY B, C
                                         
3) GROUP BY GROUPING SETS((A, B, C)) = GROUP BY A, B, C

4) GROUP BY GROUPING SETS(A, (B), ()) = GROUP BY A UNION ALL
                                        GROUP BY B UNION ALL
                                        GROUP BY ()
*/

--Q24) �м� �Լ� MAX, MIN, COUNT, LAG, LEAD, RANK
--              RATIO_TO_REPORT, ROW_NUMBER, SUM, AVG ��
/*
  ARGS: 0~3�������� �� �� �ִ�
  [����] ���̺��� ������� ������� GROUPING�ؼ� ������ ���� �м��Լ��� ����� RETURN
        [���̺� -> ���� �� -> GROUPING -> ���� -> ���� ����]
  SELECT 
        �м��Լ�(ARGS) OVER (
        [PARTITION_BY_CLAUSE] ���� ����� �׷����� ���´�
        [ORDER_BY_CLAUSE] ������ ���� ������ �׷쿡 ���� ����(���� �˻� ����) 
                   ASC/DESC/NULL/FIRST/LAST
                   EX) DESC NULL FIRST, ASC NULL LAST
        [WINDOWING_CLAUSE] ROWS/RANGE(BETWEEN AND)
                            )
  FROM ���̺��;
  
*/
-- �����ȣ, �̸�, �μ���ȣ, �޿�, �μ������� �޿��� ���� ������� ������ �������
SELECT EMPNO, ENAME, DEPTNO, SAL,
       RANK() OVER (PARTITION BY DEPTNO
                    ORDER BY SAL DESC) "�μ��� �޿� ����"
FROM SCOTT.EMP;

SELECT EMPNO, ENAME, DEPTNO, SAL,
      DENSE_RANK() OVER (PARTITION BY DEPTNO
                   ORDER BY SAL DESC) "�μ��� �޿� ����"
FROM SCOTT.EMP;

--Q25) CUME_DIST(): ������ �л������� ���
-- 20�� ����� �̸�, �޿�, �����л��� ����غ���
SELECT EMPNO, ENAME, DEPTNO, SAL,
      CUME_DIST() OVER (ORDER BY SAL)
FROM SCOTT.EMP
WHERE DEPTNO = 20;

--Q26) NTILE(N) 
-- ����� �޿��� �������� 4���
SELECT EMPNO, ENAME, DEPTNO, SAL,
       NTILE(4) OVER (ORDER BY SAL)
FROM SCOTT.EMP;

--Q27) ����̸�, �μ���ȣ, �޿�, ��ü �޿� �հ�, �μ��� �޿� �հ踦 ���
SELECT ENAME, DEPTNO, SAL,
      SUM(SAL) OVER () "TOTAL_SUM",
      SUM(SAL) OVER (PARTITION BY DEPTNO) "DEPT_SUM"
FROM SCOTT.EMP;

--ORDER BY SAL�� �ָ� �����հ踦 �����ش�
SELECT ENAME, DEPTNO, SAL,
      SUM(SAL) OVER () "TOTAL_SUM",
      SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL) "DEPT_SUM"
FROM SCOTT.EMP;

--Q28) ����̸�, ����, �޿�, ������ ��� �޿�, �����߿� �ִ�޿�
SELECT ENAME, JOB, SAL, 
      ROUND(AVG(SAL) OVER (PARTITION BY JOB)) "SAL_AVG BY JOB",
      MAX(SAL) OVER (PARTITION BY JOB) "MAX_SAL BY JOB"
FROM SCOTT.EMP;

--ORDER BY SAL�� �ָ� ���� ����� �ش�
SELECT ENAME, JOB, SAL, 
      ROUND(AVG(SAL) OVER (PARTITION BY JOB ORDER BY SAL)) "SAL_AVG BY JOB",
      MAX(SAL) OVER (PARTITION BY JOB) "MAX_SAL BY JOB"
FROM SCOTT.EMP;

--Q29) ����̸�, �μ���ȣ, �޿��� �հ踦 3�پ� ���� ���, �����հ踦 ���
SELECT ENAME, DEPTNO, SAL,
      SUM(SAL) OVER (ORDER BY SAL ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) "SUM1",
      SUM(SAL) OVER (ORDER BY SAL ROWS UNBOUNDED PRECEDING) "SUM2" 
FROM SCOTT.EMP;

--Q30) RATIO_TO_REPORT�� �̿��ؼ� �ش� ������ �����ϴ� ������ RETURN
--����� ��ü �޿��� 50000������ �ϰ� ���� ������ �������� ��� �� ����� ����
SELECT ENAME, SAL, ROUND(RATIO_TO_REPORT(SAL) OVER (),2) AS "����",
       ROUND(50000 * (RATIO_TO_REPORT(SAL) OVER ())) AS "��ü �޿� 50000��"
FROM SCOTT.EMP;

--Q31) LAG: GROUPING ������ ����� ROW�� ����
-- ���� ��(������ ��ġ��)�� ���� RETURN
-- LAG(SAL, 2, 0): 2�྿ �Ѱܼ� ����
SELECT ENAME, DEPTNO, SAL, LAG(SAL, 1, 0) OVER (ORDER BY SAL) "NEXT_SAL",
       LAG(SAL, 1, SAL) OVER (ORDER BY SAL) "NEXT_SAL02",
       LAG(SAL, 1, SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL) "NEXT_SAL03"
FROM SCOTT.EMP;

--Q32) LEAD: GROUPING ������ ����� ROW�� ����
-- ���� ��(������ ��ġ��)�� ���� RETURN
SELECT ENAME, DEPTNO, SAL, LEAD(SAL, 1, 0) OVER (ORDER BY SAL) "NEXT_SAL",
       LEAD(SAL, 1, SAL) OVER (ORDER BY SAL) "NEXT_SAL02",
       LEAD(SAL, 1, SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL) "NEXT_SAL03"
FROM SCOTT.EMP;







