public class grzcampaignmemberclass 
{
    public static void cmstatus(List<Campaignmember> cms)
    {
        Set<ID> st=new Set<ID>();
        Set<ID> me=new set<ID>();
        for(Campaignmember cs:[select name,campaignid from campaignmember where id IN:cms])
        {
            me.add(cs.campaignid);
             System.debug('###################'+me);
        }    
       
        List<Campaignmember> ce=new List<Campaignmember>();
        List<Campaign> c=new List<Campaign>();    
        for(Campaign cg:[select id,name,Available_Seat__c,(select campaignId,status,leadid from campaignmembers) from campaign where id IN:me])
        {
            for(Campaignmember cm:cg.campaignmembers)
            {
                if(cm.status=='Responded')
                {
                    cm.status='Invited'; 
                    ce.add(cm);
                    st.add(cm.campaignid);   
                }  
            }
            update ce;    
        }
        System.debug('&&&&&&&&&&&&&&&&&'+ce);    
        for(Campaign ci:[select Available_Seat__c,(select status from campaignmembers) from campaign where id IN:me]) 
        {
            if(ci.Available_Seat__c>0)
            {
                ci.Available_Seat__c=ci.Available_Seat__c-1;    
            }
            c.add(ci);    
        }
        update c;    
    }
}