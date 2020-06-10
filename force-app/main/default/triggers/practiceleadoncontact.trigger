trigger practiceleadoncontact on Contact (before insert) 
{
List<Contact> con=new List<Contact>();
    for(contact con:trigger.new)
    {
        if(con.accountid==null)
            con.adderror('Each contact must be linked with an account');
    }
        }