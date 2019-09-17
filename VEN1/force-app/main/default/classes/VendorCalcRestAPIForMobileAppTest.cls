@IsTest 
private class VendorCalcRestAPIForMobileAppTest {

    @isTest
    private static void doPost_Test(){
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        insert l;
        
        Program_Partner__c partner = new Program_Partner__c();
		 partner.Name = 'Telstra';
		 partner.Goods_Type__c = 'Telecommunications';
		 insert partner;
        
        Calculator__c calc = new Calculator__c();
		 calc.Name = 'TestRJ';
		 calc.Amount_Financed__c = 42000;
		 calc.Ballon__c = 5.00;
		 calc.Balloon_c__c = 2100;
		 calc.Customer_Rate_Expected__c = 3.3;
		 calc.Customer_Rate_Non_Published__c = 3.3;
		 calc.Date__c = Date.today();
		 calc.Desired_Brokerage_Incl_GST_c__c = 1234.22;
		 calc.Desired_Brokerage_Incl_GST_p__c = 3.2;
		 calc.Goods_Type__c = 'Trucks ( New - 3 yrs old )';
		 calc.Incl_GST_c__c = 1233.22;
		 calc.Loan_Facility_Type__c = 'Chattel Mortgage';
		 calc.Please_enter_your_desired_Base_Rate_here__c = 3.3;
		 calc.Published_Base_Rate__c = 3.3;
		 calc.Repayment_Expected_c__c = 1222.02;
		 calc.Repayment_Non_Published__c = 1235.32;
		 calc.Repayment_Frequency__c = 'Yearly';
		 calc.Repayment_Type__c = 'Advance';
		 calc.State__c = 'WA';
		 calc.Term_months__c = 45;
		 calc.Total_Incl_GST_c__c = 1386.00;
		 calc.PPSR_Fees_Disclosed__c = 1386.00;
		 calc.Fees_Other_Disclosed__c = 1386.00;
		 calc.Document_Fee_Disclosed__c = 1386.00;
		// calc.Program_Partner__c = partner.Id;
		 calc.Program_Partner_L__c = partner.Id;
	  //   calc.Program_Partner_L__r = partner.Name;
		 insert calc;
        
        VEN3__Vendor_Guest_User__c MatrixUserObj = new VEN3__Vendor_Guest_User__c();
		MatrixUserObj.Name = 'Test Matrix User';
		MatrixUserObj.VEN3__Email__c = 'testuser@Chase.com';
		MatrixUserObj.VEN3__Username__c = 'Chaseuser123@aChase.com';
		MatrixUserObj.VEN3__Password__c = 'ChaseUser@123';
		MatrixUserObj.VEN3__Program_Partner__c = partner.Id;
		insert MatrixUserObj;
        
        Id RecId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Chase Vendor').getRecordTypeId();
        
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/services/apexrest/VEN3/VendorCalc';
        request.httpMethod = 'POST';
		//request.requestBody = Blob.valueof(myJSON);
		VendorCalcRestAPIForMobileApp.DataWrapper dp = new VendorCalcRestAPIForMobileApp.DataWrapper();
        dp.username = 'sarthak@cd.com';
        dp.password = 'sarthat';
        dp.name = 'sarthat';
        dp.email = 'sarthak@cd.com';
        dp.method = 'registration';
        dp.vendorUserId = MatrixUserObj.Id;
        dp.LeadId = l.Id;
        dp.Term = '24';
        dp.FacilityType = 'Chattel Mortgare';
        dp.ProgramPartnerId = partner.Id;
        dp.CalculatorRecordId = calc.Id;
        dp.ObjectName = 'Lead';
        dp.RecordTypeName = 'Chase Vendor';
        dp.Company = 'CD';
        dp.GuestUserId = MatrixUserObj.Id;
        dp.MobilePhone = '123456';
        dp.FirstName = 'sarthak';
        dp.LastName = 'saxena';
        dp.Status = 'Follow-Up Request';
        dp.EmailTemplateName = 'test';
        dp.CalcName = 'test';
        dp.CalcPaymentToOwn = 2;
        dp.CalcLoanFacilityType = 'test';
        dp.CalcState = 'test';
        dp.CalcProgramPartner = 'test';
        dp.CalcAmountFinanced = 15000;
        dp.CalcGoodsType = 'Yellow Goods';
        dp.CalcRepaymentType = 'test';
        dp.CalcRepaymentExpected = 15000;
        dp.CalcFeesDisclosed = 450;
        Boolean establishment = true;
        dp.CalcEstablishmentFeeFinanced = establishment;
        dp.CalcFeesFinanced = establishment;
        dp.CalcEstablishmentFeeDisclosed = 500;
        
        String myJSON = JSON.serialize(dp);
        request.requestBody = Blob.valueof(myJSON);
        request.params.put('username','sarthak@cd.com');
        request.params.put('password','sarthak');
        request.params.put('method','login');
        
        RestContext.request = request;
        RestContext.response = res;
        
        Test.startTest();
        VendorCalcRestAPIForMobileApp.doGet();
        VendorCalcRestAPIForMobileApp.doPost();
        Test.stopTest();
        
        //system.assert(leadList !=null);
    }
    @isTest
    public static void doPost2_Test(){
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        insert l;
        
        Program_Partner__c partner = new Program_Partner__c();
		 partner.Name = 'Telstra';
		 partner.Goods_Type__c = 'Telecommunications';
		 insert partner;
        
        Calculator__c calc = new Calculator__c();
		 calc.Name = 'TestRJ';
		 calc.Amount_Financed__c = 42000;
		 calc.Ballon__c = 5.00;
		 calc.Balloon_c__c = 2100;
		 calc.Customer_Rate_Expected__c = 3.3;
		 calc.Customer_Rate_Non_Published__c = 3.3;
		 calc.Date__c = Date.today();
		 calc.Desired_Brokerage_Incl_GST_c__c = 1234.22;
		 calc.Desired_Brokerage_Incl_GST_p__c = 3.2;
		 calc.Goods_Type__c = 'Trucks ( New - 3 yrs old )';
		 calc.Incl_GST_c__c = 1233.22;
		 calc.Loan_Facility_Type__c = 'Chattel Mortgage';
		 calc.Please_enter_your_desired_Base_Rate_here__c = 3.3;
		 calc.Published_Base_Rate__c = 3.3;
		 calc.Repayment_Expected_c__c = 1222.02;
		 calc.Repayment_Non_Published__c = 1235.32;
		 calc.Repayment_Frequency__c = 'Yearly';
		 calc.Repayment_Type__c = 'Advance';
		 calc.State__c = 'WA';
		 calc.Term_months__c = 45;
		 calc.Total_Incl_GST_c__c = 1386.00;
		 calc.PPSR_Fees_Disclosed__c = 1386.00;
		 calc.Fees_Other_Disclosed__c = 1386.00;
		 calc.Document_Fee_Disclosed__c = 1386.00;
		// calc.Program_Partner__c = partner.Id;
		 calc.Program_Partner_L__c = partner.Id;
	  //   calc.Program_Partner_L__r = partner.Name;
		 insert calc;
        
        VEN3__Vendor_Guest_User__c MatrixUserObj = new VEN3__Vendor_Guest_User__c();
		MatrixUserObj.Name = 'Test Matrix User';
		MatrixUserObj.VEN3__Email__c = 'testuser@Chase.com';
		MatrixUserObj.VEN3__Username__c = 'Chaseuser123@aChase.com';
		MatrixUserObj.VEN3__Password__c = 'ChaseUser@123';
		MatrixUserObj.VEN3__Program_Partner__c = partner.Id;
		insert MatrixUserObj;
        
        Id RecId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Chase Vendor').getRecordTypeId();
       
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/services/apexrest/VEN3/VendorCalc';
        request.httpMethod = 'POST';
		//request.requestBody = Blob.valueof(myJSON);
		VendorCalcRestAPIForMobileApp.DataWrapper dp = new VendorCalcRestAPIForMobileApp.DataWrapper();
        dp.username = 'sarthak@cd.com';
        dp.password = 'sarthat';
        dp.name = 'sarthat';
        dp.email = 'sarthak@cd.com';
        dp.method = 'login';
        dp.vendorUserId = MatrixUserObj.Id;
        dp.LeadId = l.Id;
        dp.Term = '24';
        dp.FacilityType = 'Chattel Mortgare';
        dp.ProgramPartnerId = partner.Id;
        dp.CalculatorRecordId = calc.Id;
        dp.ObjectName = 'Lead';
        dp.RecordTypeName = 'Chase Vendor';
        dp.Company = 'CD';
        dp.GuestUserId = MatrixUserObj.Id;
        dp.MobilePhone = '123456';
        dp.FirstName = 'sarthak';
        dp.LastName = 'saxena';
        dp.Status = 'Follow-Up Request';
        dp.EmailTemplateName = 'test';
        dp.CalcName = 'test';
        dp.CalcPaymentToOwn = 2;
        dp.CalcLoanFacilityType = 'test';
        dp.CalcState = 'test';
        dp.CalcProgramPartner = 'test';
        dp.CalcAmountFinanced = 15000;
        dp.CalcGoodsType = 'Yellow Goods';
        dp.CalcRepaymentType = 'test';
        dp.CalcRepaymentExpected = 15000;
        dp.CalcFeesDisclosed = 450;
        Boolean establishment = true;
        dp.CalcEstablishmentFeeFinanced = establishment;
        dp.CalcFeesFinanced = establishment;
        dp.CalcEstablishmentFeeDisclosed = 500;
        
        String myJSON = JSON.serialize(dp);
        request.requestBody = Blob.valueof(myJSON);
        request.params.put('username','sarthak@cd.com');
        request.params.put('password','sarthak');
        request.params.put('method','registration');
        
        RestContext.request = request;
        RestContext.response = res;
        
        Test.startTest();
        VendorCalcRestAPIForMobileApp.doGet();
        VendorCalcRestAPIForMobileApp.doPost();
        Test.stopTest();
        
        //system.assert(leadList !=null);
    }
    @isTest
    public static void doPost3_Test(){
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        insert l;
        
        Program_Partner__c partner = new Program_Partner__c();
		 partner.Name = 'Telstra';
		 partner.Goods_Type__c = 'Telecommunications';
		 insert partner;
        
        Calculator__c calc = new Calculator__c();
		 calc.Name = 'TestRJ';
		 calc.Amount_Financed__c = 42000;
		 calc.Ballon__c = 5.00;
		 calc.Balloon_c__c = 2100;
		 calc.Customer_Rate_Expected__c = 3.3;
		 calc.Customer_Rate_Non_Published__c = 3.3;
		 calc.Date__c = Date.today();
		 calc.Desired_Brokerage_Incl_GST_c__c = 1234.22;
		 calc.Desired_Brokerage_Incl_GST_p__c = 3.2;
		 calc.Goods_Type__c = 'Trucks ( New - 3 yrs old )';
		 calc.Incl_GST_c__c = 1233.22;
		 calc.Loan_Facility_Type__c = 'Chattel Mortgage';
		 calc.Please_enter_your_desired_Base_Rate_here__c = 3.3;
		 calc.Published_Base_Rate__c = 3.3;
		 calc.Repayment_Expected_c__c = 1222.02;
		 calc.Repayment_Non_Published__c = 1235.32;
		 calc.Repayment_Frequency__c = 'Yearly';
		 calc.Repayment_Type__c = 'Advance';
		 calc.State__c = 'WA';
		 calc.Term_months__c = 45;
		 calc.Total_Incl_GST_c__c = 1386.00;
		 calc.PPSR_Fees_Disclosed__c = 1386.00;
		 calc.Fees_Other_Disclosed__c = 1386.00;
		 calc.Document_Fee_Disclosed__c = 1386.00;
		// calc.Program_Partner__c = partner.Id;
		 calc.Program_Partner_L__c = partner.Id;
	  //   calc.Program_Partner_L__r = partner.Name;
		 insert calc;
        
        VEN3__Vendor_Guest_User__c MatrixUserObj = new VEN3__Vendor_Guest_User__c();
		MatrixUserObj.Name = 'Test Matrix User';
		MatrixUserObj.VEN3__Email__c = 'testuser@Chase.com';
		MatrixUserObj.VEN3__Username__c = 'Chaseuser123@aChase.com';
		MatrixUserObj.VEN3__Password__c = 'ChaseUser@123';
		MatrixUserObj.VEN3__Program_Partner__c = partner.Id;
		insert MatrixUserObj;
        
        Id RecId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Chase Vendor').getRecordTypeId();
       
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/services/apexrest/VEN3/VendorCalc';
        request.httpMethod = 'POST';
        VendorCalcRestAPIForMobileApp.DataWrapper dp = new VendorCalcRestAPIForMobileApp.DataWrapper();
        dp.username = 'sarthak@cd.com';
        dp.password = 'sarthat';
        dp.name = 'sarthat';
        dp.email = 'sarthak@cd.com';
        dp.method = 'registration';
        dp.vendorUserId = MatrixUserObj.Id;
        dp.LeadId = l.Id;
        dp.Term = '24';
        dp.FacilityType = 'Chattel Mortgare';
        dp.ProgramPartnerId = partner.Id;
        dp.CalculatorRecordId = calc.Id;
        dp.ObjectName = 'Lead';
        dp.RecordTypeName = 'Chase Vendor';
        dp.Company = 'CD';
        dp.GuestUserId = MatrixUserObj.Id;
        dp.MobilePhone = '123456';
        dp.FirstName = 'sarthak';
        dp.LastName = 'saxena';
        dp.Status = 'Follow-Up Request';
        dp.EmailTemplateName = 'test';
        dp.CalcName = 'test';
        dp.CalcPaymentToOwn = 2;
        dp.CalcLoanFacilityType = 'test';
        dp.CalcState = 'test';
        dp.CalcProgramPartner = 'test';
        dp.CalcAmountFinanced = 15000;
        dp.CalcGoodsType = 'Yellow Goods';
        dp.CalcRepaymentType = 'test';
        dp.CalcRepaymentExpected = 15000;
        dp.CalcFeesDisclosed = 450;
        Boolean establishment = true;
        dp.CalcEstablishmentFeeFinanced = establishment;
        dp.CalcFeesFinanced = establishment;
        dp.CalcEstablishmentFeeDisclosed = 500;
        
        String myJSON = JSON.serialize(dp);
        request.requestBody = Blob.valueof(myJSON);
        request.params.put('username','');
        
        RestContext.request = request;
        RestContext.response = res;
        Test.startTest();
        VendorCalcRestAPIForMobileApp.doPost();
        Test.stopTest();
    }
    
    @isTest
    public static void miscellaneousTest () {
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        insert l;
        
        Program_Partner__c partner = new Program_Partner__c();
		 partner.Name = 'Telstra';
		 partner.Goods_Type__c = 'Telecommunications';
		 insert partner;
        
        Calculator__c calc = new Calculator__c();
		 calc.Name = 'TestRJ';
		 calc.Amount_Financed__c = 42000;
		 calc.Ballon__c = 5.00;
		 calc.Balloon_c__c = 2100;
		 calc.Customer_Rate_Expected__c = 3.3;
		 calc.Customer_Rate_Non_Published__c = 3.3;
		 calc.Date__c = Date.today();
		 calc.Desired_Brokerage_Incl_GST_c__c = 1234.22;
		 calc.Desired_Brokerage_Incl_GST_p__c = 3.2;
		 calc.Goods_Type__c = 'Trucks ( New - 3 yrs old )';
		 calc.Incl_GST_c__c = 1233.22;
		 calc.Loan_Facility_Type__c = 'Chattel Mortgage';
		 calc.Please_enter_your_desired_Base_Rate_here__c = 3.3;
		 calc.Published_Base_Rate__c = 3.3;
		 calc.Repayment_Expected_c__c = 1222.02;
		 calc.Repayment_Non_Published__c = 1235.32;
		 calc.Repayment_Frequency__c = 'Yearly';
		 calc.Repayment_Type__c = 'Advance';
		 calc.State__c = 'WA';
		 calc.Term_months__c = 45;
		 calc.Total_Incl_GST_c__c = 1386.00;
		 calc.PPSR_Fees_Disclosed__c = 1386.00;
		 calc.Fees_Other_Disclosed__c = 1386.00;
		 calc.Document_Fee_Disclosed__c = 1386.00;
		// calc.Program_Partner__c = partner.Id;
		 calc.Program_Partner_L__c = partner.Id;
	  //   calc.Program_Partner_L__r = partner.Name;
		 insert calc;
        
        VEN3__Vendor_Guest_User__c MatrixUserObj = new VEN3__Vendor_Guest_User__c();
		MatrixUserObj.Name = 'Test Matrix User';
		MatrixUserObj.VEN3__Email__c = 'testuser@Chase.com';
		MatrixUserObj.VEN3__Username__c = 'sarthak@cd.com';
		MatrixUserObj.VEN3__Password__c = 'sarthat';
		MatrixUserObj.VEN3__Program_Partner__c = partner.Id;
        MatrixUserObj.VEN3__isActive__c = true;
		insert MatrixUserObj;
        
       
        Id RecId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Chase Vendor').getRecordTypeId();
       // Id CalcRecId = Schema.SObjectType.Calculator__c.getRecordTypeInfosByName().get('Supplier Quote').getRecordTypeId();
        
                    
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/services/apexrest/VEN3/VendorCalc';
        request.httpMethod = 'POST';
		//request.requestBody = Blob.valueof(myJSON);
		VendorCalcRestAPIForMobileApp.DataWrapper dp = new VendorCalcRestAPIForMobileApp.DataWrapper();
        dp.username = 'sarthak@cd.com';
        dp.password = 'sarthat';
        dp.name = 'sarthat';
        dp.email = 'sarthak@cd.com';
        dp.method = 'getCalculationRecord';
        dp.vendorUserId = MatrixUserObj.Id;
        dp.LeadId = l.Id;
        dp.Term = '24';
        dp.FacilityType = 'Chattel Mortgare';
        dp.ProgramPartnerId = partner.Id;
        dp.CalculatorRecordId = calc.Id;
        dp.ObjectName = 'Lead';
        dp.RecordTypeName = 'Chase Vendor';
        dp.Company = 'CD';
        dp.GuestUserId = MatrixUserObj.Id;
        dp.MobilePhone = '123456';
        dp.FirstName = 'sarthak';
        dp.LastName = 'saxena';
        dp.Status = 'Follow-Up Request';
        dp.EmailTemplateName = 'test';
        dp.CalcName = 'test';
        dp.CalcPaymentToOwn = 2;
        dp.CalcLoanFacilityType = 'test';
        dp.CalcState = 'test';
        dp.CalcProgramPartner = 'test';
        dp.CalcAmountFinanced = 15000;
        dp.CalcGoodsType = 'Yellow Goods';
        dp.CalcRepaymentType = 'test';
        dp.CalcRepaymentExpected = 15000;
        dp.CalcFeesDisclosed = 450;
        Boolean establishment = true;
        dp.CalcEstablishmentFeeFinanced = establishment;
        dp.CalcFeesFinanced = establishment;
        dp.CalcEstablishmentFeeDisclosed = 500;
        
        String myJSON = JSON.serialize(dp);
        request.requestBody = Blob.valueof(myJSON);
        request.params.put('username','sarthak@cd.com');
        request.params.put('password','sarthak');
        request.params.put('method','login');
        
        RestContext.request = request;
        RestContext.response = res;
        
        Test.startTest();
        VendorCalcRestAPIForMobileApp.doPost();
        Test.stopTest();
    }
    @isTest
    public static void miscellaneousTest2 () {
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        insert l;
        
        Program_Partner__c partner = new Program_Partner__c();
		 partner.Name = 'Telstra';
		 partner.Goods_Type__c = 'Telecommunications';
		 insert partner;
        
        Calculator__c calc = new Calculator__c();
		 calc.Name = 'TestRJ';
		 calc.Amount_Financed__c = 42000;
		 calc.Ballon__c = 5.00;
		 calc.Balloon_c__c = 2100;
		 calc.Customer_Rate_Expected__c = 3.3;
		 calc.Customer_Rate_Non_Published__c = 3.3;
		 calc.Date__c = Date.today();
		 calc.Desired_Brokerage_Incl_GST_c__c = 1234.22;
		 calc.Desired_Brokerage_Incl_GST_p__c = 3.2;
		 calc.Goods_Type__c = 'Trucks ( New - 3 yrs old )';
		 calc.Incl_GST_c__c = 1233.22;
		 calc.Loan_Facility_Type__c = 'Chattel Mortgage';
		 calc.Please_enter_your_desired_Base_Rate_here__c = 3.3;
		 calc.Published_Base_Rate__c = 3.3;
		 calc.Repayment_Expected_c__c = 1222.02;
		 calc.Repayment_Non_Published__c = 1235.32;
		 calc.Repayment_Frequency__c = 'Yearly';
		 calc.Repayment_Type__c = 'Advance';
		 calc.State__c = 'WA';
		 calc.Term_months__c = 45;
		 calc.Total_Incl_GST_c__c = 1386.00;
		 calc.PPSR_Fees_Disclosed__c = 1386.00;
		 calc.Fees_Other_Disclosed__c = 1386.00;
		 calc.Document_Fee_Disclosed__c = 1386.00;
		// calc.Program_Partner__c = partner.Id;
		 calc.Program_Partner_L__c = partner.Id;
	  //   calc.Program_Partner_L__r = partner.Name;
		 insert calc;
        
        VEN3__Vendor_Guest_User__c MatrixUserObj = new VEN3__Vendor_Guest_User__c();
		MatrixUserObj.Name = 'Test Matrix User';
		MatrixUserObj.VEN3__Email__c = 'testuser@Chase.com';
		MatrixUserObj.VEN3__Username__c = 'sarthak@cd.com';
		MatrixUserObj.VEN3__Password__c = 'sarthat';
		MatrixUserObj.VEN3__Program_Partner__c = partner.Id;
        MatrixUserObj.VEN3__isActive__c = true;
		insert MatrixUserObj;
        
       
        Id RecId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Chase Vendor').getRecordTypeId();
       // Id CalcRecId = Schema.SObjectType.Calculator__c.getRecordTypeInfosByName().get('Supplier Quote').getRecordTypeId();
        
                    
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/services/apexrest/VEN3/VendorCalc';
        request.httpMethod = 'POST';
		//request.requestBody = Blob.valueof(myJSON);
		VendorCalcRestAPIForMobileApp.DataWrapper dp = new VendorCalcRestAPIForMobileApp.DataWrapper();
        dp.username = 'sarthak@cd.com';
        dp.password = 'sarthat';
        dp.name = 'sarthat';
        dp.email = 'sarthak@cd.com';
        dp.method = 'getCalculatorSetting';
        dp.vendorUserId = MatrixUserObj.Id;
        dp.LeadId = l.Id;
        dp.Term = '24';
        dp.FacilityType = 'Chattel Mortgare';
        dp.ProgramPartnerId = partner.Id;
        dp.CalculatorRecordId = calc.Id;
        dp.ObjectName = 'Lead';
        dp.RecordTypeName = 'Chase Vendor';
        dp.Company = 'CD';
        dp.GuestUserId = MatrixUserObj.Id;
        dp.MobilePhone = '123456';
        dp.FirstName = 'sarthak';
        dp.LastName = 'saxena';
        dp.Status = 'Follow-Up Request';
        dp.EmailTemplateName = 'test';
        dp.CalcName = 'test';
        dp.CalcPaymentToOwn = 2;
        dp.CalcLoanFacilityType = 'test';
        dp.CalcState = 'test';
        dp.CalcProgramPartner = 'test';
        dp.CalcAmountFinanced = 15000;
        dp.CalcGoodsType = 'Yellow Goods';
        dp.CalcRepaymentType = 'test';
        dp.CalcRepaymentExpected = 15000;
        dp.CalcFeesDisclosed = 450;
        Boolean establishment = true;
        dp.CalcEstablishmentFeeFinanced = establishment;
        dp.CalcFeesFinanced = establishment;
        dp.CalcEstablishmentFeeDisclosed = 500;
        
        String myJSON = JSON.serialize(dp);
        request.requestBody = Blob.valueof(myJSON);
        request.params.put('username','sarthak@cd.com');
        request.params.put('password','sarthak');
        request.params.put('method','login');
        
        RestContext.request = request;
        RestContext.response = res;
        
        Test.startTest();
        VendorCalcRestAPIForMobileApp.doPost();
        Test.stopTest();
    }
    @isTest
    public static void miscellaneousTest3 () {
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        insert l;
        
        Program_Partner__c partner = new Program_Partner__c();
		 partner.Name = 'Telstra';
		 partner.Goods_Type__c = 'Telecommunications';
		 insert partner;
        
        Calculator__c calc = new Calculator__c();
		 calc.Name = 'TestRJ';
		 calc.Amount_Financed__c = 42000;
		 calc.Ballon__c = 5.00;
		 calc.Balloon_c__c = 2100;
		 calc.Customer_Rate_Expected__c = 3.3;
		 calc.Customer_Rate_Non_Published__c = 3.3;
		 calc.Date__c = Date.today();
		 calc.Desired_Brokerage_Incl_GST_c__c = 1234.22;
		 calc.Desired_Brokerage_Incl_GST_p__c = 3.2;
		 calc.Goods_Type__c = 'Trucks ( New - 3 yrs old )';
		 calc.Incl_GST_c__c = 1233.22;
		 calc.Loan_Facility_Type__c = 'Chattel Mortgage';
		 calc.Please_enter_your_desired_Base_Rate_here__c = 3.3;
		 calc.Published_Base_Rate__c = 3.3;
		 calc.Repayment_Expected_c__c = 1222.02;
		 calc.Repayment_Non_Published__c = 1235.32;
		 calc.Repayment_Frequency__c = 'Yearly';
		 calc.Repayment_Type__c = 'Advance';
		 calc.State__c = 'WA';
		 calc.Term_months__c = 45;
		 calc.Total_Incl_GST_c__c = 1386.00;
		 calc.PPSR_Fees_Disclosed__c = 1386.00;
		 calc.Fees_Other_Disclosed__c = 1386.00;
		 calc.Document_Fee_Disclosed__c = 1386.00;
		// calc.Program_Partner__c = partner.Id;
		 calc.Program_Partner_L__c = partner.Id;
	  //   calc.Program_Partner_L__r = partner.Name;
		 insert calc;
        
        VEN3__Vendor_Guest_User__c MatrixUserObj = new VEN3__Vendor_Guest_User__c();
		MatrixUserObj.Name = 'Test Matrix User';
		MatrixUserObj.VEN3__Email__c = 'testuser@Chase.com';
		MatrixUserObj.VEN3__Username__c = 'sarthak@cd.com';
		MatrixUserObj.VEN3__Password__c = 'sarthat';
		MatrixUserObj.VEN3__Program_Partner__c = partner.Id;
        MatrixUserObj.VEN3__isActive__c = true;
		insert MatrixUserObj;
        
       
        Id RecId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Chase Vendor').getRecordTypeId();
       // Id CalcRecId = Schema.SObjectType.Calculator__c.getRecordTypeInfosByName().get('Supplier Quote').getRecordTypeId();
        
                    
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/services/apexrest/VEN3/VendorCalc';
        request.httpMethod = 'POST';
		//request.requestBody = Blob.valueof(myJSON);
		VendorCalcRestAPIForMobileApp.DataWrapper dp = new VendorCalcRestAPIForMobileApp.DataWrapper();
        dp.username = 'sarthak@cd.com';
        dp.password = 'sarthat';
        dp.name = 'sarthat';
        dp.email = 'sarthak@cd.com';
        dp.method = 'getParticularCalculatorRecord';
        dp.vendorUserId = MatrixUserObj.Id;
        dp.LeadId = l.Id;
        dp.Term = '24';
        dp.FacilityType = 'Chattel Mortgare';
        dp.ProgramPartnerId = partner.Id;
        dp.CalculatorRecordId = calc.Id;
        dp.ObjectName = 'Lead';
        dp.RecordTypeName = 'Chase Vendor';
        dp.Company = 'CD';
        dp.GuestUserId = MatrixUserObj.Id;
        dp.MobilePhone = '123456';
        dp.FirstName = 'sarthak';
        dp.LastName = 'saxena';
        dp.Status = 'Follow-Up Request';
        dp.EmailTemplateName = 'test';
        dp.CalcName = 'test';
        dp.CalcPaymentToOwn = 2;
        dp.CalcLoanFacilityType = 'test';
        dp.CalcState = 'test';
        dp.CalcProgramPartner = 'test';
        dp.CalcAmountFinanced = 15000;
        dp.CalcGoodsType = 'Yellow Goods';
        dp.CalcRepaymentType = 'test';
        dp.CalcRepaymentExpected = 15000;
        dp.CalcFeesDisclosed = 450;
        Boolean establishment = true;
        dp.CalcEstablishmentFeeFinanced = establishment;
        dp.CalcFeesFinanced = establishment;
        dp.CalcEstablishmentFeeDisclosed = 500;
        
        String myJSON = JSON.serialize(dp);
        request.requestBody = Blob.valueof(myJSON);
        request.params.put('username','sarthak@cd.com');
        request.params.put('password','sarthak');
        request.params.put('method','login');
        
        RestContext.request = request;
        RestContext.response = res;
        
        Test.startTest();
        VendorCalcRestAPIForMobileApp.doPost();
        Test.stopTest();
    }
    @isTest
    public static void miscellaneousTest4 () {
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        insert l;
        
        Program_Partner__c partner = new Program_Partner__c();
		 partner.Name = 'Telstra';
		 partner.Goods_Type__c = 'Telecommunications';
		 insert partner;
        
        Calculator__c calc = new Calculator__c();
		 calc.Name = 'TestRJ';
		 calc.Amount_Financed__c = 42000;
		 calc.Ballon__c = 5.00;
		 calc.Balloon_c__c = 2100;
		 calc.Customer_Rate_Expected__c = 3.3;
		 calc.Customer_Rate_Non_Published__c = 3.3;
		 calc.Date__c = Date.today();
		 calc.Desired_Brokerage_Incl_GST_c__c = 1234.22;
		 calc.Desired_Brokerage_Incl_GST_p__c = 3.2;
		 calc.Goods_Type__c = 'Trucks ( New - 3 yrs old )';
		 calc.Incl_GST_c__c = 1233.22;
		 calc.Loan_Facility_Type__c = 'Chattel Mortgage';
		 calc.Please_enter_your_desired_Base_Rate_here__c = 3.3;
		 calc.Published_Base_Rate__c = 3.3;
		 calc.Repayment_Expected_c__c = 1222.02;
		 calc.Repayment_Non_Published__c = 1235.32;
		 calc.Repayment_Frequency__c = 'Yearly';
		 calc.Repayment_Type__c = 'Advance';
		 calc.State__c = 'WA';
		 calc.Term_months__c = 45;
		 calc.Total_Incl_GST_c__c = 1386.00;
		 calc.PPSR_Fees_Disclosed__c = 1386.00;
		 calc.Fees_Other_Disclosed__c = 1386.00;
		 calc.Document_Fee_Disclosed__c = 1386.00;
		// calc.Program_Partner__c = partner.Id;
		 calc.Program_Partner_L__c = partner.Id;
	  //   calc.Program_Partner_L__r = partner.Name;
		 insert calc;
        
        VEN3__Vendor_Guest_User__c MatrixUserObj = new VEN3__Vendor_Guest_User__c();
		MatrixUserObj.Name = 'Test Matrix User';
		MatrixUserObj.VEN3__Email__c = 'testuser@Chase.com';
		MatrixUserObj.VEN3__Username__c = 'sarthak@cd.com';
		MatrixUserObj.VEN3__Password__c = 'sarthat';
		MatrixUserObj.VEN3__Program_Partner__c = partner.Id;
        MatrixUserObj.VEN3__isActive__c = true;
		insert MatrixUserObj;
        
       
        Id RecId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Chase Vendor').getRecordTypeId();
       // Id CalcRecId = Schema.SObjectType.Calculator__c.getRecordTypeInfosByName().get('Supplier Quote').getRecordTypeId();
        
                    
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='/services/apexrest/VEN3/VendorCalc';
        request.httpMethod = 'POST';
		//request.requestBody = Blob.valueof(myJSON);
		VendorCalcRestAPIForMobileApp.DataWrapper dp = new VendorCalcRestAPIForMobileApp.DataWrapper();
        dp.username = 'sarthak@cd.com';
        dp.password = 'sarthat';
        dp.name = 'sarthat';
        dp.email = 'sarthak@cd.com';
        dp.method = 'getEmailTemplate';
        dp.vendorUserId = MatrixUserObj.Id;
        dp.LeadId = l.Id;
        dp.Term = '24';
        dp.FacilityType = 'Chattel Mortgare';
        dp.ProgramPartnerId = partner.Id;
        dp.CalculatorRecordId = calc.Id;
        dp.ObjectName = 'Lead';
        dp.RecordTypeName = 'Chase Vendor';
        dp.Company = 'CD';
        dp.GuestUserId = MatrixUserObj.Id;
        dp.MobilePhone = '123456';
        dp.FirstName = 'sarthak';
        dp.LastName = 'saxena';
        dp.Status = 'Follow-Up Request';
        dp.EmailTemplateName = 'test';
        dp.CalcName = 'test';
        dp.CalcPaymentToOwn = 2;
        dp.CalcLoanFacilityType = 'test';
        dp.CalcState = 'test';
        dp.CalcProgramPartner = 'test';
        dp.CalcAmountFinanced = 15000;
        dp.CalcGoodsType = 'Yellow Goods';
        dp.CalcRepaymentType = 'test';
        dp.CalcRepaymentExpected = 15000;
        dp.CalcFeesDisclosed = 450;
        Boolean establishment = true;
        dp.CalcEstablishmentFeeFinanced = establishment;
        dp.CalcFeesFinanced = establishment;
        dp.CalcEstablishmentFeeDisclosed = 500;
        
        String myJSON = JSON.serialize(dp);
        request.requestBody = Blob.valueof(myJSON);
        request.params.put('username','sarthak@cd.com');
        request.params.put('password','sarthak');
        request.params.put('method','login');
        
        RestContext.request = request;
        RestContext.response = res;
        
        Test.startTest();
        VendorCalcRestAPIForMobileApp.doPost();
        Test.stopTest();
    }
}