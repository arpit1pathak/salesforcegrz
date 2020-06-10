trigger grzavailableseat on CampaignMember(before insert,after insert,before delete,after delete,before update,after update)
{
    Map < ID, List < Campaignmember >> camidndcammember = new Map < ID, List < Campaignmember >> ();
    Map < ID, Decimal > ma = new map < ID, Decimal > ();
    Map < ID, Decimal > to = new map < ID, Decimal > ();
    Map < ID, Campaign > cam = new Map < ID, Campaign > ();
   if (Trigger.isinsert)
      {
          for (Campaignmember cm: trigger.new) 
        	{
            if (camidndcammember.containsKey(cm.campaignid)) 
            {
                List < Campaignmember > ca = camidndcammember.get(cm.campaignid);
                ca.add(cm);
                camidndcammember.put(cm.campaignid, ca);
            }
            else 
            {
                List < Campaignmember > ca = new List < Campaignmember > ();
                ca.add(cm);
                camidndcammember.put(cm.campaignid, ca);
            }
        }
    for (Campaign ca: [select id, Available_Seat__c from Campaign where id IN: camidndcammember.keyset()]) 
            {
                ma.put(ca.id, ca.available_seat__c);
            }
          if(Trigger.isbefore)
        {
            
            for (Campaignmember co: trigger.new) 
            {
                if (ma.containskey(co.campaignid) && ma.get(co.campaignid) > 0) 
                {
                    if (co.status == 'Responded' || co.status == 'Waiting' || co.status == 'Invited') 
                    {
                        co.status = 'Invited';
                        ma.put(co.campaignid, ma.get(co.CampaignId)-1);
                        System.debug('$$$$$$$$$$$$'+ma.get(co.CampaignId));
                    }
                }
                else if (ma.containskey(co.campaignid) && ma.get(co.campaignid) == 0) 
                {
                    if (co.status == 'Responded' || co.status == 'Waiting' || co.status == 'Invited') 
                    {
                        co.status = 'Waiting';
                        ma.put(co.campaignid, ma.get(co.CampaignId));
                    }
                }  
	}   
        
}
else if(Trigger.isafter)
{
  for(Campaignmember co:trigger.new)
  {
      if(co.Status=='Invited' && ma.containskey(co.campaignid) && ma.get(co.campaignid)>0)
      {
          ma.put(co.campaignid, ma.get(co.CampaignId)-1);
      }
      else if(co.Status=='Waiting' && ma.containskey(co.campaignid) && ma.get(co.campaignid)<0)
      {
        ma.put(co.campaignid, ma.get(co.CampaignId));  
      }  
     for(ID ie:ma.keySet())
     {
         Campaign c=new Campaign();
         c.id=ie;
         c.Available_Seat__c=ma.get(co.CampaignId);
         cam.put(c.id, c);
         System.debug('&&&&&&&&&&&&&&&&&&'+c.Available_Seat__c);
     }
     update cam.values();
}
   
}
}
else if(Trigger.isdelete)
    {
        if(Trigger.isafter)
        {
        for (Campaignmember cm: trigger.old) 
        {
            if (camidndcammember.containsKey(cm.campaignid)) 
            {
                List < Campaignmember > ca = camidndcammember.get(cm.campaignid);
                ca.add(cm);
                camidndcammember.put(cm.campaignid, ca);
            }
            else 
            {
                List < Campaignmember > ca = new List < Campaignmember > ();
                ca.add(cm);
                camidndcammember.put(cm.campaignid, ca);
            }
        }
       for (Campaign ca: [select id, Available_Seat__c,Total_Seat__c from Campaign where id IN: camidndcammember.keyset()]) 
            {
                ma.put(ca.id, ca.available_seat__c);
                to.put(ca.id, ca.Total_Seat__c);
            }

     for (Campaignmember co: trigger.old) 
           {
             if (ma.containskey(co.campaignid) && ma.get(co.campaignid) >= 0) 
                {
                   if (co.status == 'Invited' && ma.get(co.campaignid) < to.get(co.campaignid)) 
                      {
                         ma.put(co.campaignid, ma.get(co.CampaignId) + 1);
                                System.debug('&&&&&&&&' + ma);
                       }
                 }
                for (ID ie: ma.keyset()) 
                {
                    Campaign d = new Campaign();
                    d.id = ie;
                    d.Available_Seat__c = ma.get(ie);
                    cam.put(d.Id, d);
                    System.debug('&&&&&&&&&&&&&&&&'+ d);
                }
                
          }    
        update cam.values();
    }
}
else if(Trigger.isupdate)
{
    if(Trigger.isafter)
    {
     for (Campaignmember cm: trigger.new) 
            {
                if (camidndcammember.containsKey(cm.campaignid)) 
                {
                    List < Campaignmember > ca = camidndcammember.get(cm.campaignid);
                    ca.add(cm);
                    camidndcammember.put(cm.campaignid, ca);
                }
                else
                {
                    List < Campaignmember > ca = new List < Campaignmember > ();
                    ca.add(cm);
                    camidndcammember.put(cm.campaignid, ca);
                }
            }
            for (Campaign ca: [select id, Available_Seat__c from Campaign where id IN: camidndcammember.keyset()]) 
            {
                ma.put(ca.id, ca.available_seat__c);
            }
              for (Campaignmember co: trigger.new) 
              {
                  if (ma.containskey(co.campaignid) && ma.get(co.campaignid) < to.get(co.campaignid)) 
                {
                    if (co.status == 'Waiting' || co.status == 'Sent' || co.Status=='Responded') 
                    {
                        ma.put(co.campaignid, ma.get(co.CampaignId) + 1);
                    }
                }
                  else if (ma.containskey(co.campaignid) && ma.get(co.campaignid) <= to.get(co.campaignid))
                  {
                     ma.put(co.campaignid, ma.get(co.CampaignId) - 1); 
                  }
              }
                 for (Campaignmember co: trigger.new) 
                   {
                  if (ma.containskey(co.campaignid) && ma.get(co.campaignid) < to.get(co.campaignid)) 
                     {
                    if (co.status == 'Waiting' || co.status == 'Sent' || co.Status=='Responded') 
                       {
                        ma.put(co.campaignid, ma.get(co.CampaignId) + 1);
                       }
                     }
                  else if (ma.containskey(co.campaignid) && ma.get(co.campaignid) <= to.get(co.campaignid))
                    {
                     ma.put(co.campaignid, ma.get(co.CampaignId) - 1); 
                    }
                    }   
                for (ID ie: ma.keyset()) 
                {
                    Campaign d = new Campaign();
                    d.id = ie;
                    d.Available_Seat__c = ma.get(ie);
                    cam.put(d.Id, d);
                    System.debug('&&&&&&&&&&&&&&&&' + d);
                }
              }
         update cam.values();
 if(Trigger.isbefore)
 {
          for (Campaignmember cm: trigger.new) 
        	{
            if (camidndcammember.containsKey(cm.campaignid)) 
            {
                List < Campaignmember > ca = camidndcammember.get(cm.campaignid);
                ca.add(cm);
                camidndcammember.put(cm.campaignid, ca);
            }
            else 
            {
                List < Campaignmember > ca = new List < Campaignmember > ();
                ca.add(cm);
                camidndcammember.put(cm.campaignid, ca);
            }
        }
    for (Campaign ca: [select id, Available_Seat__c from Campaign where id IN: camidndcammember.keyset()]) 
            {
                ma.put(ca.id, ca.available_seat__c);
            }
            
            for (Campaignmember co: trigger.new) 
            {
                if (ma.containskey(co.campaignid) && ma.get(co.campaignid) > 0) 
                {
                    if (co.status == 'Responded' || co.status == 'Waiting' || co.status == 'Invited') 
                    {
                        co.status = 'Invited';
                        ma.put(co.campaignid, ma.get(co.CampaignId)-1);
                        System.debug('$$$$$$$$$$$$'+ma.get(co.CampaignId));
                    }
                }
                else if (ma.containskey(co.campaignid) && ma.get(co.campaignid) == 0) 
                {
                    if (co.status == 'Responded' || co.status == 'Waiting' || co.status == 'Invited') 
                    {
                        co.status = 'Waiting';
                        ma.put(co.campaignid, ma.get(co.CampaignId));
                    }
                } 
 }
}    
}
}