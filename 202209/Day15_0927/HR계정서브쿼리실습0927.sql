--[하위질의(SubQuery]
--: 하나의 쿼리에 다른 쿼리가 포함되는 구조,()로처리
--1) 단일행 서브쿼리(단일행반환) :  > , < , >=, <= , <>
--     Main Query
--               
--           Sub  Query      ----->   1 개결과
--
--2) 다중행 서브쿼리(여러행반환) : in, any, all
--     Main Query
--     
--          Sub Query      ----->   여러개의 결과  
--      
--       < any : 비교대상중 최대값보다 작음
--       > any : 비교대상중 최소값보다 큼   
--                  (ex. 과장직급의 급여를 받는 사원조회)
--       =  any : in연산자와 동일
--       <  all   : 비교대상중 최소값보다 작음
--       >  all   : 비교대상중 최대값보다 큼 
--                  (ex. 모든과장들의 직급보다 급여가 많은 사원조회)
--
--3) 상관쿼리(correlated  subquery)   
--  : 메인쿼리에서 고려된 각 후보 행들에 대해 서브쿼리가 다른 결과를 반환해야하는경우
--    (메인쿼리에서 처리되는 각 행들의 값에 따라 응답이 달라져야하는 경우)에 유용하다
--      exists,  not exists : 존재 여부에 따라 true,false을 반환\

--ex01) Neena사원의 부서명을 알아내시오
SELECT DEPARTMENT_ID  FROM EMPLOYEES  WHERE FIRST_NAME='Neena';
SELECT DEPARTMENT_NAME  FROM DEPARTMENTS  WHERE DEPARTMENT_ID=90;

SELECT DEPARTMENT_NAME 
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID  
                       FROM EMPLOYEES  
                       WHERE FIRST_NAME='Neena');

--ex02) Neena사원의 부서에서 Neena사원보다 급여를 많이 받는 사원들을 구하시오
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID 
                     FROM EMPLOYEES
                     WHERE FIRST_NAME='Neena')
AND  SALARY > (SELECT SALARY
               FROM EMPLOYEES
               WHERE FIRST_NAME='Neena');

--ex03) 부서별 급여합계중 최대급여를 받는 부서의 부서명과 급여합계를 구하시오
SELECT DEPARTMENT_NAME, SUM(SALARY)
FROM EMPLOYEES
JOIN DEPARTMENTS USING(DEPARTMENT_ID)
GROUP BY DEPARTMENT_NAME
HAVING SUM(SALARY)=(SELECT MAX(SUM(SALARY))
                    FROM EMPLOYEES
                    GROUP BY DEPARTMENT_ID);

--ex04) 최저급여를 받는 사원들의 이름과 급여를 구하시오
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEES);

--ex05) Austin과 같은부서이면서 같은 급여를 받는사원들의
--      이름, 부서명, 급여를 구하시오(60부서,4800달러)
SELECT LAST_NAME, DEPARTMENT_NAME, SALARY
FROM EMPLOYEES
LEFT JOIN DEPARTMENTS USING(DEPARTMENT_ID)
WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID
                     FROM EMPLOYEES
                     WHERE LAST_NAME='Austin')
AND SALARY=(SELECT SALARY
            FROM EMPLOYEES
            WHERE LAST_NAME='Austin');
            
            
--ex06) 'IT_PROG' 직급의 최소급여보다 급여가 많은 'ST_MAN'직급 직원들을 조회하시오
SELECT LAST_NAME,JOB_ID,SALARY
FROM EMPLOYEES
WHERE JOB_ID='ST_MAN'
AND SALARY > ANY(SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG');

--ex07) 'IT_PROG' 직급중 가장많이 받는 사원의 급여보다,더 많은급여를 받는
--      'FI_ACCOUNT' 또는 'SA_REP' 직급 직원들을 조회하시오
--      조건1) 급여순으로 내림차순정렬하시오
--      조건2) 급여는 세자리마다 콤마(,) 찍고 화폐단위 '원'을 붙이시오
--      조건3) 타이틀은  사원명, 업무ID, 급여로 표시하시오
SELECT LAST_NAME AS 사원명, JOB_ID AS  업무ID,
       TO_CHAR(SALARY,'99,999,999')||'원' AS 급여
FROM EMPLOYEES
WHERE (JOB_ID='FI_ACCOUNT' OR JOB_ID='SA_REP')
AND SALARY>ALL(SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG')
ORDER BY SALARY DESC;

--ex08) 'IT_PROG'와 같은 급여를 받는 사원들의 이름, 업무ID, 급여를 전부 구하시오
SELECT LAST_NAME,JOB_ID,SALARY
FROM EMPLOYEES
WHERE SALARY IN(SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG');

--ex09) 전체직원에 대한 관리자와 직원을 구분하는 표시를 하시오(in, not in이용)
--사원번호      이름       구분
---------------------------------------
--100          King      관리자

--방법1 (in연산자)
SELECT EMPLOYEE_ID AS 사원번호, LAST_NAME AS 이름, 
          CASE 
              WHEN EMPLOYEE_ID IN(SELECT  MANAGER_ID FROM EMPLOYEES) THEN '관리자'
              ELSE '직원'
          END AS 구분
FROM EMPLOYEES
ORDER BY 3, 1;  

--방법2 (uinon, in, not in연산자)
SELECT EMPLOYEE_ID 사원번호, LAST_NAME 이름,'관리자' AS 구분
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(SELECT MANAGER_ID FROM EMPLOYEES)
UNION      
SELECT EMPLOYEE_ID 사원번호, LAST_NAME 이름,'직원' AS 구분
FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN(SELECT MANAGER_ID 
                         FROM EMPLOYEES 
                         WHERE MANAGER_ID IS NOT NULL)
ORDER BY 3,1;

--방법3 (상관쿼리이용)
-- 메인쿼리 한행을 읽고 해당값을 서브쿼리에서 참조하여 
-- 서브쿼리결과에 존재하면 true를 반환
SELECT EMPLOYEE_ID 사원번호,LAST_NAME 이름,'관리자' AS구분
FROM EMPLOYEES E
WHERE EXISTS(SELECT NULL
             FROM EMPLOYEES
             WHERE E.EMPLOYEE_ID=MANAGER_ID)
UNION
SELECT EMPLOYEE_ID 사원번호,LAST_NAME 이름, '직원' AS 구분
FROM EMPLOYEES E
WHERE NOT EXISTS(SELECT NULL
                 FROM EMPLOYEES
                 WHERE E.EMPLOYEE_ID = MANAGER_ID)
ORDER BY 3,1;    

--ex10) group by rollup : a,b별 집계
--부서별, 직무ID별 급여평균구하기(동일부서에 대한 직무별 평균급여)
--조건1) 반올림해서 소수 2째자리까지 구하시오
--조건2) 제목은 Job_title, Department_name, Avg_sal로 표시하시오
SELECT DEPARTMENT_NAME,JOB_TITLE,ROUND(AVG(SALARY),2) AS "Avg_sal"
FROM EMPLOYEES
JOIN DEPARTMENTS  USING (DEPARTMENT_ID)
JOIN JOBS USING(JOB_ID)
GROUP BY ROLLUP(DEPARTMENT_NAME,JOB_TITLE);

--ex11) group by cube :  a별 집계 또는 b별 집계
--부서별, 직무ID별 급여평균구하기(부서를 기준으로 나타내는 평균급여)                    
SELECT DEPARTMENT_NAME,JOB_TITLE,ROUND(AVG(SALARY),2) AS "Avg_sal"
FROM EMPLOYEES
JOIN DEPARTMENTS  USING (DEPARTMENT_ID)
JOIN JOBS USING(JOB_ID)
GROUP BY CUBE(DEPARTMENT_NAME,JOB_TITLE); 

--ex12) group by grouping sets
--직무별 평균급여와 전체사원의 평균급여를 함께 구하시오                 
SELECT JOB_TITLE, ROUND(AVG(SALARY),2) AS AVG_SAL
FROM EMPLOYEES E
JOIN DEPARTMENTS USING(DEPARTMENT_ID)
JOIN JOBS USING (JOB_ID)
GROUP BY GROUPING SETS((JOB_TITLE),());   
