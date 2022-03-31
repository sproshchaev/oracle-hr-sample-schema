/**
 * Триггер обновляющий данные в полях в таблицы EMPLOYEES:
 *    UPD_COUNTER числового типа для счетчика оптимистичной блокировки
 *    CRT_USER текстового типа для хранения имени пользователя, создавшего запись в таблице
 *    CRT_DATE для хранения даты создания записи
 *    UPD_USER текстового типа для хранения имени пользователя, обновившего запись
 *    UPD_DATE для хранения даты обновления данных
 *
 * @author Sergey Proshchaev
 * @version 1.0 (27.03.2022)
 */
CREATE OR REPLACE TRIGGER update_employees
BEFORE UPDATE
    ON employees
   FOR EACH ROW
DECLARE
  user_for_insert employees.crt_user%TYPE;
BEGIN

  SELECT user INTO user_for_insert FROM dual;

  :new.upd_counter := :old.upd_counter + 1;

  :new.upd_user := user_for_insert;

  :new.upd_date := sysdate;

END update_employees;