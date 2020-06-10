public class UpdateRelatedJuly 
{
public static void upd()
{
    Contact conupd=[select Account.name from contact where firstname='Fname' limit 1];
    conupd.phone='23456789';
    conupd.email='sarthak1996@yahoo.co.in';
    
    conupd.account.name='New Updated Name';
    conupd.account.type='Customer';
    
    update conupd;
    
    update conupd.account;
}
}