@isTest
public class TestReferredApplicationsController {
	@isTest
    static void testGetApplications_NoReferredApplications() {
        List<Application__c> applicationsList = ReferredApplicationsController.getApplications();
        System.debug('Running test');
        System.assert(applicationsList.size() == 0);
    }
    
    @isTest
    static void testGetApplications_ReferredApplicationsFound() {
        Application__c application1 = new Application__c();
        application1.Loan_Amount__c = 2800;
        application1.Loan_Period__c = 8;
        application1.Salary__c = 20000;
        Application__c savedApp1 = ApplicationsController.saveApplication(application1);
        
        Application__c application2 = new Application__c();
        application2.Loan_Amount__c = 3000;
        application2.Loan_Period__c = 10;
        application2.Salary__c = 40000;
        Application__c savedApp2 = ApplicationsController.saveApplication(application2);
        
        List<Application__c> applicationsList = ReferredApplicationsController.getApplications();
        System.assert(applicationsList.size() == 2);
    }
    
    @isTest
    static void testSaveApplication() {
        Application__c application1 = new Application__c();
        application1.Loan_Amount__c = 2800;
        application1.Loan_Period__c = 8;
        application1.Salary__c = 20000;
        Application__c savedApp1 = ApplicationsController.saveApplication(application1);
        
        List<Application__c> applicationsList = ReferredApplicationsController.getApplications();
        System.assert(applicationsList.size() == 1);
        Application__c application = applicationsList[0];
        application.Status__c = 'Approved';
        ReferredApplicationsController.saveApplication(application);
        
        applicationsList = ReferredApplicationsController.getApplications();
        System.assert(applicationsList.size() == 0);
        
    }
}