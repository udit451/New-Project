public class CustomLookup {
    @AuraEnabled
    public static List<CustomLookupWrapper> getLookupRecord_Apex(String valueEnter, String objName){
        Boolean checkObjectAvailability = CustomLookup.checkObjectAvailability(objName);
        if(checkObjectAvailability == true){
            String tempLabel = '';
            String query = 'Select Id, ';
            if(objName.equalsIgnoreCase('VEN3__Program_Partner__c')){
                query += ' Name From ' + objName + ' where Name Like \'' + valueEnter + '%\' AND VEN3__Active__c = true Limit 10000';
                tempLabel = 'Name';
            }else if(objName != 'Case'){
                query += ' Name From ' + objName + ' where Name Like \'' + valueEnter + '%\' Limit 10000';
                tempLabel = 'Name';
            }else {
                query += ' CaseNumber From ' + objName + ' where Name Like \'' + valueEnter + '%\' Limit 10000';
                tempLabel = 'CaseNumber';
            }
            List<sObject> objList = new List<sObject>();
            objList = Database.query(query);
            if(objList.size() > 0){
                List<CustomLookupWrapper> wrapperList = new List<CustomLookupWrapper>();
                for(sObject sObj : objList){
                    CustomLookupWrapper wrapper = new CustomLookupWrapper();
                    wrapper.Id = (String)sObj.get('Id');
                    wrapper.Name = (String)sObj.get(tempLabel);
                    wrapperList.add(wrapper);
                }
                if(wrapperList.size() > 0){
                    return wrapperList;
                }
            }
        }
        return null;
    }

    public static Boolean checkObjectAvailability (String objName){
        if(objName != null){
            List<String> sObjectList = new List<String>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                Schema.DescribeSObjectResult describeSObjectResultObj = objTyp.getDescribe();
                if(describeSObjectResultObj.isQueryable())
                {
                    String name = objTyp.getDescribe().getName();
                    if(!name.containsignorecase('history') && !name.containsignorecase('tag')&&
                            !name.containsignorecase('share') && !name.containsignorecase('feed') && !name.containsignorecase('feed'))
                    {
                        SobjectList.add(name);
                    }
                }
            }
            if(SobjectList.size()>0){
                for(String str : SobjectList){
                    if(str == objName){
                        return true;
                    }
                }
            }
        }else{
            return false;
        }

        return false;
    }

    @AuraEnabled
    public static CustomLookupWrapper getLookupRecordFromId_Apex(String Id, String objName){
        Boolean checkObjectAvailability = CustomLookup.checkObjectAvailability(objName);
        if(checkObjectAvailability == true){
            String tempLabel = '';
            String query = 'Select Id, ';
            if(objName.equalsIgnoreCase('VEN3__Program_Partner__c')){
                query += ' Name From ' + objName + ' where Id = \'' + Id + '\'';
                tempLabel = 'Name';
            }else if(objName != 'Case'){
                query += ' Name From ' + objName + ' where Id = \'' + Id + '\' ';
                tempLabel = 'Name';
            }else {
                query += ' CaseNumber From ' + objName + ' where Id = \'' + Id + '\' ';
                tempLabel = 'CaseNumber';
            }
            List<sObject> objList = new List<sObject>();
            objList = Database.query(query);
            if(objList.size() > 0){
                CustomLookupWrapper wrapper = new CustomLookupWrapper();
                wrapper.Id = (String)objList.get(0).get('Id');
                wrapper.Name = (String)objList.get(0).get(tempLabel);
                return wrapper;
            }
        }
        return null;
    }

	@AuraEnabled
	public static String getCurrentUserName_Apex(String Id) {
		User u = new User();
		u = [Select Id,Name from User where Id =: Id limit 1];
		return u.Name;
	}

    @AuraEnabled
    public static CustomLookupWrapper getCurrentUser_Apex() {
        CustomLookupWrapper userDetails = new CustomLookupWrapper();
        userDetails.Id = UserInfo.getUserId();
        userDetails.Name = UserInfo.getName();
        return userDetails;
    }

    public class CustomLookupWrapper{
        @AuraEnabled public String Id;
        @AuraEnabled public String Name;
    }
}