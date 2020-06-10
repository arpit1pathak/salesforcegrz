({
	onsearch : function(component, event, helper) {
		var inputsearch = component.get("v.input");
        var action = component.get("c.getmethod");
            action.setParams({
                'inp': inputsearch
            })
            action.setCallback(this,function(res)
            {
              var result= res.getReturnValue();
                component.set("v.output",result);
            })
	$A.enqueueAction(action,true);
    }
})