/**
 * Добавление столбцов в таблицу EMPLOYEES:
 *	UPD_COUNTER числового типа для счетчика оптимистичной блокировки
 *	CRT_USER текстового типа для хранения имени пользователя, создавшего запись в таблице
 *	CRT_DATE для хранения даты создания записи
 *	UPD_USER текстового типа для хранения имени пользователя, обновившего запись
 *	UPD_DATE для хранения даты обновления данных
 *
 * @author Sergey Proshchaev
 * @version 1.0 (27.03.2022)
 */
ALTER TABLE employees ADD
( upd_counter number(10),
  crt_user varchar2(50),
  crt_date date,
  upd_user varchar2(50),
  upd_date date);