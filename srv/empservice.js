//import cds object
const cds = require('@sap/cds');

module.exports = cds.service.impl(async function(){
    // Define constants for entities coming from empservice.cds
    //const { Employees, Roles } = this.entities;

    this.after('READ', 'Employees', (data)=>{
        //check if the data is in Array form
        //console.log(data);
        const employees = Array.isArray(data)?data:[data];

        // looping through the array of employees and check the salary
        employees.forEach((employee)=>{
            if(employee.salary >=120000){
                employee.lastname = 'High Salary'
            }
        });
    } );

});