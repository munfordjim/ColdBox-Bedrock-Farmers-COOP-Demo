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
                    <cfelseif isdefined("prc.newAddressBean") AND #prc.newAddressBean.getAddrID()# neq 0  >
                        <h3 class="p-2 text-success">Successfully added a new farmer and address!</h3>
                        <div class="row">
                            <div class="col-md-4 ps-5 pb-4">
                                <cfoutput>
                                    <span class="fw-bold">
                                        Name:
                                    </span>#prc.newAddressBean.getFirstName()# #prc.newAddressBean.getLastName()#
                                    <br>
                                    <span class="fw-bold">
                                        Email Address:
                                    </span>#prc.newAddressBean.getEmailAddress()#
                                    <br>
                                    <span class="fw-bold">
                                        Phone Number:
                                    </span>#prc.newAddressBean.getPhoneNumber()#
                                    <br>
                                    <span class="fw-bold">
                                        Address:
                                    </span>
                                    <br>#prc.newAddressBean.getAddressLine1()#
                                    <br>#prc.newAddressBean.getCity()#, #prc.newAddressBean.getState()# #prc.newAddressBean.getZip()#
                                </cfoutput>
                            </div>
                            <div>
                                <button type="button" class="btn btn-primary" tabindex="9" name="btnDifferentFarmer"
                                        onclick="location.href='#event.buildLink( "farmer/add" )#'">
                                    Add Another Farmer
                                </button>
                            </div>
                        </div>
                    <cfelse>
                        <h4 class="text-success fw-bold pb-3">Add a farmer to Bedrock Farmers Coop:</h4>

                        <!--- form --->
                        <form class="g-3" action="#event.buildLink( "farmer/add" )#" method="post">
                            <!--- CSRF = Cross Site Request Forgery.  Prevents that kind of hackery.  The key parameter is optional but if used it MUST be used when 
                                    the token is verified
                                --->
                            <cfoutput>
                            <input name="validationToken" type="hidden" value="#CSRFGenerateToken( forceNew=true )#">
                            </cfoutput>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="firstName" name="firstName" maxlength="100" placeholder="First Name" tabindex="1"
                                            required="required" oninvalid="this.setCustomValidity('Please Enter a valid First Name')" 
                                            oninput="setCustomValidity('')">
                                        <label for="firstName" class="form-label text-success fw-bold">First Name</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="lastName" name="lastName" maxlength="100" placeholder="Last Name" tabindex="2"
                                            required="required" oninvalid="this.setCustomValidity('Please Enter a valid Last Name')" 
                                            oninput="setCustomValidity('')">
                                        <label for="lastName" class="form-label text-success fw-bold">Last Name</label>         
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="email" class="form-control" id="emailAddress" name="emailAddress" maxlength="100" placeholder="Email Address" tabindex="3">
                                        <label for="emailAddress" class="form-label text-success fw-bold">Email Address</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" maxlength="100" placeholder="Phone" tabindex="4">
                                        <label for="phoneNumber" class="form-label text-success fw-bold">Phone Number</label>         
                                    </div>
                                </div>
                            </div>	
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">                                
                                        <input type="text" class="form-control" id="addressLine1" name="addressLine1" maxlength="100" placeholder="Address Line 1" tabindex="5"
                                            required="required" oninvalid="this.setCustomValidity('Please Enter a valid Address Line 1')" 
                                            oninput="setCustomValidity('')">
                                        <label for="addressLine1" class="form-label text-success fw-bold">Address Line 1</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">           
                                        <input type="text" class="form-control" id="city" name="city" maxlength="100" placeholder="City" tabindex="6"
                                            required="required" oninvalid="this.setCustomValidity('Please Enter a valid City')" 
                                            oninput="setCustomValidity('')">
                                        <label for="city" class="form-label text-success fw-bold">City</label>
                                    </div>
                                </div>
                                
                                <div class="col-md-4 col-lg-3 pt-2 pb-3 pb-sm-3">
                                    <select id="state" name="state" class="form-select-lg" tabindex="7"
                                        required="required" oninvalid="this.setCustomValidity('Please select a valid state')" 
                                        oninput="setCustomValidity('')">
                                        <option value="" class="text-success fw-bold">Choose a state</option>
                                        <cfloop index="s" from="1" to="#prc.qAllUSStates.RecordCount#">
                                            <cfoutput><option value="#prc.qAllUSStates.StAB[s]#">#prc.qAllUSSTates.StateName[s]#</option></cfoutput>
                                        </cfloop>
                                    </select>
                                </div>
                                <div class="col-md-3 col-lg-2 pl-sm-3 pl-md-3 pl-lg-3">
                                    <div class="form-floating mb-3">           
                                        <input type="text" class="form-control" id="zip" name="zip" maxlength="10" placeholder="Zip Code" tabindex="8"
                                            required="required" oninvalid="this.setCustomValidity('Please Enter a valid Zip Code')" 
                                            oninput="setCustomValidity('')">
                                        <label for="zip" class="form-label text-success fw-bold">Zip</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                &nbsp;
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary" tabindex="9" name="btnAddNewFarmer">ADD</button>
                            </div>
                        </form>
                    </cfif>
                </div>
            </div>
        </div>
    </div>
</cfoutput>