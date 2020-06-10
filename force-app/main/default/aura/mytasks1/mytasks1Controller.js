({
	doInit :function(component, event, helper) 
    {
    component.set("v.title","Today's Tasks");
    var heading = component.get("v.title");
    var action = component.get("c.getTasks");
        action.setParams({
            "title" : heading
        });
         action.setCallback(this, function(response) {
            var state = response.getState();
            if (state == "SUCCESS") 
            {
                console.log('Returned values',response.getReturnValue());
                component.set("v.Task", response.getReturnValue());
                
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    handleSelect : function(component, event, helper) 
    {
	var menu=event.getParam("value");   
        console.log("Menu---->"+menu);
       if(menu==='MenuItemOne') 
       {
           component.set("v.title","Today's Tasks");
          var title='Today';
       }
       else if(menu==='MenuItemTwo') 
       {
           component.set("v.title",'My Tasks');
            var title='My';
       }
        else if(menu==='MenuItemThree') 
       {
           component.set("v.title",'All Overdue Tasks');
            var title='All';
       } 
          else if(menu==='MenuItemFour') 
       {
           component.set("v.title",'Completed Tasks');
            var title='Completed';
       }
        else
        {
            return null;
        }
      	var heading = component.get("v.title");
        console.log('Changed set of values--->'+title);
        var action=component.get("c.getTasks");  
        action.setParams
        ({
           "title" : heading
        });
        console.log('Changed set of values1--->'+title);
         action.setCallback(this, function(response) 
           {
            var state = response.getState();
            if (state == "SUCCESS") 
            {
                console.log('Values on change',response.getReturnValue())
                component.set("v.Task", response.getReturnValue());
                
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
        
	},
    onCheck : function(component, event, helper)
    {
        var a=event.target.getAttribute("id");
        var b=a+'tag';
        component.set("v.subjectid",a);
        var isChecked=document.getElementById(a).checked;
        if(isChecked==false)
        {
            component.set("v.showModal",true);
        }
        else
        {
        var action=component.get("c.setTasks");  
        action.setParams({
            "tskId":a,
            "check":isChecked
        });
         action.setCallback(this, function(response) {
            var state = response.getState();
             var active = response.getReturnValue();
            if (state == "SUCCESS") 
            {
                component.set("v.check", true);
                document.getElementById(b).style.textDecoration='line-through';
            }
            else {
                component.set("v.check",false);
                console.log("Failed with state: " + state);
            }
        });
         
        $A.enqueueAction(action);
    }
    },
    showpopup : function(component, event, helper)
    {
      
      var selectedId = event.target.getAttribute('id');
        var whoId = event.target.getAttribute("data-attriVal");
        component.set("v.contactId", whoId);
        component.set("v.popup",true);
    },
    hidepop : function(component, event, helper)
    {
        component.set("v.popup",false);
    },
})