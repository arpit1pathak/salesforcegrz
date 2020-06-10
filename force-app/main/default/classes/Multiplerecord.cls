public class Multiplerecord 
{
public void input()
{
    List<Contact> acct= new List<Contact>
    {
        new Contact(FirstName='Ankit',LastName='Tiwari'),
        new Contact(FirstName='Ankit',LastName='Gupta')
    };
        insert acct;
}
}