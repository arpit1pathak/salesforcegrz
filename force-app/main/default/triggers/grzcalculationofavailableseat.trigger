trigger grzcalculationofavailableseat on CampaignMember(before insert, after insert,after delete,before update,after update) 
{
    List < campaign > c = new List < campaign > ();
     List < campaign > d = new List < campaign > ();
    Map < Id, List < Campaignmember >> campaignmemberwithcampaignid = new Map < Id, List < campaignmember >> ();
    if (Trigger.isInsert||Trigger.isupdate)
    {
        for (Campaignmember ca: trigger.new) 
            {
                if (campaignmemberwithcampaignid.containsKey(ca.CampaignId)) 
                {
                    List < Campaignmember > p = campaignmemberwithcampaignid.get(ca.CampaignId);
                    p.add(ca);
                    campaignmemberwithcampaignid.put(ca.CampaignId, p);
                } 
                else 
                {
                    List < Campaignmember > p = new List < Campaignmember > ();
                    p.add(ca);
                    campaignmemberwithcampaignid.put(ca.campaignid, p);
                }
            }
        if (Trigger.isBefore) 
        {   
            for (Campaign ca: [select Available_Seat__c from campaign where id IN: campaignmemberwithcampaignid.keySet()]) 
            {
                for (Campaignmember cm: trigger.new) 
                {
                    if (cm.status == 'Responded' && ca.Available_Seat__c > 0) 
                    {
                        cm.status = 'Invited';
                    }
                    else if(ca.Available_Seat__c==0)
                    {
                        cm.Status='Waiting';
                    }
                }
            }
        }
        if (Trigger.isafter) 
        {
            for (Campaign cw: [select Available_Seat__c from campaign where id IN: campaignmemberwithcampaignid.keySet()]) 
            {
                for (Campaignmember ce: trigger.new) 
                {
                    if (cw.Available_Seat__c > 0 && ce.CampaignId == cw.Id && ce.Status=='Invited') 
                    {
                        cw.Available_Seat__c = cw.Available_Seat__c - 1;
                        
                    }
                    c.add(cw);
                }
            }

        } 
    update c;
    }
    if(Trigger.isdelete)
    {
        for (Campaignmember ca: trigger.old) 
            {
                if (campaignmemberwithcampaignid.containsKey(ca.CampaignId)) 
                {
                    List < Campaignmember > p = campaignmemberwithcampaignid.get(ca.CampaignId);
                    p.add(ca);
                    campaignmemberwithcampaignid.put(ca.CampaignId, p);
                } 
                else 
                {
                    List < Campaignmember > p = new List < Campaignmember > ();
                    p.add(ca);
                    campaignmemberwithcampaignid.put(ca.campaignid, p);
                }
        if(Trigger.isafter)
        {
            for(Campaign ci:[select Available_Seat__c,Total_Seat__c from campaign where id IN:campaignmemberwithcampaignid.keySet()])
            {
                for(Campaignmember co:trigger.old)
                {
                    if(ci.Available_Seat__c<ci.Total_Seat__c && ci.Total_Seat__c!=0 && co.Status=='Invited')
                    ci.Available_Seat__c=ci.available_seat__c+1;
                    d.add(ci);
                }
                    
            }
        }
    update d;
            }
        
    }
}