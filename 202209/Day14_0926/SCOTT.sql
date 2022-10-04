--SubQuery
-- 1) �������� ���������� �����Ǵ� �ϳ��� �������� ���� ���������� ����ǰ� ����� ���ؼ� ������ ������ ����ȴ�
-- 2) SELECT, FROM, WHERE, GROUP BY, ORDER BY, UPDATE, DELETE, HAVING, INSERT INTO ������ ����Ѵ�
-- 3) ()�� ��� ����Ѵ�. / �������� �����ʿ� ����ȴ� / �Ϲ������� ORDER BY���� ������� �ʴ´�
-- 4) ���������� ����� ������, ���������� ������
-- 5) ������ ������(> , >=, != ��) ������ ������(IN, NOT IN, ANY, ALL ��)

--Q1) JONES���� �޿��� ���� �޴� ����� �̸��� �޿��� �������
SELECT SAL
FROM EMP
WHERE ENAME = 'JONES';

SELECT ENAME, SAL
FROM EMP
WHERE SAL > 2975;

SELECT ENAME, SAL   -- �⺻ ���� / �⺻ ���� / ������ / �ܺ�����
FROM EMP
WHERE SAL > (SELECT SAL   -- �������� / ������
             FROM EMP
             WHERE ENAME = 'JONES');

--Q2) ��� ��ȣ�� 7839�� ����� ���� ������ ���� ������� �̸��� ������ �������
SELECT ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB
             FROM EMP
             WHERE EMPNO = 7839);

--Q3) 7566 ������� �޿��� ���� �޴� ����� �̸�, �޿��� ����غ���
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
             FROM EMP
             WHERE EMPNO = 7566);

--Q4) ����� �޿��� ��պ��� ���� ����� �����ȣ, �̸�, ����, �μ���ȣ ���
SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE SAL < (SELECT AVG(SAL)
             FROM EMP);

--Q5) �����ȣ�� 7521�� ����� ������ ���� �޿��� 7934�� ������� ���� ����� �̸�, ����, �Ի���, �޿� ���
SELECT ENAME, JOB, HIREDATE, SAL
FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO = 7521) AND SAL > (SELECT SAL FROM EMP WHERE EMPNO = 7934);

--Q6) ��ձ޿��� ���� ���� ������ ���
SELECT JOB, AVG(SAL)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) = (SELECT MIN(AVG(SAL))
                   FROM EMP
                   GROUP BY JOB);

--Q7) ����� �޿��� 20�� �μ���ȣ�� �ּ� �޿����� ���� �μ���ȣ
SELECT DEPTNO, MIN(SAL)
FROM EMP 
GROUP BY DEPTNO
HAVING MIN(SAL) > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 20);

--Q8) �μ��� �ּ� �޿��� ���� �޿��� �޴� ����� �μ���ȣ�� �̸� ���
SELECT DEPTNO, ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO); 

SELECT DEPTNO, ENAME, SAL
FROM EMP
WHERE SAL = ANY(SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);

SELECT DEPTNO, MIN(SAL) FROM EMP GROUP BY DEPTNO;

-- ���� �� (Multiple-Row) �������� ? �ϳ� �̻��� ���� ���� �ϴ� ���������� ���� �� ����������� �Ѵ�.
-- ���� �� ������(IN, ANY, ALL)�� ����Ѵ�. 
-- IN: ��Ͽ� �ִ� ������ ���� �����ϸ� ��  
-- ANY: ������������ ���ϵ� ������ ���� ���Ͽ� �ϳ��� ���̸� �� ( "=ANY"�� "IN"�� ����) 
--       EX) < ANY  = �ִ밪���� ����, > ANY �ּҰ����� ŭ
-- ALL: ������������ ���ϵ� ��� ���� ���Ͽ� ��� ���̾�� ��
--       EX) < ALL = �ּҰ����� ����, > ALL �ִ밪 ���� ŭ
-- NOT �����ڴ� IN, ANY, ALL �����ڿ� �Բ� ���� �� �ִ�.

--Q9) ������ SALESMAN�� ����� �ּ� �޿����� �޿��� ���� �޴� ����� �̸�, �޿�, ������ ���
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL > ANY(SELECT SAL
                FROM EMP
                WHERE JOB = 'SALESMAN');

--Q10) FORD, BLAKE�� �Ŵ��� �� �μ���ȣ�� ���� ����� ������ ���
SELECT ENAME, MGR, DEPTNO
FROM EMP
WHERE (MGR, DEPTNO) IN (SELECT MGR, DEPTNO FROM EMP WHERE ENAME IN ('FORD', 'BLAKE'));
                        
--Q11) �Ҽӵ� �μ���ȣ�� ��� �޿����� ���� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ, �Ի���, ���� ���
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 10;  

SELECT ENAME, SAL, DEPTNO, HIREDATE, JOB
FROM EMP E
WHERE SAL > (SELECT AVG(SAL)
             FROM EMP
             WHERE DEPTNO = E.DEPTNO);
             -- E.DEPTNO: ������ ���̺��� �÷��� �������� �� ��Ī�� ���!!!!!
             
-- ��ȣ ����(CORRELATED) ��������: ���� ���� �� �������� �ִ� ���̺��� ���� �����ϴ� ���� ���Ѵ�
-- 1) �� ������ �ϳ��� ROW���� ���������� �ѹ��� ����ȴ�
-- 2) ���̺��� ���� ���� �о �� ���� ���� ���õ� �����Ϳ� ���Ѵ�
-- 3) �� �������� �� ���������� �࿡ ���� �ٸ� ����� ������ �� ����Ѵ�
-- 4) �� ���� ���� ���� ������ �޶����� ���� ������ ���� ���Ϲ��� �� ����Ѵ�
-- 5) ������������ ���� ���� �÷����� ����� �� ������ ���ο����� ���������� �÷����� ����� �� ����

--Q12) �ζ��� ��(INLINE VIEW): FROM ���� �������� Q11)���
SELECT E.ENAME, E.DEPTNO, E.JOB
FROM (SELECT ENAME, JOB, DEPTNO
      FROM EMP
      WHERE JOB = 'MANAGER') E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.ENAME, E.SAL, E.DEPTNO, E.HIREDATE, E.JOB, D.AVGSAL
FROM EMP E, (SELECT DEPTNO, AVG(SAL) AVGSAL FROM EMP E GROUP BY DEPTNO) D
WHERE E.DEPTNO = D.DEPTNO AND E.SAL > D.AVGSAL;

--��Į��(Scalar) ��������
--�ϳ��� �࿡�� �ϳ��� �� ���� �����ϴ� ���� ������ ��Į�� ����������� �Ѵ�
--��Į�� ���� ������ ���� ���� ������ SELECT ��Ͽ� �ִ� �׸� ���̴�
--���������� 0���� ���� �����ϸ� ��Į�� ���������� ���� NULL�̴�
--���������� 2�� �̻��� ���� �����ϸ� ������ ���ϵȴ�
--SELECT(GROUP BY�� ����), INSERT�� VALUES ���, DECODE�� CASE���ǹ�, UPDATE SET��

--Q13) �����ȣ, �̸�, �μ���ȣ, ����� ���� �μ��� ��� �޿��� ���
SELECT EMPNO, ENAME, DEPTNO, SAL, 
       ROUND((SELECT AVG(SAL)
       FROM EMP
       WHERE DEPTNO = E.DEPTNO)) AS M_SAL
FROM EMP E;

--Q14) �����ȣ, �̸�, �μ���ȣ, ����� ���� �μ��� ��� �޿��� �����ؼ� ���
SELECT EMPNO, ENAME, DEPTNO, SAL
FROM EMP E
ORDER BY (SELECT DNAME
          FROM DEPT
          WHERE DEPTNO = E.DEPTNO);

--Q15) 
SELECT E.EMPNO, E.ENAME, E.DEPTNO, E.SAL, D.DNAME,
       ROUND((SELECT AVG(SAL) FROM EMP WHERE DEPTNO = E.DEPTNO)) AS M_SAL
FROM EMP E, DEPT D
ORDER BY D.DNAME;

--Q16) EXISTS ������
-- ������ �� ����� �̸�, ����, �Ի���, �޿��� ���
SELECT EMPNO, ENAME, JOB, HIREDATE, MGR, SAL
FROM EMP E
WHERE EXISTS (SELECT 1
              FROM EMP
              WHERE E.EMPNO = MGR)
ORDER BY EMPNO;
              
-- ������ ����
SELECT EMPNO, ENAME, JOB, HIREDATE, MGR, SAL
FROM EMP E
WHERE NOT EXISTS (SELECT 1
                  FROM EMP
                  WHERE E.EMPNO = MGR)
ORDER BY EMPNO;
              
-- Join
-- ���� ���̺��� �����Ͱ� �ʿ��� ��� ���
-- ������ ������ ���̽����� �⺻
-- ���� ���̺��� �ٸ� ���̺� �ִ� ROW�� ã�� ���� ��
-- ORACLE JOIN: EQUI, NON-EQUI, SELF, OUTER
-- ANSI JOIN: CROSS, NATURAL, INNER, OUTER

--Q1) INNER JOIN�� �غ���
-- SALESMAN�� �����ȣ, �̸�, �޿�, �μ���, �ٹ����� ���
--ORACLE JOIN
SELECT EMPNO, ENAME, SAL, DNAME, LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;  -- ORACLE �� JOIN
              
--ANSI JOIN: �ΰ��� ���̺� ������ �÷��� ������ ���� USING(�÷���)
--         / �ٸ� �÷��� ���� ������ ���� ON(�÷�A = �÷�B)
SELECT EMPNO, ENAME, SAL, DNAME, LOC
FROM EMP JOIN DEPT USING(DEPTNO);

SELECT EMPNO, ENAME, SAL, DNAME, LOC
FROM EMP INNER JOIN DEPT USING(DEPTNO);

/* 
  JOIN = INNER JOIN = �ΰ��� ���̺��� TRUE ���� ���, FALSE, NULL�� ������� �ʴ´�
*/

-- SAMPLE
CREATE TABLE M(
  M1 VARCHAR(10),
  M2 VARCHAR(10));

INSERT INTO M VALUES('A', '1');
INSERT INTO M VALUES('B', '1');
INSERT INTO M VALUES('C', '3');
INSERT INTO M VALUES(NULL, '3');

DELETE M;

CREATE TABLE S(
  S1 VARCHAR2(10),
  S2 VARCHAR2(10));

INSERT INTO S VALUES('A', 'X');
INSERT INTO S VALUES('B', 'Y');
INSERT INTO S VALUES('NULL', 'Z');

CREATE TABLE X(
  X1 VARCHAR2(10),
  X2 VARCHAR2(10));

INSERT INTO X VALUES('A', 'DATA');

SELECT * FROM M;
SELECT * FROM S;
SELECT * FROM X;

--Q2) M, S �� ���̺��� M1, S1�÷��� �����غ���
--ORACLE JOIN
SELECT *
FROM M, S
WHERE M1 = S1;

--ANSI JOIN
SELECT * 
FROM M JOIN S ON(M1 = S1);


