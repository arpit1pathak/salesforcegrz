trigger practicetriggeroncontactpopulatingthephonenumberontheaccount on Contact (after insert)
{
set<ID> s=new set<ID>();
    for(Contact con:trigger.new)
    {
        s.add(con.accountid);
    }
    List<Account> ac=[select phone from account where id IN:s];
        for(Contact c:trigger.new)
    {
        for(Account a:ac)
        {
            a.phone=c.phone;
        }
    }
}