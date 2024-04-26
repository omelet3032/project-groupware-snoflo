-- 부서정보
INSERT INTO departments (department_code, department_name, manager_id)
VALUES (101, 'CEO실', 1);
INSERT INTO departments (department_code, department_name, manager_id)
VALUES (102, '경영지원팀', 2);
INSERT INTO departments (department_code, department_name, manager_id)
VALUES (103, '개발실', 3);
INSERT INTO departments (department_code, department_name, manager_id)
VALUES (104, 'devops', 3);

-- 직급정보
INSERT INTO job_positions (position_code, position_name)
VALUES (201, 'CEO');
INSERT INTO job_positions (position_code, position_name)
VALUES (202, '실장');
INSERT INTO job_positions (position_code, position_name)
VALUES (203, '팀장');
INSERT INTO job_positions (position_code, position_name)
VALUES (204, '매니저');

-- 고용형태 정보
INSERT INTO employment_types (employment_type_code, employment_type_name)
VALUES (10, '정규직');
INSERT INTO employment_types (employment_type_code, employment_type_name)
VALUES (20, '계약직');
INSERT INTO employment_types (employment_type_code, employment_type_name)
VALUES (30, '인턴');

-- 계정정보
INSERT INTO accounts (employee_id, email, password, role)
VALUES (1, 'jinwooyu@gmail.com', '1234', '최고관리자');
INSERT INTO accounts (employee_id, email, password, role)
VALUES (2, 'hong@gmail.com', '1234', '승인권자');
INSERT INTO accounts (employee_id, email, password, role)
VALUES (3, 'chul@gmail.com', '1234', '승인권자');
INSERT INTO accounts (employee_id, email, password, role)
VALUES (4, 'young@gmail.com', '1234', '직원');

-- 휴가 정보
INSERT INTO vacation_types (vacation_code, vacation_name) 
VALUES (301, '연차');
INSERT INTO vacation_types (vacation_code, vacation_name) 
VALUES (302, '경조사휴가');

-- 휴직 정보
INSERT INTO leave_of_absence_types (leave_of_absence_code, leave_of_absence_name)
VALUES (401, '육아휴직');
INSERT INTO leave_of_absence_types (leave_of_absence_code, leave_of_absence_name)
VALUES (402, '질병휴직');

--사원정보
INSERT INTO employees (employee_id, employee_name, email, phone, birth_date, status, hire_date, position_code, department_code, manager_id, employment_type_code) 
VALUES (1, '유진우', 'jinwooyu@gmail.com', '010-1111-2222', '1990-08-14', '재직', '2024-01-01', 201, 101, 1, 10);
INSERT INTO employees (employee_id, employee_name, email, phone, birth_date, status, hire_date, position_code, department_code, manager_id, employment_type_code) 
VALUES (2, '홍길동', 'hong@gmail.com', '010-1111-3333', '1993-02-11', '재직', '2024-01-01', 202, 103, 2, 10);
INSERT INTO employees (employee_id, employee_name, email, phone, birth_date, status, hire_date, position_code, department_code, manager_id, employment_type_code) 
VALUES (3, '김철수', 'chul@gmail.com', '010-1111-4433', '1995-02-11', '재직', '2024-01-10', 203, 102, 3, 10);
INSERT INTO employees (employee_id, employee_name, email, phone, birth_date, status, hire_date, position_code, department_code, manager_id, employment_type_code) 
VALUES (4, '김영희', 'young@gmail.com', '010-1122-3333', '1996-02-11', '퇴사', '2024-01-20', 204, 104, 3, 10);

-- 직무 이력 정보
INSERT INTO job_history (employee_id, start_date, end_date, position_code, department_code, employment_type_code, summary)
VALUES (4, '2024-01-20', '2024-01-30', 204, 104, 10, '퇴사');

-- 출퇴근기록
INSERT INTO attendance_record (employee_id, go_to_work_datetime, get_off_work_datetime, work_time)
VALUES (1, '2023-01-01 09:00:00', '2023-01-01 18:00:00', timediff('2023-01-01 18:00:00', '2023-01-01 09:00:00'));
commit;



COMMIT;