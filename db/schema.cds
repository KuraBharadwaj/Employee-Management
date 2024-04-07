namespace employeemng;

using {
    managed,
    cuid
} from '@sap/cds/common';

entity Employees : cuid, managed {
    firstname : String;
    lastname  : String;
    email     : String;
    phone     : String;
    address1  : String;
    address2  : String;
    city      : String;
    state     : String;
    country   : String;
    county    : String;
    zipcode   : Integer;
    salary    : Integer;
    emprole  : Association to Roles;

}

entity Roles : cuid, managed {
    title       : String;
    description : String;
    level       : String;
    location    : String;
    employees   : Association to many Employees
                      on employees.emprole = $self;
}
