trigger practiceaccounttypenull on Account (before insert)
{
    List<account> ac=new List<Account>();
    for(Account ac:trigger.new)
    {
        if(ac.type==null)
            ac.adderror('Account type is mandatory');
    }
}