@isTest private class testgrzavailableseat
{
    /*
@isTest static void testmethod1()
{
List<Lead> ld=new List<Lead>();
List<Campaign> c=new List<Campaign>();
Lead l=new lead(LastName='Arpit',Company='Grazitti');
ld.add(l);
Lead l1=new Lead(LastName='Shadab',Company='Grazitii');
ld.add(l1); 
Lead l2=new Lead(LastName='Vishal',Company='Grazitii');
ld.add(l2);
Lead l3=new Lead(LastName='Harsh',Company='Grazitii');    
ld.add(l3);
insert ld;    
Campaign cm=new Campaign(Name='First come first serve Microsoft');
cm.Available_Seat__c=3;
cm.Total_Seat__c=3;
c.add(cm);    
insert c;
List<Campaignmember> cd=new List<Campaignmember>();
Campaignmember co1=new Campaignmember();    
co1.LeadId=l1.id;
co1.CampaignId=cm.id;    
co1.Status='Responded';
cd.add(co1);    
Campaignmember co2=new Campaignmember();   
co2.LeadId=l2.id;
co2.CampaignId=cm.id;    
co2.Status='Invited';
cd.add(co2);  
Campaignmember co3=new Campaignmember();   
co3.LeadId=l3.id;
co3.CampaignId=cm.id;    
co3.Status='Waiting';
cd.add(co3);  
Campaignmember co=new Campaignmember();
co.LeadId=l.id;
co.CampaignId=cm.id;
co.Status='Responded';
cd.add(co);
    insert cd;
    cd=[SELECT Id,status from Campaignmember where status='Sent' or status ='Responded' or status='Waiting'];
    for(Campaignmember d:cd)
    {
        d.status='Waiting';
    }
    update cd;
    delete cd;
}  */  
}