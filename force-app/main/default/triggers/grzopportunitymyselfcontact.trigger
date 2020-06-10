trigger grzopportunitymyselfcontact on Contact(after delete) 
{
    Map < ID, List < Contact >> acidwidcon = new Map < ID, List < Contact >> ();
    Map < ID, List < opportunity >> acidwidop = new Map < ID, List < Opportunity >> ();
    Map < ID, Decimal > acidwidamount = new Map < ID, Decimal > ();
    Map < ID, Account > ac = new Map < ID, Account > ();
    if (Trigger.isdelete) 
    {
        if (Trigger.isafter) 
        {
            for (Contact co: trigger.old) {
                if (acidwidcon.containsKey(co.accountid)) {
                    List < Contact > ac = acidwidcon.get(co.accountid);
                    ac.add(co);
                    acidwidcon.put(co.Accountid, ac);
                } else {
                    List < Contact > ac = new List < Contact > ();
                    ac.add(co);
                    acidwidcon.put(co.Accountid, ac);
                }
            }
            for (Account ac: [select id, name, (select id,contactid,amount from opportunities) from Account where id IN: acidwidcon.keySet()]) {
                Decimal Money = 0;
                for (Opportunity o: ac.opportunities) 
                {
                    if(o.ContactId!=null)
                    Money += o.amount;
                }
                acidwidamount.put(ac.Id, Money);

                
            }
            for (ID ie: acidwidamount.keySet()) {
                    Account a = new Account();
                    a.id = ie;
                    a.Amount__c = acidwidamount.get(ie);
                    ac.put(a.Id, a);
                }
            update ac.values();
        }
    }
}