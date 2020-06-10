({
    doInit : function(component, event, helper)
    {
        document.title = "Home";
        var url = $A.get('$Resource.Background');
        component.set('v.backgroundImageURL', url);
        var url1=$A.get('$Resource.solutionicon');
        component.set('v.backgroundImagesolution', url1);
        var url2=$A.get('$Resource.Announcement');
        component.set('v.backgroundImageannouncement', url2);
        var url3=$A.get('$Resource.knowledgearticle');
        component.set('v.backgroundImageknowledge',url3);
         var url4=$A.get('$Resource.caraousel');
        component.set('v.backgroundImagecarousel',url4);
        
    }
})