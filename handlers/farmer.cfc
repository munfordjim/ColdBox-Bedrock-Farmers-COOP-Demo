component 
{

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
	/*
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

	/**
	 * index
	 */
	function index( event, rc, prc ){
		//writeDump( event.getSESBaseURL() ); abort;
		prc.pageTitle = "Data Maintenance";
		event.setView( "farmer/index" );
	}

	/**
	 * list
	 */
	function list( event, rc, prc ){
		event.setView( "farmer/list" );
	}

	/**
	 * add
	 */
	function add( event, rc, prc )
	{
		prc.pageTitle = "Add New Farmer";
		//writeDump( application ); abort;

		//  Instantiate a utilities object
		//  Read in all US States to be used in the add form
		var  objUtilities = getInstance ( "utilities" );
		prc.qAllUSStates = objUtilities.getUSStates();		

		if ( isdefined( "rc.btnAddNewFarmer") )
		{
			// The Add form has been filled out and submitted.
			// 	Populate a model :  for this to work, the form var names have to 
			//  match the names that are in your model. For huge forms, this would save a HUGE
			//  amount of time, effort, and cut down on errors.
			
			var objAddressBean = populateModel ( model='addressBean', memento=rc);
			//  Now validate the data
			var validationResults = validateModel ( objAddressBean );

			if ( validationResults.hasErrors() )
			{
				//  ***  NOTE:  relocate() replaces the rc scope with the parameters in the relocate method.
				var errors = validationResults.getAllErrors();
				relocate( event = "farmer/add",
							persistStruct = { errors: errors });
			}
			else
			{
				//  Data looks good, lets add the new farmer and address
				newAddressBean = 0;
				prc.newAddressBean = getInstance( "addressDAO" ).createNewAddressRecord( objAddressBean );
			}
		}
	}

	/**
	 * edit
	 */
	function edit( event, rc, prc ){
		prc.pageTitle = "Update Farmer";
		prc.qAllFarmerRecords = getInstance( "farmerGateway").getAllFarmerRecords();

		if ( isdefined( "rc.btnSelectFarmerToUpdate" ) )
		{
			//  The farmer to update has been selected.  Validate the token and if good, show the form with current data.
			//  Instantiate a utilities object
			var  objUtilities = getInstance ( "utilities" );
			
			//  Verify the token
			validate = objUtilities.verifyToken( rc.validationToken );
            if( !validate )
	        {
				//  There was a problem - hold the horses!
                writeOutput("<div style='margin-left: 15px; margin-top: 15px;')><h4 class='text-danger'>ERROR</h4>There was error submitting the form.  
					Please use the button below to return to the form and try again.
					<br><br>
					<a class='button' href='#event.buildList( "farmer/edit" )#'>Go Back</a></div>");
            }
			else
			{
				//  Token was good.  Show the current data
				//  Read in all US States to be used in the add form
				prc.qAllUSStates = objUtilities.getUSStates();						
				prc.objAddrBean = getInstance( "farmerDAO" ).getFarmerAndAddressByFarmerID(rc.selectFarmer);
			}
		}
		else if ( isdefined( "rc.btnUpdateFarmer" ) )
		{
			//  An update was made.  Need to validate the form data and then make the update.
			//  Populate the bean
			var objAddressBean = populateModel ( model='addressBean', memento=rc);
			prc.objAddressBean = objAddressBean;
			//  Now validate the data
			var validationResults = validateModel ( objAddressBean );

			if ( validationResults.hasErrors() )
			{
				//  ***  NOTE:  relocate() replaces the rc scope with the parameters in the relocate method.
				var errors = validationResults.getAllErrors();
				relocate( event = "farmer/edit",
							persistStruct = { errors: errors });
			}
			else
			{
				//  Data looks good, lets add the new farmer and address
				// Update the Address 
				boolAddrStatus =  getInstance( "addressDAO" ).updateAddressRecord(#objAddressBean#);
				if ( boolAddrStatus )
				{
					//  update the farmer
					boolFarmerUpdate = getInstance( "farmerDAO" ).updateFarmerRecord(#objAddressBean#);
				}
			}
		}
	}

	/**
	 * delete
	 */
	function delete( event, rc, prc )
	{
		prc.pageTitle = "Delete Farmer";
		prc.qAllFarmerRecords = getInstance( "farmerGateway").getAllFarmerRecords();

		if (isdefined( "rc.btnSelectFarmerToDelete") )
		{
			//  The farmer to delete has been selected.  Validate the token and if good, show the confirmation page with current data.
			//  Instantiate a utilities object
			var  objUtilities = getInstance ( "utilities" );
			
			//  Verify the token
			validate = objUtilities.verifyToken( rc.validationToken );
            if( !validate )
	        {
				//  There was a problem - hold the horses!
                writeOutput("<div style='margin-left: 15px; margin-top: 15px;')><h4 class='text-danger'>ERROR</h4>There was error submitting the form.  
					Please use the button below to return to the form and try again.
					<br><br>
					<a class='button' href='#event.buildList( "farmer/delete" )#'>Go Back</a></div>");
            }
			else
			{
				//  Token was good.  Show the confirmation page
				//writeDump( rc );
				prc.objAddrBean = getInstance( "farmerDAO" ).getFarmerAndAddressByFarmerID(rc.selectFarmer);
				//writeDump( prc.objAddrBean ); abort;											
			}
		}
		else if (isdefined ( "rc.btnConfirmDelete") )
		{
			prc.objAddrBean = getInstance( "farmerDAO" ).getFarmerAndAddressByFarmerID( rc.confirmFarmer) ;			
			boolDeleteFarmer = getInstance( "farmerDAO" ).deleteFarmerRecordByFarmerID( prc.objAddrBean.getFarmerID() );
			boolDeleteAddress = getInstance( "addressDAO" ).deleteAddressRecordByAddrID( prc.objAddrBean.getAddrID() );
		}
	}
}
