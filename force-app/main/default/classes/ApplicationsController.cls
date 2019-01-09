/*
 * "with sharing" means that this automatically applies your org’s sharing rules to 
 * the records that are available via these methods.
 */
public with sharing class ApplicationsController {

    @AuraEnabled
    public static List<Application__c> getApplications() {
        System.debug('Executing ApplicationsController.getApplications()');
        
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
        
        /*
        User user = [select id,Name from User where id =: userInfo.getUserId()];
		System.debug('Curent user: ' + user.Name);
        */
        
        return [SELECT Id, Name, CreatedById, Loan_Amount__c, Loan_Period__c, Status__c
                FROM Application__c 
                WHERE OwnerId =: userInfo.getUserId()];
    }
    
    @AuraEnabled
    public static Application__c saveApplication(Application__c application) {
        
        System.debug('Executing ApplicationsController.saveApplication()');
        Application__c updatedApplication = makeDecision(application);
        
        // Perform isUpdatable() checking first, then
        upsert updatedApplication;
        return updatedApplication;
    }
    
    private static Application__c makeDecision(Application__c application) {
        // Save user name on the Application__c.Name field?
        User user = [select id,Name from User where id =: userInfo.getUserId()];
		System.debug('Curent user: ' + user.Name);
        application.Name = user.Name;
        
        if (application.Loan_Amount__c > 5000 || application.Loan_Amount__c < 1000 ) {
            application.Status__c = 'Rejected';
        } else if (application.Loan_Period__c < 6 || application.Loan_Period__c > 12 ) {
            application.Status__c = 'Rejected';
        } else if (application.Loan_Amount__c > 2000) {
        	application.Status__c = 'Referred';            
        } else {
            // Check that there is no Approved already there for this user!
            Application__c[] approvedApplications = 
                [SELECT Id FROM Application__c WHERE (Status__c = 'Approved' AND Name =: user.Name)]; 
            if (approvedApplications.size() > 0) {
                application.Status__c = 'Referred';
            } else {        
            	application.Status__c = 'Approved';
            }
        }
        return application;
    }
}