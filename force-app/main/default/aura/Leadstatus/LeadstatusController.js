({
	handleSelect : function(component, event, helper) 
    {
        var taskmenu={"MenuItemOne":"Today's Tasks",
                      "MenuItemTwo":"My Tasks",
                      "MenuItemThree":"All Overdue Tasks",
                      "MenuItemFour":"Completed within Last 7 days"
                     }
        var tasks=event.getParam('value');
        component.set("v.menu",taskmenu[tasks]);
	},
    doInit : function(component,event,helper)
    {
        
    }
})