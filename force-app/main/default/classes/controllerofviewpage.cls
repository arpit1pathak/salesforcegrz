public class controllerofviewpage 
{
public controllerofviewpage(Addcustomer obj)
{
        
}
public list<Product__c> getprod()
{
    List<Product__c> pr=[select Name,Brand__c,Categories__c,Model_Number__c,Price__c from Product__c];
    return pr;
}
}