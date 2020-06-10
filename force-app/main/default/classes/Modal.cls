public with sharing class Modal 
{
    @AuraEnabled
    public static string setstatus(String taskid,String status)
    {
        System.debug('taskid'+taskid);
        System.debug('status'+status);
        List<Task> tc=[select id,status from Task where id=:taskid];
        for(Task t:tc)
        {
            t.status=status;
        }
        update tc;
        return 'test';
    }

}