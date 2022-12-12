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
                                    <button type='button' class='btn btn-primary' tabindex='9' name='btnGoBack' onclick="location.href='#event.buildLink( "farmer/edit" )#'"> Go Back </button>
                                </p>
                            </cfloop>
                        </div>       
                    <cfelseif isdefined("prc.objAddressBean") AND #prc.objAddressBean.getAddrID()# neq 0  >
                        <h3 class="p-2 text-success">
                            Successfully updated the farmer and address!
                        </h3>
                        <p class="p-2 mb-0 text-success fw-bold">
                            Updated information:
                        </p>
                        
                        <div class="row">
                            <div class="col-md-4 ps-5 pb-4">
                                <cfoutput>
                                    <span class="fw-bold">
                                        Name:
                                    </span>#prc.objAddressBean.getFirstName()# #prc.objAddressBean.getLastName()#
                                    <br>
                                    <span class="fw-bold">
                                        Email Address:
                                    </span>#prc.objAddressBean.getEmailAddress()#
                                    <br>
                                    <span class="fw-bold">
                                        Phone Number:
                                    </span>#prc.objAddressBean.getPhoneNumber()#
                                    <br>
                                    <span class="fw-bold">
                                        Address:
                                    </span>
                                    <br>#prc.objAddressBean.getAddressLine1()#
                                    <br>#prc.objAddressBean.getCity()#, #prc.objAddressBean.getState()# #prc.objAddressBean.getZip()#
                                </cfoutput>
                            </div>
                        </div>
                   
                        <div>
                            <button type="button" class="btn btn-primary" tabindex="9" name="btnDifferentFarmer"
                                onclick="location.href='#event.buildLink( "farmer/edit" )#'">
                                Select Another Farmer
                            </button>
                        </div>
                    <cfelseif isdefined( "rc.btnSelectFarmerToUpdate" )>
                        <h4 class="pb-3 ps-1 text-success fw-bold">
                            Update an existing Bedrock Farmers Coop farmer:
                        </h4>
                        
                        <!--- form --->
                        <form class="g-3" action="#event.buildLink( "farmer/edit" )#" method="post">
                            <cfoutput>
                                <input type="hidden" id="addrID" name="addrID" value="#prc.objAddrBean.getAddrID()#">
                                <input type="hidden" id="farmerID" name="farmerID" value="#prc.objAddrBean.getFarmerID()#">
                                <input name="validationToken" type="hidden" value="#CSRFGenerateToken( forceNew=true )#">

                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" id="firstName" name="firstName"
                                                    maxlength="100" placeholder="First Name" tabindex="1" value="#prc.objAddrBean.getFirstName()#"
                                                    required="required" oninvalid="this.setCustomValidity('Please Enter a valid First Name')" oninput="setCustomValidity('')">
                                            <label for="firstName" class="form-label text-success fw-bold">
                                                First Name
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" id="lastName" name="lastName"
                                                    maxlength="100" placeholder="Last Name" tabindex="2" value="#prc.objAddrBean.getLastName()#"
                                                    required="required" oninvalid="this.setCustomValidity('Please Enter a valid Last Name')" oninput="setCustomValidity('')">
                                            <label for="lastName" class="form-label text-success fw-bold">
                                                Last Name
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-floating mb-3">
                                            <input type="email" class="form-control" id="emailAddress" name="emailAddress"
                                                    maxlength="100" placeholder="Email Address" tabindex="3" value="#prc.objAddrBean.getEmailAddress()#">
                                            <label for="emailAddress" class="form-label text-success fw-bold">
                                                Email Address
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber"
                                                    maxlength="100" placeholder="Phone" tabindex="4" value="#prc.objAddrBean.getPhoneNumber()#">
                                            <label for="phoneNumber" class="form-label text-success fw-bold">
                                                Phone Number
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" id="addressLine1" name="addressLine1"
                                                    maxlength="100" placeholder="Address Line 1" tabindex="5" value="#prc.objAddrBean.getAddressLine1()#"
                                                    required="required" oninvalid="this.setCustomValidity('Please Enter a valid Address Line 1')" oninput="setCustomValidity('')">
                                            <label for="addressLine1" class="form-label text-success fw-bold">
                                                Address Line 1
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" id="city" name="city"
                                                    maxlength="100" placeholder="City" tabindex="6" value="#prc.objAddrBean.getCity()#"
                                                    required="required" oninvalid="this.setCustomValidity('Please Enter a valid City')" oninput="setCustomValidity('')">
                                            <label for="city" class="form-label text-success fw-bold">
                                                City
                                            </label>
                                        </div>
                                    </div>

                                    <div class="col-md-4 col-lg-3 pt-2 pb-3 pb-sm-3">
                                        <select id="state" name="state" class="form-select-lg" tabindex="7"
                                                required="required" oninvalid="this.setCustomValidity('Please select a valid state')" oninput="setCustomValidity('')">
                                            <option value="" class="text-success fw-bold">
                                                Choose a State 
                                            </option>
                                            <cfloop index="s" from="1" to="#prc.qAllUSStates.RecordCount#">
                                                <cfif prc.qAllUSStates.StAB[s] eq #prc.objAddrBean.getState()#>
                                                    <option value="#prc.qAllUSStates.StAB[s]#" selected>
                                                        #prc.qAllUSSTates.StateName[s]#
                                                    </option>
                                                <cfelse>
                                                    <option value="#prc.qAllUSStates.StAB[s]#">
                                                        #prc.qAllUSSTates.StateName[s]#
                                                    </option>
                                                </cfif>
                                            </cfloop>
                                        </select>
                                    </div>
                                    <div class="col-md-3 col-lg-2 pl-sm-3 pl-md-3 pl-lg-3">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" id="zip" name="zip"
                                                    maxlength="10" placeholder="Zip Code" tabindex="8" value="#prc.objAddrBean.getZip()#"
                                                    required="required" oninvalid="this.setCustomValidity('Please select a valid zip code')" oninput="setCustomValidity('')">
                                            <label for="zip" class="form-label text-success fw-bold">
                                                Zip
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    &nbsp;
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary" tabindex="9" name="btnUpdateFarmer">
                                        UPDATE
                                    </button>
                                    <button type="button" class="btn btn-primary" tabindex="9" name="btnDifferentFarmer"
                                            onclick="location.href='#event.buildLink( "farmer/edit" )#'">
                                        Select Another Farmer
                                    </button>
                                </div>
                            </cfoutput>
                        </form>
                    <cfelse>
                        <!--- Show a list of existing farmers to pick from for updating --->
                        <!--- form --->
                        <form class="g-3 p-0" action="#event.buildLink( "farmer/edit" )#" method="post">
                            <cfoutput>
                                <input name="validationToken" type="hidden" value="#CSRFGenerateToken( forceNew=true )#">
                            </cfoutput>
                            <div class="p-3 m-0">
                                <h4 class="pb-3 text-success fw-bold">
                                    Please select an existing farmer to update:
                                </h4>
                                <select id="selectFarmer" name="selectFarmer" class="form-select-lg" tabindex="7"
                                        required="required" oninvalid="this.setCustomValidity('Please select a Farmer from the list')" oninput="setCustomValidity('')">
                                    <option value="">
                                        Choose a Farmer
                                    </option>
                                    <cfloop index="s" from="1" to="#prc.qAllFarmerRecords.RecordCount#">
                                        <cfoutput>
                                            <option value="#prc.qAllFarmerRecords.FarmerID[s]#">
                                                #prc.qAllFarmerRecords.FirstName[s]# 
                                                #prc.qAllFarmerRecords.LastName[s]#
                                            </option>
                                        </cfoutput>
                                    </cfloop>
                                </select>
                            </div>
                            <div class="p-3">
                                <button type="submit" class="btn btn-primary" tabindex="9" name="btnSelectFarmerToUpdate">
                                    Select Farmer
                                </button>
                            </div>
                        </form>
                    </cfif>
                </div>
            </div>
        </div>
    </div>
</cfoutput>