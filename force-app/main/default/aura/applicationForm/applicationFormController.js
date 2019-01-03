({
	clickCreate: function(component, event, helper) {
        var validApplication = component.find('expenseform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validApplication){
            // Create the new expense
            var newApplication = component.get("v.newApplication");
            console.log("Create expense: " + JSON.stringify(newApplication));
            helper.createApplication(component, newApplication);
        }
    }
})