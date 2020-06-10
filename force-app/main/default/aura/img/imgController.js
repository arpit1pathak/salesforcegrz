({
	doInit : function(component, event, helper) {
		var url4=$A.get('$Resource.caraousel');
        component.set('v.backgroundImageURL',url4);
	}
})