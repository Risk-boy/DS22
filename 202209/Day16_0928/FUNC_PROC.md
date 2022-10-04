```sql
--FUNCTION1
create or replace FUNCTION FUNCTION1 
(
  A IN VARCHAR2 DEFAULT 100 
) RETURN VARCHAR2 AS 
BEGIN
  RETURN NULL;
END FUNCTION1;

--FUNCTION2
create or replace FUNCTION FUNCTION2 (mydata VARCHAR2) RETURN VARCHAR2 AS 

  grade VARCHAR2(5) := mydata;
  res   VARCHAR2(20) := NULL;
BEGIN

  CASE grade
    WHEN 'A' THEN res := 'Excellent';
    WHEN 'B' THEN res := 'Very Good';
    WHEN 'C' THEN res := 'Good';
    WHEN 'D' THEN res := 'Fair';
    WHEN 'F' THEN res := 'Poor';
    ELSE res := 'No such grade';
  END CASE;
  RETURN res;
END FUNCTION2;

--GETBONG
create or replace FUNCTION GETBONG
(
  V_EMPNO IN EMP.EMPNO%TYPE
) RETURN NUMBER AS 
  V_BONG NUMBER;    
  V_SAL EMP.SAL%TYPE;
  V_COMM EMP.COMM%TYPE;
  BEGIN   
    SELECT SAL, NVL(COMM,0) INTO V_SAL, V_COMM 
    FROM EMP
    WHERE EMPNO = V_EMPNO;    
    V_BONG := (V_SAL * 12 + V_COMM); --봉급: 연봉 + 커미션
  RETURN V_BONG;
END;

--강사님 CODE
--CREATE OR REPLACE FUNCTION GETBONG(V_EMPNO IN EMP.EMPNO%TYPE)
--RETURN NUMBER AS
--V_SAL EMP.SAL%TYPE := 0;
--V_TOT NUMBER := 0;
--V_COMM NUMBER := 0;
--BEGIN 
--SELECT SAL, COMM INTO V_SAL, V_COMM
--FROM EMP
--WHERE EMPNO = V_EMPNO;
--V_TOT := V_SAL * 12 + NVL(V_COMM, 0);
--RETURN V_TOT;
--END GETBONG;

--GETDEPT
create or replace FUNCTION GETDEPT 
(
  P_EMPNO IN EMP.EMPNO%TYPE
) RETURN VARCHAR2 AS 
  V_RES VARCHAR2(60);
  V_DEPTNO EMP.DEPTNO%TYPE; --SELECT 문에서 리턴을 하는 부서번호 대입      
  BEGIN   
  SELECT DEPTNO INTO V_DEPTNO FROM EMP
  WHERE EMPNO = P_EMPNO;    -- 사원번호에 해당하는 부서번호출력

  IF V_DEPTNO = 10 THEN
    V_RES := 'ACCOUNTING 부서 사원입니다';
  ELSIF V_DEPTNO = 20 THEN
    V_RES :='RESEACH 부서 사원입니다';
  ELSIF V_DEPTNO = 30 THEN
    V_RES :='SALES 부서 사원입니다';
  ELSIF V_DEPTNO = 40 THEN
    V_RES :='OPERATIONS 부서 사원입니다'; 
  END IF; 
  RETURN V_RES;
END;

--GETSAL
create or replace FUNCTION GETSAL
(
  V_EMPNO IN EMP.EMPNO%TYPE
) RETURN VARCHAR2 AS 
  V_RES VARCHAR2(60);    
  V_SAL EMP.SAL%TYPE;
  BEGIN   
    SELECT SAL INTO V_SAL 
    FROM EMP
    WHERE EMPNO = V_EMPNO;    
    V_RES := TO_CHAR(V_SAL * 12, 'FML999,999')||'만원'; 
  RETURN V_RES;
END;


--------------------------------------------
--EX_GETDEPT
create or replace PROCEDURE  EX_GETDEPT(
  P_EMPNO IN EMP.EMPNO%TYPE, 
  V_RES OUT VARCHAR2)                      
AS   
  V_DEPTNO EMP.DEPTNO%TYPE; --SELECT 문에서 리턴을 하는 부서번호 대입      
  BEGIN   
  SELECT DEPTNO INTO V_DEPTNO FROM EMP
  WHERE EMPNO = P_EMPNO;    -- 사원번호에 해당하는 부서번호출력

  IF V_DEPTNO = 10 THEN
    V_RES := 'ACCOUNTING 부서 사원입니다';
  ELSIF V_DEPTNO = 20 THEN
    V_RES :='RESEACH 부서 사원입니다';
  ELSIF V_DEPTNO = 30 THEN
    V_RES :='SALES 부서 사원입니다';
  ELSIF V_DEPTNO = 40 THEN
    V_RES :='OPERATIONS 부서 사원입니다'; 
  END IF; 
END;

--EX01
create or replace PROCEDURE EX01 
(
  V_EMPNO IN EMP.EMPNO%TYPE
, V_ENAME IN EMP.ENAME%TYPE
, V_DEPTNO IN EMP.SAL%TYPE 
) AS 

  R_EMPNO EMP.EMPNO%TYPE;
  R_ENAME EMP.ENAME%TYPE;
  R_SAL EMP.SAL%TYPE;

--1. 커서 선언: 하나 이상의 ROW를 담을 수 있는 객체
CURSOR EMP_CURSOR IS 
  SELECT EMPNO, ENAME, SAL
  FROM EMP
  WHERE DEPTNO = V_DEPTNO;
BEGIN --2. 실제 코드
  --3. 커서 오픈
  OPEN EMP_CURSOR;
    LOOP 
      FETCH EMP_CURSOR INTO R_EMPNO, R_ENAME, R_SAL; --4. 변수 대입
      EXIT WHEN EMP_CURSOR%ROWCOUNT > 5 OR EMP_CURSOR%NOTFOUND;
      
      DBMS_OUTPUT.PUT_LINE(R_EMPNO||' '||R_ENAME||' '||R_SAL);
    END LOOP;
  CLOSE EMP_CURSOR;
END EX01;

--EX02
create or replace PROCEDURE EX02
IS
   V_EMPNO EMP.EMPNO%TYPE;
   V_ENAME EMP.ENAME%TYPE;
   V_SAL   NUMBER(7,2);
  
 CURSOR EMP_CURSOR(V_DEPTNO NUMBER) IS  --커서에 매개변수 선언
   SELECT EMPNO,ENAME,SAL
   FROM EMP
   WHERE DEPTNO = V_DEPTNO;

BEGIN
  OPEN  EMP_CURSOR(10);
    LOOP
    FETCH EMP_CURSOR INTO V_EMPNO, V_ENAME,V_SAL;
    EXIT  WHEN EMP_CURSOR%ROWCOUNT > 5 OR
         EMP_CURSOR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(V_EMPNO||'  '||V_ENAME||'  '||V_SAL);
    END LOOP;
  CLOSE EMP_CURSOR;

  OPEN  EMP_CURSOR(20);
    LOOP
    FETCH EMP_CURSOR INTO V_EMPNO, V_ENAME,V_SAL;
    EXIT  WHEN EMP_CURSOR%ROWCOUNT > 5 OR
         EMP_CURSOR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(V_EMPNO||'  '||V_ENAME||'  '||V_SAL);
    END LOOP;
  CLOSE EMP_CURSOR;
END EX02;

--PROC01
create or replace PROCEDURE PROC01 AS 
  "BEGIN" varchar2(15) := 'UPPERCASE';
  "Begin" varchar2(15) := 'Initial Capital';
  "begin" varchar2(15) := 'lowercase';
BEGIN
  DBMS_Output.Put_Line("BEGIN");
  DBMS_Output.Put_Line("Begin");
  DBMS_Output.Put_Line("begin");
END PROC01;

--PROC02
create or replace PROCEDURE PROC02 
(
  AAA IN VARCHAR2 DEFAULT 1 
, BBB OUT VARCHAR2  --OUT은 DEFAULT값을 주면 ERROR!!
, CCC IN OUT VARCHAR2
) AS 
BEGIN
  NULL;
END PROC02;

--PROC03
create or replace PROCEDURE PROC03 AS 
-- 1. 변수선언
-- 2. 값 대입
  i integer := 20;
  j int := 10;
  hap int := 0;
  sub int := 0;
  mul number(5) := 0;
  div number(5, 1) := 0.0;
BEGIN
-- 3. 연산
  hap := i + j;
  sub := i - j;
  mul := i * j;
  div := i / j;
-- 4. 출력
  DBMS_OUTPUT.PUT_LINE(i||' + '||j||' = '||hap);
  DBMS_OUTPUT.PUT_LINE(i||' - '||j||' = '||sub);
  DBMS_OUTPUT.PUT_LINE(i||' * '||j||' = '||mul);
  DBMS_OUTPUT.PUT_LINE(i||' / '||j||' = '||div);
  IF i != 20 THEN 
    DBMS_OUTPUT.PUT_LINE('i는 '||i);
  ELSE
    DBMS_OUTPUT.PUT_LINE('i는 '||i);
  END IF;
  
--CASE WHEN THEN  
DECLARE
  grade CHAR(1);
BEGIN
  grade := 'B';

  CASE grade
    WHEN 'A' THEN DBMS_OUTPUT.PUT_LINE('Excellent');
    WHEN 'B' THEN DBMS_OUTPUT.PUT_LINE('Very Good');
    WHEN 'C' THEN DBMS_OUTPUT.PUT_LINE('Good');
    WHEN 'D' THEN DBMS_OUTPUT.PUT_LINE('Fair');
    WHEN 'F' THEN DBMS_OUTPUT.PUT_LINE('Poor');
    ELSE DBMS_OUTPUT.PUT_LINE('No such grade');
  END CASE;
END;
END PROC03;

--PROC04
create or replace PROCEDURE PROC04 AS 
  V_EMP EMP%ROWTYPE;
  CURSOR C1 IS SELECT * FROM EMP;
BEGIN
  OPEN C1;
  -- Fetch entire row into v_employees record:
  LOOP -- 처음부터 끝까지 돌기
    FETCH C1 INTO V_EMP;
    EXIT WHEN C1%NOTFOUND;
    -- Process data here
    DBMS_OUTPUT.PUT_LINE(V_EMP.ENAME||' '||V_EMP.SAL);
  END LOOP;
  CLOSE C1;
END PROC04;
```



