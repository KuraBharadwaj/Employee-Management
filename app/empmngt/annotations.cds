using EmpService as service from '../../srv/empservice';

annotate service.Employees with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>FirstName}',
            Value : firstname,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>LastName}',
            Value : lastname,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Email}',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Phone}',
            Value : phone,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Address}',
            Value : address1,
        },
        {
            $Type : 'UI.DataField',
            Value : emprole.title,
            Label : '{i18n>Title}',
        },
    ]
);
annotate service.Employees with {
    emprole @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Roles',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : emprole_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'title',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'description',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'level',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'location',
            },
        ],
    }
};
annotate service.Employees with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'firstname',
                Value : firstname,
            },
            {
                $Type : 'UI.DataField',
                Label : 'lastname',
                Value : lastname,
            },
            {
                $Type : 'UI.DataField',
                Label : 'email',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Label : 'phone',
                Value : phone,
            },
            {
                $Type : 'UI.DataField',
                Label : 'address1',
                Value : address1,
            },
            {
                $Type : 'UI.DataField',
                Label : 'address2',
                Value : address2,
            },
            {
                $Type : 'UI.DataField',
                Label : 'city',
                Value : city,
            },
            {
                $Type : 'UI.DataField',
                Label : 'state',
                Value : state,
            },
            {
                $Type : 'UI.DataField',
                Label : 'country',
                Value : country,
            },
            {
                $Type : 'UI.DataField',
                Label : 'county',
                Value : county,
            },
            {
                $Type : 'UI.DataField',
                Label : 'zipcode',
                Value : zipcode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'salary',
                Value : salary,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Employee Detail',
            ID : 'EmployeeDetail',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Subsections',
                    ID : 'Subsections',
                    Target : '@UI.FieldGroup#Subsections',
                },],
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Role',
            ID : 'RoleDetails',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Role Details',
                    ID : 'RoleDetails1',
                    Target : '@UI.FieldGroup#RoleDetails',
                },],
        },]
);
annotate service.Employees with @(
    UI.SelectionFields : [
        emprole_ID,
    ]
);
annotate service.Employees with {
    emprole @Common.Label : '{i18n>EmployeeRole}'
};
annotate service.Employees with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : firstname,
        },
        TypeName : '',
        TypeNamePlural : '',
    }
);
annotate service.Employees with @(
    UI.FieldGroup #Subsections : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : address1,
                Label : 'Address 1',
            },{
                $Type : 'UI.DataField',
                Value : address2,
                Label : 'Address 2',
            },{
                $Type : 'UI.DataField',
                Value : city,
                Label : 'City',
            },{
                $Type : 'UI.DataField',
                Value : country,
                Label : 'Country',
            },{
                $Type : 'UI.DataField',
                Value : county,
                Label : 'County',
            },{
                $Type : 'UI.DataField',
                Value : createdAt,
            },{
                $Type : 'UI.DataField',
                Value : createdBy,
            },{
                $Type : 'UI.DataField',
                Value : email,
                Label : 'Email',
            },{
                $Type : 'UI.DataField',
                Value : firstname,
                Label : 'Firstname',
            },{
                $Type : 'UI.DataField',
                Value : lastname,
                Label : 'Lastname',
            },{
                $Type : 'UI.DataField',
                Value : phone,
                Label : 'Phone',
            },{
                $Type : 'UI.DataField',
                Value : salary,
                Label : 'Salary',
            },{
                $Type : 'UI.DataField',
                Value : state,
                Label : 'State',
            },{
                $Type : 'UI.DataField',
                Value : zipcode,
                Label : 'Zipcode',
            },],
    }
);
annotate service.Employees with @(
    UI.FieldGroup #RoleDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : emprole.description,
                Label : 'Description',
            },{
                $Type : 'UI.DataField',
                Value : emprole.level,
                Label : 'Level',
            },{
                $Type : 'UI.DataField',
                Value : emprole.location,
                Label : 'Location',
            },{
                $Type : 'UI.DataField',
                Value : emprole.title,
                Label : 'Title',
            },],
    }
);
