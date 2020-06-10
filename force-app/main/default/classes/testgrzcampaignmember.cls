@isTest private class testgrzcampaignmember 
{
@isTest static void testmethod1()
{
List<Lead> ld=new List<Lead>();
Lead l=new lead(LastName='Arpit',Company='Grazitti');
ld.add(l);
insert ld;
List<Campaign> c=new List<Campaign>();    
Campaign cm=new Campaign(Name='First come first serve Microsoft');
c.add(cm);    
Campaign cm1=new Campaign(Name='First come first serve Tableau');
c.add(cm1); 
Campaign cm2=new Campaign(Name='First come first serve Excel');
c.add(cm2);
Campaign cm3=new Campaign(Name='First come first Salesforce');
c.add(cm3);
insert c;
List<Campaignmember> cd=new List<Campaignmember>();
Campaignmember co=new Campaignmember();
co.LeadId=l.id;
co.CampaignId=cm.id;
co.Status='Sent';
cd.add(co);
Campaignmember co1=new Campaignmember();    
co1.LeadId=l.id;
co1.CampaignId=cm1.id;    
co1.Status='Sent';
cd.add(co1);    
Campaignmember co2=new Campaignmember();   
co2.LeadId=l.id;
co2.CampaignId=cm2.id;    
co2.Status='Sent';
cd.add(co2);  
Campaignmember co3=new Campaignmember();   
co3.LeadId=l.id;
co3.CampaignId=cm3.id;    
co3.Status='Sent';
cd.add(co3);     
insert cd;
List<Campaignmember> f=[select id from campaignmember where campaign.name like 'Excel' or campaign.name like 'Microsoft'or campaign.name like '%Salesforce%'or campaign.name like '%Tableau%'];
delete f;
}   
}