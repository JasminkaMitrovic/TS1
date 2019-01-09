({
	createApplication: function(component, newApplication) {
        var createEvent = component.getEvent("createApplication");
        createEvent.setParams({ "application": newApplication });
        createEvent.fire();
        
        component.set("v.newApplication",{ 'sobjectType': 'Application__c',
        	'Loan_Amount__c': 0,
            'Loan_Period__c': '',
            'Salary__c': 0,
            'Status__c': 'Submitted'});
    },

})