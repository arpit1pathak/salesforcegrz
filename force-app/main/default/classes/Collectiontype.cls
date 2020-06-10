public class Collectiontype 
{
public static void ctypeset()
{
    set<string> s=new set<string>{'a','c','b'};
    s.add('c');
    s.add('f');
    s.add('D');
    s.add('C');
    s.add('d');
    if(s.contains('b'))
    {
        System.debug('Set contain b and have size'+s.size());
    }
    System.debug(s);
}
    }