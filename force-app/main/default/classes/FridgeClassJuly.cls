public class FridgeClassJuly 
{
public integer NumberinStock;
public string ModelNumber;
    public FridgeClassJuly()
    {
        NumberinStock=100;
        ModelNumber='LG01';
        UpdateStock(50);
    }
   public void UpdateStock(integer soldout)
   {
       NumberinStock=NumberinStock-soldout;
       System.debug('Fridge Model Number:'+ModelNumber);
       System.debug('Left in stock:'+NumberinStock);
   }
}