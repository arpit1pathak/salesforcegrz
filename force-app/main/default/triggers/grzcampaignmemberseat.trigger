trigger grzcampaignmemberseat on CampaignMember (before insert) 
{
grzcampaignmemberclass.cmstatus(trigger.new);
}