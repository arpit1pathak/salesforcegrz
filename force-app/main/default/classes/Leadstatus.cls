public class Leadstatus 
{
    @AuraEnabled
    public static List<Task> getTask()
    {
        list<Task> tsk= [SELECT Id, ActivityDate,WhatID FROM Task limit 5];
        system.debug('tsk-->' +tsk);
        return tsk;
    }
}