/* eslint-disable guard-for-in */
/* eslint-disable no-console */
/* eslint-disable no-alert */
import { LightningElement,track,wire} from 'lwc';
import getApprovalsRule from '@salesforce/apex/ApprovalsRule.getApprovalsRule';
import TotalRecords from '@salesforce/apex/ApprovalsRule.TotalRecords';
import fatchPickListValue from '@salesforce/apex/ApprovalsRule.fatchPickListValue';
import getApprovalAssigneeData from '@salesforce/apex/ApprovalsRule.getApprovalAssigneeData';
export default class Approvalspage extends LightningElement {
    @track fields = [];
    @track typefields = [];
    @track pageNo = 1;
    @track rows;
    @track apRecords;
    @track assigneeRecords;
    @track searchApproval='';
    @track uesrApproval='';
    @track assigneApproval='';
    @track approvalIds;
    @track inputValue;
    @track entryId;
    @track v_TotalRecords;
    @track disabled=true;
    @track limits=4;
    @track offsetSize=0;
    @track show=false;
    @track usersType="Need To Select Assignee Type";
    
    @wire(getApprovalsRule, { approvalFilter: '$searchApproval',rUserFilter :'$uesrApproval',assigneeFilter:'$assigneApproval',LimitSize:'$limits',OffsetSize:'$offsetSize' })
    wiredapRecords({ data }) {
        if (data) {
            this.apRecords = data;
            console.log(this.apRecords);
        } else {
            this.message ='No record found';
        }
    }
    @wire(getApprovalAssigneeData, { entrylId : '$entryId',rUserFilter :'$uesrApproval',assigneeFilter:'$assigneApproval' })
    wiredAssigneeRecord({ data }) {
        if (data) {
            this.assigneeRecords = data;
        } else {
            this.message ='No record found';
        }
    }
    @wire(fatchPickListValue,{objInfo: {'sobjectType' : 'Apttus_Approval_ApprovalRuleAssignee__c'},
    picklistFieldApi: 'Apttus_Approval_AssigneeValue__c'})
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
        this.fields=tempArray;
        } 
    }
    renderedCallback() {
        TotalRecords().then(result=>{
            this.v_TotalRecords = result;
            console.log(this.v_TotalRecords);
            this.rows=Math.ceil(this.v_TotalRecords/this.limits);
            if(this.limits >= this.v_TotalRecords){
                this.template.querySelector('.first').disabled=true;
                this.template.querySelector('.pre').disabled=true;
                this.template.querySelector('.nxt').disabled=true;
                this.template.querySelector('.last').disabled=true;
            }
        });
    }
    @wire(fatchPickListValue,{objInfo: {'sobjectType' : 'Apttus_Approval_ApprovalRuleAssignee__c'},
    picklistFieldApi: 'Apttus_Approval_AssigneeType__c'})
    wiredRoless({ data }) {
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
        this.typefields=tempArray;
        } 
    }
    getEntries(event){
        let targetIds= event.currentTarget.dataset.id;
            this.template.querySelector(`[data-id="${targetIds}"]`).classList.toggle('slds-is-open');
            if(this.approvalIds === targetIds){
                this.approvalIds='';
            }
            else if(!this.approvalIds){
                this.approvalIds=targetIds;
            }
            else{
                this.template.querySelector(`[data-id="${this.approvalIds}"]`).classList.toggle('slds-is-open');
                this.approvalIds=targetIds;
            }
    }
    handleChange(event) {
        this.uesrApproval = event.detail.value;
        console.log(this.uesrApproval);
        this.assigneApproval='';
        if(this.uesrApproval ==='User'){
            this.disabled=false;
            this.inputValue='';
            this.usersType = "Enter Assignee Name";
            this.template.querySelector('.usersType').classList.remove('slds-hide');
            this.template.querySelector('.assigneName').classList.add('slds-hide');
        }
        else if(this.uesrApproval ==='Related User'){
            this.usersType = "Select Assignee Name";
            this.template.querySelector('.usersType').classList.add('slds-hide');
            this.template.querySelector('.assigneName').classList.remove('slds-hide');
            this.template.querySelector('.assigneName').classList.add('slds-show');
        }
        else{
            this.inputValue="Need To Select Assignee Type";
            this.template.querySelector('.usersType').classList.remove('slds-hide');
            this.template.querySelector('.assigneName').classList.add('slds-hide');  
            this.disabled=true;
        }
    }
    searchByApprovals(event){
        this.searchApproval=event.target.value;
    }
    searchOnInput(event){
        this.assigneApproval=event.target.value;
        console.log(this.assigneApproval);
    }
    onValueSelection(event) {
        this.assigneApproval = event.detail.value;
    }
    onView(event){
        this.entryId=event.currentTarget.dataset.id;
        this.show=true;
    }
    onClose(){
        this.show=false;
    }
    handleSize(event){
        this.limits=event.target.value;
        this.offsetSize=0;
        this.pageNo=1;
        if(this.limits >= this.v_TotalRecords){
        this.template.querySelector('.first').disabled=true;
        this.template.querySelector('.pre').disabled=true;
        this.template.querySelector('.nxt').disabled=true;
        this.template.querySelector('.last').disabled=true;
        }
        else{
            this.template.querySelector('.first').disabled=true;
            this.template.querySelector('.pre').disabled=true;
            this.template.querySelector('.nxt').disabled=false;
            this.template.querySelector('.last').disabled=false;
        }
    }
    nextPage(){
        if(this.pageNo <= this.rows){
            this.offsetSize=this.offsetSize-(-this.limits);
            this.template.querySelector('.pre').disabled=false;
            this.template.querySelector('.first').disabled=false;
            this.pageNo = this.pageNo +1;
        }
        if(this.pageNo >= this.rows){
            this.template.querySelector('.nxt').disabled=true;
            this.template.querySelector('.last').disabled=true;
        }
    }
    prePage(){
        if(this.pageNo >=1){
            this.offsetSize=this.offsetSize-this.limits;
            this.pageNo = this.pageNo -1;
            this.template.querySelector('.nxt').disabled=false;
            this.template.querySelector('.last').disabled=false;
            if(this.pageNo ===1){
                this.template.querySelector('.pre').disabled=true;
                this.template.querySelector('.first').disabled=true;
            }
        }      
    }
    lastPage(){
        this.offsetSize=this.v_TotalRecords - (this.v_TotalRecords)%(this.limits);
        this.pageNo=this.rows;
        this.template.querySelector('.last').disabled=true;
        this.template.querySelector('.nxt').disabled=true;
        this.template.querySelector('.pre').disabled=false;
        this.template.querySelector('.first').disabled=false;
    }
    firstPage(){
        this.offsetSize=0;
        this.pageNo=1;
        this.template.querySelector('.first').disabled=true;
        this.template.querySelector('.pre').disabled=true;
        this.template.querySelector('.nxt').disabled=false;
        this.template.querySelector('.last').disabled=false;
    }
}