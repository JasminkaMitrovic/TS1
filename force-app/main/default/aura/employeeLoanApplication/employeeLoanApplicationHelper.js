({
    createApplication: function(component, application) {
        var theApplications = component.get("v.applications");
 
        // Copy the expense to a new object
        // THIS IS A DISGUSTING, TEMPORARY HACK
        var newApplication = JSON.parse(JSON.stringify(application));
 
        theApplications.push(newApplication);
        component.set("v.applications", theApplications);
    }
})