/* eslint-disable @lwc/lwc/no-async-operation */
import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';

export default class accountpopuplwc extends NavigationMixin(LightningElement) {
    
        cancel()
        {
           // var url = window.location.href;
            //var value = url.substr(0,url.lastIndexOf('/') + 1);
            window.history.back();
            return false;
    
    }
        createnew(evt)
        {
            // eslint-disable-next-line no-alert
            alert('I am working');
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
}