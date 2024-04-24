-- 직원정보 
CREATE TABLE employees (
    id INTEGER AUTO_INCREMENT, -- 일련번호 기본키
    employee_id INTEGER UNSIGNED UNIQUE, -- 사번 
    employee_name VARCHAR(20) NOT NULL, -- 이름
    email VARCHAR(50) NOT NULL, -- 이메일 / account 참조 외래키 v
    phone VARCHAR(20) NOT NULL , -- 연락처
    birth_date DATE NOT NULL, -- 생년월일
    photo VARCHAR(255), -- 증명사진
    status VARCHAR(20) NOT NULL, -- 재직상태
    hire_date VARCHAR(20) NOT NULL, -- 입사일자 
    position_code INTEGER UNSIGNED NOT NULL, -- 직급코드 / positions 참조 외래키
    department_code INTEGER UNSIGNED NOT NULL, -- 부서코드 / departments 참조 외래키
    manager_id INTEGER UNSIGNED, -- 부서 담당자 코드 // departments 참조외래키
    employment_type_code INTEGER UNSIGNED NOT NULL, -- 고용형태 /employment_types 참조 외래키
    PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE departments ( 
    department_code INTEGER UNSIGNED, -- 부서코드
    department_name VARCHAR(20) NOT NULL, -- 부서이름
    manager_id INTEGER UNSIGNED,-- 관리자 이름 
    PRIMARY KEY (department_code, manager_id)
) ENGINE=InnoDB;

-- 직급정보
CREATE TABLE job_positions (
    position_code INTEGER UNSIGNED, -- 직급코드
    position_name VARCHAR(20) NOT NULL, -- 직급이름
    PRIMARY KEY (position_code)
) ENGINE=InnoDB;

-- 고용형태 정보
CREATE TABLE employment_types (
    employment_type_code INTEGER UNSIGNED, -- 고용형태 코드
    employment_type_name VARCHAR(20) NOT NULL, -- 고용형태 이름
    PRIMARY KEY (employment_type_code)
) ENGINE=InnoDB;

-- 이력 
CREATE TABLE job_history (
	id INTEGER AUTO_INCREMENT, -- 일련번호 기본키
    employee_id INTEGER UNSIGNED, -- 사번 / employee 참조 외래키
    start_date DATE NOT NULL, -- 시작일자 (입사, 승진, 부서이동 등)
    end_date DATE, -- 마감일자? (퇴사, 이전 부서 근무기간 등)
    position_code INTEGER UNSIGNED NOT NULL, -- 직급코드 / positions 참조 외래키
    department_code INTEGER UNSIGNED NOT NULL, -- 부서코드 / departments 참조 외래키
    employment_type_code INTEGER UNSIGNED NOT NULL, -- 고용형태코드 / employment_types 참조 외래키
    summary VARCHAR(50), -- 부서이동 및 승진 관련 메모 ex. 부서이동, 팀장으로 승진
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 계정정보
CREATE TABLE accounts (
    employee_id INTEGER UNSIGNED, -- 사번 
    email VARCHAR(50) NOT NULL, -- 이메일 (아이디)
    password VARCHAR(50) NOT NULL, -- 비밀번호
    role VARCHAR(20) NOT NULL, -- 역할 (관리자, 승인권자, 일반)
    PRIMARY KEY (email)
) ENGINE=InnoDB;

-- 출퇴근 기록
CREATE TABLE attendance_record (
    id INTEGER AUTO_INCREMENT, -- 일련번호 기본키
    employee_id INTEGER UNSIGNED NOT NULL, -- 사번
    go_to_work_datetime DATETIME, -- 출근일시
    get_off_work_datetime DATETIME, -- 퇴근일시
    work_time TIME, -- 근무시간 (INSERT INTO ~ timediff 함수)
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 휴가 종류 (명명 규칙 가독성을 고려하여 vacation_code만으로 의미가 명확하다고 판단, type 제거함)
CREATE TABLE vacation_types (
    vacation_code INTEGER UNSIGNED, -- 휴가 코드
    vacation_name VARCHAR(20) NOT NULL, -- 휴가 타입 (연차, 휴직 등)
    PRIMARY KEY (vacation_code)
) ENGINE=InnoDB;

-- 휴가 지급내역
CREATE TABLE vacation_allocation_history (
    id INTEGER AUTO_INCREMENT, -- 일련번호 기본키
    employee_id INTEGER UNSIGNED NOT NULL, -- 사번
    vacation_allocation_date DATE NOT NULL, -- 휴가 지급일자
    vacation_code INTEGER UNSIGNED NOT NULL, -- 휴가종류 / vacation_types 외래키
    allocated_days INTEGER NOT NULL, -- 휴가 지급일수
    summary VARCHAR(50), -- 휴가/휴직 지급 관련 메모
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 휴가 사용내역
CREATE TABLE vacation_usage_history (
    id INTEGER AUTO_INCREMENT, -- 일련번호 기본키
    employee_id INTEGER UNSIGNED NOT NULL, -- 사번
    start_date DATE NOT NULL, -- 시작일자
    end_date DATE NOT NULL, -- 종료일자
    vacation_code INTEGER UNSIGNED NOT NULL, -- 사용한 휴가/휴직 종류 / vacation_of_absence 외래키
    usage_days INTEGER UNSIGNED NOT NULL, -- 사용일수
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 직원별 휴가내역
CREATE TABLE remaining_vacation_days (
    employee_id INTEGER UNSIGNED NOT NULL, -- 사번
    year YEAR NOT NULL, -- 연도
    remaining_days INTEGER NOT NULL, -- 잔여 휴가 일수
    PRIMARY KEY (employee_id, year) -- 복합 기본 키 설정
) ENGINE=InnoDB;

-- 휴직 종류
CREATE TABLE leave_of_absence_types (
	leave_of_absence_code INTEGER UNSIGNED, -- 휴가 코드
	leave_of_absence_name VARCHAR(20) NOT NULL, -- 휴가 타입 (연차, 휴직 등)
    PRIMARY KEY (leave_of_absence_code)
) ENGINE=InnoDB;

-- 휴직 지급내역
CREATE TABLE leave_of_absence_grant_history (
    id INTEGER AUTO_INCREMENT, -- 일련번호 기본키
    employee_id INTEGER UNSIGNED NOT NULL, -- 사번
	grant_date DATE NOT NULL, -- 지급일자
    leave_of_absence_code INTEGER UNSIGNED NOT NULL, -- 휴직종류 / vacation_types 외래키
    days_of_grant INTEGER, -- 휴직 지급일수 (질병휴직의 경우 기간 설정이 승인 당시 어렵기 때문에 not null 제약조건 삭제)
    summary VARCHAR(50), -- 휴가/휴직 지급 관련 메모
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 휴직 사용내역
CREATE TABLE leave_of_absence_usage_history (
    id INTEGER AUTO_INCREMENT, -- 일련번호 기본키
    employee_id INTEGER UNSIGNED NOT NULL, -- 사번
    start_date DATE NOT NULL, -- 시작일자
    end_date DATE NOT NULL, -- 종료일자
    leave_of_absence_code INTEGER UNSIGNED NOT NULL, -- 사용한 휴직 종류 
    usage_days INTEGER UNSIGNED NOT NULL, -- 사용일수
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- INDEX
-- departments
ALTER TABLE departments ADD INDEX (manager_id);

-- FOREIGN KEY
-- employees 
ALTER TABLE employees ADD FOREIGN KEY (email) REFERENCES accounts(email);
ALTER TABLE employees ADD FOREIGN KEY (position_code) REFERENCES job_positions(position_code);
ALTER TABLE employees ADD FOREIGN KEY (department_code) REFERENCES departments(department_code);
ALTER TABLE employees ADD FOREIGN KEY (manager_id) REFERENCES departments(manager_id);
ALTER TABLE employees ADD FOREIGN KEY (employment_type_code) REFERENCES employment_types(employment_type_code);

-- job_history 
ALTER TABLE job_history ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE job_history ADD FOREIGN KEY (position_code) REFERENCES job_positions(position_code);
ALTER TABLE job_history ADD FOREIGN KEY (department_code) REFERENCES departments(department_code);
ALTER TABLE job_history ADD FOREIGN KEY (employment_type_code) REFERENCES employment_types(employment_type_code);

-- vacation_allocation_history 
ALTER TABLE vacation_allocation_history ADD FOREIGN KEY (vacation_code) REFERENCES vacation_types(vacation_code);

-- vacation_usage_record 
ALTER TABLE vacation_usage_history ADD FOREIGN KEY (vacation_code) REFERENCES vacation_types(vacation_code);

-- leave_of_absence_grant_history
ALTER TABLE leave_of_absence_grant_history ADD FOREIGN KEY (leave_of_absence_code) REFERENCES leave_of_absence_types(leave_of_absence_code);

-- leave_of_absence_usage_history
ALTER TABLE leave_of_absence_usage_history ADD FOREIGN KEY (leave_of_absence_code) REFERENCES leave_of_absence_types(leave_of_absence_code);

-- remaining_vacation_days 
AlTER TABLE remaining_vacation_days ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

-- attendance_record
AlTER TABLE attendance_record ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

