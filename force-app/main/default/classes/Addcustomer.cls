public class Addcustomer
{
    public string custname{get;set;}
    public string custaddress{get;set;}
    public string custEmail{get;set;}
    public string custcontact{get;set;}
    public string prodname{get;set;}
    public string prodbrand{get;set;}
    public decimal prodprice{get;set;}
    public string prodcategory{get;set;}
    public string prodmodel{get;set;}
    public string categid{get;set;}
    public string prodid{get;set;}
 public PageReference save()
{
    Customer__c cus=new Customer__c(Name=custname,Address__c=custaddress,Email_ID__c=custEmail,Contact_Number__c=custcontact);
    insert cus;
    PageReference pr=new PageReference('/apex/Success');
    return pr;
}
 public PageReference save1()
{
    Product__c pro=new Product__c(Name=prodname,Brand__c=prodbrand,Categories__c=categid,Model_Number__c=prodmodel,Price__c=prodprice);
    insert pro;
    PageReference pr1=new PageReference('/apex/Success');
    return pr1;
    
}
  public PageReference Cancel()
{
    PageReference pr=new PageReference('/apex/home');
    return pr;
}
 public List<SelectOption> getCategory()
{
    List<Selectoption> catlist=new List<SelectOption>();
    catlist.add(new SelectOption('--Select','--Select--'));
    catlist.add(new SelectOption('TV','TV'));
    catlist.add(new SelectOption('Mobile','Mobile'));
    catlist.add(new SelectOption('DVD','DVD'));
    catlist.add(new SelectOption('Laptop','Laptop'));
    return catlist;
}
    List<Selectoption> listoption=new List<selectoption>();
    public list<Selectoption> getOptions()
    {
        listoption.add(new Selectoption('--Select--','-Select-'));
        for(Product__c pr:[select id,Name from Product__c])
        {
            listoption.add(new Selectoption(pr.id,pr.name));
        }
       return listoption;
    }
    public List<Product__c> getprod1()
    {
     List<Product__c> prodlist=[select name,Brand__c,categories__c,Model_number__c,Price__c from Product__c where id=:prodid];
    return prodlist;
     }
     public PageReference save2()
{
     Product__c pro1=new Product__c(Name=prodname,Brand__c=prodbrand,Categories__c=categid,Model_Number__c=prodmodel,Price__c=prodprice);
     update pro1;
     PageReference pr1=new PageReference('/apex/Success');
     return pr1;    
}
}