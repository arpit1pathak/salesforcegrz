public class SobjectExampleJuly 
{
public static void SobMethod()
{
    Account ac=[select name from Account where name='Arpit'];
    System.debug(ac);
}
}