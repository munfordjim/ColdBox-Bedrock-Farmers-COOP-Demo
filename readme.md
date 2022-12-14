<h2 align="center">Code Demo</h2>

# About

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
	<li>Simple REST API concepts using ColdBox Rest functionality (Reports).  API security not yet implemented. 
	<li>Protection against SQL injection (SQLi), Cross-Site Scripting (XSS), etc. using appropriate cbValidation,
		ColdFusion tags and functions (ie, cfqueryparam, canonicalize, CSRFGenerateToken, encoding, regular expressions, etc.)</li>
</ol>

<p class="p-2">The idea of the demo and the use of node came from https://github.com/twbs/bootstrap-npm-starter.  Much thanks!  The bacpac file called "BFC_backpac.bacpac" is the Microsoft SQL Server tables and data used to run this demo application.  
</p>




