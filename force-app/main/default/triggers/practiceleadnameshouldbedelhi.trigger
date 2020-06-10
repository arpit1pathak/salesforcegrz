trigger practiceleadnameshouldbedelhi on Lead (before insert)
{
List<Lead> ld=new List<Lead>();
    for(Lead l:trigger.new)
    {
        if(l.fax==null)
        l.fax='0000000';
    }
}