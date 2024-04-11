namespace employeemng;

using {
    managed,
    cuid
} from '@sap/cds/common';
using {API_BUSINESS_PARTNER as external} from '../srv/external/API_BUSINESS_PARTNER';

entity Employees : cuid, managed {
    firstname   : String;
    lastname    : String;
    email       : String;
    phone       : String;
    address1    : String;
    address2    : String;
    city        : String;
    state       : String;
    country     : String;
    county      : String;
    zipcode     : Integer;
    salary      : Integer;
    emprole     : Association to Roles;
    criticality : Integer;
    rating      : Integer;
    bp          : Association to BusinessPartners;

}

entity Roles : cuid, managed {
    title       : String;
    description : String;
    level       : String;
    location    : String;
    employees   : Association to many Employees
                      on employees.emprole = $self;
}

entity BusinessPartners as
    projection on external.A_BusinessPartner {
        key BusinessPartner,
            BusinessPartnerFullName as FullName,
    };
