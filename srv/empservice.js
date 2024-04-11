//import cds object
const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    // Define constants for entities coming from empservice.cds
    //const { Employees, Roles } = this.entities;

    this.after('READ', 'Employees', (data) => {
        //check if the data is in Array form
        //console.log(data);
        const employees = Array.isArray(data) ? data : [data];

        // looping through the array of employees and check the salary
        employees.forEach((employee) => {
            // initiate switch case statement
            if (employee.salary > 120000) {
                employee.criticality = 3;
            }
            else if (employee.salary < 120000) {
                employee.criticality = 1;
            }
            else {
                employee.criticality = 3;
            }
        });
    });

    //Implement the logic to use the api-key in .env file and call the Business Partner Values. 
    //Declare a constant by connecting to the service through csn
    const BPsrv = await cds.connect.to("API_BUSINESS_PARTNER");

    // Each request to the API requires a key in the header. 
    this.on("READ",'BusinessPartners',async (req)=>{
        //filter the values with firstname and lastname. 
        //add a querey to the request
        req.query.where("LastName <> '' and FirstName <> ''").limit(10);

        //Connect to the API, using BPsrv constant variable and pass the query and apikey in headers. 
        return await BPsrv.transaction(req).send({
            query : req.query,
            headers: {
                apikey : process.env.apikey,
            },
        });
    });
});


