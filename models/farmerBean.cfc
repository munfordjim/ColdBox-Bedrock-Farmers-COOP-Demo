/**
 * I am a new Model Object
 */
component accessors="true" displayname="farmerBean" output="false" hint="the bean farmerBean"
{

	property name="farmerID" type="numeric" default=0;
    property name="firstName" type="string" default="";
    property name="lastName" type="string" default="";
    property name="emailAddress" type="string" default="";
    property name="phoneNumber" type="string" default="";
    
    this.constraints = {
        firstName = {
            required: "true",
            requiredMessage = "Please enter the FIRST NAME of the farmer.",
            type = "string"
        },
        lastName = {
            required: "true",
            requiredMessage = "Please enter the LAST NAME of the farmer.",
            type = "string"
        },
        emailAddress = {
            required: "false",
            type = "email",
            typeMessage = "Please enter a valid email address for the farmer."
        },        
        phoneNumber = {
            required: "false",
            type = "telephone",
            typeMessage = "Please enter a valid PHONE NUMBER for the Farmer's."
        }        
    }    
    // Pseudo-Constructor 
    variables.instance = { farmerID=0, firstName='', lastName='', emailAddress='', phoneNumber='' };

	// Constructor
    public any function init(required numeric farmerID=0, required string firstName="", required string lastName="", required string emailAddress="", required string phoneNumber="")
    {
        setFarmerID(arguments.farmerID);           
        setFirstName(arguments.firstName);
        setLastName(arguments.lastName);     
        setEmailAddress(arguments.emailAddress);
        setPhoneNumber(arguments.phoneNumber);
        
        return this;
    }

    // Get the FULL Farmer Name concatenated together 
    public string function getFullFarmerName()
    {
        full_farmer_name = "";
        full_farmer_name = full_farmer_name & this.getFirstName() & '<BR>' & this.getLastName();
        return full_farmer_name;
    }

    // Used for troubleshooting purposes
    public any function getMemento()
    {
        return variables.instance;
    }

}