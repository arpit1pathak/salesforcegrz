import {LightningElement,wire} from 'lwc';
// import apex method reference from controller
import fatchPickListValue from '@salesforce/apex/getPickListValueInLwcCtrl.fatchPickListValue';
 
export default class GetPickListValueInLWC extends LightningElement {
//  invoke apex method with wire property and fetch picklist options.
// pass 'object information' and 'picklist field API name' method params which we need to fetch from apex
 @wire(fatchPickListValue, {objInfo: {'sobjectType' : 'AccountContactRole'},
                          picklistFieldApi: 'Role'}) stageNameValues;
 
 onValueSelection(event){
  // eslint-disable-next-line no-alert
  alert(event.target.value);
 }                      
}