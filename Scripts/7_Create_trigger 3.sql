/**
 * Триггер добавляющий данные в поле messages.id
 *
 * @author Sergey Proshchaev
 * @version 1.0 (27.03.2022)
 */
CREATE OR REPLACE TRIGGER insert_messages
BEFORE INSERT
    ON messages
   FOR EACH ROW
BEGIN

  SELECT message_id_sequence.nextval INTO :new.id FROM dual;

END insert_messages;