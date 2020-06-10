trigger practiceleadopportunitymustbelinkedwithaccount on Opportunity (before insert) 
{
List<Opportunity> op=new List<opportunity>();
    for(opportunity op:trigger.new)
    {
    if(op.accountid==null)
        op.adderror('Each opportunity must be linked with an account');
        }
}