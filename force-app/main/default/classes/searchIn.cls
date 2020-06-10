public class searchIn {
@AuraEnabled
    public static String getmethod(String inp){
        System.debug(inp);
        return inp;
    }
}