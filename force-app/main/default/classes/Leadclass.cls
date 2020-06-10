public class Leadclass 
{
  public id leadid {get;set;}
List<selectOption> listoption=new List<SelectOption>();
public List<SelectOption> getOptions()
{
    listoption.add(new Selectoption('--Select--','--Select--'));
    for(Lead ld:[select id,name from Lead])
    {
        listoption.add(new SelectOption(ld.id,ld.name));
    }
    return listoption;
}
public list<lead> getLeads()
{
    List<lead> Leadlist=[select name,leadsource,email,phone from Lead where id=:leadid];
    return Leadlist;
}
}