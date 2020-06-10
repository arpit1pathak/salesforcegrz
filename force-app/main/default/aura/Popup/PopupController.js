({
	doInit : function(component, event, helper) 
    {
	 var contactId=component.get("v.contactId");
            var action=component.get("c.setpopupvalues");  
        action.setParams({
            "contactId" : contactId
        });
         action.setCallback(this, function(response) {
            var state = response.getState();
             var action = response.getReturnValue();
            if (state == "SUCCESS") 
            {
                console.log('Values on change',response.getReturnValue())
                component.set("v.displaycontact",response.getReturnValue());
            }
            else 
            {
                console.log("Failed with state: " + state);
            }
        });
         
        $A.enqueueAction(action);
    }
        
	
})