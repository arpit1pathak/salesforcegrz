trigger OpportunityApprovalTrigger on Opportunity (before update) {
List<Opportunity> opps=new List<Opportunity>();
    for(Opportunity o:trigger.new)
    {
        opps.add(o);
    }
    OpportunityApproval.beforeUpdate(opps);
}