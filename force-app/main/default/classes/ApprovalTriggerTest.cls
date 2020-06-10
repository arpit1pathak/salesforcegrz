@isTest
private class ApprovalTriggerTest {
    @testSetup
         static void testOpp(){
            List<Apttus_Approval_ApprovalRule__c> ar=new List<	Apttus_Approval_ApprovalRule__c>();
            Apttus_Approval_ApprovalRule__c a=new Apttus_Approval_ApprovalRule__c();
            String p='{"sObjectName":"Opportunity","sObjectLabel":"Opportunity","filter":{"predicates":[{"RowNum":1,"RHSFieldValueType":null,"RHSChildFilterName":null,"LHSFieldValueType":null,"LHSChildFilterName":null,"FieldValue":"Closed Lost","FieldType":"PICKLIST","FieldName":"StageName","FieldLabel":"Stage","CompOper":"equal to","BoolOper":"AND"}],"condExpr":"1 AND (2 OR 4)"},"fields":["StageName"],"exprStr":"(StageName = Closed Lost)"}';
            System.debug('Criteria-->'+a.Apttus_Approval_Criteria__c);
            a.Name='Rule 1';
            a.Apttus_Approval_Criteria__c=p; 
            a.Apttus_Approval_Sequence__c=1;
            ar.add(a);
            Apttus_Approval_ApprovalRule__c a0=new Apttus_Approval_ApprovalRule__c();
            String k='{"sObjectName":"Opportunity","sObjectLabel":"Opportunity","filter":{"predicates":[{"RowNum":2,"RHSFieldValueType":null,"RHSChildFilterName":null,"LHSFieldValueType":null,"LHSChildFilterName":null,"FieldValue":"Closed Lost","FieldType":"PICKLIST","FieldName":"StageName","FieldLabel":"Stage","FieldValue":"Closed Lost","CompOper":"greater than","BoolOper":"AND"}],"condExpr":"TRUE OR (TRUE OR (FALSE AND (TRUE OR FALSE))) "},"fields":["StageName"],"exprStr":"(StageName = Closed Lost)"}';
            System.debug('Criteria-->'+a0.Apttus_Approval_Criteria__c);
            a0.Name='Rule 2';
            a0.Apttus_Approval_Criteria__c=k; 
            a0.Apttus_Approval_Sequence__c=2;
            ar.add(a0); 
            insert ar;
           List<Account> ac=new List<Account>();
    Account a1=new Account(Name='KPP');
    ac.add(a1);
    insert ac;
     System.debug('Account is---'+a1.id);
          
    List<Opportunity> op=new List<Opportunity>();
    Opportunity op1=new Opportunity();
    op1.name='Abused Ink';
    op1.accountid=a1.id;
    op1.closedate=date.parse('12/11/2019');
    op1.Amount=5000;
    op1.StageName='Closed Lost';
    op1.TotalOpportunityQuantity=5;
    op1.Approval_Status__c='Pending';  
    op1.LeadSource='Other';        
    op.add(op1);
    Opportunity op3=new Opportunity();
    op3.name='Mc Donald';
    op3.accountid=a1.id;
    op3.closedate=date.parse('12/11/2019');
    op3.Amount=5000;
    op3.StageName='Prospecting';
    op3.LeadSource='Other'; 
    op3.Approval_Status__c='Pending';           
    op.add(op3);
    insert op;
    System.debug('Opportunity---->'+op1.id);       
    System.debug('Opportunity---->'+op3.id);            
        }
    @isTest
    static  void testOpp1()
    {
        Test.startTest();
       List<Boolean> values = new List<Boolean> {
    true, false, true
};
 
  
       List< Opportunity > opp = [SELECT Id, Name, AccountId, CloseDate, StageName, LeadSource,Approval_Status__c FROM Opportunity];
        System.debug('Opportunity to be updated--->'+opp);
        for(Opportunity o:opp)
        {
        o.StageName='Closed Lost';
       System.debug('Opportunity  Stagename--->'+o.Approval_Status__c);
       System.debug('Opportunity  updated--->'+o);
       System.debug('Opportunity Status--->'+o.Approval_Status__c);
       
        }  
        update opp;
       List<Opportunity> o= [SELECT Id, Name, AccountId, CloseDate, StageName, LeadSource,Approval_Status__c FROM Opportunity];
        {
       System.debug('Not Submitted----->'+o[1].Approval_Status__c);
       System.assertEquals('Not Submitted', o[1].Approval_Status__c);
        }
        Test.stopTest();
     
    }
    
}