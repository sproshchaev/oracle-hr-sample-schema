/**
 * Создание новой таблицы MESSAGES, которая содержит очередь сообщений для
 * обработки внешней системой. Столбцы таблицы:
 *	ID - первичный ключ, идентификатор сообщения в очереди, должен присваиваться автоматически
 *	MSG_TEXT - будет содержать текст сообщения
 *	MSG_TYPE – текстовое значение типа сообщения (email, sms и т.п.)
 *	DEST_ADDR – адрес получателя сообщения (email, номер телефона)
 *	MSG_STATE - числовой статус обработки сообщения внешней системой (0 - добавлено в очередь, 1 - успешно отправлено, -1 - отправлено с ошибкой)
 *
 * @author Sergey Proshchaev
 * @version 1.0 (27.03.2022)
 */
CREATE TABLE messages
( id number(10) NOT NULL,
  msg_text varchar2(1000),
  msg_type varchar2(20),
  dest_addr varchar2(50),
  msg_state number(2),
  CONSTRAINT messages_pk PRIMARY KEY (id)
);