--[문제 1]  사원테이블에서 사원번호, 사원명, 급여를 검색하시오
select  employee_id,last_name,salary 
from employees;
--[문제 2]  사원테이블에서 부서가  90번인 사원들의 사원명,입사일,연봉,부서코드를 출력하시오
--         조건1)  제목은  사원명, 입 사 일,연   봉,부서코드로 하시오(as 별명)
--         조건2)  연봉  = 급여 * 12
--         조건3)  연봉 뒤에 화폐단위 "원"을 붙이시오 (|| 연결연산자)
--         조건4)  사원명은  first_name , last_name을 연결 하시오

select first_name || '  ' ||last_name as 사원명,hire_date as "입 사 일", 
          salary*12 || '원' as "연  봉" , department_id as 부서코드
from employees
where department_id=90;
 
--[문제 3]  사원테이블에서  업무ID가  IT_PROG,ST_MAN,SA_REP인 사원을 표시하시오
--        조건1)  사원명, 업무ID, 부서ID만 표시
--        조건2)  or  연산자 이용 ,  in 연산자 이용 둘다 쓰시오
--        or연산자 이용
select last_name,job_id,department_id 
from employees
where job_id='IT_PROG' or  job_id='ST_MAN' or job_id='SA_REP';

--       in연산자 이용
select last_name,job_id,department_id 
from employees
where  job_id  in ('IT_PROG','ST_MAN','SA_REP');

--[문제 4]  입사일이  1997~2000 사이의 입사한 사원들의  사원명,입사일, 업무 ID를 출력하시오 
--(and,  between연산자 모두 표시)
--  and연산자
select last_name,hire_date,job_id 
from employees
where  HIRE_DATE >= '1997/01/01'
            and  HIRE_DATE  <= '2000/12/31';

-- between연산자 (초과,미만이 없다)
select last_name,hire_date,job_id 
from employees
where  hire_date  between '1997/01/01' and '2000/12/31';




--[문제 5]  커미션을 받지 않는 사원들의   이름과 연봉,커미션을 출력하시오
--         (is  null)  
select last_name,salary*12,commission_pct
from employees
where  commission_pct is null;
--[문제 6]   업무ID중  IT가 포함되어있는 사원들의 이름과 업무ID을 구하시오

select last_name,job_id 
from employees
where  job_id like '%IT%'; 
--[문제 7] 급여가  1500이상  5000이하인 사원중  IT_PROG의 업무 ID인 사원을 표시하시오
--조건1) 제목은  사원이름, 이메일,전화번호

select  last_name as 사원이름,email as 이메일,phone_number as 전화번호
from employees
where (salary between 1500 and 5000) and job_id='IT_PROG';

--[문제 8 ]   다음과 같이 사원번호 , 이름, 연봉을 출력하시오 

select employee_id as "사원번호",first_name || '  ' || last_name as "이  름",
       salary * 12 || '달러' as "연  봉"
from  employees;

 
--[문제  9] 사원의 이름과 job_id를 다음과 같이 출력하시오 

 select last_name || ' is a ' || job_id as "Employee Detail" from employees; 
--[문제 10] 급여가 2500이하 이거나 3000이상이면서 90번 부서인 사원의 이름, 급여, 부서ID를 출력하시오.
--      조건1) 제목은 사원명, 월  급, 부서코드로 하시오
--      조건2) 급여앞에 $를 붙이시오
--      조건3) 사원명은 first_name과 last_name을 연결해서 출력하시오

select first_name ||'  ' || last_name as "사원명",
       '$'|| salary as "월  급",department_id as "부서코드"
from employees
where (salary<=2500  or  salary>=3000) and department_id=90;

--[문제 11 ] 업무ID가 'SA_REP' 이거나 'AD_PRES' 이면서 급여가 15000를 
--초과하는 사원들의 이름, 업무ID ,급여를 출력하시오
 
select last_name as "이름",job_id as "업무ID", salary || '원' as "급 여"
from employees
where  (job_id = 'SA_REP' or job_id = 'AD_PRES') and salary > 15000;


--[문제12] Employees테이블의 업무ID가 중복되지 않게 표시하는 질의를 작성하시오
select distinct job_id
from employees;
 
 
--[문제13 ] 입사일이 97년인 사원들의 사원번호,이름,입사일을 표시하시오
select employees_id,last_name,hire_date
from employees
where hire_date like '97%';

  
--
--[문제 14 ] 업무ID에 MAN이 포함되어있는 사원들의 이름,업무ID,부서ID를 출력하시오

 

select last_name,job_id,department_id
from employees
where  job_id  like '%MAN%';


 
--[문제 15 ] 사원명, 부서ID, 입사일을  부서별로 내림차순 정렬하시오
--     같은부서가 있을때는  입사일 순으로 정렬하시오

select last_name,department_id,hire_date 
from employees
order by  department_id  desc,  hire_date asc;


 


--[문제 16] 사원의 레코드를 검색하시오(concat,  length)
--      조건1) 이름과 성을 연결하시오(concat)
--      조건2) 구해진 이름의 길이를 구하시오(length)
--      조건3) 성이 n으로 끝나는 사원(substr)
select  employee_id, concat(first_name,last_name) as name, 
length(concat(first_name,last_name)) as length
from employees
where  substr(last_name,-1,1)='n';

 

 
--[문제 17] 2000년 이후에 고용된 사원을 찾으시오 
select last_name,to_char(hire_date,'dd-mon-yyyy')
from employees
where hire_date>to_char(to_date('2000-01-01','yy-mm-dd'),'yy-mm-dd');
 
--[문제 18] 급여가 10000미만이면 초급, 20000미만이면 중급 그 외면 고급을 출력하시오
--조건1) 컬럼명은  '구분'으로 하시오
--      조건2) 제목은 사원번호, 사원명, 구  분
--      조건3) 구분(오름차순)으로 정렬하고, 같으면 사원명(오름차순)으로 정렬하시오

select employee_id as 사원번호,last_name as 사원명, 
       case 
          when salary<10000 then '초급'
          when salary<20000 then '중급'
          else '고급'
       end "구분"
from employees
order by 3,2;
 

--[문제 19 ] 사원테이블에서 사원번호, 이름, 급여, 커미션, 연봉을 출력하시오
--        조건1) 연봉은 $ 표시와 세자리마다 콤마를 사용하시오
--        조건2) 연봉 = 급여 * 12 + (급여 * 12 * 커미션) 
--        조건3) 커미션을 받지 않는 사원도 포함해서 출력하시오

select employee_id as "사원번호",last_name as "사원이름",
       salary as "급여", nvl(commission_pct,0) as "커미션",
       to_char(to_number((salary*12+(salary*12*nvl(commission_pct,0)))),
        '$9,999,999') as "연봉"
from employees;   

 
 
--[문제 20] 매니저가 없는 사원의 매니저id를, 1000번으로 표시
--        조건1) 제목은 사원번호,이름,매니저ID
--        조건2) 모든 사원을 표시하시오       
 
select employee_id,last_name,nvl(manager_id,1000) as manager_id
from employees;





