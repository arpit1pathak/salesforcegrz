({
    handleSelect : function(component, event, helper) 
    {
        var menuItem={
            "MenuItemOne"   :"Today's Task",
            "MenuItemTwo"   :"My Tasks",
            "MenuItemThree" :"All Overdue",
            "MenuItemFour"  :"Completed within Last 7 days"
        }
        var tasks = event.getParam('value');
        component.set("v.menu",menuItem[tasks]);
        var action=component.get("c.getTask");
        action.setParams({ 
            'inp': menuItem[tasks]
        });
        
        action.setCallback(this,function(res){
             var state = res.getState();
            if (state === "SUCCESS") 
            {
                alert("From server: " + res.getReturnValue());
            }
              var result= res.getReturnValue();
            System.debug('@@@@'+result);
            console.log('@@@@'+result);
                component.set("v.listoftasks",result);
           
            });
    	$A.enqueueAction(action,true);  
    },

        
   
})