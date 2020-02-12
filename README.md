# Lightning SAP Integration Component

<img src="https://github.com/eyewell/Salesforce2SAPWithAura/blob/master/SAPAuraComponent.jpg">

###### What the component does:
This Lightning component queries for Order fields from SAP, using a specific SAP username and Order ID. The query is made via SOAP (REST is supported as well, but this POC was for SOAP). The fields are then returned by SAP, parsed by salesforce service-side component, and then passed to the client-side controller, and client side component for rendering in Javascript/HTML.

###### Usage
Just click on the Make Callout button, and the fields above will be populated with the data returned.

## Dev, Build and Test

No deployment script - this is a reference implementation from which developers can learn about the architecture of a similar component.

At a high level, the code in this repo is specific to the SAP API WSDL that was deployed - your any other deployment really needs to go through that same process.


## App architecture
There are 2 options when you make callouts from lightning apps. You can either:
1) call the API from the component, through the salesforce servers, to the remote API, or
2) call the API from the component, across the local network.
This implementation takes the first approach.

The solution architecture is "API - Server-Side Controller - Client-Side Controller - View":

###### API 
an SAP Hana API endpoint, exposed via SOAP/WSDL. The WSDL was loaded into salesforce WSDLtoApex, to generate the necessary Apex Classes.

###### Server-Side Controller
The Apex classes respond to client-side controller requests, and query the SAP API

###### Client-Side Controller
The Aura component contains the javascript and helper code to respond to the UI, and to query the salesforce server side controller.

###### View
The Aura component contains the UI

## Description of Files and Directories

###### /force-app/main/default/aura/SampleSAPQuery/
Directory of parts of the Lightning Component: UI and Client Controller. The population of the returned data from SAP starts at line 27 in file /force-app/main/default/aura/SampleSAPQuery/SampleSAPQuery.cmp. 

Apex had already parsed the data, and made it available in a variable called "v.response".

v.response was populated by the short amount of code in /force-app/main/default/aura/SampleSAPQuery/SampleSAPQueryHelper.js

###### / force-app/main/default/classes/
Directory of the Apex classes which support the API call out, and the WSDL-based supporting Apex classes. The SAP callout happens at line 40 in file /force-app/main/default/classes/SampleSAPQueryApexController.cls


