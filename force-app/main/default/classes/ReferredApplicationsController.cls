/*
 * "with sharing" means that this automatically applies your org’s sharing rules to 
 * the records that are available via these methods.
 */
public with sharing class ReferredApplicationsController {

    @AuraEnabled
    public static List<Application__c> getApplications() {
        
        System.debug('*** Get Applications ****');
        
        // Check to make sure all fields are accessible to this user
        String[] fieldsToCheck = new String[] {
            'Id', 'Name', 'CreatedById', 'Loan_Amount__c', 'Loan_Period__c', 'Status__c', 'Credit_R__c', 'Salary__c'
        };
        
        Map<String,Schema.SObjectField> fieldDescribeTokens = 
            Schema.SObjectType.Application__c.fields.getMap();
        
        for(String field : fieldsToCheck) {
            if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        
        return [SELECT Id, Name, CreatedById, Loan_Amount__c, Loan_Period__c, Status__c, Credit_R__c, Salary__c
                FROM Application__c
               	WHERE Status__c='Referred'];
    }
    
    @AuraEnabled
    public static Application__c saveApplication(Application__c application) {
        // Perform isUpdatable() checking first, then
        upsert application;
        return application;
    }
    
    @AuraEnabled
    public static Application__c getRating(Application__c application) {
        System.debug('*** Get Rating ****');
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
		request.setMethod('GET');
		HttpResponse response = http.send(request);
		// If the request is successful, parse the JSON response.
		if (response.getStatusCode() == 200) {
    		// Deserialize the JSON string into collections of primitive data types.
    		Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    		// Cast the values in the 'animals' key as a list
    		List<Object> animals = (List<Object>) results.get('animals');
    		System.debug('Received the following animals:');
    		for (Object animal: animals) {
        		System.debug(animal);
    		}
            // application.Credit_R__c = 50;
            application.Credit_R__c = Math.floor((Math.random() * 100) + 1);
            
            upsert application;
		}
        return application;
    }
}