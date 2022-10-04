--SELECT COLUMNS FROM TABLE;

--Q1) 사원테이블에서 사원의 이름과 봉급을 출력하자
SELECT ENAME, SAL
FROM SCOTT.EMP;

--Q2) 사원테이블에서 전체 데이터를 출력하자
SELECT *
FROM SCOTT.EMP;

--Q3) 사원테이블에서 사원의 번호, 사원의 이름, 봉급을 출력하자
SELECT EMPNO, ENAME, SAL
FROM SCOTT.EMP;

--Q4) 부서테이블에서 부서의 이름과 부서번호를 출력하자
SELECT DNAME, DEPTNO
FROM SCOTT.DEPT;

--Q5) 사원테이블에서 사원의 번호를 '사번'이라 출력하고 사원의 이름을 '이름'이라 출력하자
--별칭: 컬럼별칭, 테이블의 별칭
--SELECT 컬렴명 별칭 / SELECT 컬럼명 AS 별칭 / SELECT 컬럼명 AS "별 칭"
SELECT EMPNO 사번, ENAME 이름
FROM SCOTT.EMP;

SELECT EMPNO AS 사번, ENAME AS 이름
FROM SCOTT.EMP;

SELECT EMPNO AS "사 번", ENAME AS "이 름"
FROM SCOTT.EMP;

--Q6) 테이블의 별칭을 주자 [명시적: 테이블들에서 동일한 컬럼이 존재할 경우, 묵시적]
--6-1) 사원테이블의 내용과 부서테이블의 전체 내용을 출력하자 56개의 행이 출력되는 이유!
SELECT *
FROM SCOTT.EMP, SCOTT.DEPT; -- CROSS JOIN / ANSI QUERY
--6-2) 사원테이블의 내용과 부서테이블의 내용 중 사원의이름과 부서번호를 출력
SELECT E.ENAME, D.DEPTNO
FROM SCOTT.EMP E, SCOTT.DEPT D; -- 테이블의 명시적인 별칭 -> 테이블명 별칭
--6-3) 사원테이블의 내용과 부서테이블의 내용 중 사원의 이름과 부서번호를 출력
SELECT ENAME, "D".DEPTNO
FROM SCOTT.EMP, SCOTT.DEPT "D"; --double quotation도 가능

SELECT ENAME, D.DEPTNO
FROM SCOTT.EMP, SCOTT.DEPT "D"; --double quotation도 가능

SELECT ENAME, "나".DEPTNO
FROM SCOTT.EMP, SCOTT.DEPT "나"; --한글도 가능

--6-4) 사원테이블의 내용과 부서테이블의 내용 중 사원의 이름과 부서번호를 출력
SELECT ENAME, SCOTT.DEPT.DEPTNO    -- 테이블 명시
FROM SCOTT.EMP, SCOTT.DEPT;

--Q7) 사원의 테이블에서 사원의 이름과 봉급을 출력하되 봉급은 연봉으로 출력하자
--컬럼 + 컬럼
SELECT ENAME, SAL*12 AS 연봉
FROM SCOTT.EMP;

--Q8) 사원의 테이블에서 사원의 이름과 봉급을 출력하되 "OO의 봉급은 OO이다" 형식으로 출력
-- || (연결문자열)
SELECT ENAME||'님' --DOUBLE QUOTATION은 ERROR
FROM SCOTT.EMP;

SELECT ENAME||'의 봉급은 '||SAL||'이다'
FROM SCOTT.EMP;

--Q9) SELECT COLUMN LIST FROM TABLE LIST WHERE 조건문
--사원테이블에서 사원의 이름이 JONES인 레코드 전체를 출력
SELECT *
FROM SCOTT.EMP
WHERE ENAME = 'JONES';

--Q10) 부서테이블에서 부서번호가 10 또는 20인 내용만 출력
SELECT *
FROM SCOTT.DEPT
WHERE DEPTNO = 10 OR DEPTNO = 20;

--Q11) 사원테이블에서 사원의 이름, 사원의 봉급, 커미션, 봉급 + 커미션을 월급이라고 출력
SELECT ENAME, SAL, COMM, SAL+COMM AS 월급
FROM SCOTT.EMP;

SELECT ENAME, SAL, NVL(COMM,0) AS COMM, SAL+NVL(COMM,0) AS 월급
FROM SCOTT.EMP;
-- NULL
--1) NULL은 공백 문자(CMD에서는 보이지 않음), 0은 숫자
--2) NULL의 키워드는 null(소문자)
--3) NULL의 연산결과는 NULL
--4) NULL을 하나라도 포함한 데이터의 연산결과는 NULL
--5) 비어있는 데이터는 NULL

--Q12) 사원테이블에서 이름, 봉급, 커미션, 봉급+커미션을 월급이라고 출력
--NULL을 VALUE로 채우기: nvl(컬럼, 초기값)
SELECT COMM, NVL(COMM,0)
FROM SCOTT.EMP;

--Q13) 사원테이블에서 이름, 커미션을 출력하되 커미션이 책정되지 않는 사원은 봉급으로 채워서 출력
SELECT ENAME, COMM, NVL(COMM, SAL) AS COMM
FROM SCOTT.EMP;

--Q14) 사원의 이름, 매니저를 출력하되 ABCD라는 값의 중간 컬럼으로 추가하자
SELECT ENAME, 'ABCD', MGR
FROM SCOTT.EMP;

--Q15) 사원의 이름(사원), 매니저(매니저)로 출력
SELECT ENAME||'(사원)' AS 사원, MGR||'(매니저)' AS 매니저
FROM SCOTT.EMP;

--Q16) 중복 행 제거
--DISTINCT 키워드를 컬럼명 앞에 선언하여 중복 행 제거 후 단일 행 출력
--같은 컬럼에 있는 동일한 값은 단 한번만 출력
--SELECT 바로 뒤에 사용된다
--DISTINCT 다음에 여러 열을 사용할 수 있다
SELECT JOB
FROM SCOTT.EMP;

--Q17) 부서(DEPT)별 담당하는 업무(JOB)을 한번씩만 조회
SELECT DISTINCT DEPTNO, JOB
FROM SCOTT.EMP;

--Q18) 의사열(PSEUDO COLUMNS): 테이블과 유사하게 QUERY 가능한 열로써 변경은 할 수 없다.
--ROWNUM 
  --SELECT문으로 검색하게 되면 ROW 개수를 RETURN 
  --검색된 행의 일련번호
  --ORDER BY 정렬 전에 부여된다
--ROWID
  --테이블 내에 특정한 행을 구별할 수 있는 ID
SELECT ROWNUM, ROWID, ENAME
FROM SCOTT.EMP;

--Q19) WHERE 사용: 담당업무가 매니저인 사원 정보를 출력
/*
SELECT 컬럼리스트 AS "별 칭" -> "" 타이틀명, '' 데이터 VALUE
FROM 테이블리스트 별칭
WHERE 조건식; -> 열 이름, 비교연산자, 조건연산자 등으로 리턴값이 TRUE인 데이터만 추출
             -> 비교대상: 상수, 열 이름, 값 목록 등으로 이루어진다
             -> 산술, 비교, 논리, LIKE, IN, NOT, BETWEEN, IS NULL, IS NOT NULL, ANY, ALL 등
*/
SELECT * 
FROM SCOTT.EMP
WHERE JOB = 'MANAGER';

--Q20) 급여가 3000이상인 사원의 번호, 사원의 이름, 급여를 출력
SELECT EMPNO, ENAME, SAL
FROM SCOTT.EMP
WHERE SAL >= 3000;

--Q21) 급여가 1300이상 1700이하인 사원 이름, 급여를 출력
SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE SAL BETWEEN 1300 AND 1700;

SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE SAL >= 1300 AND SAL <= 1700;

--Q22) 급여가 1300이상 1700이하가 아닌 사원 이름, 급여를 출력
SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE SAL NOT BETWEEN 1300 AND 1700;

SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE SAL < 1300 OR SAL > 1700;

--Q23) BETWWEN 번외
SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE SAL BETWEEN 1700 AND 1300; --앞에는 항상 작은값!

--Q24) IN: 여러 값 중에 일치하는 값 RETURN
-- IN = ANY
-- NOT IN == ALL
-- 사원번호가 7902, 7788, 7566인 사원의 이름, 사원번호, 입사일을 출력
--TO_DATE, TO_CHAR, TO_NUM
SELECT ENAME, EMPNO, TO_CHAR(HIREDATE, 'YYYY"년" MM"월" DD"일" DAY')
FROM SCOTT.EMP
WHERE EMPNO IN (7902, 7788, 7566);

SELECT ENAME, EMPNO
FROM SCOTT.EMP 
WHERE EMPNO NOT IN (7902, 7788, 7588);

--Q25) LIKE
/*
문자의 패턴이 같은 것 출력
%: 임의의 길이 문자열(공백 가능)
_: 한글자
ESCAPE: 검색할 문자에 %, _ 문자 대응
*/
-- 사원의 이름이 S로 시작하는 사원의 이름, 급여 출력
SELECT ENAME, SAL
FROM SCOTT.EMP
WHERE ENAME LIKE 'S%';

--PLAYER_T 테이블에서 영문이름에 _문자가 들어있는 선수의 정보를 출력
/*
SELECT PNAME
FROM PLAYER_T
WHERE PNAME LIKE '%#_%' ESCAPE '#';
*/

--Q26) NULL 사원테이블에서 커미션이 책정된 사원 출력
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
  논리 연산자는 두 조건의 결과를 결합하여 하나의 결과를 생성하거나 단일 조건의 결과를 부정하기도 한다.
  조건의 전체가 참인 경우에만 행이 반환된다.
  1) WHERE 절 여러 개의 조건을 지정할 때 사용한다.
  2) AND는 모든 조건의 결과가 TRUE여야 선택된다.
  3) OR는 핚 조건의 결과라도 TRUE이면 선택된다.
  4) NOT은 뒤따르는 조건의 결과가 FALSE이면 선택된다.
  5) 우선순위는 NOT, AND, OR 순이다.
  6) (  ) 는 모든 우선 순위 규칙보다 우선한다.  
*/
  
--Q27) EMP 테이블에서 급여가 2800 이상이고 
--JOB이 MANAGER인 사원의 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하자.
SELECT EMPNO, ENAME, JOB, SAL, TO_CHAR(HIREDATE, 'YYYY-MM-DD'), DEPTNO
FROM SCOTT.EMP
WHERE SAL >= 2800 AND JOB = 'MANAGER';

--Q28)EMP 테이블에서 급여가 2800 이상이거나
--JOB이 MANAGER인 사원의 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력한다. 
SELECT EMPNO, ENAME, JOB, SAL, TO_CHAR(HIREDATE, 'YYYY-MM-DD'), DEPTNO
FROM SCOTT.EMP
WHERE SAL >= 2000 OR JOB = 'MANAGER';

--Q29)EMP 테이블에서 JOB이 'MANAGER', 'CLERK', 'ANALYST' 가 아닌 
--사원의 사원번호, 성명, 담당업무, 급여, 부서번호를 출력하자
SELECT EMPNO, ENAME, JOB, SAL, TO_CHAR(HIREDATE, 'YYYY"년" MM"월" DD"일"'), DEPTNO
FROM SCOTT.EMP
WHERE JOB NOT IN ('MANAGER', 'CLERK', 'ANALYST');

--Q30) 데이터 정렬 / 입사일 순으로 정렬해서 사원이름, 급여, 입사일자, 부서번호 출력
/*
  SELECT
  FROM
  WEHRE
  ORDER BY ASC / DESC: ORDER BY는 SELECT문장의 마지막에 명시한다 
  ASC: 오름차순(DEFAULT)
  DESC: 내림차순
  NULL은 오름차순 정렬시 마지막에 표시된다
*/
SELECT ROWNUM, ROWID, ENAME, SAL, HIREDATE, DEPTNO
FROM SCOTT.EMP
ORDER BY HIREDATE ASC;

SELECT ROWNUM, ROWID, ENAME, SAL, HIREDATE, DEPTNO
FROM SCOTT.EMP
ORDER BY 3; --이름순으로 정렬(ENMAE이 3번째 위치)

SELECT ROWNUM, ROWID, ENAME, SAL, HIREDATE, DEPTNO
FROM SCOTT.EMP
ORDER BY HIREDATE DESC;

SELECT ROWNUM, ROWID, ENAME, SAL, HIREDATE, DEPTNO
FROM SCOTT.EMP
ORDER BY SAL DESC;

--Q31) 부서별로 담당하는 업무를 한번씩 조회 후 업무 기준으로 정렬
SELECT DISTINCT DEPTNO, JOB
FROM SCOTT.EMP
ORDER BY JOB; 

SELECT DISTINCT JOB
FROM SCOTT.EMP
ORDER BY JOB;

--Q32) 함수: 문자함수, 숫자함수, 날짜함수, 변환함수, 기타함수(윈도우 함수, 분석함수) 등
-- 공식문서 참조

--Q33) 사원테이블에서 SCOTT의 사원번호, 이름, 담당업무(소문자)를 출력해보자
SELECT EMPNO, ENAME, LOWER(JOB)
FROM SCOTT.EMP
WHERE ENAME = 'SCOTT';

SELECT EMPNO, ENAME, LOWER(JOB)
FROM SCOTT.EMP
WHERE ENAME = UPPER('scott'); -- VALUE는 대소문자를 가림

SELECT EMPNO, INITCAP(LOWER(ENAME)) 
FROM SCOTT.EMP;

--Q34) 사원 이름과 번호를 하나의 컬럼에 작성(|| 사용금지)
SELECT ENAME, EMPNO, CONCAT(ENAME, EMPNO) AS CONCAT
FROM SCOTT.EMP;


/*
  - LOWER(char): 문자열을 소문자로 
- UPPER(char): 문자열을 대문자로 
- INITCAP(char) ? 주어진 문자열의 첫 번째 문자를 대문자로 나머지 문자는 소문자로 변환시켜 준다.
- CONCAT(char1, char2) ? CONCAT 함수는 Concatenation의 약자로 두 문자를 결합
- SUBSTR(s, m ,[n]): 부분 문자열 추출함 . m 번째 자리부터 길이가 n개인 문자열을 반환
    ? m이음수일 경우에는 뒤에서 M번째 문자부터 반대 방향으로 n개의 문자를 반환
- INSTR(s1, s2 , m, n): 문자열 검색, s1의 m번째부터 s2 문자열이 나타나는 n번째 나오는 s2의 위치 반환 / 지정한 문자열이 발견되지 않으면 0 이 반환된다

- LENGTH(s) ? 문자열의 길이를 리턴  
 -CHR(n) ? ASCII값이 n에 해당되는 문자를 리턴
- ASCII (s) ? 해당 문자의 ASCII값 리턴
- LPAD(s1,n,[s2]): 왼쪽에 문자열을 S2를 끼어 놓는 역할,
         n은 반환되는 문자열의 전체 길이를 나타내며, S1의 문자열이 n보다 클 경우 S1을 n개 문자열 만큼 반환.
-RPAD(s1,n,[s2]): LPAD와반대로 오른쪽에 문자열을 끼어 놓는 역할
 -LTRIM (s ,c) , RTRIM (s,c) ? 문자열 왼쪽 c문자열 제거 , 문자열 오른쪽 c문자열 제거
- TRIM ? 특정 문자를 제거 한다.   제거핛 문자를 입력하지 않으면 기본적으로 공백이 제거 된다.  리턴 값의 데이터타입은 VARCHAR2 이다.
- REPLACE(s, from, to): s에서 from 문자열의 각 문자를 to문자열의 각 문자로 변환한다.
- TRANSLATE(s, from, to): s에서 from 문자열의 각 문자를 to문자열의 각 문자로 리턴
*/

--Q35) DEPT 테이블에서 컬럼의 첫 글자들만 대문자로 변화하여 모든 정보를 출력하여라. 
SELECT INITCAP(DEPTNO), INITCAP(DNAME), INITCAP(LOC)
FROM SCOTT.DEPT;

--Q36) EMP 테이블에서 이름의 첫글자가 'K'보고 크고 'Y'보다 작은 사원의 사원번호, 이름, 업무, 급여, 부서번호를 조회한다. 
--단, 이름순으로 정렬하여라. 
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM SCOTT.EMP
WHERE SUBSTR(ENAME, 1, 1) > 'K' AND SUBSTR(ENAME, 1, 1) < 'Y'
ORDER BY ENAME;

--Q37) EMP 테이블에서 부서가 20번인 사원의 사원번호, 이름, 이름의 자릿수, 급여, 급여의 자릿수를 조회한다.LENGTH사용
SELECT EMPNO, ENAME, LENGTH(ENAME), SAL, LENGTH(SAL), DEPTNO
FROM SCOTT.EMP
WHERE DEPTNO = 20;

SELECT LENGTH('가'), LENGTHB('가'), LENGTHB('A'), LENGTHB('가나')
FROM DUAL;
--LENGTHB: Byte를 return(한글은 3bytes차지)

--Q38) EMP 테이블에서 이름 중 'L'자의 위치를 조회한다.
--EX) ALLEN	2	2	3	0
SELECT ENAME, INSTR(ENAME, 'L') "0" , INSTR(ENAME, 'L', 1, 1) "1", INSTR(ENAME, 'L', 1, 2) "2", INSTR(ENAME, 'L', 4, 1) "3" 
FROM SCOTT.EMP;

--Q39) EMP 테이블에서 10번 부서의 사원에 대하여 담당 업무 중 좌측에 'A'를 삭제하고 급여 중 좌측의 1을 삭제하여 출력하여라. 
--LTRIM 사용
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

--Q40) REPLACE함수를 사용하여 사원이름에 SC문자열을 *?로 변경해서 조회. 
SELECT REPLACE(ENAME, 'SC', '*?')
FROM SCOTT.EMP;
--REPLACE 는 통째로 SC가 있어야함

--Q41) TRANSLATE함수를 사용하여 사원이름에 SC문자열을 *?로 변경해서 조회한다
SELECT TRANSLATE(ENAME, 'SC', '*?')
FROM SCOTT.EMP;
--TRANSLATE는 'S', 'C' 를 '*', '?' 에 매칭시켜서 변경
--매칭 문자열이 없으면 삭제
SELECT REPLACE('S123C', 'SC', '*?'), REPLACE('S123SCS', 'SC', '*?')
FROM DUAL;

SELECT TRANSLATE('S123C', 'SC', '*?'), TRANSLATE('S123SCS', 'SC', '*?')
FROM DUAL;

SELECT REPLACE('S12 C', NULL, '*?')
FROM DUAL;

SELECT REPLACE('S12 C', ' ', '*?')
FROM DUAL;

--DESC: 테이블 구조 확인
DESC SCOTT.EMP;

/*
  그룹함수: GROUP BY 키워드와 함께 사용
  SELECT
  FROM
  WHERE
  GROUP BY
  HAVING
  ORDER BY
  
  다중 행 함수는 조건연산을 할 때는 HAVING을 사용한다.
*/

--Q42) 사원테이블의 입사일로 집계함수를 출력해보자
SELECT MIN(HIREDATE), MAX(HIREDATE), MEDIAN(HIREDATE), COUNT(HIREDATE), COUNT(*)
FROM SCOTT.EMP;

--Q43) 사원테이블에서 급여의 MAX, MIN, MEDIAN, AVG, SUM 구하기
SELECT MAX(SAL), MIN(SAL), MEDIAN(SAL), ROUND(AVG(SAL), 2), SUM(SAL)
FROM SCOTT.EMP;

--Q44) 직업별 인원수를 출력해보자
SELECT JOB, COUNT(JOB)
FROM SCOTT.EMP
GROUP BY JOB;

SELECT COUNT(*), COUNT(COMM), COUNT(ENAME)
FROM SCOTT.EMP; --NULL은 COUNT에 집계안됨

--Q45) 사원테이블에서 부서별로 급여의 MAX, MIN, MEDIAN, AVG, SUM 구하기
SELECT DEPTNO, MAX(SAL), MIN(SAL), MEDIAN(SAL), ROUND(AVG(SAL), 0), SUM(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO;

--Q46) 각 부서별로 급여의 MAX, MIN, MEDIAN, AVG, SUM을 구하자
--단 급여의 합이 많은 순으로 정렬
SELECT DEPTNO, MAX(SAL), MIN(SAL), MEDIAN(SAL), ROUND(AVG(SAL), 0), SUM(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO
ORDER BY 6 DESC;

--Q47) 직업, 부서별 급여의 합을 구하자
SELECT JOB, DEPTNO, SUM(SAL)
FROM SCOTT.EMP
GROUP BY JOB, DEPTNO;

--Q48) EMP 테이블에서 부서인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합
SELECT DEPTNO 부서번호, COUNT(*) 부서인원수, SUM(SAL) 급여합계
FROM SCOTT.EMP
GROUP BY DEPTNO
HAVING COUNT(*) > 4;
/*
  WHERE는 집계 함수 이전
  HAVING은 집계 함수 이후에 필터링 작업을 한다.
  HAVING을 이용해 집계함수 결과로 그룹을 제한한다.
  그룹이 형성(행이 분류) -> 그룹함수 계산 -> HAVING절 필터링
  HAVING절은 반드시 GROUP BY에 선언한 컬럼이나 집계함수 비교시 사용
*/
--Q49) 사원테이블에서 급여가 최대 2900 이상인 부서에 대해서 부서번호, 평균, 급여합계 구하기
SELECT DEPTNO, ROUND(AVG(SAL), 0), SUM(SAL)
FROM SCOTT.EMP
GROUP BY DEPTNO
HAVING MAX(SAL) >= 2900;

--Q50) 업무별 급여의 평균이 3000이상인 업무에 대해서 평균급여, 급여합계 구하기
SELECT JOB, ROUND(AVG(SAL), 0), SUM(SAL)
FROM SCOTT.EMP
GROUP BY JOB
HAVING AVG(SAL) >= 3000;

--Q51) 부서별 평균 급여 중 최대값을 조회해보자
SELECT ROUND(MAX(AVG(SAL)), 0)
FROM SCOTT.EMP
GROUP BY DEPTNO;

--Q52) SQL문 실행 순서!!!
/*
  FROM: JOIN을 통해서 테이블을 생성
  WHERE: 한 ROW씩 읽어서 조건을 만족하는 결과 추출
  GROUP BY: 원하는 행들을 GROUPING
  HAVING: 조건을 만족하는 그룹을 RETURN
  ORDER BY: 조건에 따라 정렬
  SELECT: 원하는 결과만 PROJECTION한다
*/

SELECT ENAME, TO_CHAR(SAL, 'FML999,999')
FROM SCOTT.EMP;
