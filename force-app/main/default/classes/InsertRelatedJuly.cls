public class InsertRelatedJuly 
{
public static void Ins()
{
    Account ac=new Account(Name='Acc new1',Type='Customer',Industry='Electronics');
    insert ac;
    Id acctid=ac.id;
    Contact con=new Contact(Firstname='Fname',lastname='Lname',Phone='3456789',email='fname@gmail.com',Accountid=acctid);
    insert con;
}
}