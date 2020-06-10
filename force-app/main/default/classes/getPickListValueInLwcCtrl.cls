public with sharing class getPickListValueInLwcCtrl {
    @AuraEnabled(cacheable = true)
    public static List < FatchValueWrapper > fatchPickListValue(sObject objInfo, string picklistFieldApi) {
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objInfo.getSObjectType().getDescribe();
 
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
 
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values = fieldMap.get(picklistFieldApi).getDescribe().getPickListValues();
 
        // Create a list of wrapper to store picklist value/lable
        list < FatchValueWrapper > objWrapper = new list < FatchValueWrapper > ();
 
        for (Schema.PicklistEntry a: values) {
            FatchValueWrapper oFatchValueWrapper = new FatchValueWrapper();
            oFatchValueWrapper.slabel = a.getLabel();
            oFatchValueWrapper.svalue = a.getValue();
            objWrapper.add(oFatchValueWrapper);
        }
        return objWrapper;
 
    }
    @AuraEnabled(cacheable = true)
    public static List<FatchValueWrapper> getcontactroles(list<String> accId)
    {
      List<FatchValueWrapper> wrapperList=new List<FatchValueWrapper>();
      List<AccountContactRole> accountRole = [SELECT Id,IsDeleted, Contact.Name,Contact.Account.Name,Contact.Id,Contact.AccountId,
      isPrimary,Contact.Phone,Contact.Email,Role 
      FROM AccountContactRole WHERE Account.id in : accId ORDER BY isPrimary DESC];
      for(AccountContactRole acr:accountRole)
      {
        FatchValueWrapper obj=new FatchValueWrapper();
        obj.getRoles=acr;
        obj.AccountName=acr.Contact.Account.Name;
        obj.ContactName=acr.Contact.Name;
        wrapperList.add(obj);
        
      }
      return wrapperList;
    }
    @AuraEnabled
    public static string deleteacr(String deleteid)
    {
     List<AccountContactRole> del=[select id from AccountContactRole where id=:deleteid];
     delete del;
     return 'deleted';
    }
    @AuraEnabled
    public static void savecontactroles(String accid,string conid,boolean ischk,string role,string rolId)
    {
      if(rolId != null)
      {
        AccountContactRole acr = [SELECT Id, ContactId,Role, isPrimary FROM AccountContactRole WHERE Id =:rolId];
        acr.ContactID=conid;
        acr.isPrimary=ischk;
        acr.Role=role;
        update acr;
      }
      else {
      AccountContactRole cr = new AccountContactRole();
      cr.AccountId=accid;
      cr.ContactID=conid;
      cr.isPrimary=ischk;
      cr.Role=role;
      insert cr;
        
      }
      
    }
    
    // class for Saving the values
 // wrapper class 
    public with sharing class FatchValueWrapper {
        @auraEnabled public string slabel {get;set;}
        @auraEnabled public string svalue {get;set;}
        @AuraEnabled public AccountContactRole getRoles {get;set;}
        @auraEnabled public string AccountName {get;set;}
        @auraEnabled public string ContactName {get;set;}

    }
    @AuraEnabled(cacheable = true)
    public static AccountContactRole recordEditd(String editId){
      AccountContactRole singleRecord=[select id,ContactId,Contact.Name,Role,isPrimary from AccountContactRole where id=:editId];
      return singleRecord;
    }
}