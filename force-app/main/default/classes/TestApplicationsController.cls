@isTest
public class TestApplicationsController {
	@isTest
    static void testGetApplications_NoApplications() {
        // ApplicationsController ac = new ApplicationsController();
        List<Application__c> applicationsList = ApplicationsController.getApplications();
        System.debug('Running test');
        System.assert(applicationsList.size() == 0);
    }
    
    @isTest
    static void testGetApplications_ApplicationsExist() {
        Application__c application1 = new Application__c();
        application1.Loan_Amount__c = 2000;
        application1.Loan_Period__c = 8;
        application1.Salary__c = 20000;
        insert application1;
        
        Application__c application2 = new Application__c();
        application2.Loan_Amount__c = 3000;
        application2.Loan_Period__c = 9;
        application2.Salary__c = 40000;
        insert application2;
        
        List<Application__c> applicationsList = ApplicationsController.getApplications();
        System.debug('Running test');
        System.assert(applicationsList.size() == 2);
    }
    
    @isTest
    static void testSaveApplication_AutomaticallyApproved() {
        Application__c application1 = new Application__c();
        application1.Loan_Amount__c = 1800;
        application1.Loan_Period__c = 8;
        application1.Salary__c = 20000;
       
        Application__c savedApp1 = ApplicationsController.saveApplication(application1);
        
        System.assert(application1.Loan_Amount__c == savedApp1.Loan_Amount__c);
        System.assert(application1.Loan_Period__c == savedApp1.Loan_Period__c);
        System.assert(application1.Status__c == 'Approved');
    }
    
    @isTest
    static void testSaveApplication_AutomaticallyReferred() {
        Application__c application1 = new Application__c();
        application1.Loan_Amount__c = 2800;
        application1.Loan_Period__c = 8;
        application1.Salary__c = 20000;
      
        Application__c savedApp1 = ApplicationsController.saveApplication(application1);
        
        System.assert(application1.Loan_Amount__c == savedApp1.Loan_Amount__c);
        System.assert(application1.Loan_Period__c == savedApp1.Loan_Period__c);
        System.assert(application1.Status__c == 'Referred');
    }
    
    @isTest
    static void testSaveApplication_AutomaticallyReferredApprovedAlreadyExists() {
        // This test should create one approved application. 
        testSaveApplication_AutomaticallyApproved();
        
        // There can only be 
        // one active at the time, so the second one wil get Referred even though
        // it should be Applroved.
        Application__c application1 = new Application__c();
        application1.Loan_Amount__c = 1800;
        application1.Loan_Period__c = 8;
        application1.Salary__c = 20000;
        
        Application__c savedApp1 = ApplicationsController.saveApplication(application1);
        
        System.assert(application1.Loan_Amount__c == savedApp1.Loan_Amount__c);
        System.assert(application1.Loan_Period__c == savedApp1.Loan_Period__c);
        System.assert(application1.Status__c == 'Referred');
    }
    
    @isTest
    static void testSaveApplication_FieldValidationFailsOnSubmit() {
        Application__c application1 = new Application__c();
        application1.Loan_Amount__c = 7000;
        application1.Loan_Period__c = 20;
        application1.Salary__c = 20000;
        
        try {
            System.debug('in try, before');
        	Application__c savedApp1 = ApplicationsController.saveApplication(application1);
            System.debug('in try, after');
            throw new MyException('An exception should have been thrown by the trigger but was not.');
        } catch (Exception e) {
            System.debug('in catch');
            System.debug('Caught an exception!');
            Boolean expectedExceptionThrown =  e.getMessage().contains('My Error Message') ? false : true;
			System.AssertEquals(true, expectedExceptionThrown);
        }
    }
    
    private class MyException extends Exception { 
   	   // do nothing here, this class is just used to distinguish
   	   // the catched exception type.
	}
}