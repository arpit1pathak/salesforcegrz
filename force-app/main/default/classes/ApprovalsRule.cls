public with sharing class ApprovalsRule {

    public Integer totalRec=0;
    @AuraEnabled(cacheable = true)
    public static Integer TotalRecords(){
        return [SELECT Count() FROM Apttus_Approval_ApprovalRule__c];
    }
    @AuraEnabled(cacheable = true)
    public static List < wrapperClass > getApprovalsRule(string approvalFilter,string rUserFilter,string assigneeFilter,Integer LimitSize,Integer OffsetSize) {
        list<wrapperClass> returnList = new list<wrapperClass>();
        Map<String, list<Apttus_Approval_ApprovalRuleEntry__c>> entryMap = new Map<String, list<Apttus_Approval_ApprovalRuleEntry__c>>();
        String searchByApprovals = '%' + approvalFilter + '%';
        String searchByAssignee = '%'+ assigneeFilter+ '%';
        list<Apttus_Approval_ApprovalRule__c> appRuleIds = new list<Apttus_Approval_ApprovalRule__c>();
        list<Apttus_Approval_ApprovalRuleEntry__c> ruleEntry = new list<Apttus_Approval_ApprovalRuleEntry__c> ();
        if(approvalFilter=='' && rUserFilter =='' && assigneeFilter ==''){
            appRuleIds = [SELECT Id FROM Apttus_Approval_ApprovalRule__c ORDER BY Apttus_Approval_Sequence__c LIMIT:LimitSize OFFSET:OffsetSize];
            ruleEntry = [SELECT Id, Apttus_Approval_ApprovalRuleId__c,Apttus_Approval_ApprovalRuleId__r.Name ,Apttus_Approval_Condition__c, 
            Apttus_Approval_ConditionFieldNames__c, Apttus_Approval_DependsOn__c, Apttus_Approval_Description__c, 
            (SELECT Id,Apttus_Approval_AssigneeType__c, Name, Apttus_Approval_DependsOn__c, Apttus_Approval_AssigneeDescription__c, 
            Apttus_Approval_AssigneeLabel__c,
            Apttus_Approval_Sequence__c, Apttus_Approval_NotifyOnly__c, Apttus_Approval_RuleEntryId__c, 
            Apttus_Approval_SendEmail__c, Apttus_Approval_AssigneeValue__c FROM Approval_Rule_Assignees__r ORDER BY Apttus_Approval_Sequence__c),
            Apttus_Approval_EntryLabel__c, Apttus_Approval_Sequence__c,	Apttus_Approval_AutoReapprovalCriteria__c FROM Apttus_Approval_ApprovalRuleEntry__c WHERE Apttus_Approval_ApprovalRuleId__c IN:appRuleIds 
            ORDER BY Apttus_Approval_Sequence__c ];
        }
        else  if(approvalFilter !='' && rUserFilter =='' && assigneeFilter ==''){
            appRuleIds = [SELECT Id FROM Apttus_Approval_ApprovalRule__c WHERE Name LIKE :searchByApprovals ORDER BY Apttus_Approval_Sequence__c LIMIT:LimitSize OFFSET:OffsetSize];
            ruleEntry = [SELECT Id, Apttus_Approval_ApprovalRuleId__c,Apttus_Approval_ApprovalRuleId__r.Name ,Apttus_Approval_Condition__c, 
            Apttus_Approval_ConditionFieldNames__c, Apttus_Approval_DependsOn__c, Apttus_Approval_Description__c, 
            (SELECT Id, Name,Apttus_Approval_AssigneeType__c, Apttus_Approval_DependsOn__c, Apttus_Approval_AssigneeDescription__c, Apttus_Approval_AssigneeLabel__c,
            Apttus_Approval_Sequence__c, Apttus_Approval_NotifyOnly__c, Apttus_Approval_RuleEntryId__c, 
            Apttus_Approval_SendEmail__c, Apttus_Approval_AssigneeValue__c FROM Approval_Rule_Assignees__r ORDER BY Apttus_Approval_Sequence__c),
            Apttus_Approval_EntryLabel__c, Apttus_Approval_Sequence__c,	Apttus_Approval_AutoReapprovalCriteria__c FROM Apttus_Approval_ApprovalRuleEntry__c WHERE Apttus_Approval_ApprovalRuleId__c IN:appRuleIds 
            ORDER BY Apttus_Approval_Sequence__c];
        }
        else  if( rUserFilter !='' || assigneeFilter !=''){
            List<Apttus_Approval_ApprovalRuleEntry__c> eruleId=new List<Apttus_Approval_ApprovalRuleEntry__c>();
            List<Apttus_Approval_ApprovalRuleAssignee__c>  assigneesApprovals = new List<Apttus_Approval_ApprovalRuleAssignee__c> ();
            Set<Id> ruleEntryIds = new Set<Id>();
            Set<Id> ruleIds = new Set<Id>();            
            if(rUserFilter !=''){
                assigneesApprovals = [SELECT Id, Apttus_Approval_RuleEntryId__c,Apttus_Approval_AssigneeType__c  FROM Apttus_Approval_ApprovalRuleAssignee__c
                WHERE Apttus_Approval_AssigneeType__c =:rUserFilter AND Apttus_Approval_AssigneeValue__c LIKE :searchByAssignee];
               
                for(Apttus_Approval_ApprovalRuleAssignee__c assigneeIds : assigneesApprovals){
                    ruleEntryIds.add(assigneeIds.Apttus_Approval_RuleEntryId__c);
                }
            }
            eruleId =[SELECT Apttus_Approval_ApprovalRuleId__c FROM Apttus_Approval_ApprovalRuleEntry__c
                      WHERE Id IN: ruleEntryIds];
            for(Apttus_Approval_ApprovalRuleEntry__c recordsEntry :eruleId){
                ruleIds.add(recordsEntry.Apttus_Approval_ApprovalRuleId__c);
            }
            if(approvalFilter==''){
            appRuleIds = [SELECT Id FROM Apttus_Approval_ApprovalRule__c WHERE Id IN:ruleIds ORDER BY Apttus_Approval_Sequence__c LIMIT:LimitSize OFFSET:OffsetSize];
            ruleEntry = [SELECT Id, Apttus_Approval_ApprovalRuleId__c,Apttus_Approval_ApprovalRuleId__r.Name ,Apttus_Approval_Condition__c, 
            Apttus_Approval_ConditionFieldNames__c, Apttus_Approval_DependsOn__c, Apttus_Approval_Description__c, 
            (SELECT Id, Name,Apttus_Approval_AssigneeType__c, Apttus_Approval_DependsOn__c, Apttus_Approval_AssigneeDescription__c, Apttus_Approval_AssigneeLabel__c,
            Apttus_Approval_Sequence__c, Apttus_Approval_NotifyOnly__c, Apttus_Approval_RuleEntryId__c, 
            Apttus_Approval_SendEmail__c, Apttus_Approval_AssigneeValue__c FROM Approval_Rule_Assignees__r ORDER BY Apttus_Approval_Sequence__c),
            Apttus_Approval_EntryLabel__c, Apttus_Approval_Sequence__c,	Apttus_Approval_AutoReapprovalCriteria__c FROM Apttus_Approval_ApprovalRuleEntry__c WHERE Apttus_Approval_ApprovalRuleId__c IN:appRuleIds 
            AND Id IN(SELECT Apttus_Approval_RuleEntryId__c FROM Apttus_Approval_ApprovalRuleAssignee__c WHERE Apttus_Approval_AssigneeType__c =: rUserFilter AND Apttus_Approval_AssigneeValue__c LIKE :searchByAssignee)
            ORDER BY Apttus_Approval_Sequence__c ];
            }
            else {
            appRuleIds = [SELECT Id FROM Apttus_Approval_ApprovalRule__c WHERE Id IN:ruleIds AND Name LIKE : searchByApprovals ORDER BY Apttus_Approval_Sequence__c LIMIT:LimitSize OFFSET:OffsetSize];
            ruleEntry = [SELECT Id, Apttus_Approval_ApprovalRuleId__c,Apttus_Approval_ApprovalRuleId__r.Name ,Apttus_Approval_Condition__c, 
            Apttus_Approval_ConditionFieldNames__c, Apttus_Approval_DependsOn__c, Apttus_Approval_Description__c, 
            (SELECT Id, Name,Apttus_Approval_AssigneeType__c, Apttus_Approval_DependsOn__c, Apttus_Approval_AssigneeDescription__c, Apttus_Approval_AssigneeLabel__c,
            Apttus_Approval_Sequence__c, Apttus_Approval_NotifyOnly__c, Apttus_Approval_RuleEntryId__c, 
            Apttus_Approval_SendEmail__c, Apttus_Approval_AssigneeValue__c FROM Approval_Rule_Assignees__r ORDER BY Apttus_Approval_Sequence__c),
            Apttus_Approval_EntryLabel__c, Apttus_Approval_Sequence__c,	Apttus_Approval_AutoReapprovalCriteria__c FROM Apttus_Approval_ApprovalRuleEntry__c WHERE Apttus_Approval_ApprovalRuleId__c IN:appRuleIds 
            AND Id IN(SELECT Apttus_Approval_RuleEntryId__c FROM Apttus_Approval_ApprovalRuleAssignee__c WHERE Apttus_Approval_AssigneeType__c =:rUserFilter AND Apttus_Approval_AssigneeValue__c LIKE :searchByAssignee)
            ORDER BY Apttus_Approval_Sequence__c];
            }
        }
        for(Apttus_Approval_ApprovalRuleEntry__c entries :ruleEntry){
            if (entryMap.containsKey((entries.Apttus_Approval_ApprovalRuleId__c+';;'+ entries.Apttus_Approval_ApprovalRuleId__r.Name))) {
                list<Apttus_Approval_ApprovalRuleEntry__c> entry=entryMap.get(entries.Apttus_Approval_ApprovalRuleId__c+';;'+ entries.Apttus_Approval_ApprovalRuleId__r.Name);
                entry.add(entries);
                entryMap.put(entries.Apttus_Approval_ApprovalRuleId__c+';;'+ entries.Apttus_Approval_ApprovalRuleId__r.Name,entry);
            }
            else {
                list<Apttus_Approval_ApprovalRuleEntry__c> entry =new  list<Apttus_Approval_ApprovalRuleEntry__c>();
                entry.add(entries);
                entryMap.put(entries.Apttus_Approval_ApprovalRuleId__c+';;'+ entries.Apttus_Approval_ApprovalRuleId__r.Name,entry);
            }
        }
        for(String keys:entryMap.keySet()){
            wrapperClass obj = new wrapperClass();
            obj.approvalId = keys.substringBefore(';;');
            obj.approvalName = keys.substringAfter(';;');
            obj.entries = entryMap.get(keys);
            returnList.add(obj);
        }
        System.debug('returnList :'+returnList);
        return returnList;
    }
    @AuraEnabled(cacheable = true)
    public static List<Apttus_Approval_ApprovalRuleAssignee__c> getApprovalAssigneeData(list<String> entrylId,string rUserFilter,string assigneeFilter){
      
        String searchByAssignee = '%'+assigneeFilter+ '%';
        List<Apttus_Approval_ApprovalRuleAssignee__c> assignees = new List<Apttus_Approval_ApprovalRuleAssignee__c>();
        if(rUserFilter != ''){
            assignees =  [SELECT Id, Apttus_Approval_DependsOn__c, Apttus_Approval_AssigneeDescription__c, 
            Apttus_Approval_AssigneeId__c, Apttus_Approval_AssigneeLabel__c, Apttus_Approval_Sequence__c,
            Apttus_Approval_AssigneeType__c, Apttus_Approval_AssigneeValue__c, Apttus_Approval_NotifyOnly__c,
            Apttus_Approval_RuleEntryId__c, Apttus_Approval_SendEmail__c FROM Apttus_Approval_ApprovalRuleAssignee__c 
            WHERE Apttus_Approval_RuleEntryId__c IN : entrylId AND Apttus_Approval_AssigneeType__c = : rUserFilter AND Apttus_Approval_AssigneeValue__c LIKE :searchByAssignee ORDER BY Apttus_Approval_Sequence__c ASC];
        
            }
            else{
                assignees =  [SELECT Id, Apttus_Approval_DependsOn__c, Apttus_Approval_AssigneeDescription__c, 
                Apttus_Approval_AssigneeId__c, Apttus_Approval_AssigneeLabel__c, Apttus_Approval_Sequence__c,
                Apttus_Approval_AssigneeType__c, Apttus_Approval_AssigneeValue__c, Apttus_Approval_NotifyOnly__c,
                Apttus_Approval_RuleEntryId__c, Apttus_Approval_SendEmail__c FROM Apttus_Approval_ApprovalRuleAssignee__c 
                WHERE Apttus_Approval_RuleEntryId__c IN : entrylId AND Apttus_Approval_AssigneeValue__c LIKE :searchByAssignee ORDER BY Apttus_Approval_Sequence__c ASC];
            
            }
        return assignees;
    }
    @AuraEnabled(cacheable=true)
    public static List < wrapperClass > fatchPickListValue(sObject objInfo, string picklistFieldApi) {
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objInfo.getSObjectType().getDescribe();
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
 
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values = fieldMap.get(picklistFieldApi).getDescribe().getPickListValues();
 
        // Create a list of wrapper to store picklist value/lable
        list < wrapperClass > objWrapper = new list < wrapperClass > ();
        for (Schema.PicklistEntry a: values) {
            wrapperClass oFatchValueWrapper = new wrapperClass();
            oFatchValueWrapper.slabel = a.getLabel();
            oFatchValueWrapper.svalue = a.getValue();
            objWrapper.add(oFatchValueWrapper);
        }
        return objWrapper;
    }
    public class wrapperClass
    {
        @AuraEnabled public String approvalId{get;set;}
        @AuraEnabled public String approvalName{get;set;}
        @AuraEnabled public List<Apttus_Approval_ApprovalRuleEntry__c> entries{get;set;} 
        @auraEnabled public string slabel {get;set;}
        @auraEnabled public string svalue {get;set;}
    }
}