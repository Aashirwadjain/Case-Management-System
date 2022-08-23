public with sharing class CaseManagementController {
    public CaseManagementController() {}
    @AuraEnabled(cacheable=True)
    public static List<String> getFields(){
        List<String> reqFields = new List<String>();
        try {
            String selectedObject = 'Case';
            Map <String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
            Schema.SObjectType sobjType = gd.get(selectedObject);
            Schema.DescribeSObjectResult r = sobjType.getDescribe();
            Map<String, Schema.SObjectField> MapofField = r.fields.getMap();
            
            for(String fieldName : MapofField.keySet()) {
                Schema.SObjectField field = MapofField.get(fieldName);
                Schema.DescribeFieldResult F = field.getDescribe();
                reqFields.add(F.getName());
            }
            System.debug(reqFields);
            return reqFields;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}