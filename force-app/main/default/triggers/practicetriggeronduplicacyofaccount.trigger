trigger practicetriggeronduplicacyofaccount on Account (before insert) 
{
List<Account> ac=[select name from Account];
List<Account> acc=new List<Account>();
    for(Account acc:trigger.new)
    {
        for(Account d:ac)
        {
            if(acc.Name==d.name)
                acc.adderror('Account already exists');
        }
    }
}