/**
 * Тестирование функционала: 
 * - прием сотрудника с расчетом средней зарплаты, 
 * - повышение оклада на 10%, 
 * - увольнение сотрудника 
 *
 * @author Sergey Proshchaev
 * @version 1.0 (27.03.2022)
 */
exec entEMPLOYEES.employment('Антон', 'Антонов', 'aantonov@ourcompany.com', '+7(495)123-45-73', 4, 2, null, null);
exec entEMPLOYEES.payrise(7, null); 
exec entEMPLOYEES.leave(7);