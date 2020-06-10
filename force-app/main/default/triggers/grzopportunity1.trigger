trigger grzopportunity1 on Opportunity(after insert, after update) 
{
    Map < ID, List < Opportunity >> acidwidopp = new Map < ID, List < Opportunity >> ();
    Map < ID, List < Contact >> acidwidcon = new Map < ID, List < Contact >> ();
    Map < ID, Decimal > acidwidamount = new Map < ID, Decimal > ();
    Map < ID, Account > acupdate = new Map < ID, Account > ();
    Set<ID> se=new Set<ID>();
    if (Trigger.isinsert || Trigger.isupdate)
    {
        for (Opportunity op: trigger.new)
        {
           se.add(op.AccountId);
        }
        for (Contact co: [select id, accountid from contact where accountid IN:se]) 
        {
            if (acidwidcon.containsKey(co.accountid)) 
            {
                List < Contact > cn = acidwidcon.get(co.accountid);
                cn.add(co);
                acidwidcon.put(co.accountid, cn);
            }
            else
            {
                List < Contact > cn = new List < Contact > ();
                cn.add(co);
                acidwidcon.put(co.AccountId, cn);
            }
        }
   for(Account a:[select id,name,Amount__c ,(select id,Amount,contactId from opportunities) from account where id IN:acidwidcon.keySet()])
   {
       Decimal Money=0;
    for(Opportunity o:a.opportunities)
    {
        if(o.contactId != null) 
        Money-=o.Amount;
         
        acidwidamount.put(a.Id, Money);
    }
       
   }
        for (Opportunity oc: trigger.new) 
        {
            for (ID ie: acidwidamount.keySet()) 
            {
                Account a = new Account();
                a.id = ie;
                a.Amount__c = acidwidamount.get(a.id);
                acupdate.put(a.Id, a);
            }
        }
        update acupdate.values();
    }
}