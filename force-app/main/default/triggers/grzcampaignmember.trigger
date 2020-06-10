trigger grzcampaignmember on campaignmember(after insert,after update,after delete)
{  
if(Trigger.isinsert||Trigger.isupdate)
{    
       string d='';
       boolean found=true;
       List<Lead> we=new List<Lead>();
       Set<string> ld=new Set<string>();
       for (Campaignmember c:trigger.new)
       {
           ld.add(c.LeadId);
       }
            for(Lead lea:[SELECT name,id,Campaign__c,(select id,campaign.name from campaignmembers) FROM Lead where id IN:ld])
            {
                Set<string> re=new Set<string>();
                for(Campaignmember cm:lea.campaignmembers)
                {   
                    if(cm.campaign.name.contains('Microsoft')) 
                    {    
                        re.add('Microsoft');
                    }
                       else if(cm.campaign.name.contains('Salesforce'))
                          {
                        re.add('Salesforce');
                          }
                 else if(cm.campaign.name.contains('Tableau'))
                         {
                           re.add('Tableau');
                         }
                     if(cm.campaign.name.contains('Excel'))
                         {
                         re.add('Excel');
                         }
                
                }    
                for(String s:re)
                {
                  d+=s+';';  
                }
                lea.campaign__c=d;
                we.add(lea);  
                d='';
            }  
          update we;  
    
    }
if(Trigger.isDelete)
{
    string d='';
  List<Lead> we=new List<Lead>();
       Set<string> ld=new Set<string>();
       for (Campaignmember c:trigger.old)
       {
           ld.add(c.LeadId);
       }
            for(Lead lea:[SELECT name,id,Campaign__c,(select id,campaign.name from campaignmembers) FROM Lead where id IN:ld])
            {
                for(Campaignmember cm:lea.campaignmembers)
                {  
                    
                    if(cm.campaign.name.contains('Microsoft'))
                           {
                               d+='Microsoft; '; 
                       }
                        else if(cm.campaign.name.contains('Salesforce'))
                          {
                         d+='Salesforce; ';
                          }
                 else  if(cm.campaign.name.contains('Tableau'))
                         {
                           d+='Tableau; ';
                         }
                    else  if(cm.campaign.name.contains('Excel'))
                         {
                         d+='Excel';
                         }  
                }      
                lea.campaign__c=d;
                we.add(lea);  
            }  
          update we;    
}
}