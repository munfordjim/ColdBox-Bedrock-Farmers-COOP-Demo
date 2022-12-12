component{
	this.allowedMethods = { 
        listSpecific   = "GET",
		index = "GET"
    };

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	IMPLICIT FUNCTIONS: Uncomment to use

	function preHandler( event, rc, prc, action, eventArguments ){
	}
	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	function onInvalidHTTPMethod( event, rc, prc, faultAction, eventArguments ){
	}
	*/

	// index
	function index( event, rc, prc )
	{
		// No input string - bring them all back
		qMembers = getInstance( "api.apiDAO" ).getFarmerAndAddress();		
		return qMembers;
	}

	// listSpecific
	function listSpecific( event, rc, prc )
	{
		if ( ( REFIND("[*A-Za-z]", rc.memberID ) ) &&  REFIND("[*0-9]", rc.memberID ) )
		{
			// There are numbers AND characters in the input string
			event.renderData( type="JSON", data={}, statusCode=404, statusMessage="Member not found");
			
		}
		else if ( REFIND("[*A-Za-z]", rc.memberID) )
		{
			// There are only characters in the input string - search by last name
			qMember = getInstance( "api.apiDAO" ).getFarmerAndAddress( rc.memberID, "LastName" );			
			if ( qMember.recordCount )
			{
				event.renderData( type="JSON", data=qMember);
			}
			else 
			{
				event.renderData( type="JSON", data={}, statusCode=404, statusMessage="Member not found");				
			}
		}
		else if ( REFIND("[*0-9]", rc.memberID ) )
		{
			// There are only numbers in the input string - search by farmerID
			qMember = getInstance( "api.apiDAO" ).getFarmerAndAddress( rc.memberID, "FarmerID" );			
			if ( qMember.recordCount )
			{
				event.renderData( type="JSON", data=qMember);
			}
			else 
			{
				event.renderData( type="JSON", data={}, statusCode=404, statusMessage="Member not found");				
			}
		}
	}

	// authFailed
	function authFailed( event, rc, prc )
	{
		event.renderData( type="JSON", data={}, statusCode=404, statusMessage="Authentication Failed." );				
	}

	// remove
	function remove( event, rc, prc )
	{

	}

	// error uniformity for resources
	function onError( event, rc, prc, faultaction, exception ){
		prc.response = getModel("ResponseObject");

		// setup error response
		prc.response.setError(true);
		prc.response.addMessage("Error executing resource #arguments.exception.message#");

		// log exception
		//log.error( "The action: #arguments.faultaction# failed when requesting resource: #arguments.event.getCurrentRoutedURL()#", getHTTPRequestData() );

		// display
		arguments.event.setHTTPHeader(statusCode="500",statusText="Error executing resource #arguments.exception.message#")
			.renderData( data=prc.response.getDataPacket(), type="json" );
	}


}
