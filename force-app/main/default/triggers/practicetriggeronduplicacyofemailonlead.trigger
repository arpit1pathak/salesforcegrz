trigger practicetriggeronduplicacyofemailonlead on Lead (before insert) 
{
List<Lead> ld=[select email from Lead];
    List<Lead> ldd=new List<Lead>();
    for(Lead ldd:trigger.new)
    {
      for(Lead l:ld)
      {
          if(ldd.email==l.email)
              ldd.adderror('Lead already exists');
      }
    }
}