public with sharing class mytasks1
{   
   @AuraEnabled
    public static List<wrapperclass> getTasks(String title) 
    {
        Date d=System.today();
        List<wrapperclass> wc = new List<wrapperclass>();
    	list<Task> tasklist=new list<Task> ();   
         if(title.contains('Today'))
        {
            tasklist=[SELECT Id,subject,ActivityDate,who.name,who.id,status,isClosed FROM Task where ActivityDate=today AND isClosed=false Limit 5];
         }
        else if(title.contains('My'))
        {
            tasklist=[SELECT Id,subject,ActivityDate,who.name,whoid,ownerid,status,isClosed FROM Task where ownerid=:UserInfo.getUserId() AND isClosed=false Limit 5];
        }
            else if(title.contains('All'))
        {
            tasklist=[SELECT Id,Subject,Status,ActivityDate,Who.Name,whoId,isClosed FROM Task WHERE Who.type = 'Contact' AND ActivityDate <: System.today() AND isClosed=false LIMIT 5];
           
        }
       else if(title.contains('Completed'))
       {
           tasklist=[SELECT Id,Subject,Status,ActivityDate,Who.Name,whoId,isClosed FROM Task WHERE ActivityDate >= LAST_WEEK AND  Who.type = 'Contact' AND isClosed=True LIMIT 5]; 
       }
        else
        {
            return null;
        }
        for(Task tsk: tasklist)
        {
            wrapperclass obj=new wrapperclass();
            obj.getTask=tsk;
            if(tsk.status=='Completed')
            {
                obj.checkstatus=tsk.Isclosed;
            }
            else
            {
                obj.checkstatus=tsk.IsClosed;
            }
            if(tsk.ActivityDate==System.today())
            {
                obj.day='Today';
            }
            else if(tsk.ActivityDate==System.today().addDays(-1))
            {
                obj.day='Yesterday';
            }
               else if(tsk.ActivityDate==System.today().addDays(+1))
            {
                obj.day='Tomorrow';
            }
            else
            {
                Date date1=tsk.ActivityDate;
                obj.day=String.valueOf(date1);
                System.debug(obj.day);
            }
            wc.add(obj);
        }
        return wc;
     }
    @AuraEnabled
    public static void setTasks(Boolean check,String tskId)
    {
        if(check==true)
        {
     List<Task> uptask=[select id,status from Task where id=:tskid]; 
            for(Task t:uptask)
            {
                t.status='Completed';
            }
            update uptask;
        }
    }
   
    public class wrapperclass
    {
       @AuraEnabled public Contact getcontact{get;set;} 
       @AuraEnabled public Task getTask{get;set;}
        @AuraEnabled public Boolean checkstatus{get;set;}
        @AuraEnabled public string day{get;set;}
    }
    
}