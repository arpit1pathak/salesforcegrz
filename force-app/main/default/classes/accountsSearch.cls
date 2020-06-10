public with sharing class accountsSearch {
     @AuraEnabled(cacheable=true)
    public static List<Account> searchForIds(String searchText)
    {
       
         List<Account> ac=new List<Account>();
         System.debug('----->'+searchText);
        if(String.isNotBlank(searchText))
        {  
            ac=[Select Id ,Name from Account where name like  : '%'+searchText+'%' limit 10];
                System.debug('Account Name--->'+ac);
        return ac;
        } 
        
        else{
                return null;
            }
    }
}