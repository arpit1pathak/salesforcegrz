public class Pageofleadcontroller 
{
public id leadid
{
    get;
    set;
}
    List<selectOption> listOption=new LIst<SelectOption>();
    public List<selectOption> getOptions()
    {
        listOption.add(new SelectOption('--Select--','--Select--'));
        for(Lead ld:[select id,name from Lead])
        {
            listOption.add(new SelectOption(ld.id,ld.name));
        }
        return listoption;
    }
public list<lead> getLeads()
{
    List<Lead> Leadlist=[select name,leadsource,email,phone from lead where id=:leadid];
return Leadlist;
        }
}