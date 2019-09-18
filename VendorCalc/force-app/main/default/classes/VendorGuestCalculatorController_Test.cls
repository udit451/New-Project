@IsTest
private class VendorGuestCalculatorController_Test {
    @isTest static void authenticateUserWithValidUser_Test(){
        VEN3__Program_Partner__c ProgramPartnerObj = new VEN3__Program_Partner__c();
        ProgramPartnerObj.Name = 'Test Program Partner';
        ProgramPartnerObj.VEN3__Active__c = true;
        ProgramPartnerObj.VEN3__Goods_Type__c = 'Test Good1,Test Good2';
        ProgramPartnerObj.VEN3__Address__c = 'AUS';
        insert ProgramPartnerObj;

        VEN3__Vendor_Guest_User__c MatrixUserObj = new VEN3__Vendor_Guest_User__c();
        MatrixUserObj.Name = 'Test Matrix User';
        MatrixUserObj.VEN3__Email__c = 'testuser@Chase.com';
        MatrixUserObj.VEN3__Username__c = 'Chaseuser123@aChase.com';
        MatrixUserObj.VEN3__Password__c = 'ChaseUser@123';
        MatrixUserObj.VEN3__Program_Partner__c = ProgramPartnerObj.Id;
        insert MatrixUserObj;

        Test.startTest();
        VendorGuestCalculatorController.UserDetailsStatusWrapper returnedValidUser = VendorGuestCalculatorController.authenticateUser_Apex(MatrixUserObj.VEN3__Username__c, MatrixUserObj.VEN3__Password__c);
        system.assertEquals(returnedValidUser.status,'InActive User');
        Test.stopTest();
    }

    @isTest static void authenticateUserWithInvalidUser_Test(){
        VEN3__Program_Partner__c ProgramPartnerObj = new VEN3__Program_Partner__c();
        ProgramPartnerObj.Name = 'Test Program Partner';
        ProgramPartnerObj.VEN3__Active__c = true;
        ProgramPartnerObj.VEN3__Goods_Type__c = 'Test Good1,Test Good2';
        ProgramPartnerObj.VEN3__Address__c = 'AUS';
        insert ProgramPartnerObj;

        VEN3__Vendor_Guest_User__c MatrixUserObj = new VEN3__Vendor_Guest_User__c();
        MatrixUserObj.Name = 'Test Chase User';
        MatrixUserObj.VEN3__Email__c = 'testuser@Chase.com';
        MatrixUserObj.VEN3__Username__c = 'matrixuser123@amatrix.com';
        MatrixUserObj.VEN3__Password__c = 'MatrixUser@123';
        MatrixUserObj.VEN3__Program_Partner__c = ProgramPartnerObj.Id;
        insert MatrixUserObj;

        Test.startTest();
        VendorGuestCalculatorController.UserDetailsStatusWrapper returnedInvalidUser = VendorGuestCalculatorController.authenticateUser_Apex('test@matrix.xom', 'test@123');
        system.assertEquals(returnedInvalidUser.status,'Invalid User');
        Test.stopTest();
    }

    @isTest static void authenticateUserWithNullValues_Test(){
        Test.startTest();
        VendorGuestCalculatorController.UserDetailsStatusWrapper returnedNoUser = VendorGuestCalculatorController.authenticateUser_Apex(null, null);
        system.assertEquals(returnedNoUser,null);
        Test.stopTest();
    }

    @isTest static void getRelatedRecords_Test(){
        Id RecordTypeId = Schema.SObjectType.VEN3__Calculator__c.getRecordTypeInfosByName().get('Chase Finance').getRecordTypeId();
        VEN3__Program_Partner__c ProgramPartnerObj = new VEN3__Program_Partner__c();
        ProgramPartnerObj.Name = 'Test Program Partner';
        ProgramPartnerObj.VEN3__Active__c = true;
        ProgramPartnerObj.VEN3__Goods_Type__c = 'Test Good1,Test Good2';
        ProgramPartnerObj.VEN3__Address__c = 'AUS';
        insert ProgramPartnerObj;

        VEN3__Vendor_Guest_User__c MatrixUserObj = new VEN3__Vendor_Guest_User__c();
        MatrixUserObj.Name = 'Test Matrix User';
        MatrixUserObj.VEN3__Email__c = 'testuser@matrix.com';
        MatrixUserObj.VEN3__Username__c = 'matrixuser123@amatrix.com';
        MatrixUserObj.VEN3__Password__c = 'MatrixUser@123';
        MatrixUserObj.VEN3__Program_Partner__c = ProgramPartnerObj.Id;
        insert MatrixUserObj;

        Lead leadObj = new Lead();
        leadObj.FirstName = 'Test';
        leadObj.LastName = 'Lead';
        leadObj.VEN3__Date__c = system.today();
        leadObj.VEN3__Vendor_Guest_User__c = MatrixUserObj.Id;
        leadObj.Status = 'Working - Contacted';
        leadObj.Company = 'CD';
        insert leadObj;

        List<VEN3__Calculator__c> calcList = new List<VEN3__Calculator__c>();
        for(Integer i = 1; i <= 10; i++){
            VEN3__Calculator__c calcObj = new VEN3__Calculator__c();
            calcObj.Name = 'Test Customer - '+i;
            calcObj.RecordTypeId = RecordTypeId;
            calcObj.VEN3__Lead__c = leadObj.Id;
            calcObj.VEN3__Program_Partner_L__c = ProgramPartnerObj.Id;
            calcObj.VEN3__Payments_to_Own__c = 5000;
            calcObj.VEN3__Loan_Facility_Type__c = 'Chattel Mortgage';
            calcObj.VEN3__Repayment_Type__c = 'Advanced';
            calcObj.VEN3__State__c = 'AUS';
            calcObj.VEN3__Repayment_Frequency__c = 'Monthly';
            calcObj.VEN3__Goods_Type__c = 'Agriculture';
            calcObj.VEN3__Repayment_Expected_c__c = 2500;
            calcObj.VEN3__Amount_Financed__c = 45990;
            calcList.add(calcObj);
        }
        Test.startTest();
        insert calcList;
        VendorGuestCalculatorController.leadCalculatorWrapper returnedLeadCalWrapper= VendorGuestCalculatorController.getRelatedRecords_Apex(ProgramPartnerObj.Id);
        system.assertEquals(returnedLeadCalWrapper.leadList.size(),1);
        system.assertEquals(returnedLeadCalWrapper.leadList[0].VEN3__Vendor_Guest_User__c,MatrixUserObj.Id);
        system.assertEquals(returnedLeadCalWrapper.leadList[0].VEN3__Date__c,system.today());
        system.assertEquals(returnedLeadCalWrapper.leadList[0].Company,'CD');
        system.assertEquals(returnedLeadCalWrapper.calcList.size(),10);
        system.assertEquals(returnedLeadCalWrapper.calcList[0].Name,'Test Customer - 1');
        system.assertEquals(returnedLeadCalWrapper.calcList[0].VEN3__Program_Partner_L__c,ProgramPartnerObj.Id);
        system.assertEquals(returnedLeadCalWrapper.calcList[0].VEN3__Lead__c,leadObj.Id);
        system.assertEquals(returnedLeadCalWrapper.calcList[9].Name,'Test Customer - 10');
        system.assertEquals(returnedLeadCalWrapper.calcList[9].VEN3__Program_Partner_L__c,ProgramPartnerObj.Id);
        system.assertEquals(returnedLeadCalWrapper.calcList[9].VEN3__Lead__c,leadObj.Id);
        Test.stopTest();
    }

    @isTest static void getRelatedRecordsWithNullValues_Test(){
        Test.startTest();
        VendorGuestCalculatorController.leadCalculatorWrapper returnedLeadCalWrapper= VendorGuestCalculatorController.getRelatedRecords_Apex(null);
        system.assertEquals(returnedLeadCalWrapper,null);
        Test.stopTest();
    }
}