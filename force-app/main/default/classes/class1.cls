public with sharing class class1
{
    public List<Contact> contacts { get; set; }
    public String name { get; set; }
    public String mailingState { get; set; }

    public class1()
    {
        contacts = new List<Contact>();
    }

    public PageReference searchContacts()
    {
        contacts = [select Id
                          ,Name
                          ,MailingState 
                     from Contact 
                    where Name = :name
                    and MailingState = :mailingState];
        return null;
    }
}