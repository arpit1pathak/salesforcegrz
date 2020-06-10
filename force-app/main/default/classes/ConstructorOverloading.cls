public class ConstructorOverloading
{
public ConstructorOverloading(integer a,integer b)
{
    integer e=a+b;
    System.debug('Sum='+e);
}
public ConstructorOverloading(integer a,integer b,integer c) 
   {
       integer f=a+b+c;
    System.debug('Sum='+f);
   }
     public ConstructorOverloading(integer a,integer b,integer c,integer d)
    {
        integer g=a+b+c+d;
        System.debug('Sum='+g);
    }
}