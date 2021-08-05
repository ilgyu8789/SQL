-- Q1 매니저가 있는 직원은 몇 명? 106명이 나오게 처리
SELECT count(manager_id) haveMgrCount
FROM employees
WHERE manager_id IS NOT NULL;

-- Q2 직원중에 최고임금과 최저임금을 구하고 두 임금의 차이는?
SELECT MAX(salary) 최고임금, MIN(salary) 최저임금,
    MAX(salary) - MIN(salary) "최고임금 - 최저임금"
FROM employees;

-- Q3 마지막으로 신입사원이 들어온 날은? 0000년 0월 0일 형태로 출력(TO_CHAR)
SELECT TO_CHAR(MAX(hire_date), 'YYYY"년" MM"월" DD"일"')
FROM employees;

-- Q4 부서별 평균임금, 최고임금, 최저임금을 부서아이디와 함께 출력 -> GROUP BY
-- 정렬순서는 부서번호(내림차순) -> ORDER BY
SELECT department_id, avg(salary), max(salary), min(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id DESC;

-- Q5 업무(job_id)별 평균임금, 최고임금, 최저임금을 업무아이다와 함께 출력
-- 정렬순서는 최저임금 내림차순, 평균임금 오름차순으로 출력해라
SELECT job_id, ROUND(AVG(salary)), MIN(salary), MAX(salary)
FROM employees
GROUP BY job_id
ORDER BY MIN(salary) DESC, AVG(salary) ASC;

-- Q6 가장 오래 근속한 직원의 입사일은? "0000년 0월 0일 0요일"로 출력
SELECT TO_CHAR(MIN(hire_date), 'yyyy-mm-dd day')
FROM employees;

-- Q7 평균임금과 최저임금의 차이가 2000미만인 부서, 평균임금, 최저임금 그리고
-- 평균임금-최저임금을 평균임금-최저임금의 내림차순으로 정렬
SELECT department_id,
    AVG(salary),
    MIN(salary),
    AVG(salary) - MIN(salary)
FROM employees
GROUP BY department_id
    HAVING AVG(salary) - MIN(salary) < 2000
ORDER BY AVG(salary) - MIN(salary) DESC;

-- Q8 업무별(JOBS) 최고임금과 최저임금의 차이를 출력, 내림차순으로 정리
SELECT job_id,
    MAX(salary) - MIN(salary) as diff
FROM employees
GROUP BY job_id
ORDER BY diff DESC;

-- Q9 2005년 이후 입사자를 관리자별로 평균급여, 최소급여, 최대급여는?
-- 출력은 관리자별 평균급여가 5000이상 중에서 출력한다
-- 평균급여는 내림차순으로 정렬하고 소수점 첫째자리에서 반올림해라
SELECT manager_id, ROUND(AVG(salary)), MIN(salary), MAX(salary)
FROM employees
WHERE hire_date >= '05/01/01'
GROUP BY manager_id
    HAVING AVG(salary) >= 5000
ORDER BY AVG(salary) DESC;

-- Q10 입사일 기준으로 나눠라
-- 입사일이 02/12/30일 이전이면 창립멤버, 03년은 '03년 입사'
-- 04년은 '04년 입사', 이후 입사자는 '상장 이후 입사' optDate 컬럼의 데이터로 출력
-- 정렬은 입사일을 오름차순으로
SELECT employee_id, salary,
    CASE WHEN hire_date <= '02/12/31' THEN '창립멤버'
        WHEN hire_date <= '03/12/31' THEN '03년 입사'
        WHEN hire_date <= '04/12/31' THEN '04년 입사'
        ELSE '상장이후 입사'
    END optDate, hire_date
FROM employees
ORDER BY hire_date;


