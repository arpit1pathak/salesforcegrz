/* eslint-disable no-alert */
/* eslint-disable no-unused-vars */
// eslint-disable-next-line no-unused-vars
import { LightningElement,api,wire,track} from 'lwc';
import searchForIds from '@salesforce/apex/contactlookupcontrollerlwc.searchForIds';
export default class Lookup extends LightningElement 
{
    @api searchtext='';
    @api selectid;
    @api selectname='';
    @wire(searchForIds, { searchtext: '$searchtext' }) contacts;
    search(event)
    {
        const searchtext = event.target.value;
        this.searchtext = searchtext;
        const toastModel = this.template.querySelector('[data-id="toastModel"]');
        toastModel.className = 'slds-show';
        
    }
    selectvalue(event)
    {
        this.searchtext=event.currentTarget.dataset.name;
        this.selectid=event.currentTarget.dataset.id;
        const toastModel = this.template.querySelector('[data-id="toastModel"]');
        toastModel.className = 'slds-hide';  
        const selectedEvent = new CustomEvent("contactid", {
            detail: this.selectid
          });
          this.dispatchEvent(selectedEvent);
    }
    clearvalues()
    {
      this.template.querySelector('.clear').value='';
      this.searchtext='';
    }
}