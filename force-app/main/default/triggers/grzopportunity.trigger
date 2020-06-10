trigger grzopportunity on Opportunity (before insert,after insert,after update)
{
    Map<ID,List<Opportunity>> coidwidopp=new Map<ID,List<Opportunity>>();
    Map<ID,List<Contact>> acidwidcon=new Map<ID,List<Contact>>();
    Map<ID,Decimal> cu=new Map<ID,Decimal>();
    Map<ID,Account> ac=new Map<ID,Account>();
    if(Trigger.isinsert || Trigger.isupdate)
    {
     for(Opportunity op:trigger.new)
      {
        if(coidwidopp.containsKey(op.contactid))
         {
           List<Opportunity> opp=coidwidopp.get(op.contactid);
           opp.add(op);
           coidwidopp.put(op.contactid,opp);
         }
           else
         {
           List<Opportunity> opp=new List<Opportunity>();
           opp.add(op);
           coidwidopp.put(op.contactid, opp);
         }
System.debug('Contact ID with opportunity'+coidwidopp);
      }

for(Contact co:[select id,accountid from contact where id IN:coidwidopp.keySet()])
    {
       if(acidwidcon.containsKey(co.accountid))
        {
        List<Contact> cn=acidwidcon.get(co.accountid);
        cn.add(co);
        acidwidcon.put(co.accountid, cn);
        }    
          else
        {
         List<Contact> cn=new List<Contact>();
         cn.add(co);
         acidwidcon.put(co.AccountId,cn);   
        }
 System.debug('Account ID with contact'+acidwidcon);  
    }    
if(Trigger.isafter)
{
    for(Account ac:[select id, Amount__c,(select id from Contacts) from Account where ID in:acidwidcon.keySet()])
    {
        cu.put(ac.id,ac.Amount__c);
    }
    for(Opportunity o:trigger.new)
    {
        for(Contact c:[select id,name,accountid,Account.Amount__c from contact where id=:o.contactId])
        {
          if(coidwidopp.containsKey(o.ContactId) && acidwidcon.containsKey(o.ContactId))
           {
             cu.put(c.accountid,c.account.Amount__c+o.Amount); 
           } 
       for(ID ie:cu.keySet())
        {
        Account a=new Account(); 
        a.id=ie;
        a.Amount__c=cu.get(c.accountid);
        ac.put(a.Id,a);
        }
    }
    update ac.values();    
    }
}
}
}