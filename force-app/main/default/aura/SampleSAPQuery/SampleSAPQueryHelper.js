({
	// Define the getResponse function, which calls the Apex Class static function SampleSAPQueryCall()

    getResponse: function(component) {
        // create a server side action.       
        var action = component.get("c.SampleSAPQueryCall");

        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if (component.isValid() && state === "SUCCESS") {
                // set the response(return Map<String,String>) to response attribute.      
                component.set("v.response", response.getReturnValue());

            }
        });
 
        $A.enqueueAction(action);
    },
})