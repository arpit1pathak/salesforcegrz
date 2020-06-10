({
	cancelclick : function(component, event, helper)
    {
    component.set("v.attr",false);    
	},
    myvalue : function(component, event, helper)
    {
        
        var radio=event.getParam("value");
       
        component.set("v.val",radio);
    },
    saveclick : function(component, event, helper)
    {
       
    var sid=component.get("v.subject");  
        var b=sid+'tag';
        
    var action=component.get("c.setstatus"); 
    var val=component.get("v.value");
        var status=component.get("v.val");    
        action.setParams({
            "taskid" : sid,
            "status" : status
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") 
            {
                
                console.log("Success :"+state);
                component.set("v.attr",false); 
                document.getElementById(b).style.removeProperty('text-decoration');
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
    },
      
})