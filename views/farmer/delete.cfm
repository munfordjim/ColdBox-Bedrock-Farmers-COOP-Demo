<cfoutput>
    <div class="container-fluid">
        <div class="row">
            <!--- Main body content --->
            <div class="bg-white h-100 sidebar">
                <h2 class="p-3">#prc.pageTitle#</h2>
                <div class="container-fluid">
                    <cfif isdefined( "rc.errors" )>
                        <div class="alert alert-danger" role="alert">
                            <cfloop array="#rc.errors#" index="curError">
                                <p>#curError#
                                    <button type='button' class='btn btn-primary' tabindex='9' name='btnGoBack' onclick="location.href='#event.buildLink( "farmer/add" )#'"> Go Back </button>
                                </p>
                            </cfloop>
                        </div>
                    <cfelseif (isdefined("prc.objAddrBean") AND #prc.objAddrBean.getAddrID()# neq 0) && not isdefined( "rc.btnConfirmDelete" ) >
                        <h3 class="p-2 text-success">Please confirm that you would like to DELETE the farmer below and their address:</h3>
                        <div class="row">
                            <div class="col-md-4 ps-5 pb-4">
                                <cfoutput>
                                <span class="fw-bold">Name:</span>  #prc.objAddrBean.getFirstName()# #prc.objAddrBean.getLastName()#<BR>
                                <span class="fw-bold">Email Address:</span>  #prc.objAddrBean.getEmailAddress()#<BR>
                                <span class="fw-bold">Phone Number:</span>  #prc.objAddrBean.getPhoneNumber()#<BR>
                                <span class="fw-bold">Address:</span> <BR>
                                #prc.objAddrBean.getAddressLine1()#<BR>
                                #prc.objAddrBean.getCity()#, #prc.objAddrBean.getState()# #prc.objAddrBean.getZip()#
                                </cfoutput>
                            </div>
                        </div>
                        <form class="g-3" action="#event.buildLink( "farmer/delete" )#" method="post">
                            <cfoutput>
                                <input type="hidden" id="confirmFarmer" name="confirmFarmer" value="#rc.selectFarmer#">
                            </cfoutput>
                            <div>
                                <button type="submit" class="btn btn-primary" tabindex="9" name="btnConfirmDelete">Confirm Delete</button>                                
                            </div>                        
                        </form>
                    <cfelseif isdefined( "rc.btnConfirmDelete" )>
                        <cfoutput><h3 class="p-2 text-success">Successfully deleted #prc.objAddrBean.getFirstName()# #prc.objAddrBean.getLastName()# and their address!</h3></cfoutput>
                    <cfelse>
                        <!--- form --->
                        <form class="g-3 p-0" action="#event.buildLink( "farmer/delete" )#" method="post">
                            <cfoutput>
                                <input name="validationToken" type="hidden" value="#CSRFGenerateToken( forceNew=true )#">
                            </cfoutput>
                            <div class="p-3 m-0">
                                <h4 class="pb-3 text-success fw-bold">Please select an existing farmer to delete:</h4>                            
                                <select id="selectFarmer" name="selectFarmer" class="form-select-lg" tabindex="7"
                                        required="required" oninvalid="this.setCustomValidity('Please select a Farmer from the list')" 
                                        oninput="setCustomValidity('')">
                                    <option value="">Choose a Farmer</option>
                                    <cfloop index="s" from="1" to="#prc.qAllFarmerRecords.RecordCount#">
                                        <cfoutput><option value="#prc.qAllFarmerRecords.FarmerID[s]#">#prc.qAllFarmerRecords.FirstName[s]# #prc.qAllFarmerRecords.LastName[s]#</option></cfoutput>
                                    </cfloop>
                                </select>
                            </div>
                            <div class="p-3">
                                <button type="submit" class="btn btn-primary" tabindex="9" name="btnSelectFarmerToDelete">Select Farmer</button>
                            </div>                            
                        </form>                        
                    </cfif>
                </div>
            </div>
        </div>
    </div>
</cfoutput>                    