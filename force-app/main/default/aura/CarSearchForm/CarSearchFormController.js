({
	onSearchClick : function(component, event, helper) 
    {
	helper.helper(component,event,helper);
	},
    togglebutton : function(component, event, helper) 
    {
	var currentvalue=component.get("v.isNewAvailable");
        if(currentvalue)
        {
            component.set("v.isNewAvailable","false");
        }
            else
            {
                component.set("v.isNewAvailable","true");
            }
     },
    newvalueselected : function(component, event, helper)
    {
        var cartypeid=component.find('CarTypeList').get("v.value");
        alert(cartypeid+  ' Option selected');
    },
    doinit : function(component, event, helper)
    {
        component.set("v.carTypes",['Sports Car','Luxury Car','Van']);
    },
    
})