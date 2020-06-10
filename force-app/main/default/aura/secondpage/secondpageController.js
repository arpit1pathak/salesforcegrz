({
	search : function(component, event, helper) 
    {
        var abc=component.get("v.search");
        var action=component.get("c.getvalue");
        action.setparams({
            inp: 'abc'
        })
        
        
	}
})