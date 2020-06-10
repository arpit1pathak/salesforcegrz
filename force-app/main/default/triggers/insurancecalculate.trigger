trigger insurancecalculate on Policy__c (before insert) 
{
Decimal n=0;
Map<string,map<Decimal,Decimal>> pb=new map<string,map<Decimal,Decimal>>();
    map<Decimal,Decimal> car=new map<Decimal,Decimal>();
    map<Decimal,Decimal> health=new map<Decimal,Decimal>();
    car.put(3, 30);
    car.put(5, 50);
    health.put(3,20);
    health.put(5, 40);
    pb.put('Car Insurance', car);
    pb.put('Health Insurance', health);
    for(Policy__c p:trigger.new)
    {
        if(p.Amount__c>200000)
        {
        p.Discount_Amount__c=n;
        p.Discount_Amount__c = p.Amount__c-(pb.get(p.Insurance__c).get(p.Number_of_Years__c))/100;
        }
        else
        {
        p.Amount__c.adderror('You are not eligible for the discount');
        }
        }
}