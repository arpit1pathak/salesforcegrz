public class Campaign1 
{
public Campaign1(ApexPages.StandardSetController controller) {
}
 public string searchName {get;set;}
 public list < Campaign> campaigns{get;set;}
 public Campaign c {get;set;}  
 public Campaign1(apexPages.standardController con) 
 {
 c = (Campaign)con.getRecord();
  campaigns= new list <Campaign> ();
  campaigns= [select ID, Name, StartDate, EndDate, Type from Campaign];
 } 
 public void searchbox()
 {
  campaigns= new list <Campaign> ();
  String name = '%' + searchName + '%';
  campaigns= [select ID, Name, StartDate, EndDate, Type from Campaign where Name Like :name];
 }
}