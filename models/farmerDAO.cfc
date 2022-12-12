component displayname="farmerBean" output="false" hint="the bean farmerBean"
{
    property name="farmerID" type="numeric" default=0;
    property name="firstName" type="string" default="";
    property name="lastName" type="string" default="";
    property name="emailAddress" type="string" default="";
    property name="phoneNumber" type="string" default="";
    property name="objUtilities" inject="utilities"; 

    _dsn = "ncc-web";

    // Pseudo-Constructor  --->
    variables.instance = { farmerID=0, firstName='', lastName='', emailAddress='', phoneNumber='' };

    public any function init()
    {
        return this;
    }
    // CREATE a new farmer record
    public any function createNewFarmerRecord( required farmerBean bean )
    {
        nextFarmerID = 0;

        try 
        {
            sql = "SELECT MAX(FarmerID) + 1 'Next_FarmerID' FROM bfc_Farmer;"
            strParams = {};
            strOptions = {datasource:_dsn};
            qNextID = queryExecute(sql, strParams, strOptions);
        } 
        catch( any e )
        {
            throw( type="custom", message="Error in createNewFarmerRecord - farmerDAO.cfc: #e.message#; detail=#e.detail#" );
        }

        if ( qNextID.Next_FarmerID neq "" )
        {
            nextFarmerID = #qNextID.Next_FarmerID#;
        }
        else
        {
            nextFarmerID = 1;
        }

        try 
        {
            sql = "SET QUOTED_IDENTIFIER ON;";
            sql = sql & "INSERT INTO bfc_Farmer (FarmerID, FirstName, LastName, EmailAddress, PhoneNumber)
                        VALUES (:farmerID, :firstName, :lastName, :emailAddress, :phoneNumber);";
            var strParams = {
                farmerID = { value = #nextFarmerID#, cfsqltype="CF_SQL_VARCHAR" },
                firstName = { value = #arguments.bean.getFirstName()#, cfsqltype="CF_SQL_VARCHAR"},
                lastName = { value = #arguments.bean.getLastName()#, cfsqltype="CF_SQL_VARCHAR"},
                emailAddress = { value = #arguments.bean.getEmailAddress()#, cfsqltype="CF_SQL_VARCHAR"},
                phoneNumber = { value = #arguments.bean.getPhoneNumber()#, cfsqltype="CF_SQL_VARCHAR"}
            }
            strOptions = {datasource=_dsn};
            qInsert = queryExecute(sql, strParams, strOptions);
        } 
        catch( any e )
        {
            throw( type="custom", message="Error in createNewFarmerRecord - farmerDAO.cfc: #e.message#; detail=#e.detail#" );
        }

        return getRecordByFarmerID(nextFarmerID);
    }


     //  READ Farmer Record 
     public any function getRecordByFarmerID( required numeric farmerID )
     {
        try 
        {
            sql = "SET QUOTED_IDENTIFIER ON;";
            sql = "SELECT FarmerID, FirstName, LastName, EmailAddress, PhoneNumber
                    FROM bfc_Farmer
                    WHERE FarmerID = :farmerID;";
            strParams = {farmerID = { value = #nextFarmerID#, cfsqltype="CF_SQL_VARCHAR" }};
            strOptions = {datasource=_dsn};
            qResult = queryExecute(sql, strParams, strOptions);
        } 
        catch( any e )
        {
            throw( type="custom", message="Error in getRecordByFarmerID - farmerDAO.cfc: #e.message#; detail=#e.detail#" );
        }

        if ( qResult.RecordCount )
        {
            objFarmerBean = new farmerBean().init(
                farmerID = #qResult.FarmerID#, 
                firstName = "#qResult.FirstName#", 
                lastName = "#qResult.LastName#", 
                emailAddress = "#qResult.EmailAddress#", 
                phoneNumber = "#qResult.PhoneNumber#");
        }

        return objFarmerBean;
    }

    //  UPDATE Farmer Record 
    public boolean function updateFarmerRecord( required addressBean bean )
    {
        var boolSuccess = true;

        try 
        {
            sql = "UPDATE bfc_Farmer ";
            sql = sql & "SET FirstName = :firstName, ";
            sql = sql & "LastName = :lastName, ";
            sql = sql & "EmailAddress = :emailAddress, ";
            sql = sql & "PhoneNumber = :phoneNumber ";
            sql = sql & "WHERE FarmerID = :farmerID;";

            strParams = {firstName = { value = #arguments.bean.getFirstName()#, cfsqltype="CF_SQL_VARCHAR" },
                        lastName = { value = #arguments.bean.getLastName()#, cfsqltype="CF_SQL_VARCHAR" },
                        emailAddress = { value = #arguments.bean.getEmailAddress()#, cfsqltype="CF_SQL_VARCHAR" },
                        phoneNumber = { value = #objUtilities.formatPhone( arguments.bean.getPhoneNumber() )#, cfsqltype="CF_SQL_VARCHAR" },
                        farmerID = { value = #arguments.bean.getFarmerID()#, cfsqltype="CF_SQL_NUMERIC" }};
            strOptions = {datasource=_dsn};
            qResult = queryExecute(sql, strParams, strOptions);
        } 
        catch( any e )
        {
            boolSuccess = false;
            throw( type="custom", message="Error in updateFarmerRecord - farmerDAO.cfc: #e.message#; detail=#e.detail#" );
        }

        return boolSuccess;
    }

    //  DELETE Farmer Record
    public boolean function deleteFarmerRecordByFarmerID( required numeric farmerID )
    {
        var boolSuccess = true;
        // Delete the Farmer 
        try 
        {
            sql = "DELETE FROM bfc_Farmer WHERE FarmerID = :farmerID;";
            strParams = { farmerID = { value=arguments.farmerID, cfsqltype="CF_SQL_NUMERIC"}};
            strOptions = {datasource=_dsn};
            qDeleteFarmer = queryExecute(sql, strParams, strOptions);
        } 
        catch( any e )
        {
            boolSuccess = false;
            throw( type="custom", message="Error in deleteFarmerRecordByFarmerID - farmerDAO.cfc: #e.message#; detail=#e.detail#" );
        }
        // Delete the Farmer-Address map 
        try 
        {
            sql = "DELETE FROM bfc_Farmer_Address_Map WHERE FarmerID = :farmerID;";
            strParams = { farmerID = { value=arguments.farmerID, cfsqltype="CF_SQL_NUMERIC"}};
            strOptions = {datasource=_dsn};
            qDeleteMap = queryExecute(sql, strParams, strOptions);
        } 
        catch( any e )
        {
            boolSuccess = false;
            throw( type="custom", message="Error in deleteFarmerRecordByFarmerID - farmerDAO.cfc: #e.message#; detail=#e.detail#" );
        }

        return boolSuccess;
    }

    //  READ Farmer and Address info based on the farmerID, populate an addressBean and return it 
    public any function getFarmerAndAddressByFarmerID( required numeric farmerID )
    {
        try 
        {
            sql = "SELECT f.FarmerID, RTRIM(f.FirstName) 'FirstName', RTRIM(f.LastName) 'LastName', RTRIM(f.EmailAddress) 'EmailAddress', RTRIM(f.PhoneNumber) 'PhoneNumber',
                    a.AddrID, RTRIM(a.AddressLine1) 'AddressLine1', RTRIM(a.City) 'City', RTRIM(a.State) 'State', RTRIM(a.Zip) 'Zip'
                    FROM bfc_Farmer f, bfc_Address a, bfc_Farmer_Address_Map m
                    WHERE f.FarmerID = m.FarmerID
                    AND a.AddrID = m.AddrID
                    AND m.FarmerID = :farmerID;";

            strParams = {farmerID = { value = #arguments.farmerID#, cfsqltype="CF_SQL_NUMERIC" }};
            strOptions = {datasource=_dsn};
            qResult = queryExecute(sql, strParams, strOptions);
        } 
        catch( any e )
        {
            throw( type="custom", message="Error in getFarmerAndAddressByFarmerID - farmerDAO.cfc: #e.message#; detail=#e.detail#" );
        }

        // Instantiate an addressBean and populate it 
        objAddressBean = new addressDAO().getRecordByAddrID( #qResult.AddrID#) ;
        objAddressBean.setFarmerID(#qResult.FarmerID#);
        objAddressBean.setFirstName(#qResult.FirstName#);
        objAddressBean.setLastName(#qResult.LastName#);
        objAddressBean.setEmailAddress(#qResult.EmailAddress#);
        objAddressBean.setPhoneNumber(#qResult.PhoneNumber#);

        return objAddressBean;
    }
}