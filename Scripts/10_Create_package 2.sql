CREATE OR REPLACE PACKAGE entEMPLOYEES AS
--------------------------------------------------------------------------
-- ELEMENT           PREFIX        SUFFIX      EXAMPLE        DESCRIPTION            
--------------------------------------------------------------------------
-- variable                         _var       v_var          All variables have ends with "_var" in lowercase
-- exception                        _ex        e_ex           All exceptions have ends with "_ex" in lowercase

/** 
 * Пакет для entEMPLOYEES обработки бизнес-логики объектов из таблицы EMPLOYEES
 *
 * @author Sergey Proshchaev
 * @version 1.0 (27.03.2022)
 */

   /**
    * Процедура employment реализует функционал приема на работу нового
    * сотрудника.
    * Параметры SALARY, COMMISSION_PCT не обязательны для заполнения.
    * Если они пустые, при добавлении записи эти данные заполняются средними
    * значениями по подразделению и штатной должности (JOB_ID, DEPARTMENT_ID)
    * Процедура выбрасывает исключения при нарушении ограничений на данные таблицы.
    * В случае успешного добавления записи в таблицу EMPLOYEES необходимо
    * создать новые сообщения типа email в таблице MESSAGES:
    * - для вновь принятого работника: “Уважаемый < FIRST_NAME > < LAST_NAME >!
    *   Вы приняты в качестве < JOB_TITLE > в подразделение < DEPARTMENT_NAME >.
    *   Ваш руководитель: < JOB_TITLE > < FIRST_NAME > < LAST_NAME >”.
    *   Имя и должность руководителя определить из соответствующих таблиц
    *   по DEPARTMENT_ID и MANAGER_ID
    * - для его руководителя: “Уважаемый < FIRST_NAME > < LAST_NAME >!
    *   В ваше подразделение принят новый сотрудник < FIRST_NAME > < LAST_NAME >
    *   в должности < JOB_TITLE > с окладом < SALARY >”. Значение полей извлечь
    *   из соответствующих таблиц по DEPARTMENT_ID и MANAGER_ID
    *
    * В таблицу job_history добавляется новая запись с значениями employee_id, 
    * start_date, job_id, department_id
    *
    * @author Sergey Proshchaev
    * @version 1.0 (27.03.2022)
    * @param p_first_name IN employees.first_name%TYPE
    * @param p_last_name IN employees.last_name%TYPE
    * @param p_email IN employees.email%TYPE
    * @param p_phone_number IN employees.phone_number%TYPE
    * @param p_job_id IN employees.job_id%TYPE
    * @param p_department_id IN employees.department_id%TYPE
    * @param p_salary IN employees.salary%TYPE
    * @param p_commission_pct IN employees.commission_pct%TYPE
    */
   PROCEDURE employment(
      p_first_name IN employees.first_name%TYPE,
      p_last_name IN employees.last_name%TYPE,
      p_email IN employees.email%TYPE,
      p_phone_number IN employees.phone_number%TYPE,
      p_job_id IN employees.job_id%TYPE,
      p_department_id IN employees.department_id%TYPE,
      p_salary IN employees.salary%TYPE,
      p_commission_pct IN employees.commission_pct%TYPE);

   /**
    * Процедура payrise реализует повышение оклада сотруднику
    * Если SALARY пусто, необходимо повысить оклад на 10%
    * В случае превышения максимального оклада по должности (MAX_SALARY)
    * необходимо выбросить исключение
    * В случае успешного обновления данных в таблице EMPLOYEES создать
    * новое сообщение для руководителя сотрудника следующего вида:
    * “Уважаемый < FIRST_NAME > < LAST_NAME >! Вашему сотруднику
    * < FIRST_NAME > < LAST_NAME > увеличен оклад с < SALARY old > до < SALARY new >”
    *
    * @author Sergey Proshchaev
    * @version 1.0 (27.03.2022)
    * @param p_employee_id IN employees.employee_id%TYPE
    * @param p_salary IN employees.salary%TYPE
    */
   PROCEDURE payrise(
      p_employee_id IN employees.employee_id%TYPE,
      p_salary IN employees.salary%TYPE);

   /**
    * Процедура leave реализует увольнение сотрудника.
    * Для увольнения необходимо в таблице EMPLOYEES очистить значение поля DEPARTMENT_ID.
    * В случае успешного обновления создать сообщение руководителю уволенного сотрудника
    * следующего вида: “Уважаемый < FIRST_NAME > < LAST_NAME >! Из вашего подразделения
    * уволен сотрудник < FIRST_NAME > < LAST_NAME > с должности < JOB_TITLE >.”
    *   
    * В таблице job_history для соответствующего employee_id заполняется столбец end_date
    *
    * @author Sergey Proshchaev
    * @version 1.0 (27.03.2022)
    * @param p_employee_id IN employees.employee_id%TYPE
    */ 
   PROCEDURE leave(
      p_employee_id IN employees.employee_id%TYPE);

END entEMPLOYEES;
