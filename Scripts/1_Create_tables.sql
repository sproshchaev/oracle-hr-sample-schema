/**
 * Создание таблиц стандартной учебной схемы Oracle “HR”
 *
 * @author Sergey Proshchaev
 * @version 1.0 (27.03.2022)
 */
CREATE TABLE job_history
( employee_id number(10) NOT NULL,
  start_date date,
  end_date date,
  job_id number(10),
  department_id number(10),
  CONSTRAINT job_history_pk PRIMARY KEY (employee_id)
);

CREATE TABLE jobs
( job_id number(10) NOT NULL,
  job_title varchar2(50),
  min_salary number(10,2),
  max_salary number(10,2),
  CONSTRAINT jobs_pk PRIMARY KEY (job_id)
);

CREATE TABLE departments
( department_id number(10) NOT NULL,
  department_name varchar2(50),
  manager_id number(10),
  location_id number(10),
  CONSTRAINT departments_pk PRIMARY KEY (department_id)
);

CREATE TABLE employees
( employee_id number(10) NOT NULL,
  first_name varchar2(50),
  last_name varchar2(50),
  email varchar2(50),
  phone_number varchar2(50),
  hire_date date,
  job_id number(10),
  salary number(10,2),
  commission_pct number(10,2),
  manager_id number(10),
  department_id number(10),
  CONSTRAINT employees_pk PRIMARY KEY (employee_id)
);

CREATE TABLE locations
( location_id number(10) NOT NULL,
  street_address varchar2(50),
  postal_code varchar2(50),
  city varchar2(50),
  state_province varchar2(50),
  country_id number(10),
  CONSTRAINT locations_pk PRIMARY KEY (location_id)
);

CREATE TABLE countries
( country_id number(10) NOT NULL,
  country_name varchar2(50),
  region_id number(10),
  CONSTRAINT countries_pk PRIMARY KEY (country_id)
);

CREATE TABLE regions
( region_id number(10) NOT NULL,
  region_name varchar2(100),
  CONSTRAINT regions_pk PRIMARY KEY (region_id)
);