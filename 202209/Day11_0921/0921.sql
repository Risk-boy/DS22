/*
  ROUND: 반올림 / TRUNC: 버림 / MOD(M, N): 나머지 / ABS: 절대값
  FLOOR: 해당 수 보다 작거나 같은 정수 중 가장 큰 정수값을 리턴
  CEIL: 해당 수 보다 크거나 같은 정수 중 가장 작은 정수값을 리턴
  SIGN: 부호 / POWER(M, N): M의 N제곱
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

--Q3) 사원테이블에서 급여를 30으로 나눈 나머지, 급여, 이름 출력
SELECT E.ENAME, SAL, MOD(SAL, 30) RESULT
FROM SCOTT.EMP E;

--Q4) 날짜 함수의 서식 확인
SELECT VALUE
FROM NLS_SESSION_PARAMETERS
WHERE PARAMETER ='NLS_DATE_FORMAT';
--RR/MM/DD(00~49:2000년대), DD/MON/RR(50~99: 1900년대)
--NLS_SESSION_PARAMETERS: KEY, VALUE으로 초기 데이터 베이스의 FORMAT을 관리하는 TABLE
SELECT PARAMETER, VALUE 
FROM NLS_SESSION_PARAMETERS;

--7Bytes 내부 표현 / 시간, 날짜값이 상수로 리턴
--CENTURY, YEAR, MONTH, DAY, HOURS, MINUTES, SECONDS
/*
  2011년 6월 7일 오전 3시 15분 47초
  CENTURY, YEAR, MONTH, DAY, HOURS, MINUTES, SECONDS
  20       11    06     07   3      15       47
*/

--Q5) 날짜 형식은 산술연산이 가능하다. 20번 부서의 사원이름, 입사일, 입사일의 3일 이후 출력
SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY"년" MM"월" DD"일" DAY') 입사일, TO_CHAR(HIREDATE+3, 'YYYY"년" MM"월" DD"일" DAY') "입사일+3"
FROM SCOTT.EMP
WHERE DEPTNO = 20;

SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY"년" MM"월" DD"일" Dy') 입사일, TO_CHAR(HIREDATE+3, 'YYYY"년" MM"월" DD"일" DAY') "입사일+3"
FROM SCOTT.EMP
WHERE DEPTNO = 20;

SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY"년" MM"월" DD"일" D')
FROM SCOTT.EMP;

--Q6) EXTRACT 함수: 오늘 날짜 중 년도만 조회하고 싶다
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;
-- 사원 테이블에서 사원의 이름, 입사일자에서 월만 조회
SELECT ENAME, EXTRACT(MONTH FROM HIREDATE)
FROM SCOTT.EMP;

--Q7) 사원테이블에서 사원의 현재까지의 근무일수가 몇주 며칠인지 조회
/*
MONTHS_BETWEEN(D1, D2): D1과 D2사이 개월수 (숫자 리턴)
ADD_MONTHS(D1, N): D1 + N 
NEXT_DAY(D1, 'CHAR'): D1보다 이후 날짜로 지정한 요일에 해당하는 날짜
LAST_DAY: 해당월의 마지막 날짜를 리턴
*/
SELECT MONTHS_BETWEEN (TO_DATE('02-02-1995','MM-DD-YYYY'), TO_DATE('01-01-1995','MM-DD-YYYY') )
FROM DUAL;

SELECT ENAME, HIREDATE, SYSDATE, TRUNC(SYSDATE-HIREDATE)||'일' AS "TOTAL DAYS", 
TRUNC((SYSDATE-HIREDATE) / 7)||'주' AS "TOTAL WEEKS", TRUNC(MOD((SYSDATE-HIREDATE), 7))||'일' AS "DAYS"  
FROM SCOTT.EMP
ORDER BY 4 DESC;

--Q8) 사원테이블에서 10번 부서의 사원들이 현재까지의 근무 월수를 계산해서 리턴
SELECT ENAME "이름", HIREDATE, SYSDATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS "근무 개월수",
TRUNC(MONTHS_BETWEEN(TO_DATE(SYSDATE,'RR-MM-DD'),TO_DATE(HIREDATE,'RR-MM-DD'))) AS "근무 개월수",
TRUNC(MONTHS_BETWEEN(TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD')),TO_DATE(TO_CHAR(HIREDATE,'YYYY-MM-DD')))) AS "근무 개월수",
DEPTNO "부서번호"
FROM SCOTT.EMP
WHERE DEPTNO = 10
ORDER BY 4;

SELECT TO_DATE('02-02-1995', 'MM-DD-YYYY')
FROM DUAL;

SELECT TO_DATE(HIREDATE, 'RR-MM-DD')
FROM SCOTT.EMP;

SELECT TO_DATE(HIREDATE, 'YYYY-MM-DD')
FROM SCOTT.EMP;

--Q9) 사원테이블에서 10번 부서의 사원들의 입사일로부터 5개월이 지난 후 날짜를 계산해서 출력
SELECT ENAME, HIREDATE AS "입사일", ADD_MONTHS(HIREDATE, 5) AS "입사 5개월 후", DEPTNO
FROM SCOTT.EMP
WHERE DEPTNO = 10;

--Q10) 사원테이블에서 10번 부서 사원들의 입사일로부터 돌아오는 금요일을 계산해서 리턴
SELECT ENAME, HIREDATE AS "입사일", NEXT_DAY(HIREDATE, '금') AS "돌아오는 금요일"
,NEXT_DAY(HIREDATE, 6) AS "돌아오는 금요일"
FROM SCOTT.EMP
WHERE DEPTNO = 10;

--Q11)  다음 문장의 실행 결과를 알아보자.
--날짜에 사용하면 지정형식 모델에 따라 함수가 반올림되거나 버려지므로 날짜를 가장 가까운 연도 또는 달로 반올림할 수 있다.
/*
ROUND : 일을 반올림 할때 정오를 넘으면 다음날 자정을 리턴하고, 넘지 않으면 그날 자정을 리턴한다. 
        월 : 15일 이상이면 다음달 1을 출력 / 넘지 않으면  현재 달 1을 리턴
        년도: 6월을 넘으면 다음해 1월1일 리턴 / 넘지 않으면 현재 1월 1일 리턴
        
TRUNC : 일을 절삭하면 그날 자정출력, 월을 절삭 그 달 1을출력, 년도를 절삭하면 금년 1월1일 리턴          

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

--Q12)  다음 문장의 실행 결과를 알아보자. ORACLE 전용 FUNCTION
SELECT TO_TIMESTAMP_TZ('2004-8-20 1:30:00 -3:00', 'YYYY-MM-DD HH:MI:SS TZH:TZM')
FROM DUAL;-- CHAR, VARCHAR2 데이터 타입을 TIMESTAMP WITH TIME ZONE 데이터 타입으로 리턴  

SELECT TO_TIMESTAMP('2004-8-20 1:30:00', 'YYYY-MM-DD HH:MI:SS') 
FROM DUAL;-- CHAR, VARCHAR2 데이터 타입을 TIMESTAMP 데이터 타입으로 리턴 

SELECT SYSDATE, SYSDATE+TO_YMINTERVAL('01-03') "15Months later" 
FROM  DUAL;  ---- CHAR, VARCHAR2 데이터 타입을 INTERVAL YEAR TO MONTH 데이터 타입으로 리턴 
--01: 1yr / 03: 3months

SELECT  SYSDATE, SYSDATE+TO_DSINTERVAL('003 17:00:00') AS "3days 17hours later" 
FROM DUAL; ---- CHAR, VARCHAR2 데이터 타입을 INTERVAL DAY TO SECOND 데이터 타입으로 리턴 

--Q13) 다음 문장의 실행 결과를 알아보자.
--EMP 테이블의 사원이름, 매니저 번호, 매니저번호가 null이면 ‘대표’ 로 표시하고, 매니저번호가 있으면 '프로'으로 표시. 
SELECT ENAME, MGR, NVL2(MGR, MGR||'프로','대표') 
FROM SCOTT.EMP;

--Q14) EMP 테이블의 사원이름 , 업무, 업무가 'CLERK‘ 인 경우 NULL로 나오도록 리턴.
SELECT ENAME, JOB, NULLIF(JOB,'CLERK') AS RESULT 
FROM SCOTT.EMP;

--Q15)EMP테이블에서 이름, 보너스, 급여, 보너스가 null 아닌 경우 보너스를, 보너스가 null인 경우엔 급여를
--COALESCE(COL1, COL2, COL3,,,,) NULL이 아닌 COL이 있으면 그 값을 반환
--모두 null인 경우엔 50으로 리턴.
SELECT ENAME, COMM, SAL, COALESCE(COMM,SAL,50) RESULT 
FROM SCOTT.EMP;

--Q16) DECODE 함수를 이용하여 급여가 1000보다 작으면 ‘A’, 1000이상 2500미만이면 ‘B’, 2500이상이면 ‘C’로 표시하라.
SELECT ENAME, SAL, DECODE(SIGN(SAL-1000),-1,'A', DECODE(SIGN(SAL-2500),-1,'B','C')) GRADE 
FROM SCOTT.EMP;

--Q17) CASE 함수를 이용하여 급여가 1000보다 작으면 ‘A’, 1000이상 2500미만이면 ‘B’, 2500이상이면 ‘C’로 표시하라. 
SELECT ENAME,SAL, 
        CASE WHEN SAL < 1000 THEN 'A' 
             WHEN SAL >= 1000 AND SAL < 2500 THEN 'B' 
             ELSE 'C' END AS GRADE 
FROM SCOTT.EMP ORDER BY GRADE;

--Q18) ROLLUP, CUBE: GROUPING한 결과를 상호 참조열에 따라 상위 집계를 내는 작업
/*
  ROLLUP
  정규 그룹화 행, 하위 총합을 포함해서 결과를 리턴
  데이터 보고서 작성, 집합에서 통계 및 요약정보를 추출하는데 사용
  GROUP BY 절에 ()를 이용해서 지정된 열 목록을 따라 오른쪽에서 왼쪽 방향으로 하나씩 그룹을 만든다
  그 다음 GROUP 함수를 생성한 GROUP에 적용
  총계를 산출하려면 N+1 개의 SELECT문을 UNION ALL로 지정한다
  
  CUBE
  ROLLUP 결과를 교차 도표화해서 행을 포함하는 결과 집합을 리턴
  GROUP BY 확장 기능
  집계 함수를 사용하게 되면 결과집합에 추가 행이 만들어진다
  GROUP BY 절에 N개의 열이 있을 경우 상위 집계 조합수는 2의 N제곱 개이다
*/
--사원 테이블에서 부서별로 급여의 합을 조회시 ROLLUP으로 집계를 내보자
SELECT DEPTNO, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY ROLLUP(DEPTNO);

SELECT DEPTNO, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

--Q19) 사원 테이블에서 부서별, 직업별 급여의 합 조회시 ROLLUP 집계를 내보자
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

--Q20) 사원 테이블에서 부서별, 직업별 급여의 합 조회시 CUBE 집계를 내보자
SELECT DEPTNO, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY CUBE(DEPTNO);

SELECT DEPTNO, JOB, COUNT(*), SUM(SAL)
FROM SCOTT.EMP
GROUP BY CUBE(DEPTNO, JOB);

SELECT DEPTNO, JOB, MGR, SUM(SAL)
FROM SCOTT.EMP
GROUP BY CUBE(DEPTNO, JOB, MGR); --> 2^3개의 그룹화를 계산

--Q21) GROUPING 함수는 ROLLUP, CUBE와 함께 사용한다.
/*
  하나의 열을 인수로 갖는다
  인수는 GROUP BY 절에 컬럼과 같아야 한다
  0 또는 1을 반환한다
  0일 경우: 해당 열을 그대로 사용하여 집계 값을 계산 했거나 해당 열에 나오는 NULL값이 저장된 것을 의미
  1일 경우: 해당 열을 사용하지 않고 집계 값을 계산 했거나 NULL값이 그룹화의 결과로
           ROLLUP, CUBE에 리턴 값으로 구현된 것을 의미한다.
  SELECT문 뒤에 선언한다
  행에서 하위 총계를 형성한 그룹을 찾을 수 있다
*/
SELECT DEPTNO, JOB, SUM(SAL), GROUPING(DEPTNO), GROUPING(JOB)
FROM SCOTT.EMP
GROUP BY ROLLUP(DEPTNO, JOB);

SELECT DEPTNO, JOB, SUM(SAL), GROUPING(DEPTNO), GROUPING(JOB)
FROM SCOTT.EMP
GROUP BY CUBE(DEPTNO, JOB);

--Q22) GROUPING SETS
--GROUP BY 뒤에 선언되는 함수 / 여러개를 그룹화 할 수 있다
--(DEPTNO, JOB, MGR) (DEPTNO, MGR) (JOB, MGR) 이런 식으로 
--CASE1) 그룹 합집합 UNION ALL
SELECT DEPTNO, JOB, MGR, AVG(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO, JOB, MGR
UNION ALL
SELECT DEPTNO, NULL, MGR, AVG(SAL) --NULL로 COLUMN수 맞추기
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

--Q23) 조합열
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

--Q24) 분석 함수 MAX, MIN, COUNT, LAG, LEAD, RANK
--              RATIO_TO_REPORT, ROW_NUMBER, SUM, AVG 등
/*
  ARGS: 0~3개까지만 줄 수 있다
  [형식] 테이블에서 몇행부터 몇행까지 GROUPING해서 정렬한 다음 분석함수의 결과를 RETURN
        [테이블 -> 선택 행 -> GROUPING -> 정렬 -> 집계 리턴]
  SELECT 
        분석함수(ARGS) OVER (
        [PARTITION_BY_CLAUSE] 쿼리 결과를 그룹으로 묶는다
        [ORDER_BY_CLAUSE] 위에서 묶은 각각의 그룹에 대해 정렬(행의 검색 순서) 
                   ASC/DESC/NULL/FIRST/LAST
                   EX) DESC NULL FIRST, ASC NULL LAST
        [WINDOWING_CLAUSE] ROWS/RANGE(BETWEEN AND)
                            )
  FROM 테이블명;
  
*/
-- 사원번호, 이름, 부서번호, 급여, 부서내에서 급여가 많은 사원부터 순위를 출력하자
SELECT EMPNO, ENAME, DEPTNO, SAL,
       RANK() OVER (PARTITION BY DEPTNO
                    ORDER BY SAL DESC) "부서내 급여 순위"
FROM SCOTT.EMP;

SELECT EMPNO, ENAME, DEPTNO, SAL,
      DENSE_RANK() OVER (PARTITION BY DEPTNO
                   ORDER BY SAL DESC) "부서내 급여 순위"
FROM SCOTT.EMP;

--Q25) CUME_DIST(): 누적된 분산정도를 출력
-- 20번 사원의 이름, 급여, 누적분산을 출력해보자
SELECT EMPNO, ENAME, DEPTNO, SAL,
      CUME_DIST() OVER (ORDER BY SAL)
FROM SCOTT.EMP
WHERE DEPTNO = 20;

--Q26) NTILE(N) 
-- 사원의 급여를 기준으로 4등분
SELECT EMPNO, ENAME, DEPTNO, SAL,
       NTILE(4) OVER (ORDER BY SAL)
FROM SCOTT.EMP;

--Q27) 사원이름, 부서번호, 급여, 전체 급여 합계, 부서별 급여 합계를 출력
SELECT ENAME, DEPTNO, SAL,
      SUM(SAL) OVER () "TOTAL_SUM",
      SUM(SAL) OVER (PARTITION BY DEPTNO) "DEPT_SUM"
FROM SCOTT.EMP;

--ORDER BY SAL을 주면 누적합계를 구해준다
SELECT ENAME, DEPTNO, SAL,
      SUM(SAL) OVER () "TOTAL_SUM",
      SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL) "DEPT_SUM"
FROM SCOTT.EMP;

--Q28) 사원이름, 직업, 급여, 직업별 평균 급여, 직업중에 최대급여
SELECT ENAME, JOB, SAL, 
      ROUND(AVG(SAL) OVER (PARTITION BY JOB)) "SAL_AVG BY JOB",
      MAX(SAL) OVER (PARTITION BY JOB) "MAX_SAL BY JOB"
FROM SCOTT.EMP;

--ORDER BY SAL을 주면 누적 평균을 준다
SELECT ENAME, JOB, SAL, 
      ROUND(AVG(SAL) OVER (PARTITION BY JOB ORDER BY SAL)) "SAL_AVG BY JOB",
      MAX(SAL) OVER (PARTITION BY JOB) "MAX_SAL BY JOB"
FROM SCOTT.EMP;

--Q29) 사원이름, 부서번호, 급여의 합계를 3줄씩 더한 결과, 누적합계를 출력
SELECT ENAME, DEPTNO, SAL,
      SUM(SAL) OVER (ORDER BY SAL ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) "SUM1",
      SUM(SAL) OVER (ORDER BY SAL ROWS UNBOUNDED PRECEDING) "SUM2" 
FROM SCOTT.EMP;

--Q30) RATIO_TO_REPORT를 이용해서 해당 구간을 차지하는 비율을 RETURN
--사원의 전체 급여를 50000원으로 하고 기존 비율을 유지했을 경우 각 사원의 월급
SELECT ENAME, SAL, ROUND(RATIO_TO_REPORT(SAL) OVER (),2) AS "비율",
       ROUND(50000 * (RATIO_TO_REPORT(SAL) OVER ())) AS "전체 급여 50000원"
FROM SCOTT.EMP;

--Q31) LAG: GROUPING 내에서 상대적 ROW를 참조
-- 이전 행(상위에 위치한)의 값을 RETURN
-- LAG(SAL, 2, 0): 2행씩 넘겨서 참조
SELECT ENAME, DEPTNO, SAL, LAG(SAL, 1, 0) OVER (ORDER BY SAL) "NEXT_SAL",
       LAG(SAL, 1, SAL) OVER (ORDER BY SAL) "NEXT_SAL02",
       LAG(SAL, 1, SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL) "NEXT_SAL03"
FROM SCOTT.EMP;

--Q32) LEAD: GROUPING 내에서 상대적 ROW를 참조
-- 다음 행(하위에 위치한)의 값을 RETURN
SELECT ENAME, DEPTNO, SAL, LEAD(SAL, 1, 0) OVER (ORDER BY SAL) "NEXT_SAL",
       LEAD(SAL, 1, SAL) OVER (ORDER BY SAL) "NEXT_SAL02",
       LEAD(SAL, 1, SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL) "NEXT_SAL03"
FROM SCOTT.EMP;







