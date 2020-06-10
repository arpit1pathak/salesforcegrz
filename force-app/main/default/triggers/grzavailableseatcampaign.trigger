trigger grzavailableseatcampaign on Campaign (before insert,before update) 
{
	List<Campaign> ca=new List<Campaign>();
    List<Decimal> de=new List<Decimal>();
    Set<ID> se=new Set<ID>();
    if(Trigger.isbefore)
    {
        if(Trigger.isinsert)
        {
        for(Campaign ca:trigger.new)
            {
                    ca.Available_Seat__c=ca.Total_Seat__c;
            }
    	}
        else if(Trigger.isupdate)
        { 
            Decimal n=0;
           for(Campaign cg:trigger.new)
         	{
             se.add(cg.id);
         	}
            list<Campaignmember> listCam=[Select id from Campaignmember where CampaignId IN:se AND Status='Invited'];
            for(Campaign c:Trigger.new)
            {
                c.Available_Seat__c=c.Total_Seat__c-listCam.size();    
            }
		}	
    }
}