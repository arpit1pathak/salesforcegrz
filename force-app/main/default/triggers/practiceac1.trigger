trigger practiceac1 on Account (before insert)
 {
for(Account ac:trigger.new)
{
if(ac.industry=='Education')
ac.adderror('We do not work with education orgs anymore');
}

}