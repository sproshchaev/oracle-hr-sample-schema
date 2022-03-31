INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES (1, 'Генеральный директор', 1000000.00, 1500000.00);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES (2, 'Директор департамента', 700000.00, 1000000.00);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES (3, 'Руководитель проекта', 500000.00, 700000.00);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES (4, 'Java-разработчик', 300000.00, 500000.00);
INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES (5, 'Специалист по закупкам', 300000.00, 400000.00);

INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES ( 1, 'АУП', 2, 1);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES ( 2, 'Департамент разработки', 2, 1);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES ( 3, 'Департамент АХО', 2, 1);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES ( 1, 'Иван', 'Иванов', 'iivanov@ourcompany.com', '+7(495)123-45-67', sysdate - 365, 1, 1200000.00, 0.00, 1, 1);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES ( 2, 'Петр', 'Петров', 'ppetrov@ourcompany.com', '+7(495)123-45-68', sysdate - 180, 2, 800000.00, 0.00, 1, 2);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES ( 3, 'Семен', 'Семенов', 'ssemenov@ourcompany.com', '+7(495)123-45-69', sysdate - 270, 2, 700000.00, 0.00, 1, 3);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES ( 4, 'Степан', 'Степанов', 'sstepanov@ourcompany.com', '+7(495)123-45-70', sysdate - 150, 3, 600000.00, 0.00, 2, 2);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES ( 5, 'Егор', 'Егоров', 'eegorov@ourcompany.com', '+7(495)123-45-71', sysdate - 130, 5, 300000.00, 0.00, 3, 3);
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES ( 6, 'Сергей', 'Сергееев', 'ssergeev@ourcompany.com', '+7(495)123-45-72', sysdate - 100, 4, 500000.00, 0.00, 4, 2);

INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (1, sysdate - 365, NULL, 1, 1); 
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (2, sysdate - 180, NULL, 2, 2);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (3, sysdate - 270, NULL, 2, 3);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (4, sysdate - 150, NULL, 3, 2);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (5, sysdate - 130, NULL, 5, 3);
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id) VALUES (6, sysdate - 100, NULL, 4, 2);

INSERT INTO regions (region_id, region_name) VALUES (72, 'Тюменская область');
INSERT INTO regions (region_id, region_name) VALUES (77, 'Москва');	        
INSERT INTO regions (region_id, region_name) VALUES (78, 'Санкт-Петербург');	

INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (1, 'улица Тверская,13', '125009', 'Москва', '', 2);
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (2, 'улица Малая Садовая, 1', '191060', 'Санкт‑Петербург', '', 3);
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES (3, 'улица Максима Горького, 70', '625048', 'Тюмень', 'Тюменская область', 1);

INSERT INTO countries (country_id, country_name, region_id) VALUES (1, 'Россия', 72);
INSERT INTO countries (country_id, country_name, region_id) VALUES (2, 'Россия', 77);
INSERT INTO countries (country_id, country_name, region_id) VALUES (3, 'Россия', 78);
