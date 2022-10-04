--SubQuery
-- 1) 주쿼리와 서브쿼리로 구현되는 하나의 구문에서 먼저 서브쿼리가 실행되고 결과를 통해서 주쿼리 연산이 실행된다
-- 2) SELECT, FROM, WHERE, GROUP BY, ORDER BY, UPDATE, DELETE, HAVING, INSERT INTO 문에서 사용한다
-- 3) ()로 묶어서 사용한다. / 비교조건의 오른쪽에 선언된다 / 일반적으로 ORDER BY절은 사용하지 않는다
-- 4) 서브쿼리의 결과가 단일행, 다중행으로 나뉜다
-- 5) 단일행 연산자(> , >=, != 등) 다중행 연산자(IN, NOT IN, ANY, ALL 등)

--Q1) JONES보다 급여를 많이 받는 사원의 이름과 급여를 출력하자
SELECT SAL
FROM EMP
WHERE ENAME = 'JONES';

SELECT ENAME, SAL
FROM EMP
WHERE SAL > 2975;

SELECT ENAME, SAL   -- 기본 질의 / 기본 쿼리 / 주쿼리 / 외부쿼리
FROM EMP
WHERE SAL > (SELECT SAL   -- 서브쿼리 / 부쿼리
             FROM EMP
             WHERE ENAME = 'JONES');

--Q2) 사원 번호가 7839인 사원과 같은 직업을 가진 사원들의 이름과 직업을 출력하자
SELECT ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB
             FROM EMP
             WHERE EMPNO = 7839);

--Q3) 7566 사원보다 급여를 많이 받는 사원의 이름, 급여를 출력해보자
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
             FROM EMP
             WHERE EMPNO = 7566);

--Q4) 사원의 급여의 평균보다 적은 사원의 사원번호, 이름, 직업, 부서번호 출력
SELECT EMPNO, ENAME, JOB, DEPTNO
FROM EMP
WHERE SAL < (SELECT AVG(SAL)
             FROM EMP);

--Q5) 사원번호가 7521인 사원과 직업이 같고 급여가 7934인 사원보다 많은 사원의 이름, 직업, 입사일, 급여 출력
SELECT ENAME, JOB, HIREDATE, SAL
FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO = 7521) AND SAL > (SELECT SAL FROM EMP WHERE EMPNO = 7934);

--Q6) 평균급여가 가장 적은 직업을 출력
SELECT JOB, AVG(SAL)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) = (SELECT MIN(AVG(SAL))
                   FROM EMP
                   GROUP BY JOB);

--Q7) 사원의 급여가 20번 부서번호의 최소 급여보다 많은 부서번호
SELECT DEPTNO, MIN(SAL)
FROM EMP 
GROUP BY DEPTNO
HAVING MIN(SAL) > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 20);

--Q8) 부서별 최소 급여와 같은 급여를 받는 사원의 부서번호와 이름 출력
SELECT DEPTNO, ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO); 

SELECT DEPTNO, ENAME, SAL
FROM EMP
WHERE SAL = ANY(SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);

SELECT DEPTNO, MIN(SAL) FROM EMP GROUP BY DEPTNO;

-- 다중 행 (Multiple-Row) 서브쿼리 ? 하나 이상의 행을 리턴 하는 서브쿼리를 다중 행 서브쿼리라고 한다.
-- 복수 행 연산자(IN, ANY, ALL)를 사용한다. 
-- IN: 목록에 있는 임의의 값과 동일하면 참  
-- ANY: 서브쿼리에서 리턴된 각각의 값과 비교하여 하나라도 참이면 참 ( "=ANY"는 "IN"과 동일) 
--       EX) < ANY  = 최대값보다 적음, > ANY 최소값보다 큼
-- ALL: 서브쿼리에서 리턴된 모든 값과 비교하여 모두 참이어야 참
--       EX) < ALL = 최소값보다 적음, > ALL 최대값 보다 큼
-- NOT 연산자는 IN, ANY, ALL 연산자와 함께 사용될 수 있다.

--Q9) 직업이 SALESMAN인 사원의 최소 급여보다 급여를 많이 받는 사원의 이름, 급여, 직업을 출력
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL > ANY(SELECT SAL
                FROM EMP
                WHERE JOB = 'SALESMAN');

--Q10) FORD, BLAKE와 매니저 및 부서번호가 같은 사원의 정보를 출력
SELECT ENAME, MGR, DEPTNO
FROM EMP
WHERE (MGR, DEPTNO) IN (SELECT MGR, DEPTNO FROM EMP WHERE ENAME IN ('FORD', 'BLAKE'));
                        
--Q11) 소속된 부서번호의 평균 급여보다 많은 급여를 받는 사원의 이름, 급여, 부서번호, 입사일, 직업 출력
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 10;  

SELECT ENAME, SAL, DEPTNO, HIREDATE, JOB
FROM EMP E
WHERE SAL > (SELECT AVG(SAL)
             FROM EMP
             WHERE DEPTNO = E.DEPTNO);
             -- E.DEPTNO: 주쿼리 테이블의 컬럼을 역참조할 때 별칭을 사용!!!!!
             
-- 상호 연관(CORRELATED) 서브쿼리: 상의 질의 즉 주쿼리에 있는 테이블의 열을 참조하는 것을 말한다
-- 1) 주 쿼리의 하나의 ROW에서 서브쿼리가 한번씩 실행된다
-- 2) 테이블에서 행을 먼저 읽어서 각 행의 값을 관련된 데이터와 비교한다
-- 3) 주 쿼리에서 각 서브쿼리의 행에 대해 다른 결과를 리턴할 때 사용한다
-- 4) 각 행의 값에 따라 응답이 달라지는 다중 질의의 값을 리턴받을 때 사용한다
-- 5) 서브쿼리에서 메인 쿼리 컬럼명을 사용할 수 있지만 메인에서는 서브쿼리의 컬럼명을 사용할 수 없다

--Q12) 인라인 뷰(INLINE VIEW): FROM 절에 서브쿼리 Q11)사용
SELECT E.ENAME, E.DEPTNO, E.JOB
FROM (SELECT ENAME, JOB, DEPTNO
      FROM EMP
      WHERE JOB = 'MANAGER') E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.ENAME, E.SAL, E.DEPTNO, E.HIREDATE, E.JOB, D.AVGSAL
FROM EMP E, (SELECT DEPTNO, AVG(SAL) AVGSAL FROM EMP E GROUP BY DEPTNO) D
WHERE E.DEPTNO = D.DEPTNO AND E.SAL > D.AVGSAL;

--스칼라(Scalar) 서브쿼리
--하나의 행에서 하나의 열 값만 리턴하는 서브 쿼리를 스칼라 서브쿼리라고 한다
--스칼라 서브 쿼리의 값은 서브 쿼리의 SELECT 목록에 있는 항목 값이다
--서브쿼리가 0개의 행을 리턴하면 스칼라 서브쿼리의 값은 NULL이다
--서브쿼리가 2개 이상의 행을 리턴하면 오류가 리턴된다
--SELECT(GROUP BY는 제외), INSERT의 VALUES 목록, DECODE의 CASE조건문, UPDATE SET문

--Q13) 사원번호, 이름, 부서번호, 사원이 속한 부서의 평균 급여를 출력
SELECT EMPNO, ENAME, DEPTNO, SAL, 
       ROUND((SELECT AVG(SAL)
       FROM EMP
       WHERE DEPTNO = E.DEPTNO)) AS M_SAL
FROM EMP E;

--Q14) 사원번호, 이름, 부서번호, 사원이 속한 부서의 평균 급여를 정렬해서 출력
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

--Q16) EXISTS 연산자
-- 직원을 둔 사원의 이름, 직업, 입사일, 급여를 출력
SELECT EMPNO, ENAME, JOB, HIREDATE, MGR, SAL
FROM EMP E
WHERE EXISTS (SELECT 1
              FROM EMP
              WHERE E.EMPNO = MGR)
ORDER BY EMPNO;
              
-- 직원이 없는
SELECT EMPNO, ENAME, JOB, HIREDATE, MGR, SAL
FROM EMP E
WHERE NOT EXISTS (SELECT 1
                  FROM EMP
                  WHERE E.EMPNO = MGR)
ORDER BY EMPNO;
              
-- Join
-- 여러 테이블의 데이터가 필요한 경우 사용
-- 관계형 데이터 베이스에서 기본
-- 기준 테이블에서 다른 테이블에 있는 ROW를 찾아 오는 것
-- ORACLE JOIN: EQUI, NON-EQUI, SELF, OUTER
-- ANSI JOIN: CROSS, NATURAL, INNER, OUTER

--Q1) INNER JOIN을 해보자
-- SALESMAN의 사원번호, 이름, 급여, 부서명, 근무지를 출력
--ORACLE JOIN
SELECT EMPNO, ENAME, SAL, DNAME, LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;  -- ORACLE 식 JOIN
              
--ANSI JOIN: 두개의 테이블에 동일한 컬럼을 지정할 때는 USING(컬럼명)
--         / 다른 컬럼의 값을 지정할 때는 ON(컬럼A = 컬럼B)
SELECT EMPNO, ENAME, SAL, DNAME, LOC
FROM EMP JOIN DEPT USING(DEPTNO);

SELECT EMPNO, ENAME, SAL, DNAME, LOC
FROM EMP INNER JOIN DEPT USING(DEPTNO);

/* 
  JOIN = INNER JOIN = 두개의 테이블에서 TRUE 값만 출력, FALSE, NULL은 추출되지 않는다
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

--Q2) M, S 두 테이블의 M1, S1컬럼을 조인해보자
--ORACLE JOIN
SELECT *
FROM M, S
WHERE M1 = S1;

--ANSI JOIN
SELECT * 
FROM M JOIN S ON(M1 = S1);


