trigger restrictdeletionofopportunity on Opportunity (before delete) 
{
List<opportunity> opp=new List<Opportunity>();
    for(Opportunity opp:trigger.old)
    {
        if(opp.accountid!=null)
        opp.adderror('This opportunity is linked with an account');
    }    
}