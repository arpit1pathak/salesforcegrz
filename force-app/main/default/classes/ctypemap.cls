public class ctypemap 
{
public static void ctypemap1()
{
    Map<Integer,String> Empadd=new Map<Integer,String>();
    {
        Empadd.put(1, 'Delhi');
        Empadd.put(2,'Noida');
        Empadd.put(3,'Noida');
        Empadd.put(7,'Chandigarh');
        Empadd.put(7,'Mumbai');
        System.debug('Address of Employee 2'+Empadd.get(7));
        System.debug(Empadd);
    }
    Map<String,String> mystring=new Map<string,string>{'a'=>'apple','b'=>'bee'};
        mystring.put('c','cat');
        System.debug(mystring.get('b'));
    System.debug(mystring.get('c'));
    System.debug(mystring);
}
}