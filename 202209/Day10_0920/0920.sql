--SELECT COLUMNS FROM TABLE;

--Q1) ������̺��� ����� �̸��� ������ �������
SELECT ENAME, SAL
FROM SCOTT.EMP;

--Q2) ������̺��� ��ü �����͸� �������
SELECT *
FROM SCOTT.EMP;

--Q3) ������̺��� ����� ��ȣ, ����� �̸�, ������ �������
SELECT EMPNO, ENAME, SAL
FROM SCOTT.EMP;

--Q4) �μ����̺��� �μ��� �̸��� �μ���ȣ�� �������
SELECT DNAME, DEPTNO
FROM SCOTT.DEPT;

--Q5) ������̺��� ����� ��ȣ�� '���'�̶� ����ϰ� ����� �̸��� '�̸�'�̶� �������
--��Ī: �÷���Ī, ���̺��� ��Ī
--SELECT �÷Ÿ� ��Ī / SELECT �÷��� AS ��Ī / SELECT �÷��� AS "�� Ī"
SELECT EMPNO ���, ENAME �̸�
FROM SCOTT.EMP;

SELECT EMPNO AS ���, ENAME AS �̸�
FROM SCOTT.EMP;

SELECT EMPNO AS "�� ��", ENAME AS "�� ��"
FROM SCOTT.EMP;

--Q6) ���̺��� ��Ī�� ���� [�����: ���̺�鿡�� ������ �÷��� ������ ���, ������]
--6-1) ������̺��� ����� �μ����̺��� ��ü ������ ������� 56���� ���� ��µǴ� ����!
SELECT *
FROM SCOTT.EMP, SCOTT.DEPT; -- CROSS JOIN / ANSI QUERY
--6-2) ������̺��� ����� �μ����̺��� ���� �� ������̸��� �μ���ȣ�� ���
SELECT E.ENAME, D.DEPTNO
FROM SCOTT.EMP E, SCOTT.DEPT D; -- ���̺��� ������� ��Ī -> ���̺�� ��Ī
--6-3) ������̺��� ����� �μ����̺��� ���� �� ����� �̸��� �μ���ȣ�� ���
SELECT ENAME, "D".DEPTNO
FROM SCOTT.EMP, SCOTT.DEPT "D"; --double quotation�� ����

SELECT ENAME, D.DEPTNO
FROM SCOTT.EMP, SCOTT.DEPT "D"; --double quotation�� ����

SELECT ENAME, "��".DEPTNO
FROM SCOTT.EMP, SCOTT.DEPT "��"; --�ѱ۵� ����

--6-4) ������̺��� ����� �μ����̺��� ���� �� ����� �̸��� �μ���ȣ�� ���
SELECT ENAME, SCOTT.DEPT.DEPTNO    -- ���̺� ���
FROM SCOTT.EMP, SCOTT.DEPT;

--Q7) ����� ���̺��� ����� �̸��� ������ ����ϵ� ������ �������� �������
--�÷� + �÷�
SELECT ENAME, SAL*12 AS ����
FROM SCOTT.EMP;

--Q8) ����� ���̺��� ����� �̸��� ������ ����ϵ� "OO�� ������ OO�̴�" �������� ���
-- || (���Ṯ�ڿ�)
SELECT ENAME||'��' --DOUBLE QUOTATION�� ERROR
FROM SCOTT.EMP;

SELECT ENAME||'�� ������ '||SAL||'�̴�'
FROM SCOTT.EMP;

--Q9) SELECT COLUMN LIST FROM TABLE LIST WHERE ���ǹ�
--������̺��� ����� �̸��� JONES�� ���ڵ� ��ü�� ���
SELECT *
FROM SCOTT.EMP
WHERE ENAME = 'JONES';

--Q10) �μ����̺��� �μ���ȣ�� 10 �Ǵ� 20�� ���븸 ���
SELECT *
FROM SCOTT.DEPT
WHERE DEPTNO = 10 OR DEPTNO = 20;

--Q11) ������̺��� ����� �̸�, ����� ����, Ŀ�̼�, ���� + Ŀ�̼��� �����̶�� ���
SELECT ENAME, SAL, COMM, SAL+COMM AS ����
FROM SCOTT.EMP;

SELECT ENAME, SAL, NVL(COMM,0) AS COMM, SAL+NVL(COMM,0) AS ����
FROM SCOTT.EMP;
-- NULL
--1) NULL�� ���� ����(CMD������ ������ ����), 0�� ����
--2) NULL�� Ű����� null(�ҹ���)
--3) NULL�� �������� NULL
--4) NULL�� �ϳ��� ������ �������� �������� NULL
--5) ����ִ� �����ʹ� NULL

--Q12) ������̺��� �̸�, ����, Ŀ�̼�, ����+Ŀ�̼��� �����̶�� ���
--NULL�� VALUE�� ä���: nvl(�÷�, �ʱⰪ)
SELECT COMM, NVL(COMM,0)
FROM SCOTT.EMP;

--Q13) ������̺��� �̸�, Ŀ�̼��� ����ϵ� Ŀ�̼��� å������ �ʴ� ����� �������� ä���� ���
SELECT ENAME, COMM, NVL(COMM, SAL) AS COMM
FROM SCOTT.EMP;

--Q14) ����� �̸�, �Ŵ����� ����ϵ� ABCD��� ���� �߰� �÷����� �߰�����
SELECT ENAME, 'ABCD', MGR
FROM SCOTT.EMP;

--Q15) ����� �̸�(���), �Ŵ���(�Ŵ���)�� ���
SELECT ENAME||'(���)' AS ���, MGR||'(�Ŵ���)' AS �Ŵ���
FROM SCOTT.EMP;

--Q16) �ߺ� �� ����
--DISTINCT Ű���带 �÷��� �տ� �����Ͽ� �ߺ� �� ���� �� ���� �� ���
--���� �÷��� �ִ� ������ ���� �� �ѹ��� ���
--SELECT �ٷ� �ڿ� ���ȴ�
--DISTINCT ������ ���� ���� ����� �� �ִ�
SELECT JOB
FROM SCOTT.EMP;

--Q17) �μ�(DEPT)�� ����ϴ� ����(JOB)�� �ѹ����� ��ȸ
SELECT DISTINCT DEPTNO, JOB
FROM SCOTT.EMP;

--Q18) �ǻ翭(PSEUDO COLUMNS): ���̺�� �����ϰ� QUERY ������ ���ν� ������ �� �� ����.
--ROWNUM 
  --SELECT������ �˻��ϰ� �Ǹ� ROW ������ RETURN 
  --�˻��� ���� �Ϸù�ȣ
  --ORDER BY ���� ���� �ο��ȴ�
--ROWID
  --���̺� ���� Ư���� ���� ������ �� �ִ� ID
SELECT ROWNUM, ROWID, ENAME
FROM SCOTT.EMP;

--Q19) WHERE ���: �������� �Ŵ����� ��� ������ ���
/*
SELECT �÷�����Ʈ AS "�� Ī" -> "" Ÿ��Ʋ��, '' ������ VALUE
FROM ���̺���Ʈ ��Ī
WHERE ���ǽ�; -> �� �̸�, �񱳿�����, ���ǿ����� ������ ���ϰ��� TRUE�� �����͸� ����
             -> �񱳴��: ���, �� �̸�, �� ��� ������ �̷������
             -> ���, ��, ��, LIKE, IN, NOT, BETWEEN, IS NULL, IS NOT NULL, ANY, ALL ��
*/
SELECT * 
FROM SCOTT.EMP
WHERE JOB = 'MANAGER';

--Q20) �޿��� 3000�̻��� ����� ��ȣ, ����� �̸�, �޿��� ���
SELECT EMPNO, ENAME, SAL
FROM SCOTT.EMP
WHERE SAL >= 3000;

--Q21) �޿��� 1300�̻� 1700������ ��� �̸�, �޿��� ���
SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE SAL BETWEEN 1300 AND 1700;

SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE SAL >= 1300 AND SAL <= 1700;

--Q22) �޿��� 1300�̻� 1700���ϰ� �ƴ� ��� �̸�, �޿��� ���
SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE SAL NOT BETWEEN 1300 AND 1700;

SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE SAL < 1300 OR SAL > 1700;

--Q23) BETWWEN ����
SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE SAL BETWEEN 1700 AND 1300; --�տ��� �׻� ������!

--Q24) IN: ���� �� �߿� ��ġ�ϴ� �� RETURN
-- IN = ANY
-- NOT IN == ALL
-- �����ȣ�� 7902, 7788, 7566�� ����� �̸�, �����ȣ, �Ի����� ���
--TO_DATE, TO_CHAR, TO_NUM
SELECT ENAME, EMPNO, TO_CHAR(HIREDATE, 'YYYY"��" MM"��" DD"��" DAY')
FROM SCOTT.EMP
WHERE EMPNO IN (7902, 7788, 7566);

SELECT ENAME, EMPNO
FROM SCOTT.EMP 
WHERE EMPNO NOT IN (7902, 7788, 7588);

--Q25) LIKE
/*
������ ������ ���� �� ���
%: ������ ���� ���ڿ�(���� ����)
_: �ѱ���
ESCAPE: �˻��� ���ڿ� %, _ ���� ����
*/
-- ����� �̸��� S�� �����ϴ� ����� �̸�, �޿� ���
SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE ENAME LIKE 'S%';

--PLAYER_T ���̺��� �����̸��� _���ڰ� ����ִ� ������ ������ ���
/*
SELECT PNAME
FROM PLAYER_T
WHERE PNAME LIKE '%#_%' ESCAPE '#';
*/

--Q26) NULL ������̺��� Ŀ�̼��� å���� ��� ���
SELECT * 
FROM SCOTT.EMP
WHERE COMM IS NOT NULL;

SELECT *
FROM SCOTT.EMP
WHERE COMM IS NULL;

SELECT *
FROM SCOTT.EMP
WHERE COMM = NVL(COMM, 0);

/*
  �� �����ڴ� �� ������ ����� �����Ͽ� �ϳ��� ����� �����ϰų� ���� ������ ����� �����ϱ⵵ �Ѵ�.
  ������ ��ü�� ���� ��쿡�� ���� ��ȯ�ȴ�.
  1) WHERE �� ���� ���� ������ ������ �� ����Ѵ�.
  2) AND�� ��� ������ ����� TRUE���� ���õȴ�.
  3) OR�� �� ������ ����� TRUE�̸� ���õȴ�.
  4) NOT�� �ڵ����� ������ ����� FALSE�̸� ���õȴ�.
  5) �켱������ NOT, AND, OR ���̴�.
  6) (  ) �� ��� �켱 ���� ��Ģ���� �켱�Ѵ�.  
*/
  
--Q27) EMP ���̺��� �޿��� 2800 �̻��̰� 
--JOB�� MANAGER�� ����� �����ȣ, ����, ������, �޿�, �Ի�����, �μ���ȣ�� �������.
SELECT EMPNO, ENAME, JOB, SAL, TO_CHAR(HIREDATE, 'YYYY-MM-DD'), DEPTNO
FROM SCOTT.EMP
WHERE SAL >= 2800 AND JOB = 'MANAGER';

--Q28)EMP ���̺��� �޿��� 2800 �̻��̰ų�
--JOB�� MANAGER�� ����� �����ȣ, ����, ������, �޿�, �Ի�����, �μ���ȣ�� ����Ѵ�. 
SELECT EMPNO, ENAME, JOB, SAL, TO_CHAR(HIREDATE, 'YYYY-MM-DD'), DEPTNO
FROM SCOTT.EMP
WHERE SAL >= 2000 OR JOB = 'MANAGER';

--Q29)EMP ���̺��� JOB�� 'MANAGER', 'CLERK', 'ANALYST' �� �ƴ� 
--����� �����ȣ, ����, ������, �޿�, �μ���ȣ�� �������
SELECT EMPNO, ENAME, JOB, SAL, TO_CHAR(HIREDATE, 'YYYY"��" MM"��" DD"��"'), DEPTNO
FROM SCOTT.EMP
WHERE JOB NOT IN ('MANAGER', 'CLERK', 'ANALYST');

--Q30) ������ ���� / �Ի��� ������ �����ؼ� ����̸�, �޿�, �Ի�����, �μ���ȣ ���
/*
  SELECT
  FROM
  WEHRE
  ORDER BY ASC / DESC: ORDER BY�� SELECT������ �������� ����Ѵ� 
  ASC: ��������(DEFAULT)
  DESC: ��������
  NULL�� �������� ���Ľ� �������� ǥ�õȴ�
*/
SELECT ROWNUM, ROWID, ENAME, SAL, HIREDATE, DEPTNO
FROM SCOTT.EMP
ORDER BY HIREDATE ASC;

SELECT ROWNUM, ROWID, ENAME, SAL, HIREDATE, DEPTNO
FROM SCOTT.EMP
ORDER BY 3; --�̸������� ����(ENMAE�� 3��° ��ġ)

SELECT ROWNUM, ROWID, ENAME, SAL, HIREDATE, DEPTNO
FROM SCOTT.EMP
ORDER BY HIREDATE DESC;

SELECT ROWNUM, ROWID, ENAME, SAL, HIREDATE, DEPTNO
FROM SCOTT.EMP
ORDER BY SAL DESC;

--Q31) �μ����� ����ϴ� ������ �ѹ��� ��ȸ �� ���� �������� ����
SELECT DISTINCT DEPTNO, JOB
FROM SCOTT.EMP
ORDER BY JOB; 

SELECT DISTINCT JOB
FROM SCOTT.EMP
ORDER BY JOB;

--Q32) �Լ�: �����Լ�, �����Լ�, ��¥�Լ�, ��ȯ�Լ�, ��Ÿ�Լ�(������ �Լ�, �м��Լ�) ��
-- ���Ĺ��� ����

--Q33) ������̺��� SCOTT�� �����ȣ, �̸�, ������(�ҹ���)�� ����غ���
SELECT EMPNO, ENAME, LOWER(JOB)
FROM SCOTT.EMP
WHERE ENAME = 'SCOTT';

SELECT EMPNO, ENAME, LOWER(JOB)
FROM SCOTT.EMP
WHERE ENAME = UPPER('scott'); -- VALUE�� ��ҹ��ڸ� ����

SELECT EMPNO, INITCAP(LOWER(ENAME)) 
FROM SCOTT.EMP;

--Q34) ��� �̸��� ��ȣ�� �ϳ��� �÷��� �ۼ�(|| ������)
SELECT ENAME, EMPNO, CONCAT(ENAME, EMPNO) AS CONCAT
FROM SCOTT.EMP;


/*
  - LOWER(char): ���ڿ��� �ҹ��ڷ� 
- UPPER(char): ���ڿ��� �빮�ڷ� 
- INITCAP(char) ? �־��� ���ڿ��� ù ��° ���ڸ� �빮�ڷ� ������ ���ڴ� �ҹ��ڷ� ��ȯ���� �ش�.
- CONCAT(char1, char2) ? CONCAT �Լ��� Concatenation�� ���ڷ� �� ���ڸ� ����
- SUBSTR(s, m ,[n]): �κ� ���ڿ� ������ . m ��° �ڸ����� ���̰� n���� ���ڿ��� ��ȯ
    ? m�������� ��쿡�� �ڿ��� M��° ���ں��� �ݴ� �������� n���� ���ڸ� ��ȯ
- INSTR(s1, s2 , m, n): ���ڿ� �˻�, s1�� m��°���� s2 ���ڿ��� ��Ÿ���� n��° ������ s2�� ��ġ ��ȯ / ������ ���ڿ��� �߰ߵ��� ������ 0 �� ��ȯ�ȴ�

- LENGTH(s) ? ���ڿ��� ���̸� ����  
 -CHR(n) ? ASCII���� n�� �ش�Ǵ� ���ڸ� ����
- ASCII (s) ? �ش� ������ ASCII�� ����
- LPAD(s1,n,[s2]): ���ʿ� ���ڿ��� S2�� ���� ���� ����,
         n�� ��ȯ�Ǵ� ���ڿ��� ��ü ���̸� ��Ÿ����, S1�� ���ڿ��� n���� Ŭ ��� S1�� n�� ���ڿ� ��ŭ ��ȯ.
-RPAD(s1,n,[s2]): LPAD�͹ݴ�� �����ʿ� ���ڿ��� ���� ���� ����
 -LTRIM (s ,c) , RTRIM (s,c) ? ���ڿ� ���� c���ڿ� ���� , ���ڿ� ������ c���ڿ� ����
- TRIM ? Ư�� ���ڸ� ���� �Ѵ�.   ������ ���ڸ� �Է����� ������ �⺻������ ������ ���� �ȴ�.  ���� ���� ������Ÿ���� VARCHAR2 �̴�.
- REPLACE(s, from, to): s���� from ���ڿ��� �� ���ڸ� to���ڿ��� �� ���ڷ� ��ȯ�Ѵ�.
- TRANSLATE(s, from, to): s���� from ���ڿ��� �� ���ڸ� to���ڿ��� �� ���ڷ� ����
*/

--Q35) DEPT ���̺��� �÷��� ù ���ڵ鸸 �빮�ڷ� ��ȭ�Ͽ� ��� ������ ����Ͽ���. 
SELECT INITCAP(DEPTNO), INITCAP(DNAME), INITCAP(LOC)
FROM SCOTT.DEPT;

--Q36) EMP ���̺��� �̸��� ù���ڰ� 'K'���� ũ�� 'Y'���� ���� ����� �����ȣ, �̸�, ����, �޿�, �μ���ȣ�� ��ȸ�Ѵ�. 
--��, �̸������� �����Ͽ���. 
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM SCOTT.EMP
WHERE SUBSTR(ENAME, 1, 1) > 'K' AND SUBSTR(ENAME, 1, 1) < 'Y'
ORDER BY ENAME;

--Q37) EMP ���̺��� �μ��� 20���� ����� �����ȣ, �̸�, �̸��� �ڸ���, �޿�, �޿��� �ڸ����� ��ȸ�Ѵ�.LENGTH���
SELECT EMPNO, ENAME, LENGTH(ENAME), SAL, LENGTH(SAL), DEPTNO
FROM SCOTT.EMP
WHERE DEPTNO = 20;

SELECT LENGTH('��'), LENGTHB('��'), LENGTHB('A'), LENGTHB('����')
FROM DUAL;
--LENGTHB: Byte�� return(�ѱ��� 3bytes����)

--Q38) EMP ���̺��� �̸� �� 'L'���� ��ġ�� ��ȸ�Ѵ�.
--EX) ALLEN	2	2	3	0
SELECT ENAME, INSTR(ENAME, 'L') "0" , INSTR(ENAME, 'L', 1, 1) "1", INSTR(ENAME, 'L', 1, 2) "2", INSTR(ENAME, 'L', 4, 1) "3" 
FROM SCOTT.EMP;

--Q39) EMP ���̺��� 10�� �μ��� ����� ���Ͽ� ��� ���� �� ������ 'A'�� �����ϰ� �޿� �� ������ 1�� �����Ͽ� ����Ͽ���. 
--LTRIM ���
SELECT ENAME, LTRIM(JOB, 'A'), SAL, LTRIM(SAL, 1)
FROM SCOTT.EMP
WHERE DEPTNO = 10;

SELECT LTRIM('   ABC   ') AS LTRIM, RTRIM('   ABC   ') AS RTRIM, TRIM('   ABC   ') AS TRIM
FROM DUAL;

SELECT LENGTH(LTRIM('   ABC   ')) AS LTRIM, LENGTH(RTRIM('   ABC   ')) AS RTRIM, LENGTH(TRIM('   ABC   ')) AS TRIM
FROM DUAL;

SELECT LTRIM('ABC12345A', 'XABC')
FROM DUAL;

SELECT LTRIM('ABC12345', 'AB11C25')
FROM DUAL;

SELECT LTRIM('ABC12345', '7788A')
FROM DUAL;

--Q40) REPLACE�Լ��� ����Ͽ� ����̸��� SC���ڿ��� *?�� �����ؼ� ��ȸ. 
SELECT REPLACE(ENAME, 'SC', '*?')
FROM SCOTT.EMP;
--REPLACE �� ��°�� SC�� �־����

--Q41) TRANSLATE�Լ��� ����Ͽ� ����̸��� SC���ڿ��� *?�� �����ؼ� ��ȸ�Ѵ�
SELECT TRANSLATE(ENAME, 'SC', '*?')
FROM SCOTT.EMP;
--TRANSLATE�� 'S', 'C' �� '*', '?' �� ��Ī���Ѽ� ����
--��Ī ���ڿ��� ������ ����
SELECT REPLACE('S123C', 'SC', '*?'), REPLACE('S123SCS', 'SC', '*?')
FROM DUAL;

SELECT TRANSLATE('S123C', 'SC', '*?'), TRANSLATE('S123SCS', 'SC', '*?')
FROM DUAL;

SELECT REPLACE('S12 C', NULL, '*?')
FROM DUAL;

SELECT REPLACE('S12 C', ' ', '*?')
FROM DUAL;

--DESC: ���̺� ���� Ȯ��
DESC SCOTT.EMP;

/*
  �׷��Լ�: GROUP BY Ű����� �Բ� ���
  SELECT
  FROM
  WHERE
  GROUP BY
  HAVING
  ORDER BY
  
  ���� �� �Լ��� ���ǿ����� �� ���� HAVING�� ����Ѵ�.
*/

--Q42) ������̺��� �Ի��Ϸ� �����Լ��� ����غ���
SELECT MIN(HIREDATE), MAX(HIREDATE), MEDIAN(HIREDATE), COUNT(HIREDATE), COUNT(*)
FROM SCOTT.EMP;

--Q43) ������̺��� �޿��� MAX, MIN, MEDIAN, AVG, SUM ���ϱ�
SELECT MAX(SAL), MIN(SAL), MEDIAN(SAL), ROUND(AVG(SAL), 2), SUM(SAL)
FROM SCOTT.EMP;

--Q44) ������ �ο����� ����غ���
SELECT JOB, COUNT(JOB)
FROM SCOTT.EMP
GROUP BY JOB;

SELECT COUNT(*), COUNT(COMM), COUNT(ENAME)
FROM SCOTT.EMP; --NULL�� COUNT�� ����ȵ�

--Q45) ������̺��� �μ����� �޿��� MAX, MIN, MEDIAN, AVG, SUM ���ϱ�
SELECT DEPTNO, MAX(SAL), MIN(SAL), MEDIAN(SAL), ROUND(AVG(SAL), 0), SUM(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO;

--Q46) �� �μ����� �޿��� MAX, MIN, MEDIAN, AVG, SUM�� ������
--�� �޿��� ���� ���� ������ ����
SELECT DEPTNO, MAX(SAL), MIN(SAL), MEDIAN(SAL), ROUND(AVG(SAL), 0), SUM(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO
ORDER BY 6 DESC;

--Q47) ����, �μ��� �޿��� ���� ������
SELECT JOB, DEPTNO, SUM(SAL)
FROM SCOTT.EMP
GROUP BY JOB, DEPTNO;

--Q48) EMP ���̺��� �μ��ο��� 4���� ���� �μ��� �μ���ȣ, �ο���, �޿��� ��
SELECT DEPTNO �μ���ȣ, COUNT(*) �μ��ο���, SUM(SAL) �޿��հ�
FROM SCOTT.EMP
GROUP BY DEPTNO
HAVING COUNT(*) > 4;
/*
  WHERE�� ���� �Լ� ����
  HAVING�� ���� �Լ� ���Ŀ� ���͸� �۾��� �Ѵ�.
  HAVING�� �̿��� �����Լ� ����� �׷��� �����Ѵ�.
  �׷��� ����(���� �з�) -> �׷��Լ� ��� -> HAVING�� ���͸�
  HAVING���� �ݵ�� GROUP BY�� ������ �÷��̳� �����Լ� �񱳽� ���
*/
--Q49) ������̺��� �޿��� �ִ� 2900 �̻��� �μ��� ���ؼ� �μ���ȣ, ���, �޿��հ� ���ϱ�
SELECT DEPTNO, ROUND(AVG(SAL), 0), SUM(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO
HAVING MAX(SAL) >= 2900;

--Q50) ������ �޿��� ����� 3000�̻��� ������ ���ؼ� ��ձ޿�, �޿��հ� ���ϱ�
SELECT JOB, ROUND(AVG(SAL), 0), SUM(SAL)
FROM SCOTT.EMP
GROUP BY JOB
HAVING AVG(SAL) >= 3000;

--Q51) �μ��� ��� �޿� �� �ִ밪�� ��ȸ�غ���
SELECT ROUND(MAX(AVG(SAL)), 0)
FROM SCOTT.EMP
GROUP BY DEPTNO;

--Q52) SQL�� ���� ����!!!
/*
  FROM: JOIN�� ���ؼ� ���̺��� ����
  WHERE: �� ROW�� �о ������ �����ϴ� ��� ����
  GROUP BY: ���ϴ� ����� GROUPING
  HAVING: ������ �����ϴ� �׷��� RETURN
  ORDER BY: ���ǿ� ���� ����
  SELECT: ���ϴ� ����� PROJECTION�Ѵ�
*/

SELECT ENAME, TO_CHAR(SAL, 'FML999,999')
FROM SCOTT.EMP;
