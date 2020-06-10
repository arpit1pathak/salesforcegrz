public class Ctrl_ContactSearch 
{
    public List<Contact> contacts {get;set;}
    public List<Contact> contacts1;
    public String name {get;set;}
    public String lastname {get;set;}
    public id cid {get;set;}
    
    public Ctrl_ContactSearch()
    {
        contacts = new List<Contact>();
    }
    public PageReference searchContacts()
    {
        	contacts= new List<Contact>();
        contacts = [select Id,Name from Contact  where firstname=:name];
        System.debug('&&&&&&&&&&&&&&'+contacts);
        return null;
    }
    public void deletecontacts()
    {
        Id xyz=apexpages.currentPage().getparameters().get('id');
        System.debug('&&&&&&&&&&&&&&&&&&&&&&&&&'+xyz);
        List<contact> bc=[select id from contact where id=:xyz];
        delete bc;
        searchContacts();
        
    }
    
}