public class mytasks 
{
@Auraenabled
    public static List<Task> getTask(String inp) 
    {
        List<Task> ts=new List<Task>();
        if(inp=='Today\'s Task')
            
        {
            System.debug('def');
         ts=[SELECT Id, WhoId, WhatId, Subject, ActivityDate, Status FROM Task where ActivityDate=Today];
        }
    system.debug('list--> '+ts);
         return ts;
    }
   
}