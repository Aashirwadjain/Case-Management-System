import { LightningElement, track, wire } from 'lwc';
import getFields from '@salesforce/apex/CaseManagementController.getFields';
export default class CaseManagementApplication extends LightningElement {

    @track selectedFields = [ ];
    @track allFields=[ ];
    @track objectName = 'Case';
    @track buttonLabel = 'Create Case';
    @track areDetailsVisible = false;
    @track reqFields = [ ];
    @track allFieldsVisible = true;
    @track showSuccessMessage = false;
    @track error;

    @wire(getFields)
    wiredFields({ error, data }) {
        if (data) {
            console.log(this.allFields);
            this.reqFields = data;
            for(let i=1; i<this.reqFields.length; i++){
                var val = this.reqFields[i];
                console.log(val);
                this.allFields.push({label:this.reqFields[i],value:this.reqFields[i]});
            }
        } else if (error) {
            this.error = error;
        }
    }
    @track values = ['Type'];

    handleSuccess(event){}

    seeFields(event){
        this.areDetailsVisible = true;
        this.allFieldsVisible = false;
    }

    successMessage(event){
        this.areDetailsVisible = false;
        this.showSuccessMessage = true;
    }

    handleChange(event) {
        var changeValue = event.detail.value ;
        // console.log(changeValue);
    
        this.selectedFields=changeValue;
        // for(let i = 0; i < this.selectedFields.length; i++){
        //     console.log(this.selectedFields[i]);
        // }
    }
    
}