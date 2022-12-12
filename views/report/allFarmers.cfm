<cfscript>
    //  INITIALIZE THE farmer MANAGER --->
    qryAllFarmers = getInstance( "farmerGateway" ).getAllFarmerRecords();
</cfscript>

<cfif qryAllFarmers.RecordCount>
    <cfoutput>
        <cfsavecontent variable="rptAllFarmers">
            <link rel="stylesheet" type="text/css" src="#expandPath('assets/css/')#custom.css">
            <table class="table">
            <tr>
                <td class="fw-bold fs-5">First Name</td>
                <td class="fw-bold fs-5">Last Name</td>
                <td class="fw-bold fs-5">Email Address</td>
                <td class="fw-bold fs-5">Phone Number</td>                    
                <td class="fw-bold fs-5">Address</td>
                <td class="fw-bold fs-5">City</td>
                <td class="fw-bold fs-5">State</td>                        
                <td class="fw-bold fs-5">Zip</td>                        
            </tr>
            <cfloop index="x" from="1" to="#qryAllFarmers.RecordCount#">
                <tr>
                    <td>#qryAllFarmers.FirstName[x]#</td>
                    <td>#qryAllFarmers.LastName[x]#</td>
                    <td>#qryAllFarmers.EmailAddress[x]#</td>
                    <td>#qryAllFarmers.PhoneNumber[x]#</td>                    
                    <td>#qryAllFarmers.AddressLine1[x]#</td>
                    <td>#qryAllFarmers.City[x]#</td>
                    <td>#qryAllFarmers.State[x]#</td>                        
                    <td>#qryAllFarmers.Zip[x]#</td>                                                
                </tr>
            </cfloop> 
            </table>
        </cfsavecontent>                    

    </cfoutput>
</cfif>
<!--- Main content --->
<cfoutput>
    <div class="container-fluid">
        <div class="row">
            <!--- Main body content --->
            <div class="bg-white h-100 sidebar">
                <h2 class="p-3">Report:  All Farmers</h2>
                <div class="container-fluid">
                    <cfif qryAllFarmers.RecordCount>
                        <cfif isDefined("rc.selectOutput") and rc.selectOutput is "screen">
                            <cfoutput>#rptAllFarmers#</cfoutput>
                        <cfelseif isdefined("rc.selectOutput") and rc.selectOutput is "pdf">
                            <cfdocument format="PDF" orientation="landscape">
                            <cfoutput>
                                <cfset rptAllFarmers = #Replace(rptAllFarmers, 'class="fw-bold fs-5', 'style="font-weight: bold; font-size:large; border-color: LightGrey; border-bottom-width: 1px;"', "ALL")#>
                                <cfset rptAllFarmers = #Replace(rptAllFarmers, 'class="table"', 'class="table" style="width: 100%"', "ALL")#>
                                <cfset rptAllFarmers = #Replace(rptAllFarmers, '<td>', '<td style="border-bottom-width: 1px; border-color: LightGrey">', "ALL")#>                                
                                <html>
                                    <head>
                                        <link rel="stylesheet" href="assets/css/custom.css">
                                    </head>
                                    <body>
                                        #rptAllFarmers#
                                    </body>
                                </html>
                            </cfoutput>
                            </cfdocument>
                        <cfelseif isdefined("rc.selectOutput") and rc.selectOutput is "EXCEL">
                            <!---<cfoutput>#GetDirectoryFromPath(expandPath("*.*"))#<BR></cfoutput>--->
                            <cfscript>
                                //Use an absolute path for the files.
                                theDir=GetDirectoryFromPath(expandPath("*.*")); 
                                theFile = theDir & "farmers.xls";    
                                //writedump(theFile);                    
                                // Create a new spreadsheet
                                spreadsheetObj = SpreadsheetNew('Farmers');
                                // Add a header row
                                //SpreadSheetAddRow(spreadsheetObj,'First Name,Last Name,Email Address,Phone Number, Address Line 1, City, State, Zip');
                                //Populate each object with a query.
                                SpreadsheetAddRows(spreadsheetObj,qryAllFarmers,1,1,true,[""],true); 
                                //Format Header
                                SpreadsheetformatRow(spreadsheetobj,{bold=true,alignment='center'},1);                            
                                //writedump(spreadsheetObj);
                                //Write File
                                //Spreadsheetwrite(spreadsheetobj,'#theFile#',true);
                                cfheader(name="Content-Disposition", value="inline; filename=farmers.xls");
                                cfcontent(type="application/vnd.ms-excel", variable=spreadSheetReadBinary(spreadsheetobj));
                            </cfscript>

                            <!--- Write the sheet to a single file
                            <cfspreadsheet action="write" filename="#theFile#" name="spreadsheetObj" sheetname="farmers" overwrite=true>     --->                        

                        </cfif>
                        <cfif isDefined("rc.selectOutput") and rc.selectOutput neq "screen">
                            <cfoutput>#rptAllFarmers#</cfoutput>
                        <cfelseif !isDefined("rc.selectOutput")>
                            <cfoutput>#rptAllFarmers#</cfoutput>
                        </cfif>
                        <form class="g-3" action="#event.buildLink( "report/allFarmers" )#" method="POST">
                            <div class="row">
                                <div class="col-md-4 col-lg-3 pt-2 pb-3 pb-sm-3">
                                    <label for="selectOutput" class="form-label text-success fw-bold mb-3">Choose a different way to view this report:</label>                        
                                    <select id="selectOutput" name="selectOutput" class="form-select-lg mb-3" tabindex="1"
                                        required="required" oninvalid="this.setCustomValidity('Please select how you would like to view this report')" 
                                        oninput="setCustomValidity('')">
                                        <option value="" class="text-success fw-bold">Choose an output destination:</option>
                                        <option value="SCREEN">Screen</option>
                                        <option value="PDF">PDF</option>
                                        <option value="EXCEL">Excel Spreadsheet</option>
                                    </select>        
                                    <button type="submit" class="btn btn-primary" tabindex="9" name="btnAddNewFarmer">Choose Output Destination</button>
                                </div>
                            </div>
                        </form>
                    <cfelse>
                        No records found.
                    </cfif>
                </div>
            </div>
        </div>
    </div>
</cfoutput>
<!--- End Main Content --->
