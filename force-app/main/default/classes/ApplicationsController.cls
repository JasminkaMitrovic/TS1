/*
 * "with sharing" means that this automatically applies your org’s sharing rules to 
 * the records that are available via these methods.
 */
public with sharing class ApplicationsController {

    @AuraEnabled
    public static List<Application__c> getApplications() {
        
        // Check to make sure all fields are accessible to this user
        String[] fieldsToCheck = new String[] {
            'Id', 'Name', 'CreatedById', 'Loan_Amount__c', 'Loan_Period__c', 'Status__c'
        };
        
        Map<String,Schema.SObjectField> fieldDescribeTokens = 
            Schema.SObjectType.Application__c.fields.getMap();
        
        for(String field : fieldsToCheck) {
            if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        
        return [SELECT Id, Name, CreatedById, Loan_Amount__c, Loan_Period__c, Status__c
                FROM Application__c];
    }
    
    @AuraEnabled
    public static Application__c saveApplication(Application__c application) {
        // Perform isUpdatable() checking first, then
        upsert application;
        return application;
    }
}