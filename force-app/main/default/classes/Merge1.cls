public class Merge1 
{
public static void MergeMethod()
{
    Account ac1=[select id from Account where name='Arpit' limit 1];
    Account ac2=[select id from Account where name='Sarthak' limit 1];
    
    Merge ac1 ac2;
}
}