--[SET operator]
--�ΰ� �̻��� ��������� �ϳ��� ���ս�Ű�� ������
--
--1. UNION      : ���������� ��� ����(�ߺ� ����� 1���� ����)     --> ������
--2. UNION  ALL : ���������� ��� ����(�ߺ� ����� ��� ����)  
--3. INTERSECT  : �������� ����� ��� ���ԵǴ� �ุ ǥ��          --> ������
--4. MINUS      : ����1����� ���Եǰ� ����2������� ���Ե��� �ʴ� �ุ ǥ�� -->������

[���������̺�]
create table employees_role
as  select * from employees  where 1=0;         <--- ���̺� ������ ����

insert into employees_role  values(101,'Neena','Kochhar','NKOCHHAR','515.123.4568',
'1989-09-21','AD_VP',17000.00,NULL,100,90);

insert into employees_role  values(101,'Neeno','Kochhar','NKOCHHAR','515.123.4568',
'1989-09-21','AD_VP',17000.00,NULL,100,90);

insert into employees_role values(300,'GeaHee','Kim','Jenni7','010-123-4567',
'2009-03-01','IT_PROG',23000.00,NULL,100,90);
commit;
==================================================================================
--ex1) union 
--     employee_id, last_name�� ������� �ߺ����� �Ͻÿ�  ==> 108 ���ڵ�

select employee_id, last_name
from employees
union 
select employee_id, last_name
from employees_role;

--ex2) union all
--     employee_id, last_name�� ������� �ߺ��� ��� �Ͻÿ� ==> 109 ���ڵ�

select employee_id, last_name
from employees
union all
select employee_id, last_name
from employees_role;


--ex3) minus
--    employees_role�� �ߺ��Ǵ� ���ڵ�� �����ϰ� employees���� �ִ� �������� 
--    ���Ͻÿ� (��, employee_id, last_name�� ǥ��)   ==> 106 ���ڵ�

select employee_id, last_name
from employees
minus
select employee_id, last_name
from employees_role;

--ex4) intersect
--     employees�� employees_role���� �ߺ��Ǵ� ���ڵ��� �������� ���Ͻÿ�
--     (��, employee_id, last_name�� ǥ��)   ==> 1 ���ڵ�

select employee_id, last_name
from employees
intersect
select employee_id, last_name
from employees_role;

--ex5) employees�� employees_role����  �ߺ��Ǵ·��ڵ��� �������� ���Ͻÿ�
--        ����1) ����̸�, ����ID,�Ի����� ǥ���Ͻÿ�
--        ����2) �μ���ȣ�� 90�λ���� ǥ���Ͻÿ�

select last_name,job_id,hire_date
from employees
where department_id=90
intersect
select last_name,job_id,hire_date
from employees_role
where department_id=90

--ex6) union������ �̿��Ͽ� 50�� �μ����� �����ڿ� ������ ���Ͻÿ�
--
--employee_id     last_name    ����
-----------------------------------------
--100             King         ������              
--120             Weiess       ����
--121             Fripp        ���� 
                 :

(�м�) select * from employees where department_id=50;

select employee_id,last_name,'������' as ����
from employees
where employee_id=100
union
select employee_id,last_name,'����' as ����
from employees
where department_id=50;

--ex7) ��Ÿ
select 'SQL�� �����ϰ� �ֽ��ϴ�' ����, 3 ���� from dual
union
select 'it programmer ��������', 1 from dual
union
select '���� ����ְ�', 2 from dual
order by 2 asc;

--ex8) SET operator�� IN operator����
--job_title��   'Stock Manager' �Ǵ�  'Programmer'�� ������� 
--������ job_title�� ǥ���Ͻÿ�

last_name       job_title
--------------------------------
Kaufling        StockManager
Hunlod          Programmer
           :

--���1 (join, in������ �̿�)
select last_name,job_title 
from employees
join jobs using(job_id)
where job_title in('Stock Manager','Programmer');

--���2 (join,union�̿�)
select last_name,job_title 
from employees
join jobs using(job_id)
where job_title='Stock Manager'
union
select last_name,job_title
from employees
join jobs using(job_id)
where job_title='Programmer'
order by 2;

--ex9) �÷����� �ٸ������ SET operator
--     : ����1�� ����2�� select ����� �ݵ�õ���(�÷�����,������Ÿ��)�ؾ� �ϹǷ� 
--       �̸� ���� Dummy Column�� ����Ҽ� �ִ�

select last_name,employee_id,hire_date
from employees
where department_id=20
union
select department_name,department_id,NULL
from departments
where department_id=20;