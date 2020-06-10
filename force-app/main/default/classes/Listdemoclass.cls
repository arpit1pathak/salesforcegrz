public class Listdemoclass
{
public static void Addstring()
{
    List<String> colors=new List<String>{'Orange','White','Black'};
    colors.add('Red');
    colors.add('Green');
    colors.add('Blue');
    for(String s:colors)
    {
        System.debug(s);
    }
}
}