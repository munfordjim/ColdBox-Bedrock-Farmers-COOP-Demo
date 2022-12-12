component accessors="true"{

	// Properties
	
	_dsn = "ncc-web";

	/** Constructor */
	apiDAO function init(){

		return this;
	}

    //  READ Farmer and Address info based on the farmerID, populate an addressBean and return it 
    public query function getFarmerAndAddress( any searchString, string field )
    {
        try 
        {
            sql = "SELECT RTRIM(f.FirstName) 'FirstName', RTRIM(f.LastName) 'LastName', RTRIM(f.EmailAddress) 'EmailAddress', RTRIM(f.PhoneNumber) 'PhoneNumber',
                    a.AddrID, RTRIM(a.AddressLine1) 'AddressLine1', RTRIM(a.City) 'City', RTRIM(a.State) 'State', RTRIM(a.Zip) 'Zip'
                    FROM bfc_Farmer f, bfc_Address a, bfc_Farmer_Address_Map m
                    WHERE f.FarmerID = m.FarmerID
                    AND a.AddrID = m.AddrID";
			
			if ( isDefined( "arguments.searchString" ) && isDefined( "arguments.field" ) )
			{
				if ( arguments.field == "FarmerID" )
				{
					sql = sql & " AND f.FarmerID = :farmerID;";
					strParams = {farmerID = { value = #arguments.searchString#, cfsqltype="CF_SQL_NUMERIC" }};
				}
				else if ( arguments.field == "LastName")
				{
					sql = sql & " AND f.LastName like :lastName;";
					strParams = {lastName = { value = "%#arguments.searchString#%", cfsqltype="CF_SQL_VARCHAR" }};				
				}
			}
			else 
			{
				sql = sql & ";";
				strParams = {};
			}
            strOptions = {datasource=_dsn};
            qResult = queryExecute(sql, strParams, strOptions);
        } 
        catch( any e )
        {
            throw( type="custom", message="Error in getFarmerAndAddress - apiDAO.cfc: #e.message#; detail=#e.detail#" );
        }

        return qResult;
    }	

}