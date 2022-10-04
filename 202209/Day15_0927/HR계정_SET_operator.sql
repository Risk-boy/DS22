--[SET operator]
--두개 이상의 쿼리결과를 하나로 결합시키는 연산자
--
--1. UNION      : 양쪽쿼리를 모두 포함(중복 결과는 1번만 포함)     --> 합집합
--2. UNION  ALL : 양쪽쿼리를 모두 포함(중복 결과도 모두 포함)  
--3. INTERSECT  : 양쪽쿼리 결과에 모두 포함되는 행만 표현          --> 교집합
--4. MINUS      : 쿼리1결과에 포함되고 쿼리2결과에는 포함되지 않는 행만 표현 -->차집합

[연습용테이블]
create table employees_role
as  select * from employees  where 1=0;         <--- 테이블 구조만 복사

insert into employees_role  values(101,'Neena','Kochhar','NKOCHHAR','515.123.4568',
'1989-09-21','AD_VP',17000.00,NULL,100,90);

insert into employees_role  values(101,'Neeno','Kochhar','NKOCHHAR','515.123.4568',
'1989-09-21','AD_VP',17000.00,NULL,100,90);

insert into employees_role values(300,'GeaHee','Kim','Jenni7','010-123-4567',
'2009-03-01','IT_PROG',23000.00,NULL,100,90);
commit;
==================================================================================
--ex1) union 
--     employee_id, last_name이 같을경우 중복제거 하시오  ==> 108 레코드

select employee_id, last_name
from employees
union 
select employee_id, last_name
from employees_role;

--ex2) union all
--     employee_id, last_name이 같을경우 중복을 허용 하시오 ==> 109 레코드

select employee_id, last_name
from employees
union all
select employee_id, last_name
from employees_role;


--ex3) minus
--    employees_role과 중복되는 레코드는 제거하고 employees에만 있는 사원명단을 
--    구하시오 (단, employee_id, last_name만 표시)   ==> 106 레코드

select employee_id, last_name
from employees
minus
select employee_id, last_name
from employees_role;

--ex4) intersect
--     employees와 employees_role에서 중복되는 레코드의 사원명단을 구하시오
--     (단, employee_id, last_name만 표시)   ==> 1 레코드

select employee_id, last_name
from employees
intersect
select employee_id, last_name
from employees_role;

--ex5) employees와 employees_role에서  중복되는레코드의 사원명단을 구하시오
--        조건1) 사원이름, 업무ID,입사일을 표시하시오
--        조건2) 부서번호가 90인사원만 표시하시오

select last_name,job_id,hire_date
from employees
where department_id=90
intersect
select last_name,job_id,hire_date
from employees_role
where department_id=90

--ex6) union구문을 이용하여 50번 부서원의 관리자와 직원을 구하시오
--
--employee_id     last_name    구분
-----------------------------------------
--100             King         관리자              
--120             Weiess       직원
--121             Fripp        직원 
                 :

(분석) select * from employees where department_id=50;

select employee_id,last_name,'관리자' as 구분
from employees
where employee_id=100
union
select employee_id,last_name,'직원' as 구분
from employees
where department_id=50;

--ex7) 기타
select 'SQL을 공부하고 있습니다' 문장, 3 순서 from dual
union
select 'it programmer 과정에서', 1 from dual
union
select '아주 재미있게', 2 from dual
order by 2 asc;

--ex8) SET operator과 IN operator관계
--job_title이   'Stock Manager' 또는  'Programmer'인 사원들의 
--사원명과 job_title을 표시하시오

last_name       job_title
--------------------------------
Kaufling        StockManager
Hunlod          Programmer
           :

--방법1 (join, in연산자 이용)
select last_name,job_title 
from employees
join jobs using(job_id)
where job_title in('Stock Manager','Programmer');

--방법2 (join,union이용)
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

--ex9) 컬럼명이 다른경우의 SET operator
--     : 쿼리1과 쿼리2의 select 목록은 반드시동일(컬럼갯수,데이터타입)해야 하므로 
--       이를 위해 Dummy Column을 사용할수 있다

select last_name,employee_id,hire_date
from employees
where department_id=20
union
select department_name,department_id,NULL
from departments
where department_id=20;