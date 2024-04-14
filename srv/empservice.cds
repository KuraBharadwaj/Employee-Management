using employeemng as em from '../db/schema';

@path: 'service/employee'
service EmpService @(requires: 'authenticated-user') {
    entity Employees @(restrict: [
        {
            grant: 'READ',
            to   : 'EmployeeViewer'
        },
        {
            grant: '*',
            to   : 'EmployeeAdmin'
        }
    ])                      as projection on em.Employees;

    annotate Employees with @odata.draft.enabled;

    entity Roles @(restrict: [
        {
            grant: 'READ',
            to   : 'EmployeeViewer'
        },
        {
            grant: '*',
            to   : 'EmployeeAdmin'
        }
    ])                      as projection on em.Roles;

    annotate Roles with @odata.draft.enabled;

    //Make the Businesspartner readOnly.
    @readonly
    entity BusinessPartners as projection on em.BusinessPartners;
}
