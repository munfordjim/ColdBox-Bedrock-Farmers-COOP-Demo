component accessors="true" displayname="addressBean" output="false" hint="the bean addressBean" extends="farmerBean"
{

    property name="validationToken" type="string" default="" ;  
	property name="addrID" type="numeric" default="0" ;
    property name="addressLine1" type="string" default="" ;
    property name="city" type="string" default="";
    property name="state" type="string" default="";
    property name="zip" type="string" default="";
    property name="objUtilities" inject="utilities"; 

    this.constraints = {
        validationToken = {
            required: "true",
            requiredMessage = "Please enter the FIRST NAME of the farmer.",
            udf =  ( value, target, metadata ) => objUtilities.checkForm( target ),
            udfMessage = "<h4 class='text-danger'>ERROR:</h4><BR>Could not submit the form.<BR>Please use the button below to return to the form and try again.<BR><BR></div>"            
        },
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
            udf =  ( value, target, metadata ) => objUtilities.validatePhoneNumber( value ),
            udfMessage = "<h4 class='text-danger'>ERROR:</h4><BR>Could not format phone number.  Be sure the phone number entered does not start with a 0 or 1 and has 10 numeric digits.<BR>Please use the button below to return to the form and provide clean data.<BR><BR></div>"
        },
        addressLine1 = {
            required: "true",
            requiredMessage = "<h4 class='text-danger'>ERROR:</h4><BR>Could not validate the farmer's address.  Please use the button below to return to the form and provide a valid address.<BR><BR></div>..",
            type = "string",
            typeMessage = "<h4 class='text-danger'>ERROR:</h4><BR>Could not validate the farmer's address.  Please use the button below to return to the form and provide a valid address.<BR><BR></div>."
        },
        city = {
            required: "true",
            requiredMessage = "<h4 class='text-danger'>ERROR:</h4><BR>Could not validate the farmer's city.  Please use the button below to return to the form and provide a valid city.<BR><BR></div>.",
            type = "string",
            typeMessage = "<h4 class='text-danger'>ERROR:</h4><BR>Could not validate the farmer's city.  Please use the button below to return to the form and provide a valid city.<BR><BR></div>."
        },
        state = {
            required: "true",
            requiredMessage = "<h4 class='text-danger'>ERROR:</h4><BR>Could not validate the farmer's state.  Please use the button below to return to the form and provide a valid state.<BR><BR></div>.",
            regex = "^(?:(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]))$",
            regexMessage = "<h4 class='text-danger'>ERROR:</h4><BR>Could not validate the farmer's state.  Please use the button below to return to the form and provide a valid state.<BR><BR></div>."
        },        
        zip = {
            required: "true",
            requiredMessage = "<h4 class='text-danger'>ERROR:</h4><BR>The farmer's zip code is required.  Please use the button below to return to the form and provide a valid zip code.<BR><BR></div>.",
            type = "zipcode",
            typeMessage = "<h4 class='text-danger'>ERROR:</h4><BR>Could not validate they zip code.  Please use the button below to return to the form and provide a valid zip code.<BR><BR></div>."
        }        
    }

    // Pseudo-Constructor
    variables.instance = { addrID=0, addressLine1='', city='', state='', zip='' };

    public any function init (required numeric addrID=0, required string addressLine1="", required string city="", required string state="", required string zip="" )
    {
        setAddrID(arguments.addrID);          
        setAddressLine1(arguments.addressLine1);
        setCity(arguments.city);           
        setState(arguments.state);
        setZip(arguments.zip);

        Super.init();

        return this;
    }

    public string function getFullAddress()
    {
        full_address = "";
        full_address = full_address & this.getAddressLine1() & '<BR>' & this.getCity() & ', ' & this.getState() & ' ' & this.getZip();
        return full_address;
    }

    // Used for troubleshooting purposes 
    public any function getMemento()
    {
        return variables.instance;
    }



}