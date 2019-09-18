@isTest
private class VendorSupplierController_Test {
    @isTest
    private static void Test(){
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        l.Email = 'teat@gmail.com';
        
        l.Phone = '123454321';
        
        insert l;
        String leadObj = JSON.serialize(l);
        String EmailQuoteSObjectId = l.Id;
        VEN3__Calculator__c calcInsert = new VEN3__Calculator__c();
        calcInsert.Name = 'TestQuote';
        calcInsert.VEN3__Amount_Financed__c = 42000;
        calcInsert.VEN3__Ballon__c = 5.00;
        calcInsert.VEN3__Balloon_c__c = 2100;
        calcInsert.VEN3__Customer_Rate_Expected__c = 3.3;
        calcInsert.VEN3__Customer_Rate_Non_Published__c = 3.3;
        calcInsert.VEN3__Date__c = Date.today();
        calcInsert.VEN3__Desired_Brokerage_Incl_GST_c__c = 1234.22;
        calcInsert.VEN3__Desired_Brokerage_Incl_GST_p__c = 3.2;
        calcInsert.VEN3__Goods_Type__c = 'Trucks ( New - 3 yrs old )';
        calcInsert.VEN3__Incl_GST_c__c = 1233.22;
        calcInsert.VEN3__Loan_Facility_Type__c = 'Chattel Mortgage';
        calcInsert.VEN3__Please_enter_your_desired_Base_Rate_here__c = 3.3;
        calcInsert.VEN3__Published_Base_Rate__c = 3.3;
        calcInsert.VEN3__Repayment_Expected_c__c = 1222.02;
        calcInsert.VEN3__Repayment_Non_Published__c = 1235.32;
        calcInsert.VEN3__Repayment_Frequency__c = 'Yearly';
        calcInsert.VEN3__Repayment_Type__c = 'Advance';
        calcInsert.VEN3__State__c = 'WA';
        calcInsert.VEN3__Term_months__c = 45;
        calcInsert.VEN3__Total_Incl_GST_c__c = 1386.00;
        calcInsert.VEN3__PPSR_Fees_Disclosed__c = 1386.00;
        calcInsert.VEN3__Fees_Other_Disclosed__c = 1386.00;
        calcInsert.VEN3__Document_Fee_Disclosed__c = 1386.00;
        calcInsert.VEN3__Lead__c = l.Id;
        insert calcInsert;
        
        
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
        User usr = new User(LastName = 'LIVESTON',
                            FirstName='JASON',
                            Alias = 'jliv',
                            Email = 'jason.liveston@asdf.com',
                            Username = 'jason.liveston@asdf.com',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US'
                           );
        
        Test.startTest();
        
        String myJSON = JSON.serialize(calcInsert);
        Test.setCurrentPageReference(new PageReference('Page.QuoteCalculatorPDF'));
        System.currentPageReference().getParameters().put('id', calcInsert.Id);
        System.currentPageReference().getParameters().put('rateType', 'None');
        System.currentPageReference().getParameters().put('SObjectId', l.Id);
        VendorSupplierController calcObj = new VendorSupplierController();
        
        Test.stopTest();
    }
    
    /*@isTest
private static void TestMethodForEmailQuoteRateType(){
Lead l = new Lead();
l.LastName = 'Test';
l.Status = 'Open - Not Contacted';
l.Company = 'Ca';
l.Email = 'teat@gmail.com';

l.Phone = '123454321';

insert l;
String leadObj = JSON.serialize(l);
String EmailQuoteSObjectId = l.Id;

List<VEN3__Calculator__c> calcInsertList = new List<VEN3__Calculator__c>();
for(Integer i=0;i<4;i++){
VEN3__Calculator__c calcInsert=new VEN3__Calculator__c();
calcInsert.Name = 'TestQuote';
calcInsert.VEN3__Amount_Financed__c = 42000;
calcInsert.VEN3__Ballon__c = 5.00;
calcInsert.VEN3__Balloon_c__c = 2100;
calcInsert.VEN3__Customer_Rate_Expected__c = 3.3;
calcInsert.VEN3__Customer_Rate_Non_Published__c = 3.3;
calcInsert.VEN3__Date__c = Date.today();
calcInsert.VEN3__Desired_Brokerage_Incl_GST_c__c = 1234.22;
calcInsert.VEN3__Desired_Brokerage_Incl_GST_p__c = 3.2;
calcInsert.VEN3__Goods_Type__c = 'Trucks ( New - 3 yrs old )';
calcInsert.VEN3__Incl_GST_c__c = 1233.22;
calcInsert.VEN3__Loan_Facility_Type__c = 'Chattel Mortgage';
calcInsert.VEN3__Please_enter_your_desired_Base_Rate_here__c = 3.3;
calcInsert.VEN3__Published_Base_Rate__c = 3.3;
calcInsert.VEN3__Repayment_Expected_c__c = 1222.02;
calcInsert.VEN3__Repayment_Non_Published__c = 1235.32;
calcInsert.VEN3__Repayment_Frequency__c = 'Yearly';
calcInsert.VEN3__Repayment_Type__c = 'Advance';
calcInsert.VEN3__State__c = 'WA';
calcInsert.VEN3__Term_months__c = 45;
calcInsert.VEN3__Total_Incl_GST_c__c = 1386.00;
calcInsert.VEN3__PPSR_Fees_Disclosed__c = 1386.00;
calcInsert.VEN3__Fees_Other_Disclosed__c = 1386.00;
calcInsert.VEN3__Document_Fee_Disclosed__c = 1386.00;
calcInsert.VEN3__Lead__c = l.Id;
calcInsertList.add(calcInsert);
}
insert calcInsertList;
Set<Id> Idset=new Set<Id>();
for(VEN3__Calculator__c obj : calcInsertList) {
Idset.add(obj.Id);
}


Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

User usr = new User(LastName = 'LIVESTON',
FirstName='JASON',
Alias = 'jliv',
Email = 'jason.liveston@asdf.com',
Username = 'jason.liveston@asdf.com',
ProfileId = profileId.id,
TimeZoneSidKey = 'GMT',
LanguageLocaleKey = 'en_US',
EmailEncodingKey = 'UTF-8',
LocaleSidKey = 'en_US'
);

Test.startTest();

String myJSON = JSON.serialize(calcInsertList[0]);
Test.setCurrentPageReference(new PageReference('Page.QuoteCalculatorPDF'));
System.currentPageReference().getParameters().put('id', calcInsertList[0].Id);
System.currentPageReference().getParameters().put('rateType', 'Customer Rate Only');
System.currentPageReference().getParameters().put('SObjectId', l.Id);
System.currentPageReference().getParameters().put('selectedIds', JSON.serialize(Idset));
// System.currentPageReference().getParameters().put('selectedIds', l.Id);
VendorSupplierController calcObj = new VendorSupplierController();

Test.stopTest();
}*/
    
    
    @isTest
    private static void saveANZDataTest(){
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        l.Email = 'teat@gmail.com';
        
        l.Phone = '123454321';
        
        insert l;
        String leadObj = JSON.serialize(l);
        
        VEN3__Calculator__c calcInsert = new VEN3__Calculator__c();
        calcInsert.Name = 'TestQuote';
        calcInsert.VEN3__Amount_Financed__c = 42000;
        calcInsert.VEN3__Ballon__c = 5.00;
        calcInsert.VEN3__Balloon_c__c = 2100;
        calcInsert.VEN3__Customer_Rate_Expected__c = 3.3;
        calcInsert.VEN3__Customer_Rate_Non_Published__c = 3.3;
        calcInsert.VEN3__Date__c = Date.today();
        calcInsert.VEN3__Desired_Brokerage_Incl_GST_c__c = 1234.22;
        calcInsert.VEN3__Desired_Brokerage_Incl_GST_p__c = 3.2;
        calcInsert.VEN3__Goods_Type__c = 'Trucks ( New - 3 yrs old )';
        calcInsert.VEN3__Incl_GST_c__c = 1233.22;
        calcInsert.VEN3__Loan_Facility_Type__c = 'Chattel Mortgage';
        calcInsert.VEN3__Please_enter_your_desired_Base_Rate_here__c = 3.3;
        calcInsert.VEN3__Published_Base_Rate__c = 3.3;
        calcInsert.VEN3__Repayment_Expected_c__c = 1222.02;
        calcInsert.VEN3__Repayment_Non_Published__c = 1235.32;
        calcInsert.VEN3__Repayment_Frequency__c = 'Yearly';
        calcInsert.VEN3__Repayment_Type__c = 'Advance';
        calcInsert.VEN3__State__c = 'WA';
        calcInsert.VEN3__Term_months__c = 45;
        calcInsert.VEN3__Total_Incl_GST_c__c = 1386.00;
        calcInsert.VEN3__PPSR_Fees_Disclosed__c = 1386.00;
        calcInsert.VEN3__Fees_Other_Disclosed__c = 1386.00;
        calcInsert.VEN3__Document_Fee_Disclosed__c = 1386.00;
        calcInsert.VEN3__Lead__c = l.Id;
        insert calcInsert;
        String calcObj = JSON.serialize(calcInsert);
        
        
        
        Test.startTest();
        VEN3__Chase_Lead_Notification_Emails__c setting = new VEN3__Chase_Lead_Notification_Emails__c();
        setting.Name = 'Test';
        setting.Email__c = 'Test@cd.com';        
        insert setting;
        
        VEN3__Pronto_Lead_Notification_Emails__c prontoSetting = new VEN3__Pronto_Lead_Notification_Emails__c();
        prontoSetting.Name = 'Test';
        prontoSetting.Email__c = 'Test@cd.com'; 
        insert prontoSetting;
        VEN3__Calculator__c obj = VendorSupplierController.saveANZData_Apex(calcObj, leadObj, 'chase');
        VEN3__Calculator__c obj1 = VendorSupplierController.saveANZData_Apex(calcObj, leadObj, 'pronto');
        Test.stopTest(); 
        
        system.assert(obj!= null);
        //system.assertEquals(obj.Name, 'TestQuote');
    }
    
    @isTest
    private static void saveANZDataTest1(){
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        l.Email = 'teat@gmail.com';
        l.Phone = '123454321';
        
        insert l;
        String leadObj = JSON.serialize(l); 
        
        VEN3__Calculator__c calcInsert = new VEN3__Calculator__c();
        calcInsert.Name = 'TestQuote';
        calcInsert.VEN3__Amount_Financed__c = 42000;
        calcInsert.VEN3__Ballon__c = 5.00;
        calcInsert.VEN3__Balloon_c__c = 2100;
        calcInsert.VEN3__Customer_Rate_Expected__c = 3.3;
        calcInsert.VEN3__Customer_Rate_Non_Published__c = 3.3;
        calcInsert.VEN3__Date__c = Date.today();
        calcInsert.VEN3__Desired_Brokerage_Incl_GST_c__c = 1234.22;
        calcInsert.VEN3__Desired_Brokerage_Incl_GST_p__c = 3.2;
        calcInsert.VEN3__Goods_Type__c = 'Trucks ( New - 3 yrs old )';
        calcInsert.VEN3__Incl_GST_c__c = 1233.22;
        calcInsert.VEN3__Loan_Facility_Type__c = 'Chattel Mortgage';
        calcInsert.VEN3__Please_enter_your_desired_Base_Rate_here__c = 3.3;
        calcInsert.VEN3__Published_Base_Rate__c = 3.3;
        calcInsert.VEN3__Repayment_Expected_c__c = 1222.02;
        calcInsert.VEN3__Repayment_Non_Published__c = 1235.32;
        calcInsert.VEN3__Repayment_Frequency__c = 'Yearly';
        calcInsert.VEN3__Repayment_Type__c = 'Advance';
        calcInsert.VEN3__State__c = 'WA';
        calcInsert.VEN3__Term_months__c = 45;
        calcInsert.VEN3__Total_Incl_GST_c__c = 1386.00;
        calcInsert.VEN3__PPSR_Fees_Disclosed__c = 1386.00;
        calcInsert.VEN3__Fees_Other_Disclosed__c = 1386.00;
        calcInsert.VEN3__Document_Fee_Disclosed__c = 1386.00;
        calcInsert.VEN3__Lead__c = l.Id;
        insert calcInsert;
        String calcObj = JSON.serialize(calcInsert);
        
        
        
        Test.startTest();
        VEN3__Chase_Lead_Notification_Emails__c setting = new VEN3__Chase_Lead_Notification_Emails__c();
        setting.Name = 'Test';
        setting.Email__c = 'Test@cd.com';
        insert setting;
        VEN3__Calculator__c obj = VendorSupplierController.saveANZData_Apex( calcObj, leadObj, 'chase');
        Test.stopTest();
        system.debug('obj>>'+obj);
        System.assert(obj!= null);
        System.assertEquals(obj.VEN3__Amount_Financed__c, 42000);
    }
    
    
    @isTest
    private static void getGoodsTypeTest(){
        VEN3__Program_Partner__c partner = new VEN3__Program_Partner__c();
        partner.Name = 'Telstra';
        partner.VEN3__Goods_Type__c = 'Telecommunications';
        insert partner;
        
        Test.startTest();
        VEN3__Program_Partner__c obj =  VendorSupplierController.getGoodsType_Apex(partner.Id);
        Test.stopTest();
        
        System.assert(obj != null);
    }
    
    
    @isTest
    private static void getExistingRecord_Test(){
        Lead leadObj = new Lead();
        leadObj.LastName = 'Test';
        leadObj.Status = 'Open - Not Contacted';
        leadObj.Company = 'Ca';
        leadObj.Email = 'teat@gmail.com';
        
        leadObj.Phone = '123454321';
        insert leadObj;
        
        string balloon = '10';
        string goodsType = 'telecommunications';
        string term = '24';
        Decimal Term1 = 24;
        string Asset = 'New';
        string AmountFinance = '15000';
        string Repayment = '125';
        string facilityType = 'Chattel Mortgage';
        
        VEN3__Program_Partner__c partner = new VEN3__Program_Partner__c();
        partner.Name = 'Telstra';
        partner.VEN3__Goods_Type__c = 'Telecommunications';
        insert partner;
        VEN3__Calculator_Settings__c calculatorSettingObj = new VEN3__Calculator_Settings__c();
        VendorSupplierController.getExistingRecord(leadObj.Id);
        calculatorSettingObj = VendorSupplierController.getCustomSettings_Apex(Asset, Term1, facilityType, partner.Id, goodsType);
        System.assert(calculatorSettingObj == null);
    }
}