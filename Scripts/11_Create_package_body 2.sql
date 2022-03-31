CREATE OR REPLACE PACKAGE BODY entEMPLOYEES AS  
   /*
     Revisions:
     Ver        Date        Author             Description
     ---------  ----------  -----------------  ------------------------------------
     1.0        27.03.2022  Sergey Proshchaev  Created this procedure
   */
   PROCEDURE employment(
      p_first_name IN employees.first_name%TYPE, 
      p_last_name IN employees.last_name%TYPE, 
      p_email IN employees.email%TYPE, 
      p_phone_number IN employees.phone_number%TYPE, 
      p_job_id IN employees.job_id%TYPE, 
      p_department_id IN employees.department_id%TYPE, 
      p_salary IN employees.salary%TYPE, 
      p_commission_pct IN employees.commission_pct%TYPE) IS
        
      count_var employees.employee_id%TYPE;
      new_employee employees%ROWTYPE;
        
      job_title_var jobs.job_title%TYPE;
        
      department_name_var departments.department_name%TYPE;
      manager_id_var departments.manager_id%TYPE;
        
      salary_var employees.salary%TYPE;
      commission_pct_var employees.commission_pct%TYPE;
        
      manager_first_name_var employees.first_name%TYPE;
      manager_last_name_var employees.last_name%TYPE;
      manager_job_id_var employees.job_id%TYPE;
      manager_email_var employees.email%TYPE;
        
      manager_job_title_var jobs.job_title%TYPE;
      min_salary_var jobs.min_salary%TYPE; 
      max_salary_var jobs.max_salary%TYPE;
        
      msg_text_new_employee_var messages.msg_text%TYPE;
      msg_text_manager_var messages.msg_text%TYPE;
        
      no_data_name_ex EXCEPTION; 
        
   BEGIN
    
      IF (p_first_name IS NULL) OR (p_last_name IS NULL) OR (p_email IS NULL) OR (p_phone_number IS NULL) OR (p_job_id IS NULL) OR (p_department_id IS NULL) THEN          
         RAISE no_data_name_ex;    
      END IF;   
            
      SELECT count(*) INTO count_var FROM employees;

      SELECT manager_id INTO manager_id_var FROM departments WHERE department_id = p_department_id;

      IF p_salary IS NULL THEN
         SELECT min_salary, max_salary INTO min_salary_var, max_salary_var FROM jobs WHERE job_id = p_job_id;
         salary_var := (min_salary_var + max_salary_var)/2;
      ELSE
         salary_var := p_salary; 
      END IF;

      IF p_commission_pct IS NULL THEN
         SELECT AVG(commission_pct) INTO commission_pct_var FROM employees WHERE job_id = p_job_id;
      ELSE
         commission_pct_var := p_commission_pct; 
      END IF;
        
      new_employee.employee_id := count_var + 1;
      new_employee.first_name := p_first_name;
      new_employee.last_name := p_last_name; 
      new_employee.email := p_email;  
      new_employee.phone_number := p_phone_number; 
      new_employee.hire_date := sysdate;
      new_employee.job_id := p_job_id;  
      new_employee.salary := salary_var;  
      new_employee.commission_pct := commission_pct_var; 
      new_employee.manager_id := manager_id_var; 
      new_employee.department_id := p_department_id;  
        
      tabEMPLOYEES.ins(new_employee, TRUE);

      INSERT INTO job_history (employee_id,
                               start_date,
                               end_date,
                               job_id,
                               department_id) 
                       VALUES (new_employee.employee_id,
                               new_employee.hire_date,  
                               null,
                               new_employee.job_id,
                               new_employee.department_id);

      SELECT job_title INTO job_title_var FROM JOBS WHERE job_id = p_job_id;
        
      SELECT department_name, manager_id INTO department_name_var, manager_job_id_var FROM departments WHERE department_id = p_department_id;

      SELECT first_name, last_name, email  INTO manager_first_name_var, manager_last_name_var, manager_email_var FROM employees WHERE employee_id = manager_job_id_var;
        
      SELECT job_title INTO manager_job_title_var FROM jobs WHERE job_id = manager_job_id_var;
        
      msg_text_new_employee_var := 'Уважаемый, ' || TRIM(p_first_name) || ' ' || TRIM(p_last_name) || '! Вы приняты в качестве ' || TRIM(job_title_var) || ' в подразделение ' || TRIM(department_name_var) || '. Ваш руководитель: ' || TRIM(manager_job_title_var) || ' ' || TRIM(manager_first_name_var) || ' ' || TRIM(manager_last_name_var) || '.';

      INSERT INTO messages (msg_text,
                            msg_type,
                            dest_addr,
                            msg_state) 
                    VALUES (msg_text_new_employee_var,
                            'email',  
                            p_email,
                            '1');
       
      msg_text_manager_var := 'Уважаемый, ' || TRIM(manager_first_name_var) || ' ' || TRIM(manager_last_name_var) || '! В ваше подразделение принят новый сотрудник ' || p_first_name || ' ' || p_last_name || ' в должности ' || TRIM(job_title_var) || ' с окладом ' || salary_var || ' руб.'; 
      INSERT INTO messages (msg_text,
                            msg_type,
                            dest_addr,
                            msg_state) 
                    VALUES (msg_text_manager_var,
                            'email',  
                            manager_email_var,
                            '1');

   EXCEPTION     
   
      WHEN no_data_name_ex THEN raise_application_error (01403, 'Argument cannot be null!');
      WHEN OTHERS THEN raise_application_error (-20002,'An error has occurred inserting an order.');

   END employment;     



   /*
     Revisions:
     Ver        Date        Author             Description
     ---------  ----------  -----------------  ------------------------------------
     1.0        27.03.2022  Sergey Proshchaev  Created this procedure
   */
   PROCEDURE payrise(
       p_employee_id IN employees.employee_id%TYPE, 
       p_salary IN employees.salary%TYPE) IS
       
       job_id_var jobs.job_id%TYPE;
       max_salary_var jobs.max_salary%TYPE;
       
       first_name_var employees.first_name%TYPE;
       last_name_var  employees.last_name%TYPE;
       old_salary_var employees.salary%TYPE;
       new_salary_var employees.salary%TYPE;
       manager_id_var employees.manager_id%TYPE;
       manager_first_name_var employees.first_name%TYPE;
       manager_last_name_var employees.last_name%TYPE;
       manager_email_var employees.email%TYPE;
       
       msg_text_manager_var messages.msg_text%TYPE;

       max_salary_exceeded_ex EXCEPTION; 
       
    BEGIN

       SELECT job_id, salary INTO job_id_var, old_salary_var  FROM employees WHERE employee_id = p_employee_id;
       
       SELECT max_salary INTO max_salary_var FROM jobs WHERE job_id = job_id_var;

       IF (p_salary IS NULL) THEN
          new_salary_var := old_salary_var + (old_salary_var/100) * 10; 
       ELSE
          new_salary_var := p_salary;
       END IF;

       IF new_salary_var > max_salary_var THEN
          RAISE max_salary_exceeded_ex;
       ELSE

          UPDATE employees
             SET salary = new_salary_var
          WHERE employee_id = p_employee_id;
   
          SELECT first_name, last_name, manager_id INTO first_name_var, last_name_var, manager_id_var FROM employees WHERE employee_id = p_employee_id;

          SELECT first_name, last_name, email  INTO manager_first_name_var, manager_last_name_var, manager_email_var FROM employees WHERE employee_id = manager_id_var;
                 
          msg_text_manager_var := 'Уважаемый, ' || TRIM(manager_first_name_var) || ' ' || TRIM(manager_last_name_var) || '! Вашему сотруднику ' || TRIM(first_name_var) || ' ' || TRIM(last_name_var) || ' увеличен оклад с ' || old_salary_var || ' до ' || new_salary_var || ' руб.'; 
          
          INSERT INTO messages 
          (msg_text, msg_type, dest_addr, msg_state) 
          VALUES 
          (msg_text_manager_var, 'email',  manager_email_var, '1');
          
       END IF;
       
       EXCEPTION     
          WHEN max_salary_exceeded_ex THEN raise_application_error (01404, 'Max_salary (' || max_salary_var || ' rub.) exceeded!');            

    END payrise;     
   
   /*
     Revisions:
     Ver        Date        Author             Description
     ---------  ----------  -----------------  ------------------------------------
     1.0        27.03.2022  Sergey Proshchaev  Created this procedure
   */
   PROCEDURE leave(
      p_employee_id IN employees.employee_id%TYPE) IS

      job_id_var jobs.job_id%TYPE; 
      job_title_var jobs.job_title%TYPE;
    
      count_employee_id_var employees.employee_id%TYPE;
      first_name_var employees.first_name%TYPE;
      last_name_var  employees.last_name%TYPE;
       
      manager_id_var employees.manager_id%TYPE;
      manager_first_name_var employees.first_name%TYPE;
      manager_last_name_var employees.last_name%TYPE;
      manager_email_var employees.email%TYPE;

      msg_text_manager_var messages.msg_text%TYPE;

      employee_id_not_found_ex EXCEPTION; 
    BEGIN
    
      SELECT count(*) INTO count_employee_id_var FROM employees WHERE employee_id = p_employee_id;
       
      IF (count_employee_id_var = 1) THEN

         UPDATE employees
            SET department_id = NULL
         WHERE employee_id = p_employee_id; 

         UPDATE job_history
            SET end_date = sysdate
         WHERE employee_id = p_employee_id; 

         SELECT first_name, last_name, job_id, manager_id INTO first_name_var, last_name_var, job_id_var, manager_id_var FROM employees WHERE employee_id = p_employee_id;
          
         SELECT job_title INTO job_title_var FROM jobs WHERE job_id = job_id_var;

         SELECT first_name, last_name, email  INTO manager_first_name_var, manager_last_name_var, manager_email_var FROM employees WHERE employee_id = manager_id_var;
                 
         msg_text_manager_var := 'Уважаемый, ' || TRIM(manager_first_name_var) || ' ' || TRIM(manager_last_name_var) || '! Из вашего подразделения уволен сотрудник ' || TRIM(first_name_var) || ' ' || TRIM(last_name_var) || ' с должности ' || job_title_var || '.'; 
          
         INSERT INTO messages (msg_text, msg_type, dest_addr, msg_state) 
            VALUES (msg_text_manager_var, 'email',  manager_email_var, '1');

      ELSE
         RAISE employee_id_not_found_ex;
      END IF;

   EXCEPTION     
      WHEN employee_id_not_found_ex THEN raise_application_error (01405, 'Employee_id not found or undefined!');            
       
   END leave;     
    

END entEMPLOYEES;
