trigger Countcontact on Contact (after insert)
{
    Set<Id> accidset = new Set<Id>();
    For(Contact cont: trigger.new)
    {
        accidset.add(cont.accountid);      
        
    }
List<Account> acclister=[select id,name,Total_Contact__c,(Select id,name from Contacts) from account where id IN:accidset];
          for(Account b:acclister) 
          {
        b.Total_Contact__c=b.Contacts.size();
              
    }
update acclister;
for(Account p:acclister)
{
    for(Contact c:p.contacts)
    {
    String y=c.name;
        System.debug(y);
    p.Comma_Seperated_Values__c=y;
}
}
}