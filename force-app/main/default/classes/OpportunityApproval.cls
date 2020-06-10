public class OpportunityApproval {
  public static list < Opportunity > beforeUpdate(list < Opportunity > opps ) {
        list < object > predicateList = new list < object > ();
        list < object > predicateList2 = new list < object > ();
        list < Opportunity > opplist = new list < Opportunity > ();
        set < string > fields = new set < string > ();
        set < string > oppfields = new set < string > ();
        set < string > finalfields = new set < string > (); 
        list < TriggerHelperOpportunity.FilterDetail > filterWrapper = new List < TriggerHelperOpportunity.FilterDetail > ();
            for (Apttus_Approval_ApprovalRule__c app: [SELECT Id,  Apttus_Approval_Criteria__c FROM Apttus_Approval_ApprovalRule__c]) {
                object obj = json.deserializeUntyped(app.Apttus_Approval_Criteria__c);
                    map < string, object > map1 = (map < string, object > ) obj;
                    if (map1.get('sObjectName') == 'Opportunity') {
                        map < string, object > map2 = (map < string, object > ) map1.get('filter');
                        predicateList = (List < object > ) map2.get('predicates');
                        predicateList2.add((List < object > ) map2.get('predicates'));
                        TriggerHelperOpportunity.FilterDetail f = new TriggerHelperOpportunity.FilterDetail();
                        string critConExpr = string.valueof(map2.get('condExpr'));
                        f.predicate = predicateList;
                        f.expression = critConExpr;
                        filterWrapper.add(f);
                    }
                
            }
            for (object o: predicateList2) {
                list < object > map3 = (list < object > ) o;
                for (object obj: map3) {
                    map < string, object > map4 = (map < string, object > ) obj;
                    if (map4.containskey('FieldName')) {
                        fields.add(string.valueof(map4.get('FieldName')));
                    }
                }
            }
            List < Schema.SObjectType > objects = new List < Schema.SObjectType > { Opportunity.SObjectType };
            for (Schema.SObjectType objType: objects) {
                for (Schema.SObjectField fld: objType.getDescribe().fields.getMap().values()) {
                    oppfields.add(fld.getDescribe().getName());
                }
            }
            for (string fs: fields) {
                if (oppfields.contains(fs)) {
                    finalfields.add(fs);
                } else {
                    string sobj = fs.SubStringBefore('.');
                    string actualField = sobj + 'Id';
                    finalfields.add(actualField);
                }
            }
            for (Opportunity op: opps) {
                SObject oldOpp = Trigger.oldMap.get(op.Id);
                for (string field: finalfields) {                    
                if (op.get(field) != oldOpp.get(field) && op.Approval_Status__c != 'Not Submitted') {
                    Opportunity op2 = TriggerHelperOpportunity.checkCriteria(op, filterWrapper);
                    opplist.add(op2);
                }
            }
         }
         return opplist;
  }
}