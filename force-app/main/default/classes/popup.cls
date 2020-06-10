public with sharing class popup
{
     @AuraEnabled
    public static List<Contact> setpopupvalues(String contactId)
    {
        System.debug('IDE----->'+contactId);
      List<Contact> co=new List<Contact>();
        co=[select id,name,Email,Title from Contact where id=:contactId];
        return co;
        
    }
}