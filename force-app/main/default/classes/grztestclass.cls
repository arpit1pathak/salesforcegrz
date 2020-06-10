@istest private class grztestclass
{
@istest static void testmethod1()
{
    {
        test.starttest();
    List<Opportunity> op=new List<Opportunity>();
    Opportunity op1=new Opportunity();
    op1.name='First come first serve';
    op1.closedate=date.parse('12/11/2019');
    op1.Amount=5000;
    op1.StageName='Prospecting';
    op1.Approval_Status__c='Pending'; 
    op.add(op1);
    Opportunity op3=new Opportunity();
    op3.name='First come';
    op3.closedate=date.parse('12/11/2019');
    op3.Amount=5000;
    op3.StageName='Prospecting';
    op3.Approval_Status__c='Pending';    
    op.add(op3);
    insert op;
    op1.Amount=6000;
    update op1;
    List<Opportunity> o=new List<Opportunity>();
    Opportunity op2=new Opportunity();
    op2.Name='Last come last serve';
    op2.closedate=date.parse('12/11/2019'); 
    op2.Amount=5000;
    op2.StageName='Prospecting';
    op2.Approval_Status__c='Pending';    
    o.add(op2);
    insert o;
   List<Apttus_Approval_ApprovalRule__c> ap=new List<Apttus_Approval_ApprovalRule__c>();
      Apttus_Approval_ApprovalRule__c a=new Apttus_Approval_ApprovalRule__c();
        a.Name='Rule 1';
        a.Apttus_Approval_Criteria__c='{\n"sObjectName" : "Opportunity",\n"sObjectLabel" : "Opportunity",\n"filter" : {\n"predicates" : [ {\n"RowNum" : 1,\n"RHSFieldValueType" : null,\n"RHSChildFilterName" : null,\n"LHSFieldValueType" : null,\n"LHSChildFilterName" : null,\n"FieldValue" : "Closed Lost",\n"FieldType" : "PICKLIST",\n"FieldName" : "StageName",\n"FieldLabel" : "Stage",\n"CompOper" : "equal to",\n"BoolOper" : "AND"\n}],\n"condExpr" : "1"\n},\n"fields" : [ "StageName" ],\n"exprStr" : "(Stage = Closed Lost)"\n}';
   a.Apttus_Approval_Sequence__c=1; 
        ap.add(a);
        insert ap;
        
        for(Apttus_Approval_ApprovalRule__c r:ap)
        {
            r.Apttus_Approval_Sequence__c=4;
        }
        update ap;
    }
     test.stoptest();   
    }
}