public class Fridge
{
    public string modelnumber;
    public integer numberinstock;
    public Fridge()
    {
        modelnumber='XX-XX';
        numberinstock=0;
    }
    public Fridge(String theModelNumber,Integer theNumberinStock)
    {
        modelnumber=theModelNumber;
        numberinstock=theNumberinStock;
    }
    public void updatestock(integer justsold)
    {
        numberinstock=numberinstock-justsold;
       
    }
    

}