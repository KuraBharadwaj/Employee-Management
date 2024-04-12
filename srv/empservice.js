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
    this.on("READ", 'BusinessPartners', async (req) => {
        //filter the values with firstname and lastname. 
        //add a querey to the request
        req.query.where("LastName <> '' and FirstName <> ''").limit(10);

        //Connect to the API, using BPsrv constant variable and pass the query and apikey in headers. 
        return await BPsrv.transaction(req).send({
            query: req.query,
            headers: {
                apikey: process.env.apikey,
            },
        });
    });

    //seperate logic has to be written to access BP's when Employee entity is called. 
    // the entity has to expand and call the Business Partner API. 
    //Risks?expand=bp - has to be the logic
    this.on("READ", 'Employees', async (req, next) => {

        /* 
            Check wheather request wants to "expand" the Business Partner entity
            this expand is not possible as both the entites are in differernt systems
            So remove the expand, if it exists
        */

        //If no columns are requested
        if (!req.query.SELECT.columns) return next();

        const expandIndex = req.query.SELECT.columns.findIndex(
            ({ expand, ref }) => expand && ref[0] === "bp"
        );

        //the above query returns "-1" when there is no value for based on condition
        if (expandIndex < 0) return next();

        //If it does not return "-1" which means there is an expand call to "bp"
        //remoe the expand from query

        //Arguments to the splice function are "starting point of slicing" and "number of elements to be removed"
        req.query.SELECT.columns.splice(expandIndex, 1);

        //find the column bp_BusinessPartner, if it's not there push this column into query
        if (!req.query.SELECT.columns.find((column) =>
            column.ref.find((ref) => ref == "bp_BusinessPartner")
        )
        ) {
            req.query.SELECT.columns.push({ ref: ["bp_BusinessPartner"] });
        }

        const employees = await next();
        //Initialize the empty array. 
        const asArray = x => Array.isArray(x) ? x : [x];

        //Request all Bp's anta
        //Get the Business Partner Id's from employees. 
        const bpIDs = asArray(employees).map(employee => employee.bp_BusinessPartner);
        const businessPartners = await BPsrv.transaction(req).send({
            //declare the parameters to the request
            query: SELECT.from(this.entities.BusinessPartners).where({ BusinessPartner: bpIDs }),
            headers: {
                apikey: process.env.apikey,
            }
        });

        //Convert in a map for lookup
        const bpMap = {};   

        for (const businessPartner of businessPartners)
            bpMap[businessPartner.BusinessPartner] = businessPartner;

        //Add the businessPartners to the result
        for (const note of asArray(employees)) {
            note.bp = bpMap[note.bp_BusinessPartner];
        }
        return employees;
    });
});


