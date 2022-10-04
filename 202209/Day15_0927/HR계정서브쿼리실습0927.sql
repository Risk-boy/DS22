--[��������(SubQuery]
--: �ϳ��� ������ �ٸ� ������ ���ԵǴ� ����,()��ó��
--1) ������ ��������(�������ȯ) :  > , < , >=, <= , <>
--     Main Query
--               
--           Sub  Query      ----->   1 �����
--
--2) ������ ��������(�������ȯ) : in, any, all
--     Main Query
--     
--          Sub Query      ----->   �������� ���  
--      
--       < any : �񱳴���� �ִ밪���� ����
--       > any : �񱳴���� �ּҰ����� ŭ   
--                  (ex. ���������� �޿��� �޴� �����ȸ)
--       =  any : in�����ڿ� ����
--       <  all   : �񱳴���� �ּҰ����� ����
--       >  all   : �񱳴���� �ִ밪���� ŭ 
--                  (ex. ��������� ���޺��� �޿��� ���� �����ȸ)
--
--3) �������(correlated  subquery)   
--  : ������������ ����� �� �ĺ� ��鿡 ���� ���������� �ٸ� ����� ��ȯ�ؾ��ϴ°��
--    (������������ ó���Ǵ� �� ����� ���� ���� ������ �޶������ϴ� ���)�� �����ϴ�
--      exists,  not exists : ���� ���ο� ���� true,false�� ��ȯ\

--ex01) Neena����� �μ����� �˾Ƴ��ÿ�
SELECT DEPARTMENT_ID  FROM EMPLOYEES  WHERE FIRST_NAME='Neena';
SELECT DEPARTMENT_NAME  FROM DEPARTMENTS  WHERE DEPARTMENT_ID=90;

SELECT DEPARTMENT_NAME 
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID  
                       FROM EMPLOYEES  
                       WHERE FIRST_NAME='Neena');

--ex02) Neena����� �μ����� Neena������� �޿��� ���� �޴� ������� ���Ͻÿ�
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID 
                     FROM EMPLOYEES
                     WHERE FIRST_NAME='Neena')
AND  SALARY > (SELECT SALARY
               FROM EMPLOYEES
               WHERE FIRST_NAME='Neena');

--ex03) �μ��� �޿��հ��� �ִ�޿��� �޴� �μ��� �μ���� �޿��հ踦 ���Ͻÿ�
SELECT DEPARTMENT_NAME, SUM(SALARY)
FROM EMPLOYEES
JOIN DEPARTMENTS USING(DEPARTMENT_ID)
GROUP BY DEPARTMENT_NAME
HAVING SUM(SALARY)=(SELECT MAX(SUM(SALARY))
                    FROM EMPLOYEES
                    GROUP BY DEPARTMENT_ID);

--ex04) �����޿��� �޴� ������� �̸��� �޿��� ���Ͻÿ�
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEES);

--ex05) Austin�� �����μ��̸鼭 ���� �޿��� �޴»������
--      �̸�, �μ���, �޿��� ���Ͻÿ�(60�μ�,4800�޷�)
SELECT LAST_NAME, DEPARTMENT_NAME, SALARY
FROM EMPLOYEES
LEFT JOIN DEPARTMENTS USING(DEPARTMENT_ID)
WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID
                     FROM EMPLOYEES
                     WHERE LAST_NAME='Austin')
AND SALARY=(SELECT SALARY
            FROM EMPLOYEES
            WHERE LAST_NAME='Austin');
            
            
--ex06) 'IT_PROG' ������ �ּұ޿����� �޿��� ���� 'ST_MAN'���� �������� ��ȸ�Ͻÿ�
SELECT LAST_NAME,JOB_ID,SALARY
FROM EMPLOYEES
WHERE JOB_ID='ST_MAN'
AND SALARY > ANY(SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG');

--ex07) 'IT_PROG' ������ ���帹�� �޴� ����� �޿�����,�� �����޿��� �޴�
--      'FI_ACCOUNT' �Ǵ� 'SA_REP' ���� �������� ��ȸ�Ͻÿ�
--      ����1) �޿������� �������������Ͻÿ�
--      ����2) �޿��� ���ڸ����� �޸�(,) ��� ȭ����� '��'�� ���̽ÿ�
--      ����3) Ÿ��Ʋ��  �����, ����ID, �޿��� ǥ���Ͻÿ�
SELECT LAST_NAME AS �����, JOB_ID AS  ����ID,
       TO_CHAR(SALARY,'99,999,999')||'��' AS �޿�
FROM EMPLOYEES
WHERE (JOB_ID='FI_ACCOUNT' OR JOB_ID='SA_REP')
AND SALARY>ALL(SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG')
ORDER BY SALARY DESC;

--ex08) 'IT_PROG'�� ���� �޿��� �޴� ������� �̸�, ����ID, �޿��� ���� ���Ͻÿ�
SELECT LAST_NAME,JOB_ID,SALARY
FROM EMPLOYEES
WHERE SALARY IN(SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG');

--ex09) ��ü������ ���� �����ڿ� ������ �����ϴ� ǥ�ø� �Ͻÿ�(in, not in�̿�)
--�����ȣ      �̸�       ����
---------------------------------------
--100          King      ������

--���1 (in������)
SELECT EMPLOYEE_ID AS �����ȣ, LAST_NAME AS �̸�, 
          CASE 
              WHEN EMPLOYEE_ID IN(SELECT  MANAGER_ID FROM EMPLOYEES) THEN '������'
              ELSE '����'
          END AS ����
FROM EMPLOYEES
ORDER BY 3, 1;  

--���2 (uinon, in, not in������)
SELECT EMPLOYEE_ID �����ȣ, LAST_NAME �̸�,'������' AS ����
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(SELECT MANAGER_ID FROM EMPLOYEES)
UNION      
SELECT EMPLOYEE_ID �����ȣ, LAST_NAME �̸�,'����' AS ����
FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN(SELECT MANAGER_ID 
                         FROM EMPLOYEES 
                         WHERE MANAGER_ID IS NOT NULL)
ORDER BY 3,1;

--���3 (��������̿�)
-- �������� ������ �а� �ش簪�� ������������ �����Ͽ� 
-- ������������� �����ϸ� true�� ��ȯ
SELECT EMPLOYEE_ID �����ȣ,LAST_NAME �̸�,'������' AS����
FROM EMPLOYEES E
WHERE EXISTS(SELECT NULL
             FROM EMPLOYEES
             WHERE E.EMPLOYEE_ID=MANAGER_ID)
UNION
SELECT EMPLOYEE_ID �����ȣ,LAST_NAME �̸�, '����' AS ����
FROM EMPLOYEES E
WHERE NOT EXISTS(SELECT NULL
                 FROM EMPLOYEES
                 WHERE E.EMPLOYEE_ID = MANAGER_ID)
ORDER BY 3,1;    

--ex10) group by rollup : a,b�� ����
--�μ���, ����ID�� �޿���ձ��ϱ�(���Ϻμ��� ���� ������ ��ձ޿�)
--����1) �ݿø��ؼ� �Ҽ� 2°�ڸ����� ���Ͻÿ�
--����2) ������ Job_title, Department_name, Avg_sal�� ǥ���Ͻÿ�
SELECT DEPARTMENT_NAME,JOB_TITLE,ROUND(AVG(SALARY),2) AS "Avg_sal"
FROM EMPLOYEES
JOIN DEPARTMENTS  USING (DEPARTMENT_ID)
JOIN JOBS USING(JOB_ID)
GROUP BY ROLLUP(DEPARTMENT_NAME,JOB_TITLE);

--ex11) group by cube :  a�� ���� �Ǵ� b�� ����
--�μ���, ����ID�� �޿���ձ��ϱ�(�μ��� �������� ��Ÿ���� ��ձ޿�)                    
SELECT DEPARTMENT_NAME,JOB_TITLE,ROUND(AVG(SALARY),2) AS "Avg_sal"
FROM EMPLOYEES
JOIN DEPARTMENTS  USING (DEPARTMENT_ID)
JOIN JOBS USING(JOB_ID)
GROUP BY CUBE(DEPARTMENT_NAME,JOB_TITLE); 

--ex12) group by grouping sets
--������ ��ձ޿��� ��ü����� ��ձ޿��� �Բ� ���Ͻÿ�                 
SELECT JOB_TITLE, ROUND(AVG(SALARY),2) AS AVG_SAL
FROM EMPLOYEES E
JOIN DEPARTMENTS USING(DEPARTMENT_ID)
JOIN JOBS USING (JOB_ID)
GROUP BY GROUPING SETS((JOB_TITLE),());   
