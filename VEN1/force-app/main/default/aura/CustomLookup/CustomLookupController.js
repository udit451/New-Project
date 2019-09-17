({
    getRecordNameList : function(c, e, h){
        var LValue = c.get('v.lookupValue');
        var LObj = c.get('v.lookupObjectAPI');
        if(LValue !== undefined && LValue !== null && LObj !== undefined && LObj !== null){
            if(LValue.length > 0 && LObj.length > 0){
                var action =  c.get("c.getLookupRecord_Apex");
                action.setParams({
                    "valueEnter" : LValue,
                    "objName" : LObj
                });
                action.setCallback(this, function (response) {
                    if(response.getState() == "SUCCESS"){
                        var data = (response.getReturnValue());
                        if(data !== null){
                            c.set('v.lookupList', data);
                            c.set('v.NoResults', false);
                        }else {
                            c.set('v.lookupList', []);
                            c.set('v.NoResults', true);
                        }
                    }else{
                        console.log("something misshappens");
                    }
                });
                $A.enqueueAction(action);
            }else {
                c.set('v.lookupList', []);
                c.set('v.NoResults', false);
            }
        }else {
            c.set('v.lookupList', []);
            c.set('v.NoResults', false);
        }
    },

    selectedRecord : function(c, e, h){
        var IdKey = e.currentTarget.id;
        var label = e.currentTarget.title;
        if(IdKey !== undefined && label !== undefined){
            c.set('v.lookupId',IdKey);
            c.set('v.lookupLabel',label);
            c.set('v.lookupValue',label);
            c.set('v.lookupList', null);
            c.set('v.selectedLookup', true);
            c.set('v.isError', false);
        }
    },

    clearSelected : function(c, e, h){
        try{
            c.set('v.lookupId',null);
            c.set('v.lookupLabel',null);
            c.set('v.lookupValue',null);
            c.set('v.lookupList', null);
            c.set('v.selectedLookup', false);
            c.set('v.defaultCurrentuser', false);
        }catch(ex){
            console.log(ex);
        }

    },

    userChanged : function (c, e, h) {
        var Id = c.get('v.lookupId');
        if(!$A.util.isUndefinedOrNull(Id)){
            var action = c.get("c.getLookupRecordFromId_Apex");
            action.setParams({
                "Id" : Id,
                "objName" : c.get('v.lookupObjectAPI')
            });
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var responseResult = response.getReturnValue();
                    if(!$A.util.isUndefinedOrNull(responseResult)){
                        c.set('v.lookupLabel',responseResult.Name);
                        c.set('v.lookupValue',responseResult.Name);
                        c.set('v.lookupList', null);
                        c.set('v.selectedLookup', true);
                        c.set('v.isError', false);
                    }

                } else {
                    console.log("something misshappens");
                }
            });
            $A.enqueueAction(action);
        }else {
            c.set('v.lookupLabel',undefined);
            c.set('v.lookupValue',undefined);
            c.set('v.lookupList', null);
            c.set('v.selectedLookup', false);
            c.set('v.isError', false);
        }
    }
})