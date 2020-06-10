public class TriggerHelperOpportunity {
 public static Opportunity checkCriteria(Opportunity op, List < TriggerHelperOpportunity.FilterDetail > filter) {
  set < string > fields = new set < string > ();
  set < string > oppfields = new set < string > ();
  set < string > finalfields = new set < string > ();
  map < string, string > relatedfieldsMap = new map < string, string > ();
  List < sobject > sobjList = new List < sobject > ();
  Set < Id > finalId = new Set < Id > ();
  List < Schema.SObjectType > objects = new List < Schema.SObjectType > { Opportunity.SObjectType };
  for (Schema.SObjectType objType: objects) {
   for (Schema.SObjectField fld: objType.getDescribe().fields.getMap().values()) {
    oppfields.add(fld.getDescribe().getName());
   }
  }
  for (TriggerHelperOpportunity.FilterDetail filt: filter) {
  string exp = filt.expression;
  string fieldsType;
   for (object o: filt.predicate) {
     Map < string, object > map3 = (map < string, object > ) o;
     string critFieldValue = string.valueof(map3.get('FieldValue'));
     string critFieldName = string.valueof(map3.get('FieldName'));
     string fieldType = string.valueof(map3.get('FieldType'));
     string compopr = string.valueof(map3.get('CompOper'));
     string rowno = string.valueof(map3.get('RowNum'));
     if (oppfields.contains(critFieldName) && critFieldValue != null) {
      string value = string.valueOf(op.get(critFieldName));
      SObjectType r = ((SObject)(Type.forName('Schema.Opportunity').newInstance())).getSObjectType();
      DescribeSObjectResult d = r.getDescribe();
      fieldsType = string.valueof(d.fields.getMap().get(critFieldName).getDescribe().getType());
      if (fieldType == fieldsType) {
       if (compopr == 'equal to') {
        if (value == critFieldValue) {
         exp = exp.replace(rowno, 'true');
        } else {
         exp = exp.replace(rowno, 'false');
        }
       } else if (compopr == 'does not contain' && value != null) {
        if (!value.contains(critFieldValue)) {
         exp = exp.replace(rowno, 'true');
        } else {
         exp = exp.replace(rowno, 'false');
        }
       } else if (compopr == 'greater than') {
          Decimal values1 = (Decimal)op.get(critFieldName);
          Decimal values2 = Decimal.valueOf(critFieldValue);
        if (values1 > values2) {
         exp = exp.replace(rowno, 'true');
        } else {
         exp = exp.replace(rowno, 'false');
        }
       } else if (compopr == 'greater than or equal to') {
          Decimal values1 = (Decimal)op.get(critFieldName);
          Decimal values2 = Decimal.valueOf(critFieldValue);
        if (values1 >= values2) {
         exp = exp.replace(rowno, 'true');
        } else {
         exp = exp.replace(rowno, 'false');
        }
       } else if (compopr == 'not equal to') {
        if (value != critFieldValue) {
         exp = exp.replace(rowno, 'true');
        } else {
         exp = exp.replace(rowno, 'false');
        }
       } else if (compopr == 'contains' && value != null) {
        if (value.contains(critFieldValue)) {
         exp = exp.replace(rowno, 'true');
        } else {
         exp = exp.replace(rowno, 'false');
        }
       }
      }
     } else {
      string sobj = critFieldName.SubStringBefore('.');
      string sFields = critFieldName.SubStringAfter('.');
      string actualField = sobj + 'id';
      finalId.add(string.valueOf(op.get(actualField)));
      string query = 'select ' + sFields + ' from ' + sobj + ' where id in: finalId';
      sobjList = Database.query(query);
      for (sobject s: sobjList) {
       relatedfieldsMap.put(sFields, string.valueOf(s.get(sFields)));
      }
      string value = relatedfieldsMap.get(sFields);
      if (compopr == 'equal to') {
       if (value == critFieldValue) {
        exp = exp.replace(rowno, 'true');
       } else {
        exp = exp.replace(rowno, 'false');
       }
      } else if (compopr == 'does not contain' && value != null) {
        if (!value.contains(critFieldValue)) {
         exp = exp.replace(rowno, 'true');
        } else {
         exp = exp.replace(rowno, 'false');
        }
       } else if (compopr == 'not equal to') {
       if (value != critFieldValue) {
        exp = exp.replace(rowno, 'true');
       } else {
        exp = exp.replace(rowno, 'false');
       }
      } else if (compopr == 'contains' && value !=null) {
       if (value.contains(critFieldValue) ) {
        exp = exp.replace(rowno, 'true');
       } else {
        exp = exp.replace(rowno, 'false');
       }
      }
     }
   }
   if (BooleanExpressionCalculation.evaluateExpression(exp)==true) {
      op.Approval_Status__c = 'Not Submitted';
    }
  }
  return op;
 }
 public class FilterDetail {
  public list < object > predicate;
  public String expression;
 }
}