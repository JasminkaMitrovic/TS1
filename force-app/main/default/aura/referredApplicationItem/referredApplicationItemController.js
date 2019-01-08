({
    doInit : function(component, event, helper) {
        /* Nothing to init at the moment, but you can add
         * number of days untill the loan expires for example...*/
        /*
        var mydate = component.get("v.expense.Date__c");
        if(mydate){
            component.set("v.formatdate", new Date(mydate));
        }
        */
    },
    
    handleApproval : function(component, event, helper) {
        console.log("Handling Approval" );
      
        var application = component.get("v.referredApplication");
        component.set("v.referredApplication.Status__c", "Approved");
        var updateEvent = component.getEvent("updateApplication");
        application.Status__c='Approved';
        updateEvent.setParams({ "application": application });
        updateEvent.fire();
        
    },
    
    handleRejection : function(component, event, helper) {
        console.log("Handling Rejection" );
        
        var application = component.get("v.referredApplication");
        component.set("v.referredApplication.Status__c", "Rejected");
        var updateEvent = component.getEvent("updateApplication");
        application.Status__c='Rejected';
        updateEvent.setParams({ "application": application });
        updateEvent.fire();
       
    },
    
    getCreditRating : function(component, event, helper) {
        console.log("Get Credit Rating");
        
        var application = component.get("v.referredApplication");
        // component.set("v.referredApplication.Status__c", "Rejected");
        var getRatingEvent = component.getEvent("getRating");
        //application.Status__c='Rejected';
        getRatingEvent.setParams({ "application": application });
        getRatingEvent.fire();
    },
    
})