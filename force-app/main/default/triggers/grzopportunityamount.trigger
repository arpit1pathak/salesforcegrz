trigger grzopportunityamount on Opportunity(after insert, after update,after delete) 
{
      grzopportunityamount handler=new grzopportunityamount();
    if(Trigger.isInsert || Trigger.isUpdate)
    {
      handler.bulkupsert(Trigger.new); 
 }
    if (Trigger.isdelete)
    {
        handler.bulkdelete(Trigger.old);
    }
}