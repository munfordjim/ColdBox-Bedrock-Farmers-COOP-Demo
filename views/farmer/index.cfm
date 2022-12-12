<cfoutput>
    <!--- Main content --->
    <div class="container-fluid">
        <div class="row">
            <!--- Main body content --->
            <div class="ms-4 mt-4 bg-white h-100 sidebar col-12 col-sm-8 col-md-8 col-lg-9 col-xl-9 col-xxl-10">
                <h2 class="p-2 mb-0">Data Maintenance</h2>
                <h3 class="p-2 mb-0">Select an option from the green bar above</h3>
                <p class="p-2">
                    This app is a very simple demonstration of creating, reading, updating, and deleting (CRUD) 
                    the basic information of a Farmer at Bedrock Farmers Coop using the ColdBox frameword for CFML.
                    <BR><BR>
                    Note - it should be understood that, while the addressBean component extends
                    the farmerBean component (thus breaking the "is a" rule -  an address is NOT a farmer - HA!), 
                    its intent is to show the use of inheritance in the application design.  Another demo could be 
                    created using Mayberry RFD as its basis where a "policeOfficer" component could extend a "mayberryCitizen" 
                    component and be a true "is a" relationship. A "family" component could also be used to show true 
                    "has a" composition.
                    <BR><BR>
                    The following technologies were used to develop this demo application:
                </p>
                <ol>
                    <li>ColdBox 7</li>
                    <li>CommandBox 5.7</li>
                    <li>Bootstrap 5.2</li>
                    <li>Javascript (Vanilla, JQuery, Node)</li>
                    <li>SASS</li>
                    <li>CSS</li>
                    <li>ColdFusion 2021</li>
                    <li>MS SQL Server, SQL Server Studio</li>
                    <li>MS Visual Studio Code</li>
                    <li>REST API concepts using ColdBox Rest functionality (Reports)
                    <li>Protection against SQL injection (SQLi), Cross-Site Scripting (XSS), etc. using appropriate cbValidation,
                        ColdFusion tags and functions (ie, cfqueryparam, canonicalize, CSRFGenerateToken, encoding, regular expressions, etc.)</li>
                </ol>
            </div>
        </div>
    </div>
</cfoutput>