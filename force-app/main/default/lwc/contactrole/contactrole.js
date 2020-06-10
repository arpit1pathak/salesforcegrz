/* eslint-disable consistent-return */
/* eslint-disable no-undef */
/* eslint-disable no-alert */
import { LightningElement,api,wire,track} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getcontactroles from '@salesforce/apex/getPickListValueInLwcCtrl.getcontactroles';
import deleteacr from '@salesforce/apex/getPickListValueInLwcCtrl.deleteacr';
import recordEditd from '@salesforce/apex/getPickListValueInLwcCtrl.recordEditd';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Contactrole extends NavigationMixin(LightningElement) {
    @api showmodal=false;
    @track contactroles;
    @api recordId;
    @api page;
    @track isprimary;
    @track contactsId;
    @track role;
    @track editId;
    @track ch=true;
    @api showmodal2=false;
    @track conn;
    @api contactname;
    @wire(getcontactroles, {accId : '$recordId'}) contactroles;
    contactrolehome()
    {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'home'
            }
        });   
    }
    
    // eslint-disable-next-line no-unused-vars
    openothercomponent(event)
    {
      this.showmodal=true;
    }

    closemodal(){
        this.showmodal=false;
    }
    closemodal1()
    {
        this.showmodal2=false;
    }
    contactpage(event)
    {
    this.page=event.target.getAttribute('data-id');
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
        recordId: this.page,
        objectApiName: 'Contact',
        actionName: 'view'
        },
        });
    }
    accountpage(event)
    {
    this.page=event.target.getAttribute('data-id');
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
        recordId: this.page,
        objectApiName: 'Account',
        actionName: 'view'
        },
        });
    }
    deletecontactrole(event)
    {
        var r=confirm("Are you sure...?");
        if (r === true) 
        {
            this.page=event.target.getAttribute('data-id');  
            deleteacr({ deleteid: this.page })
            .then(results =>{
                if(results){
                    this.toasts();
                    return refreshApex(this.contactroles);
                }
            })
            
        }   
    }
    toasts(){
        const evt = new ShowToastEvent({
            title: 'Success',
            message: 'Account Contact Role has been deleted',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
    saveAccounts(){
        alert('I am working');
    return refreshApex(this.contactroles);
    }
    recordEdit(event){
        this.showmodal2=true;
        this.editId =event.target.getAttribute('data-id');  
        recordEditd({editId :this.editId})
        .then(results =>{
          if(results){
             this.isprimary=results.IsPrimary;
             this.contactsId=results.ContactId;
             this.role=results.Role;
             this.contactname=results.Contact.Name;
             console.log(this.isprimary);
             console.log(this.contactsId);
             console.log(this.role);
             console.log(this.contactname);
          }
      })
      }
}