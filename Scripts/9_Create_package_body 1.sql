CREATE OR REPLACE PACKAGE BODY tabEMPLOYEES AS
   /*
     Revisions:
     Ver        Date        Author             Description
     ---------  ----------  -----------------  ------------------------------------
     1.0        27.03.2022  Sergey Proshchaev  Created this procedure
   */
   PROCEDURE sel(
     p_id IN employees.employee_id%TYPE,
     p_row OUT employees%ROWTYPE,
     p_forUpdate IN BOOLEAN := FALSE,
     p_rase IN BOOLEAN := TRUE) IS
   BEGIN

      IF p_forUpdate = true THEN
         SELECT * INTO p_row FROM employees WHERE employee_id = p_id FOR UPDATE;
      ELSE
         SELECT * INTO p_row FROM employees WHERE employee_id = p_id;
      END IF;

   EXCEPTION

       WHEN NO_DATA_FOUND THEN

         IF p_rase = true THEN
           raise_application_error (01403, 'NO_DATA_FOUND');
         END IF;

   END sel;

   /*
     Revisions:
     Ver        Date        Author             Description
     ---------  ----------  -----------------  ------------------------------------
     1.0        27.03.2022  Sergey Proshchaev  Created this procedure
   */
   PROCEDURE ins(
       p_row IN employees%ROWTYPE,
       p_update IN BOOLEAN := FALSE) IS

     duplicate_record EXCEPTION;
     count_var integer;

   BEGIN

      SELECT count(*) INTO count_var FROM employees WHERE employee_id = p_row.employee_id;

      IF count_var = 0 THEN
        INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
            VALUES (p_row.employee_id, p_row.first_name, p_row.last_name, p_row.email, p_row.phone_number, p_row.hire_date, p_row.job_id, p_row.salary, p_row.commission_pct, p_row.manager_id, p_row.department_id);
      ELSE

        IF (count_var = 1) AND (p_update = true) THEN
            UPDATE employees
              SET first_name = p_row.first_name,
                  last_name = p_row.last_name,
                  email = p_row.email,
                  phone_number = p_row.phone_number,
                  hire_date = p_row.hire_date,
                  job_id = p_row.job_id,
                  salary = p_row.salary,
                  commission_pct = p_row.commission_pct,
                  manager_id = p_row.manager_id,
                  department_id = p_row.department_id
            WHERE employee_id = p_row.employee_id;
        END IF;

        IF (count_var > 1) THEN
          RAISE duplicate_record;
        END IF;

      END IF;

   EXCEPTION
       WHEN duplicate_record THEN
           raise_application_error (-01403, 'duplicate_record');
   END ins;

   /*
     Revisions:
     Ver        Date        Author             Description
     ---------  ----------  -----------------  ------------------------------------
     1.0        27.03.2022  Sergey Proshchaev  Created this procedure
   */
   PROCEDURE upd(
      p_row IN employees%ROWTYPE,
      p_insert IN BOOLEAN := FALSE) IS

      count_var integer;
   BEGIN

      SELECT count(*) INTO count_var FROM employees;

      IF count_var = 1 THEN
            UPDATE employees
              SET first_name = p_row.first_name,
                  last_name = p_row.last_name,
                  email = p_row.email,
                  phone_number = p_row.phone_number,
                  hire_date = p_row.hire_date,
                  job_id = p_row.job_id,
                  salary = p_row.salary,
                  commission_pct = p_row.commission_pct,
                  manager_id = p_row.manager_id,
                  department_id = p_row.department_id
            WHERE employee_id = p_row.employee_id;
      END IF;

      IF (count_var = 0) AND (p_insert = true) THEN
        INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
            VALUES (p_row.employee_id, p_row.first_name, p_row.last_name, p_row.email, p_row.phone_number, p_row.hire_date, p_row.job_id, p_row.salary, p_row.commission_pct, p_row.manager_id, p_row.department_id);
      END IF;

   END upd;


   /*
     Revisions:
     Ver        Date        Author             Description
     ---------  ----------  -----------------  ------------------------------------
     1.0        27.03.2022  Sergey Proshchaev  Created this procedure
   */
   PROCEDURE del(
      p_id IN employees.employee_id%TYPE) IS
   BEGIN
       DELETE FROM employees WHERE employee_id = p_id;
   END del;

   /*
     Revisions:
     Ver        Date        Author             Description
     ---------  ----------  -----------------  ------------------------------------
     1.0        27.03.2022  Sergey Proshchaev  Created this procedure
   */
   FUNCTION exists(
      p_id IN employees.employee_id%TYPE)
      RETURN BOOLEAN IS

      count_var integer;
   BEGIN
      SELECT count(*) INTO count_var FROM employees;

      IF count_var = 1 THEN
        RETURN true;
      ELSE
        RETURN false;
      END IF;

   END exists;


END tabEMPLOYEES;