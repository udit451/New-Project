({
	doInit_Helper : function(c, e, h) {
	    h.definedCalculatorType_helper(c, e, h);
        h.initializeMatrixUser(c, e, h);
	},

	initializeMatrixUser : function(c, e, h){
	    try{
	        var userObj = {};
	        userObj.Name = null;
	        userObj.VEN3__Password__c = null;
	        userObj.VEN3__Email__c = null;
	        userObj.VEN3__Program_Partner__c = null;
	        userObj.VEN3__Username__c = null;
            c.set('v.matrixUser',userObj);
           
	    }catch(ex){
	        console.log(ex);
	    }
	},

	validate_Helper : function(c, e, h){
	    try{
	        var userObj = c.get('v.matrixUser');
	        var userName = userObj.VEN3__Username__c;
            var password = userObj.VEN3__Password__c;
            
            /*console.info('userName :: '+userName);
            console.info('password :: '+password);*/
	        if(!$A.util.isUndefinedOrNull(userName) && !$A.util.isEmpty(userName) && !$A.util.isUndefinedOrNull(password) && !$A.util.isEmpty(password)){
	            $A.util.addClass(c.find('errorLayout'), 'slds-hide');
                //$A.util.removeClass(c.find('noerrorLayout'), 'slds-hide');
                h.authenticateUser_Helper(c, e, h, userName, password);
	        }else{
	            if(($A.util.isUndefinedOrNull(userName) || $A.util.isEmpty(userName)) && (!$A.util.isUndefinedOrNull(password) && !$A.util.isEmpty(password))){
	                c.set('v.errorMessage','Please fill the Username');
	                $A.util.removeClass(c.find('errorLayout'), 'slds-hide');
                    //$A.util.addClass(c.find('noerrorLayout'), 'slds-hide');
	            }
	            if(($A.util.isUndefinedOrNull(password) || $A.util.isEmpty(password)) && (!$A.util.isUndefinedOrNull(userName) && !$A.util.isEmpty(userName))){
                    c.set('v.errorMessage','Please fill the Password');
                    $A.util.removeClass(c.find('errorLayout'), 'slds-hide');
                   // $A.util.addClass(c.find('noerrorLayout'), 'slds-hide');
                }
                if(($A.util.isUndefinedOrNull(password) || $A.util.isEmpty(password)) && ($A.util.isUndefinedOrNull(userName) || $A.util.isEmpty(userName))){
                    c.set('v.errorMessage','Please fill the Username & Password');
                    $A.util.removeClass(c.find('errorLayout'), 'slds-hide');
                   // $A.util.addClass(c.find('noerrorLayout'), 'slds-hide');
                }
            }

	    }catch(ex){
	        console.log(ex);
	    }
	},

	authenticateUser_Helper : function(c, e, h, userName, password){
	    try{
            /*console.log('method called');*/
	        var action = c.get("c.authenticateUser_Apex");
            action.setParams({
                "userName": userName,
                "password" : password
            });
            action.setCallback(this, function (response) {
                if (response.getState() === "SUCCESS") {
                    var storedResponse = response.getReturnValue();
                    if (!$A.util.isUndefinedOrNull(storedResponse)) {
                        if(storedResponse.status === 'Active User'){
                             /*console.log(storedResponse.matrixUser);*/
                            c.set('v.matrixUser',storedResponse.matrixUser);
                            $A.util.addClass(c.find('errorLayout'), 'slds-hide');
                           // $A.util.removeClass(c.find('noerrorLayout'), 'slds-hide');
                            h.showExistingCalculatorRecords(c, e, h, storedResponse.matrixUser.VEN3__Program_Partner__c);

                            var username = c.get("v.matrixUser.Name");
                            var matches = username.match(/\b(\w)/g); 
                            var userName = matches.join('');
                            userName = userName.toUpperCase();
                            c.set("v.UserName", userName);
                        }
                        else if(storedResponse.status === 'InActive User'){
                            // /c.set('v.errorMessage','Please check Username or Password');
                            c.set('v.errorMessage','Login details are no longer active. Please contact Chase Finance .');
                            $A.util.removeClass(c.find('errorLayout'), 'slds-hide');
                           // $A.util.addClass(c.find('noerrorLayout'), 'slds-hide');
                        }
                        else if(storedResponse.status === 'Invalid User'){
                            // /c.set('v.errorMessage','Please check Username or Password');
                            c.set('v.errorMessage','Your username or password is invalid. Please contact Chase Finance .');
                            $A.util.removeClass(c.find('errorLayout'), 'slds-hide');
                           // $A.util.addClass(c.find('noerrorLayout'), 'slds-hide');
                        }
                        else{
                            c.set('v.errorMessage', storedResponse.status);
                            $A.util.removeClass(c.find('errorLayout'), 'slds-hide');
                            //$A.util.addClass(c.find('noerrorLayout'), 'slds-hide');
                        }
                    } else {
                        c.set('v.errorMessage', 'Network error');
                        $A.util.removeClass(c.find('errorLayout'), 'slds-hide');
                       // $A.util.addClass(c.find('noerrorLayout'), 'slds-hide');
                    }
                } else {
                    c.set('v.errorMessage', 'Network error');
                    $A.util.removeClass(c.find('errorLayout'), 'slds-hide');
                    //$A.util.addClass(c.find('noerrorLayout'), 'slds-hide');
                }
            });
            
            $A.enqueueAction(action);
	    }catch(ex){
	        console.log(ex);
	    }
	},

	showExistingCalculatorRecords : function(c, e, h, program){
	    try{
	        if(!$A.util.isUndefinedOrNull(program) && !$A.util.isEmpty(program)){
            var action = c.get("c.getRelatedRecords_Apex");
            action.setParams({
                "program": program
            });
            action.setCallback(this, function (response) {
                if (response.getState() === "SUCCESS") {
                    var storedResponse = response.getReturnValue();
                    //console.log(storedResponse);
                    if (!$A.util.isUndefinedOrNull(storedResponse)) {
                            c.set('v.calcList',storedResponse.calcList);
                            c.set('v.leadList',storedResponse.leadList);
                            c.set('v.showExistingRecords', true);
                            c.set('v.showLoginPage', false);
                            c.set('v.openCalculator', false);
                            c.set('v.isView', false);

                    } else {
                        console.log('Error Occured');
                    }
                } else {
                    console.log('Error Occured');
                }
            });
            $A.enqueueAction(action);
        }
	    }catch(ex){
	        console.log(ex);
	    }
	},

	openCalculator_Helper : function(c, e, h){
	    c.set('v.recordId', undefined);
	    c.set('v.editRecordId', undefined);
	    c.set('v.showExistingRecords', false);
	    c.set('v.isView', false);
        c.set('v.showLoginPage', false);
        c.set('v.openCalculator', true);
	},

	disclaimerPopup_Helper : function(c, e, h){
	    var a =  c.find('SupplierMatrixCalculator');
        if(a != undefined){
            a[0].disclaimerQuote();
        }
	},

	closeDlPopup_Helper : function(c, e, h){
        h.showExistingCalculatorRecords(c, e, h, c.get('v.matrixUser.VEN3__Program_Partner__c'));
	},

	saveData_Helper : function(c, e, h){
        var a =  c.find('SupplierMatrixCalculator');
        if(a != undefined){
            a[0].saveCustomSettings();
        }
    },

    copyData_Helper : function(c, e, h){
        c.set("v.openCalculator", false);
        c.set("v.isClone",true);
        c.set('v.recordId',c.get('v.recordId'));
        var recordId = c.get('v.selectedId');
        c.set("v.LeadRecordId", recordId);
	    c.set('v.isView',false);
        c.set("v.openCalculator", true);
    },

    emailDataPopup_Helper : function(c, e, h){
        var a =  c.find('SupplierMatrixCalculator');
        if(!$A.util.isUndefinedOrNull(a)){
            a[0].emailQuoteData();
        }
    },

    clearDataPopup_Helper : function(c, e, h){
        var customSettings =  c.find('SupplierMatrixCalculator');
        if(customSettings != undefined){
            customSettings[0].clearQouteData();
        }
    },

    editSelectedRecord : function(c, e, h){
        try{
            var selectedId = c.get('v.selectedId');
            var leadlist = c.get("v.leadList");
            //console.info('leadList===>'+ JSON.stringify(leadlist));
            var calclist = c.get('v.calcList');
            leadlist.forEach(function(element) {
                if(element.Id === selectedId){
                    var targetID = c.get('v.selectedId');
                    c.set('v.recordId', targetID);
                    c.set('v.editRecordId', targetID);
                    c.set("v.showExistingRecords", false);
                    c.set("v.openCalculator", true);
                }
            });
        }catch(ex){
            console.log(ex);
        }
    },

    logout_Helper : function(c, e, h){
        c.set('v.openCalculator',false);
        c.set('v.showExistingRecords',false);
        c.set('v.recordId',undefined);
        c.set('v.editRecordId',undefined);
        c.set('v.showLoginPage',true);
    },

    definedCalculatorType_helper : function (c ) {
        var type = c.get('v.calculatorType');
        var cmpTarget = c.find('loginButton');
        var loginDivTarget = c.find('loginDiv');
        var existingDivTarget = c.find('detailedDiv');
        if(type === 'pronto'){
            $A.util.addClass(c.find('Chasefinance'), 'slds-hide');
            $A.util.addClass(cmpTarget, 'LoginButtonPronto');
            $A.util.addClass(loginDivTarget, 'boxDivPronto');
            $A.util.addClass(existingDivTarget, 'headerCssPronto');
            $A.util.removeClass(cmpTarget, 'LoginButton');
            $A.util.removeClass(loginDivTarget, 'boxDiv');
            $A.util.removeClass(existingDivTarget, 'headerCssChase');
        }else {
            $A.util.addClass(c.find('ProntoAddress'), 'slds-hide');
            $A.util.addClass(cmpTarget, 'LoginButton');
            $A.util.addClass(loginDivTarget, 'boxDiv');
            $A.util.addClass(existingDivTarget, 'headerCssChase');
            $A.util.removeClass(cmpTarget, 'LoginButtonPronto');
            $A.util.removeClass(loginDivTarget, 'boxDivPronto');
            $A.util.removeClass(existingDivTarget, 'headerCssPronto');
        }
    }
})