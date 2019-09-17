@isTest
private class CustomLookupTest {
    @isTest
    private static void getLookupRecordTest(){
        VEN3__Program_Partner__c partner = new VEN3__Program_Partner__c();
        partner.Name = 'Telstra';
        partner.VEN3__Goods_Type__c = 'Telecommunications';
        partner.VEN3__Active__c  = true;
        insert partner;
        
        Case cse = new Case();
        cse.Status = 'New';
        cse.Origin= 'Phone';
        insert cse;
        String valueEnter1 = '12345';
        String valueEnter = 'Telstra';
        List<sObject> objList = new List<sObject>();
        objList.add(partner);
        CustomLookup.CustomLookupWrapper wrap = new CustomLookup.CustomLookupWrapper();
        Test.startTest();
        List<CustomLookup.CustomLookupWrapper> wrapList = CustomLookup.getLookupRecord_Apex(valueEnter, 'VEN3__Program_Partner__c');
        Test.stopTest();
        
        system.assert(wrapList.size()>0);
    }
    
    @isTest
    private static void getLookupRecordFromIdTest(){
        VEN3__Program_Partner__c partner = new VEN3__Program_Partner__c();
        partner.Name = 'Telstra';
        partner.VEN3__Goods_Type__c = 'Telecommunications';
        partner.VEN3__Active__c  = true;
        insert partner;
        
        String valueEnter = 'Telstra';
        List<sObject> objList = new List<sObject>();
        objList.add(partner);
        CustomLookup.CustomLookupWrapper wrap = new CustomLookup.CustomLookupWrapper();
        Test.startTest();
        CustomLookup.CustomLookupWrapper wrapList = CustomLookup.getLookupRecordFromId_Apex(partner.Id, 'VEN3__Program_Partner__c');
        Test.stopTest();
        system.assert(wrapList!= null);
        // system.assert(wrapList.size()>0);
    }
    
    @isTest
    private static void getCurrentUserName_Apex(){
        
        String userId = UserInfo.getUserId();
        String userName = UserInfo.getName();
        CustomLookup.CustomLookupWrapper wrap = new CustomLookup.CustomLookupWrapper();
        Test.startTest();
        String Name = CustomLookup.getCurrentUserName_Apex(userId);
        wrap =  CustomLookup.getCurrentUser_Apex();
        Test.stopTest();
        
        system.assert(wrap!= null);
        system.assert(Name!= null);
    }
}