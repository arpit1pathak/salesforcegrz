public class sortfields 
{
    public List<account> acclist{get;set;}
        public List<Account> acc{get;set;}
public List<Account> getaccountname()
{
    acc=[select name,type,fax,rating from Account];
    return acc;
}
    public List<account> getsortname()
    {
        
        accList = [select name from account where id IN:acc order by Name limit 10];
        return acclist;
        
    }
}