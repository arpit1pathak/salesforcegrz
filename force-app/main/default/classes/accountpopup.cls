public with sharing class accountpopup {
    @AuraEnabled
    public static List<Account> searchForIds(String searchText)
    {
       
         List<Account> ac=new List<Account>();
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