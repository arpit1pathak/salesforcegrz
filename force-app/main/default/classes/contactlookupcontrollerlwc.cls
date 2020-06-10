public with sharing class contactlookupcontrollerlwc {
     @AuraEnabled(cacheable=true)
    public static List<Contact> searchForIds(String searchtext)
    {
        if(String.isNotBlank(searchtext))
        {  
            List<Contact> contacts=[SELECT Id, Name FROM Contact WHERE Name LIKE : '%'+searchtext+'%' LIMIT 5];
            return contacts;
        } 
        else{
                return null;
            }
    }
}