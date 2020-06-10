/* eslint-disable no-alert */
/* eslint-disable no-undef */
import { LightningElement,wire,api, track} from 'lwc';
import fatchPickListValue from '@salesforce/apex/getPickListValueInLwcCtrl.fatchPickListValue';
import savecontactroles from '@salesforce/apex/getPickListValueInLwcCtrl.savecontactroles';
export default class customlookuplwc extends LightningElement {
@api searchcontact;
@api role='';
@track options=[];
@api isprimary=false;
@api search;
@api editrecordid;
@api dispatchedselectid='';
@api selectedcontactid='';
@api accid;
@api conid='';
@api conname='';
@api value;
@api checked;
      @wire(fatchPickListValue,{objInfo: {'sobjectType' : 'AccountContactRole'},picklistFieldApi: 'Role'})
      wiredRoles({ data }) {
      if (data) {
                this.dataArray = data;
                let tempArray = [];
                this.dataArray.forEach(function (element) {
                var option=
                  {
                      label:element.slabel,
                      value:element.svalue
                  };
                  tempArray.push(option);
                  });
                this.options=tempArray;
            } 
      }
    cancel()
    {
        this.dispatchEvent(new CustomEvent('closemodal'));  
        
    }
    hidemodal()
    {
        this.dispatchEvent(new CustomEvent('closemodal'));  
    }
    handlecontactid(event)
    {
    var dispatchedselectid=event.detail;
    this.conid=dispatchedselectid;
    alert(this.conid);
    }
    handleChange(event)
    {
      this.role=event.target.value;
    }
    gtoggles(event)
    {
      this.isprimary=event.target.checked;
      
    }
    save()
    {
      console.log('New :',this.accid);
      // console.log('New :',this.conid);
      // console.log('New :',this.isprimary);
      // console.log('New :',this.role);
      // console.log('New :',this.editrecordid);
      savecontactroles({ accid: this.accid,conid:this.conid,ischk:this.isprimary,role:this.role,rolId:this.editrecordid})
            .then(results =>{
                if(results){
                  this.conid='';
                  alert('Working');
                }
            })
            this.dispatchEvent(new CustomEvent('saveaccountsrole'));  
            this.dispatchEvent(new CustomEvent('closemodal'));  

          }
  

}