public class grzopportunityamount {
    Map < ID, List < Opportunity >> acidwidopp = new Map < ID, List < Opportunity >> ();
    Map < ID, Decimal > acidwidamount = new Map < ID, Decimal > ();
    Map < ID, Account > acupdate = new Map < ID, Account > ();
    Set<ID> se=new Set<ID>();
    decimal money = 0;
    public void bulkupsert(List < opportunity > opps) {
        for (Opportunity op: opps) {
            if (acidwidopp.containsKey(op.accountid)) {
                List < Opportunity > opp = acidwidopp.get(op.accountid);
                opp.add(op);
                acidwidopp.put(op.accountid, opp);
            } else {
                List < Opportunity > opp = new List < Opportunity > ();
                opp.add(op);
                acidwidopp.put(op.accountid, opp);
            }
        }

        for (Contact co: [select id, accountid, (select amount, accountid, ContactId from opportunities) from contact where accountid IN: acidwidopp.keySet()]) {
            if (acidwidamount.keySet().contains(co.AccountId)) {
                money = acidwidamount.get(co.AccountId);
                system.debug(co.Id);
            } else {
                money = 0;
            }
            for (Opportunity o: co.opportunities) {
                if (o.AccountId == co.AccountId) {
                    system.debug(o.amount + ' --$$$$$$$$-- ' + co.accountid);
                    Money += o.amount;
                    acidwidamount.put(co.accountid, Money);
                }
            }
            system.debug(Money);

            system.debug(acidwidamount);
        }
        for (ID ie: acidwidamount.keySet()) {
            Account a = new Account();
            a.id = ie;
            a.Amount__c = acidwidamount.get(ie);
            acupdate.put(a.id, a);
            system.debug(a.id + ' --$$$$$$-- ' + a);
        }
        update acupdate.values();
    }
   public void bulkdelete(List < Opportunity > opps) {
        for (Opportunity op: opps) {
System.debug('op.accountID-------->'+op.AccountId);            
         se.add(op.AccountId);       
        }
for(Contact co: [select id, accountid, (select amount, accountid, ContactId from opportunities) from contact where accountid IN:se]) {
            for (Opportunity o: co.opportunities) {
                system.debug(o.amount + ' --$$$$$$$$-- ' + co.accountid);
                Money += o.amount;
            }
            acidwidamount.put(co.accountid, Money);

            system.debug(acidwidamount);
        }
        for (ID ie: acidwidamount.keySet()) {
            Account a = new Account();
            a.id = ie;
            a.Amount__c = acidwidamount.get(ie);
            acupdate.put(a.id, a);
            system.debug(a.id + ' --$$$$$$-- ' + a);
        }
        update acupdate.values();
    }
}