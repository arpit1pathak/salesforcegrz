trigger practicect1 on Contact (before insert,before update)
{
for(Contact c:trigger.new)
{
if(c.email==null)
c.adderror('Email is mandatory');
}
}