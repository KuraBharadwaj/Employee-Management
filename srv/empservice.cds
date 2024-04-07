using employeemng as em from '../db/schema';

@path: 'service/employee'
service EmpService {
    entity Employees as projection on em.Employees;
    annotate Employees with @odata.draft.enabled ;

    entity Roles as projection on em.Roles;
    annotate Roles with @odata.draft.enabled;
}
