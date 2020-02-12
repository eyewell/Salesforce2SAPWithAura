# SFDX  App

<img src="https://github.com/eyewell/Salesforce2SAPWithAura/blob/master/SAPAuraComponent.jpg">

#What the component does:
This POC  component is queries for Order fields from SAP, using a specific SAP username and Order ID (See details below). The query is made via SOAP (REST is supported as well). The fields are then returned by SAP, parsed by salesforce service-side component, and then passed to the client-side controller, and client side component for rendering in Javascript.

#Usage
Just click on the Make Callout button, and the fields below will be populated with the data returned.

## Dev, Build and Test

No deployment script - this is a reference implementation from which developers can learn about the architecture of a similar component.

At a high level, the code in this repo is specific to the SAP API WSDL that was deployed - your any other deployment really needs to go through that same process.


## Description of Files and Directories

#App architecture
There are 2 options when you make callouts from lightning apps. You can either:
1) call the API from the component, through the salesforce servers, to the remote API, or
2) call the API from the component, across the local network.
This implementation takes the first approach.

The solution architecture is "API - Server-Side Controller - Client-Side Controller - View":

#API 
an SAP Hana API endpoint, exposed via SOAP/WSDL. The WSDL was loaded into salesforce WSDLtoApex, to generate the necessary Apex Classes.

#Server-Side Controller
The Apex classes respond to client-side controller requests, and query the SAP API

#Client-Side Controller
The Aura component contains the javascript and helper code to respond to the UI, and to query the salesforce server side controller.

#View
The Aura component contains the UI


