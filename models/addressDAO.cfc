component displayname="addressDAO - used for CRUD - single records." output="true" hint="DAO class addressDAO" 
{
	property name="addrID" type="numeric" default="0" ;
    property name="addressLine1" type="string" default="" ;
    property name="city" type="string" default="";
    property name="state" type="string" default="";
    property name="zip" type="string" default="";    

    property name="objUtilities" inject="utilities"; 

    _dsn = "ncc-web";

    // Pseudo-Constructor  --->
    variables.instance = { addrID=0, addressLine1='', city='', state='', zip='' } ;

    public any function createNewAddressRecord( required addressBean bean )
    {
        // Add the Farmer, first 
        // Instantiate a farmer bean and load it up 
		objFarmerBean = new farmerBean();
        objFarmerBean.setFirstName("#bean.getFirstName()#");
        objFarmerBean.setLastName("#bean.getLastName()#");                        
        objFarmerBean.setEmailAddress("#bean.getEmailAddress()#");
        objFarmerBean.setPhoneNumber("#objUtilities.formatPhone(bean.getPhoneNumber())#");        
        
        // Add the farmer and returns a farmer bean 
        newFarmerBean = new farmerDAO().createNewFarmerRecord(objFarmerBean);

        // Now add the address 
        nextAddrID = 0;

        // First, get next AddrID 
        try 
        {
            sql = "SELECT MAX(AddrID) + 1 'Next_AddrID' FROM bfc_Address";
            strParams = {};
            strOptions = {datasource=_dsn};
    
            qNextID = queryExecute(sql, strParams, strOptions );
    
            if (qNextID.Next_AddrID neq "" )    
            {
                nextAddrID = #qNextID.Next_AddrID#;
            }
            else
            {
                nextAddrID = 1;
            }
            
            var sql = "SET QUOTED_IDENTIFIER ON;";
            sql = sql & " INSERT INTO bfc_Address ( AddrID, AddressLine1, City, State, Zip ) VALUES ( :addrID, :addressLine1, :city, :state, :zip );";
            sql = sql & "SET QUOTED_IDENTIFIER OFF";
    
            var strParams = {
                addrID   = { value = #nextAddrID#, cfsqltype="cf_sql_numeric" },
                addressLine1 = { value = #arguments.bean.getAddressLine1()#, cfsqltype="cf_sql_varchar" },
                city = { value = #arguments.bean.getCity()#, cfsqltype="cf_sql_varchar" },
                state = { value = #arguments.bean.getState()#, cfsqltype="cf_sql_varchar" },
                zip = { value = #arguments.bean.getZip()#, cfsqltype="cf_sql_varchar" }
            };
            
            strOptions = {datasource=_dsn};
    
            QueryExecute( sql, strParams, strOptions );              
        } 
        catch( any e)
        {
            throw( type="custom", message="Error in createNewAddressRecord - addressDAO.cfc: #e.message#; detail=#e.detail#" );
        }



        /*
            Now we need to map the farmer to the address.  Use the farmer ID that came back from the call to the farmerManager create
            method and the addr ID above to map the farmer and the address together.
        */
        try 
        {
            sql = " INSERT INTO bfc_Farmer_Address_Map ( FarmerID, AddrID ) VALUES ( :farmerID, :addrID );";
            var strParams = {
                farmerID = { value = #newFarmerBean.getFarmerID()#, cfsqltype="cf_sql_numeric" },
                addrID = { value = #nextAddrID#, cfsqltype="cf_sql_varchar" }
            }
            
            strOptions = {datasource=_dsn};
    
            qAddMapping = queryExecute(sql, strParams, strOptions);              
        } 
        catch( any e )
        {
            throw( type="custom", message="Error in createNewAddressRecord - addressDAO.cfc: #e.message#; detail=#e.detail#" );
        }

        newAddressBean = "";
        newAddressBean = getRecordByAddrID( #nextAddrID# );
        newAddressBean.setFarmerID( #newFarmerBean.getFarmerID()#) ;
        newAddressBean.setFirstName( #newFarmerBean.getFirstName()# );
        newAddressBean.setLastName( #newFarmerBean.getLastName()# );
        newAddressBean.setEmailAddress( #newFarmerBean.getEmailAddress()# );
        newAddressBean.setPhoneNumber( #newFarmerBean.getPhoneNumber()# );

        return  newAddressBean;
    }

    //  READ Address Record 
    public any function getRecordByAddrID( required numeric addrID )
    {
        try 
        {            
            var sql = "SET QUOTED_IDENTIFIER ON;";
            sql = sql & "SELECT AddrID, AddressLine1, City, State, Zip
                        FROM bfc_Address
                        WHERE AddrID = :addrID;";
            sql = sql & "SET QUOTED_IDENTIFIER OFF";
    
            var strParams = {
                addrID = { value = #arguments.addrID#, cfsqltype="CF_SQL_NUMERIC" }
            }
            strOptions = {datasource=_dsn};
    
            qResult = queryExecute(sql, strParams, strOptions);            
        } 
        catch( any e )
        {
            throw( type="custom", message="Error in getRecordByAddrID - addressDAO.cfc: #e.message#; detail=#e.detail#" );
        }

        if ( qResult.RecordCount )
        {
            objAddressBean = new addressBean().init(
                addrID = #qResult.AddrID#, 
                addressLine1 = "#qResult.AddressLine1#", 
                city = "#qResult.City#", 
                state = "#qResult.State#", 
                zip = "#qResult.Zip#");  
        }

        return objAddressBean;
    }
    
    //  UPDATE Address Record 
    public boolean function updateAddressRecord ( required addressBean bean )
    {
        var boolSuccess = true;

        try 
        {

            sql = "UPDATE bfc_Address ";
            sql = sql & "SET AddressLine1 = :addressLine1, ";
            sql = sql & "City = :city, ";
            sql = sql & "State = :state, ";
            sql = sql & "Zip = :zip ";
            sql = sql & "WHERE AddrID = :addrID ;"; 
    
            var strParams = {
                addressLine1 = { value = #arguments.bean.getAddressLine1()#, cfsqltype="CF_SQL_VARCHAR" },
                city = { value = #arguments.bean.getCity()#, cfsqltype="CF_SQL_VARCHAR"},
                state = { value = #arguments.bean.getState()#, cfsqltype="CF_SQL_VARCHAR"},
                zip = { value = #arguments.bean.getZip()#, cfsqltype="CF_SQL_VARCHAR"},
                addrID = { value = #arguments.bean.getAddrID()#, cfsqltype="CF_SQL_NUMERIC"}
            }
            strOptions = {datasource=_dsn};
    
            qResult = queryExecute(sql, strParams, strOptions);                      
        } 
        catch( any e )
        {
            boolSuccess = false;
            throw( type="custom", message="Error in updateAddressRecord - addressDAO.cfc: #e.message#; detail=#e.detail#" );
        }
        
        return boolSuccess;
    }

    public boolean function deleteAddressRecordByAddrID( required numeric addrID )
    {
        var boolSuccess = true;

        try 
        {
            sql = "DELETE FROM bfc_Address WHERE AddrID = :addrID;";
            strParams = { addrID = {value = #arguments.addrID#, cfsqltype="CF_SQL_NUMERIC"}};
            strOptions = {datasource=_dsn};
            qDeleteAddress = queryExecute(sql, strParams, strOptions);                      
        } 
        catch( any e )
        {
            boolSucess = false;
            throw( type="custom", message="Error in deleteAddressRecordByAddrID - addressDAO.cfc: #e.message#; detail=#e.detail#" );
        }

        return boolSuccess;
    }
 
}
