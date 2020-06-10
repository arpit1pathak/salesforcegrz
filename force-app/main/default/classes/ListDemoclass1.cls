public class ListDemoclass1 
{
public static void addstring1()
{
    List<String> colors=new List<String>{'Orange','White','Black'};
        colors.add('Red');
    colors.add('Green');
    colors.add('Blue');
    System.debug(colors);
    for(String s: colors)
    {
        System.debug(s);
    }
    colors.add(2,'Purple');
    System.debug(colors);
    colors.add(3,'Yellow');
    System.debug(colors);
    colors.remove(0);
    System.debug(colors);
    colors.clear();
    System.debug(colors);
}
}