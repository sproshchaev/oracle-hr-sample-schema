CREATE OR REPLACE PACKAGE tabEMPLOYEES AS
--------------------------------------------------------------------------
-- ELEMENT           PREFIX        SUFFIX      EXAMPLE        DESCRIPTION
--------------------------------------------------------------------------
-- variable                         _var       v_var          All variables have ends with "_var" in lowercase
-- exception                        _ex        e_ex           All exceptions have ends with "_ex" in lowercase

/**
 * Пакет tabEMPLOYEES для обработки операций
 * чтения/записи данных в таблицу EMPLOYEES, содержит
 *   процедуры: sel, ins, upd, del
 *   функции: exists
 * @author Sergey Proshchaev
 * @version 1.0 (27.03.2022)
 */

   /**
    * Процедура выполняет извлечение записи по ключу из таблицы EMPLOYEES
    * Если параметр p_forUpdate TRUE, то выполняется SELECT … FOR UPDATE,
    * в противном случае обычный SELECT
    * При значении TRUE в параметре p_rase происходит вызов исключений,
    * в противном случае исключения игнорируются
    *
    * @author Sergey Proshchaev
    * @version 1.0 (27.03.2022)
    * @param p_id IN employees.employee_id%TYPE
    * @param p_row OUT employees%ROWTYPE
    * @param p_forUpdate IN BOOLEAN
    * @param p_rase IN BOOLEAN
    */
   PROCEDURE sel(
      p_id IN employees.employee_id%TYPE,
      p_row OUT employees%ROWTYPE,
      p_forUpdate IN BOOLEAN := FALSE,
      p_rase IN BOOLEAN := TRUE);

   /**
    * Процедура ins выполняет вставку новой строки
    * При истинном значении параметра p_update, если строка с таким индексом
    * уже существует, выполняется обновление данных.
    * Процедура выбрасывает исключения при дублировании строк и нарушении
    * других ограничений, наложенных на таблицу
    *
    * @author Sergey Proshchaev
    * @version 1.0 (27.03.2022)
    * @param p_row IN employees%ROWTYPE
    * @param p_update IN BOOLEAN
    */
   PROCEDURE ins(
      p_row IN employees%ROWTYPE,
      p_update IN BOOLEAN := FALSE);

   /**
    * Процедура upd выполняет обновление данных в строке
    * (кроме первичного ключа). При истинном значении параметра p_ insert,
    * если строка с таким индексом не существует, выполняется вставка новой
    * строки
    *
    * @author Sergey Proshchaev
    * @version 1.0 (27.03.2022)
    * @param p_row IN employees%ROWTYPE
    * @param p_insert IN BOOLEAN
    */
   PROCEDURE upd(
      p_row IN employees%ROWTYPE,
      p_insert IN BOOLEAN := FALSE);

   /**
    * Процедура del выполняет удаление строки данных
    *
    * @author Sergey Proshchaev
    * @version 1.0 (27.03.2022)
    * @param p_id IN employees.employee_id%TYPE
    */
   PROCEDURE del(
      p_id IN employees.employee_id%TYPE);

   /**
    * Процедура exists возвращает истину, если строка с указанным ключом
    * существует в таблице
    *
    * @author Sergey Proshchaev
    * @version 1.0 (27.03.2022)
    * @param p_id IN employees.employee_id%TYPE
    * @return BOOLEAN
    */
   FUNCTION exists(
      p_id IN employees.employee_id%TYPE)
      RETURN BOOLEAN;

END tabEMPLOYEES;