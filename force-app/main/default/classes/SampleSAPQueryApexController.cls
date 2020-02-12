public with sharing class SampleSAPQueryApexController {
    @AuraEnabled //enable this class to be called from Lightning components
     
    public static MAP <String,String> SampleSAPQueryCall()
    { //public *static* enables this function to the called with out instantiating this class in the lightning component
		
    		//SAP HCI Integration POC constants 
    		String username = 'S0009851033';      //set the username for SAP test environment
    		String password = 'PGE2o12%';         //set the password
   		String OrderNumber = '000030015548';  //set the order number of the record we'll query
    	
        //Instantiate objects from SAP HCI WSDL-derived classes
        sapComDocumentSapSoapFunctionsMcS.TableOfBapiret2                 inputReturnTable;
    		sapComDocumentSapSoapFunctionsMcS.ZgetOrderDetailResponse_element functionReturn;
    		MAP <String,String> 			        								 resultsMap;
    		
    		inputReturnTable      = new sapComDocumentSapSoapFunctionsMcS.TableOfBapiret2();
        inputReturnTable.item = new LIST<sapComDocumentSapSoapFunctionsMcS.Bapiret2>(); 
    	    functionReturn        = new sapComDocumentSapSoapFunctionsMcS.ZgetOrderDetailResponse_element();
    	    sapComDocumentSapSoapFunctionsMcS.GetOrderDetails getOD = new sapComDocumentSapSoapFunctionsMcS.GetOrderDetails();
        
        //create a map into which we'll load all the return data
        resultsMap            = new MAP<String,String>();
        
        //allocate space for the input headers
        getOD.inputHttpHeaders_x = new Map<String,String>{}; 
        
        //set authentication, and assign to a String
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
     
        //set headers
        getOD.inputHttpHeaders_x.put('Accept', 'application/json, text/plain, */*');
        getOD.inputHttpHeaders_x.put('X-stream', 'true');
        getOD.inputHttpHeaders_x.put('Content-Type', 'application/json;charset=utf-8');
        getOD.inputHttpHeaders_x.put('Authorization', authorizationHeader); //<---- here is the authentication string
        
        //call SAP Order query
        try{
        		functionReturn = getOD.ZgetOrderDetail(OrderNumber, inputReturnTable);
        		System.debug('no error');
        }catch(Exception e)
        {
        		System.debug('error: ' +e.getMessage());
        }
        
        //if no errors, send the data back to the controller, in a Map variable
         
         if (functionReturn.Header != null)
        {
        	 	//System.debug('Orderid: ' +functionReturn.Header.Orderid);
        	 	resultsMap.put('Orderid'   , functionReturn.Header.Orderid);
        	 	resultsMap.put('ShortText' , functionReturn.Header.ShortText);
        	 	resultsMap.put('SysStatus' , functionReturn.Header.SysStatus);
        	 	resultsMap.put('CstgSheet' , functionReturn.Header.CstgSheet);
        	 	resultsMap.put('ChangeDate', functionReturn.Header.ChangeDate);
        	 	resultsMap.put('CoArea'    , functionReturn.Header.CoArea);
        	 	resultsMap.put('EnterDate' , functionReturn.Header.EnterDate);
        	 	resultsMap.put('FinishDate', functionReturn.Header.FinishDate);
        	 	resultsMap.put('Location'  , functionReturn.Header.Location);
        	 	resultsMap.put('MnWkCtr'   , functionReturn.Header.MnWkCtr);
        	 	resultsMap.put('ObjectNo'  , functionReturn.Header.ObjectNo);
        
        }
       
       return resultsMap; 
        
        
    }
    
}