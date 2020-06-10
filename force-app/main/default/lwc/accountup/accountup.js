import { LightningElement,wire,api} from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
import searchForIds from '@salesforce/apex/accountsSearch.searchForIds';
export default class Accountup extends NavigationMixin(LightningElement) {

cancel()
{
    this[NavigationMixin.Navigate]({
        type: 'standard__objectPage',
        attributes: {
            objectApiName: 'Account',
            actionName: 'home',
        },
    });
}
createnew(evt)
{
    evt.preventDefault();
    evt.stopPropagation();
    this[NavigationMixin.Navigate]({
    type: 'standard__objectPage',
    attributes: {
    objectApiName: 'Account',
    actionName: 'new'
    },
    state: {
        nooverride: '1'
        }       
    });
}
@api searchText='';
@wire(searchForIds, { searchText: '$searchText' }) accounts;
search(event)
{
    const searchText = event.target.value;
        this.searchText = searchText;
}
openRecord(event){
   let accountId =event.target.dataset.id;
   this[NavigationMixin.Navigate]({
    type: 'standard__recordPage',
    attributes: {
    recordId: accountId,
    objectApiName: 'Account',
    actionName: 'view'
    },
    });
}

}