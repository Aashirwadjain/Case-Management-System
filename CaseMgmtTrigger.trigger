trigger CaseMgmtTrigger on Case (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        try{
            List<Case> caseList = [Select Id, AccountId, ContactId, ParentId from Case where Id NOT IN :trigger.newMap.keySet()];  
            List<Case> insertedCases = [Select Id, AccountId, ContactId, ParentId, Type, Product__c, Reason, Priority from Case where Id IN :trigger.newMap.keySet()];
            List<Get_Case_Type__mdt> tableData = [Select Type__c, Product__c, Priority__c, Case_Reason__c from Get_Case_Type__mdt];
            for(Case c : caseList){
                for(Case subCase : insertedCases){
                    if(c.AccountId == subCase.AccountId && c.ContactId == subCase.ContactId){
                        subCase.ParentId = c.Id;   
                    }
                }
            }
            
            Integer flag = 0;
            for(Case subCase: insertedCases){
                for(Get_Case_Type__mdt gctype : tableData){
                    if(flag == 0 && gctype.Type__c == subCase.Type && gctype.Product__c == subCase.Product__c && gctype.Case_Reason__c == subCase.Reason){
                        subCase.Priority = gctype.Priority__c;
                        flag++;
                    }
                }
                if(flag == 0){
                    subCase.Priority = 'Low';
                    flag = 1;
                }
            }

            if(!insertedCases.isEmpty()){
                update insertedCases;
            }
        }
        catch(Exception e) {
            System.debug('An exception occurred: ' + e.getMessage());
        }
    }
}