<cfoutput>
<cfparam name="attributes.pageTitle" default="Data Maintenance" />
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--- Base URL --->
        <base href=#event.getHTMLBaseURL()# />
        <title>Bedrock Farmers Coop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">        
        <link rel="stylesheet" href="#event.getHTMLBaseURL()#includes/styles/custom.css">
    </head>
    <body
        data-spy="scroll"
        data-target=".navbar"
        data-offset="50"
        style="padding-top: 0px"
        class="d-flex flex-column h-100"
    >

    <!--- Heading --->
    <div class="w-100 has-bg-img header-image text-center" style="background-image: url('#event.getHTMLBaseURL()#includes/images/cotton-field-2500wX450h.png'); background-repeat:no-repeat; background-size:cover; 
        background-position:center; height: 250px;">
        <h1 class="fw-bold custom-hero-text">Bedrock Farmers Coop</h1>
    </div>
    <!--- End Heading --->

    <!--- Begin Navigation Bar --->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-customNavBarColor">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarSupportedContent" 
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item">
                            <cfif isdefined( "prc.pageTitle" ) && prc.pageTitle eq "Data Maintenance">
                                <a class="nav-link ps-5 active" aria-current="page" href="#event.buildLink( "farmer/index" )#">Home</a>
                            <cfelse>
                                <a class="nav-link ps-5" href="#event.buildLink( "farmer/index" )#">Home</a>
                            </cfif>
                        </li>              
                        <li class="nav-item">
                            <cfif isdefined( "prc.pageTitle" ) && prc.pageTitle eq "Add New Farmer">                            
                                <a class="nav-link ps-5 active"  aria-current="page" href="#event.buildLink( "farmer/add" )#">New Farmer</a>
                            <cfelse>
                                <a class="nav-link ps-5" href="#event.buildLink( "farmer/add" )#">New Farmer</a>
                            </cfif>
                        </li>
                        <li class="nav-item">
                            <cfif isdefined( "prc.pageTitle" ) && prc.pageTitle eq "Update Farmer">                                                        
                                <a class="nav-link  ps-5 active" aria-current="page" href="#event.buildLink( "farmer/edit" )#" tabindex="-1">Update Farmer</a>
                            <cfelse>
                                <a class="nav-link  ps-5" href="#event.buildLink( "farmer/edit" )#" tabindex="-1">Update Farmer</a>
                            </cfif>
                        </li>
                        <li class="nav-item">
                            <cfif isdefined( "prc.pageTitle" ) && prc.pageTitle eq "Delete Farmer">                                                                                    
                                <a class="nav-link  ps-5 active" aria-current="page" href="#event.buildLink( "farmer/delete" )#" tabindex="-1">Delete Farmer</a>
                            <cfelse>
                                <a class="nav-link  ps-5" href="#event.buildLink( "farmer/delete" )#" tabindex="-1">Delete Farmer</a>
                            </cfif>
                        </li>
                        <li class="nav-item dropdown">
                            <cfif isdefined( "prc.pageTitle" ) && prc.pageTitle eq "Reports">                                                                                                                
                                <a class="nav-link  ps-5 dropdown-toggle active" aria-current="page" href="##" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Reports
                                </a>
                            <cfelse>
                                <a class="nav-link  ps-5 dropdown-toggle" href="##" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    Reports
                                </a>
                            </cfif>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#event.buildLink( "api/member/" )#">All COOP Members (via rest api)</a></li>
                                <li><a class="dropdown-item" href="#event.buildLink( "api/member/flint" )#">COOP Members by Last Name (via rest api)</a></li>
                                <li><a class="dropdown-item" href="#event.buildLink( "api/member/5" )#">COOP Members by ID (via rest api)</a></li>                                
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#event.buildLink( "report/allFarmers" )#">Show all Farmers</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <!--- End Navigation Bar --->

    <!--- Views --->
    <div>#renderView()#</div>


	<footer style="margin-top: 20px;">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" 
            crossorigin="anonymous"></script>

        <script src="#event.getHTMLBaseURL()#includes/js/bfc.js"></script>
    </footer>
</body>
</html>         
</cfoutput>