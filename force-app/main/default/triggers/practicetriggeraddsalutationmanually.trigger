trigger practicetriggeraddsalutationmanually on Lead (before insert) 
{
List<Lead> lm=new List<Lead>();
    for(Lead lm:trigger.new)
    {
        if(lm.salutation==null&&lm.gender__c=='Male')
            lm.salutation='Mr.';
        else
            lm.salutation='Mrs.';
    }
}