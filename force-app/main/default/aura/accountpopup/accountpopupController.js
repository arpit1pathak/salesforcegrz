({
    cancel : function(component, event, helper)
    {
        var url = window.location.href; 
        var value = url.substr(0,url.lastIndexOf('/') + 1);
        window.history.back();
        return false;
    },
    search : function(component, event, helper)
    {
        var searchText=component.get("v.searchText");
        var action = component.get("c.searchForIds");
        action.setParams({
            "searchText" : searchText
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") 
            {
                console.log('Returned values-->'+ JSON.stringify(response.getReturnValue()));
                component.set("v.returnedname",response.getReturnValue());   
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
    },
    createnew : function (component, event, helper) 
    {
    var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({
        "entityApiName": "Account"
    });
    createRecordEvent.fire();
}
})