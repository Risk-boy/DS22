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
FROM M JOIN S ON (M1 = S1);

SELECT *
FROM M INNER JOIN S ON (M1 = S1);

-- ORACLE은 ON이나 USING에 있는 구문을 WHERE절로 뺀다
SELECT *
FROM M, S
WHERE M1 = S1;

--Q1) INNER JOIN을 이용해서 사원의 이름과 그 사원이 속해있는 부서이름 출력
--ANSI
SELECT E.ENAME, D.DNAME
FROM EMP E JOIN DEPT D USING(DEPTNO);

SELECT E.ENAME, D.DNAME
FROM EMP E INNER JOIN DEPT D USING(DEPTNO);

--ORACLE
--CASE1
SELECT ENAME, DNAME
FROM EMP E, DEPT D  
WHERE E.DEPTNO = D.DEPTNO; --객체 멤버 = NON-STATIC

--CASE2
SELECT ENAME, DNAME
FROM EMP, DEPT --> Entity / From뒤에 쓸 때만 table이라 부르고 나머지 상황에 대해선 Entity라 부름
WHERE EMP.DEPTNO = DEPT.DEPTNO; --CLASS 이름, 멤버 = STATIC

--Q2) 사원의 이름과 그 사원이 속해있는 부서이름과 부서번호 출력
--ANSI
SELECT E.ENAME, D.DNAME, D.DEPTNO
FROM EMP E JOIN DEPT D ON(E.DEPTNO = D.DEPTNO);

SELECT ENAME, DNAME, DEPTNO
FROM EMP JOIN DEPT USING(DEPTNO);

SELECT E.ENAME, D.DNAME, DEPTNO
FROM EMP E JOIN DEPT D USING(DEPTNO);

--ORACLE
SELECT E.ENAME, D.DNAME, D.DEPTNO
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--CROSS JOIN: 뒤에있는 테이블을 기점으로 앞의 테이블 참조
--ANSI JOIN
SELECT * 
FROM M CROSS JOIN S;

--ORACLE
SELECT *
FROM M, S;

--Q3) LEFT OUTER JOIN
--M 테이블에 있는 내용은 모두 출력되고 S 테이블은 조인결과만 리턴한다
--DB가 값을 안주면 전부 NULL
--NULL을 RETURN 하는 것이 아님!!
--ANSI
SELECT * 
FROM M LEFT OUTER JOIN S ON M1 = S1;

--SERVER SQL JOIN
SELECT * 
FROM M, S 
WHERE M1 = S1(+);

--Q4) RIGHT OUTER JOIN
--ANSI 
SELECT *
FROM M RIGHT OUTER JOIN S ON M1 = S1;

--SERVER SQL JOIN
SELECT *
FROM M, S
WHERE M1(+) = S1;

--Q5) SELF JOIN
--ORACLE
SELECT 사원.EMPNO, 사원.ENAME, 관리자.EMPNO, 관리자.ENAME
FROM EMP 사원, EMP 관리자
WHERE 사원.MGR = 관리자.EMPNO(+);
-- 주는 다나오고 종은 맞는것만 나와라 -> OUTER JOIN
-- 위에서 관리자.EMPNO만 해주면 KING이 NULL값을 갖고 있기 때문에 나오지 않음

--ANSI
SELECT 사원.EMPNO, 사원.ENAME, 관리자.EMPNO, 관리자.ENAME
FROM EMP 사원 LEFT OUTER JOIN EMP 관리자 ON (사원.MGR = 관리자.EMPNO);

--NONEQUI JOIN
SELECT * FROM SALGRADE;

--Q6) 각 사원의 이름과 월급, 그리고 그 사원의 급여 등급을 출력
--ORACLE
SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

--ANSI
SELECT ENAME, SAL, GRADE
FROM EMP JOIN SALGRADE ON (SAL BETWEEN LOSAL AND HISAL);

--Q7) 각 사원의 이름, 월급, 급여등급, 그가 속한 부서이름을 출력
--ORACLE
SELECT E.ENAME, E.SAL, D.DNAME, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE (E.DEPTNO = D.DEPTNO) AND (E.SAL BETWEEN S.LOSAL AND S.HISAL);

--ANSI 3중 JOIN
SELECT ENAME, SAL, DNAME, GRADE
FROM (EMP JOIN SALGRADE ON (SAL BETWEEN LOSAL AND HISAL)) JOIN DEPT USING (DEPTNO);

SELECT ENAME, SAL, DNAME, GRADE
FROM (EMP JOIN DEPT USING(DEPTNO)) JOIN SALGRADE ON (SAL BETWEEN LOSAL AND HISAL);

--Q8) EMP 테이블과 DEPT 테이블을 Cartesian Product 하여 사원번호, 이름, 업무, 부서명, 근무지 코드를 리턴한다
-- CROSS JOIN
SELECT EMPNO, ENAME, JOB, DNAME, LOC
FROM DEPT, EMP
ORDER BY 1;

SELECT COUNT(*) FROM DEPT;

--Q9) SELECT, FROM, START, CONNECT BY PRIOR -> 계층구조 출력 라벨링
SELECT LPAD(' ',2 * LEVEL * 3) || ENAME, LEVEL, EMPNO, MGR, DEPTNO, 
SYS_CONNECT_BY_PATH(ENAME, '-'), CONNECT_BY_ISLEAF --자식이 없으면 1 있으면 0
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR
ORDER SIBLINGS BY ENAME;

SELECT LPAD(' ',2 * LEVEL * 3) || ENAME, LEVEL, EMPNO, MGR, DEPTNO, 
SYS_CONNECT_BY_PATH(ENAME, '-'), CONNECT_BY_ISCYCLE
FROM EMP
START WITH MGR IS NULL
CONNECT BY NOCYCLE PRIOR EMPNO = MGR
ORDER SIBLINGS BY ENAME;


--Q10) 사원테이블에 있는 EMP -> TEST_EMP
CREATE TABLE TEST_EMP AS 
SELECT * FROM EMP;

SELECT * 
FROM TEST_EMP;

--Q11) 사원테이블에 있는 EMP에서 사원의 이름, 사원 봉급 -> TEST_EMP01
CREATE TABLE TEST_EMP01
AS
SELECT ENAME, SAL FROM EMP;

SELECT * 
FROM TEST_EMP01;

-- Q12) 사원테이블에 있는 EMP에서 사원의 이름, 사원의 급여 -> TEST_EMP02
CREATE TABLE TEST_EMP02(사원이름, 급여)
AS
SELECT ENAME, SAL FROM EMP;

SELECT * FROM TEST_EMP02;

--Q13) 사원테이블에 있는 EMP에서 이름, 급여 - > TEST_EMP03
--단 직업이 SALESMAN인 사원들만 추출 테이블 생성
CREATE TABLE TEST_EMP03(사원이름, 봉급)
AS
SELECT ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN';

SELECT * FROM TEST_EMP03;

--Q14) TEST_EMP01 테이블에서 WARD의 월급을 0으로 변경해보자
UPDATE TEST_EMP01
SET SAL = 0
WHERE ENAME = 'WARD';

COMMIT; -- RUD는 COMMIT을 해줘야 완전하게 됨!! -> CMD 확인
SELECT * FROM TEST_EMP01;

UPDATE TEST_EMP01
SET SAL = 0
WHERE ENAME = 'SMITH';

COMMIT;

UPDATE TEST_EMP01
SET SAL = 0 
WHERE ENAME = 'KING';

SELECT * FROM TEST_EMP01;

ROLLBACK; -- COMMIT 하기전에 CRUD에서 U, D에 관한것을 되돌려줌

SELECT * FROM TEST_EMP01;

--------------------------------------
--ex)
CREATE TABLE TEST(
ID NUMBER(5) NOT NULL, -- column 제약조건               
NAME CHAR(10),
ADDRESS VARCHAR2(50));

INSERT INTO TEST VALUES(NULL, NULL, NULL); -- NULL값 입력 불가능
INSERT INTO TEST VALUES(1, '1', '1');
INSERT INTO TEST VALUES(2, NULL, '2');
INSERT INTO TEST VALUES(3, NULL, '3');
INSERT INTO TEST VALUES(4, '4', NULL);
INSERT INTO TEST(ID, NAME) VALUES(5, '5');

COMMIT;

DELETE TEST;

SELECT * FROM TEST;

-- NULL 값을 가진 이름을 출력
SELECT * FROM TEST WHERE NAME IS NULL;

-- NULL 값을 가진 이름만 삭제해보자
DELETE
FROM TEST
WHERE NAME IS NULL;

SELECT * FROM TEST;

--삭제 취소
ROLLBACK;
SELECT * FROM TEST;


-- id 컬럼    --->  usr 컬럼으로 변경
ALTER TABLE TEST RENAME COLUMN ID TO USR;

SELECT * FROM TEST;

-- test 테이블  --> exam 테이블로 변경
ALTER TABLE TEST RENAME TO EXAM;

-- exam 테이블을 삭제하고 휴지통비우기 / exam 테이블을 휴지통에 넣지 않고 바로 삭제
DROP TABLE EXAM;
PURGE RECYCLEBIN;

SELECT * FROM RECYCLEBIN;

DROP TABLE EXAM PURGE;

--ex2) 테이블명 : user1
CREATE TABLE USER1(
IDX     NUMBER  PRIMARY KEY,   -- 식별키(중복데이터 & NULL 안됨!)
ID      VARCHAR2(10) UNIQUE,   -- NULL 포함인데 중복데이터 허용 X
NAME    VARCHAR2(10) NOT NULL, -- NULL 값 안됨
PHONE   VARCHAR2(15),
ADDRESS VARCHAR2(50),
SCORE   NUMBER(6,2)  CHECK(SCORE >=0 AND SCORE <= 100), -- CHECK: TRUE인 값만 허용
SUBJECT_CODE NUMBER(5),
HIRE_DATE DATE DEFAULT SYSDATE, --DEFAULT: 데이터 입력을 하지 않을 경우 NULL대신 주고 싶은 값으로 세팅
MARRIAGE CHAR(1) DEFAULT 'N' CHECK(MARRIAGE IN('Y','N')));

SELECT * FROM USER1;

DESC USER_CONSTRAINTS;

SELECT * FROM USER_CONSTRAINTS;

--EX) 시퀀스 생성(시퀀스는 정적이다)
CREATE SEQUENCE  IDX_SQL INCREMENT BY 2 START WITH 1 MAXVALUE  9  CYCLE NOCACHE;

SELECT  IDX_SQL.NEXTVAL  FROM DUAL;    ---> 다음 시퀀스값표시(nextval)
SELECT  IDX_SQL.CURRVAL  FROM DUAL;    ---> 현재 시퀀스값표시(currtval)
DROP SEQUENCE IDX_SQL;

CREATE SEQUENCE ID_NO
INCREMENT BY 5
START WITH 1
MAXVALUE 20
CYCLE NOCACHE;

--NEXTVAL을 먼저 해주어야 CURRVAL이 정의됨
SELECT ID_NO.NEXTVAL FROM DUAL;
SELECT ID_NO.CURRVAL FROM DUAL;

INSERT INTO TEST01 VALUES(ID_NO.NEXTVAL, SYSDATE);

SELECT * FROM TEST01;


--Q15) INSERT INTO 테이블명 VALUES();
-- 서브쿼리를 이용해서 INSERT를 해보자
-- 사원번호가 7902사원의 부서번호를 SCOTT사원과 동일한 값으로 변경해보자
UPDATE TEST_EMP
SET DEPTNO = (SELECT DEPTNO FROM TEST_EMP WHERE ENAME = 'SCOTT')
WHERE EMPNO = 7902;

SELECT * FROM TEST_EMP;
SELECT DEPTNO FROM EMP WHERE EMPNO = 7902;

SELECT * FROM EMP;

INSERT INTO TEST_EMP
SELECT * FROM EMP
WHERE ENAME = 'SCOTT';

SELECT * FROM TEST_EMP;

--PL/SQL

--프로시저: 작업을 수행하기 위한 서브 프로그램
--함수: 값을 리턴하는 서브 프로그램
--트리거: 특정 이벤트가 발생될 때 자동으로 실행되는 단위

SET SERVEROUTPUT ON

DECLARE
  "HELLO" varchar2(10) := 'hello';
BEGIN
  DBMS_Output.Put_Line(Hello);
END;
/

SELECT FUNCTION2 FROM DUAL;

DECLARE
  V_EMP EMP%ROWTYPE;
  CURSOR C1 IS SELECT * FROM EMP;
BEGIN
  OPEN C1;
  -- Fetch entire row into v_employees record:
  FOR I IN 1..10 LOOP
    FETCH C1 INTO V_EMPLOYEES;
    EXIT WHEN C1%NOTFOUND;
    -- Process data here
  END LOOP;
  CLOSE C1;
END;
/
