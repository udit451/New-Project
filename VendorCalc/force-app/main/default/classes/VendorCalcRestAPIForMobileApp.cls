@RestResource(UrlMapping='/VendorCalc')
global with sharing class VendorCalcRestAPIForMobileApp {
    @HttpGet
    global static String doGet() {
        return 'doGet Method';
    }

    @HttpPost
    global static ReturnData doPost() {
        ReturnData returnData = new ReturnData();
        try {
            RestRequest request = RestContext.request;
            
            String name;
            String email;
            String username;
            String password;
            String method;
            String vendorUserId;
            String LeadId;
            String Term;
            String FacilityType;
            String ProgramPartnerId;
            String CalculatorRecordId;
            String ObjectName;
            String RecordTypeName;
            String Company;
            String GuestUserId;
            String MobilePhone;
            String LastName;
            String FirstName;
            String Status;
            String AssetType;
            String EmailTemplateName;
            String CalcName;
            String CalcRecordTypeId;
            Integer CalcPaymentToOwn;
            String CalcLoanFacilityType;
            String CalcState;
            String CalcProgramPartner;
            Decimal CalcAmountFinanced;
            String CalcGoodsType;
            String CalcRepaymentType;
            Decimal CalcRepaymentExpected;
            Decimal CalcFeesDisclosed;
            Boolean CalcEstablishmentFeeFinanced;
            Boolean CalcFeesFinanced;
            Decimal CalcEstablishmentFeeDisclosed;

            Map<String, String> parameterMap = RestContext.request.params;
            try {

                //this block is for ios
                if (parameterMap.size() == 1 && parameterMap.values()[0] == '') {
                    for (String str : parameterMap.keySet()) {
                        DataWrapper dataWrapper = (DataWrapper) JSON.deserialize(str, DataWrapper.class);
                        username = dataWrapper.username;
                        password = dataWrapper.password;
                        name = dataWrapper.name;
                        email = dataWrapper.email;
                        method = dataWrapper.method;
                        vendorUserId = dataWrapper.vendorUserId;
                        LeadId = dataWrapper.LeadId;
                        Term = dataWrapper.Term;
                        FacilityType = dataWrapper.FacilityType;
                        ProgramPartnerId = dataWrapper.ProgramPartnerId;
                        CalculatorRecordId = dataWrapper.CalculatorRecordId;
                        ObjectName = dataWrapper.ObjectName;
                        RecordTypeName = dataWrapper.RecordTypeName;
                        Company = dataWrapper.Company;
                        GuestUserId = dataWrapper.GuestUserId;
                        MobilePhone = dataWrapper.MobilePhone;
                        LastName = dataWrapper.LastName;
                        FirstName = dataWrapper.FirstName;
                        Status = dataWrapper.Status;
                        EmailTemplateName =dataWrapper.EmailTemplateName;
                        CalcName = dataWrapper.CalcName;
                        CalcRecordTypeId = dataWrapper.CalcRecordTypeId;
                        CalcPaymentToOwn = dataWrapper.CalcPaymentToOwn;
                        CalcLoanFacilityType = dataWrapper.CalcLoanFacilityType;
                        CalcState = dataWrapper.CalcState;
                        CalcProgramPartner = dataWrapper.CalcProgramPartner;
                        CalcAmountFinanced = dataWrapper.CalcAmountFinanced;
                        CalcGoodsType = dataWrapper.CalcGoodsType;
                        CalcRepaymentType = dataWrapper.CalcRepaymentType;
                        CalcRepaymentExpected = dataWrapper.CalcRepaymentExpected;
                        CalcFeesDisclosed = dataWrapper.CalcFeesDisclosed;
                        CalcEstablishmentFeeFinanced = dataWrapper.CalcEstablishmentFeeFinanced;
                        CalcFeesFinanced = dataWrapper.CalcFeesFinanced;
                        CalcEstablishmentFeeDisclosed = dataWrapper.CalcEstablishmentFeeDisclosed;
                        
						AssetType = dataWrapper.AssetType;
                        break; 
                    }
                } else {//this block is for android
                    username = RestContext.request.params.get('username');
                    password = RestContext.request.params.get('password');
                    if(password != null){
                        password = EncodingUtil.urlDecode(password,'UTF-8');
                    }

                    name = RestContext.request.params.get('name');
                    method = RestContext.request.params.get('method');
                    email = RestContext.request.params.get('email');
                    vendorUserId = RestContext.request.params.get('vendorUserId');
                    LeadId = RestContext.request.params.get('LeadId');
                    Term = RestContext.request.params.get('Term');
                    FacilityType = RestContext.request.params.get('FacilityType');
                    ProgramPartnerId = RestContext.request.params.get('ProgramPartnerId');
                    CalculatorRecordId = RestContext.request.params.get('CalculatorRecordId');
                    ObjectName = RestContext.request.params.get('ObjectName');
                    RecordTypeName = RestContext.request.params.get('RecordTypeName');
                    Company = RestContext.request.params.get('Company');
                    GuestUserId = RestContext.request.params.get('GuestUserId');
                    MobilePhone = RestContext.request.params.get('MobilePhone');
                    LastName = RestContext.request.params.get('LastName');
                    FirstName = RestContext.request.params.get('FirstName');
                    Status = RestContext.request.params.get('Status');
                    EmailTemplateName = RestContext.request.params.get('EmailTemplateName');

                    CalcName = RestContext.request.params.get('CalcName');
                    CalcRecordTypeId = RestContext.request.params.get('CalcRecordTypeId');
                    CalcLoanFacilityType = RestContext.request.params.get('CalcLoanFacilityType');
                    CalcState = RestContext.request.params.get('CalcState');
                    CalcProgramPartner = RestContext.request.params.get('CalcProgramPartner');
                    CalcRepaymentType = RestContext.request.params.get('CalcRepaymentType');
                    CalcGoodsType = RestContext.request.params.get('CalcGoodsType');

                    AssetType = RestContext.request.params.get('AssetType');

                    String TempCalcPaymentToOwn = RestContext.request.params.get('CalcPaymentToOwn');
                    if(TempCalcPaymentToOwn != null && TempCalcPaymentToOwn != ''){
                        CalcPaymentToOwn = Integer.valueOf(TempCalcPaymentToOwn);
                    }

                    //CalcAmountFinanced = Decimal.valueOf(RestContext.request.params.get('CalcAmountFinanced'));
                    String TempCalcAmountFinanced = RestContext.request.params.get('CalcAmountFinanced');
                    if(TempCalcAmountFinanced != null && TempCalcAmountFinanced != ''){
                        CalcAmountFinanced = Decimal.valueOf(TempCalcAmountFinanced);
                    }

                    //CalcRepaymentExpected = Decimal.valueOf(RestContext.request.params.get('CalcRepaymentExpected'));
                    String TempCalcRepaymentExpected = RestContext.request.params.get('CalcRepaymentExpected');
                    if(TempCalcRepaymentExpected != null && TempCalcRepaymentExpected != ''){
                        CalcRepaymentExpected = Decimal.valueOf(TempCalcRepaymentExpected);
                    }

                    //CalcFeesDisclosed = Decimal.valueOf(RestContext.request.params.get('CalcFeesDisclosed'));
                    String TempCalcFeesDisclosed = RestContext.request.params.get('CalcFeesDisclosed');
                    if(TempCalcFeesDisclosed != null && TempCalcFeesDisclosed != ''){
                        CalcFeesDisclosed = Decimal.valueOf(TempCalcFeesDisclosed);
                    }

                    //CalcEstablishmentFeeFinanced = Boolean.valueOf(RestContext.request.params.get('CalcEstablishmentFeeFinanced'));
                    String TempCalcEstablishmentFeeFinanced = RestContext.request.params.get('CalcEstablishmentFeeFinanced');
                    if(TempCalcEstablishmentFeeFinanced != null && TempCalcEstablishmentFeeFinanced != ''){
                        CalcEstablishmentFeeFinanced = Boolean.valueOf(TempCalcEstablishmentFeeFinanced);
                    }

                    //CalcFeesFinanced = Boolean.valueOf(RestContext.request.params.get('CalcFeesFinanced'));
                    String TempCalcFeesFinanced = RestContext.request.params.get('CalcFeesFinanced');
                    if(TempCalcFeesFinanced != null && TempCalcFeesFinanced != ''){
                        CalcFeesFinanced = Boolean.valueOf(TempCalcFeesFinanced);
                    }

                    //CalcEstablishmentFeeDisclosed = Decimal.valueOf(RestContext.request.params.get('CalcEstablishmentFeeDisclosed'));
                    String TempCalcEstablishmentFeeDisclosed = RestContext.request.params.get('CalcEstablishmentFeeDisclosed');
                    if(TempCalcEstablishmentFeeDisclosed != null && TempCalcEstablishmentFeeDisclosed != ''){
                        CalcEstablishmentFeeDisclosed = Decimal.valueOf(TempCalcEstablishmentFeeDisclosed);
                    }



                }
            } catch (Exception ex) {
                username = RestContext.request.params.get('username');
                password = RestContext.request.params.get('password');
                if(password != null){
                    password = EncodingUtil.urlDecode(password,'UTF-8');
                }
                name = RestContext.request.params.get('name');
                method = RestContext.request.params.get('method');
                email = RestContext.request.params.get('email');
                vendorUserId = RestContext.request.params.get('vendorUserId');
                LeadId = RestContext.request.params.get('LeadId');
                CalculatorRecordId = RestContext.request.params.get('CalculatorRecordId');
                ObjectName = RestContext.request.params.get('ObjectName');
                RecordTypeName = RestContext.request.params.get('RecordTypeName');
                Company = RestContext.request.params.get('Company');
                GuestUserId = RestContext.request.params.get('GuestUserId');
                MobilePhone = RestContext.request.params.get('MobilePhone');
                LastName = RestContext.request.params.get('LastName');
                FirstName = RestContext.request.params.get('FirstName');
                Status = RestContext.request.params.get('Status');
                EmailTemplateName = RestContext.request.params.get('EmailTemplateName');

                AssetType = RestContext.request.params.get('AssetType');

                CalcName = RestContext.request.params.get('CalcName');
                CalcRecordTypeId = RestContext.request.params.get('CalcRecordTypeId');

                String TempCalcPaymentToOwn = RestContext.request.params.get('CalcPaymentToOwn');
                if(TempCalcPaymentToOwn != null && TempCalcPaymentToOwn != ''){
                    CalcPaymentToOwn = Integer.valueOf(TempCalcPaymentToOwn);
                }
                CalcLoanFacilityType = RestContext.request.params.get('CalcLoanFacilityType');
                CalcState = RestContext.request.params.get('CalcState');
                CalcProgramPartner = RestContext.request.params.get('CalcProgramPartner');

                String TempCalcAmountFinanced = RestContext.request.params.get('CalcAmountFinanced');
                if(TempCalcAmountFinanced != null && TempCalcAmountFinanced != ''){
                    CalcAmountFinanced = Decimal.valueOf(TempCalcAmountFinanced);
                }

                CalcGoodsType = RestContext.request.params.get('CalcGoodsType');
                CalcRepaymentType = RestContext.request.params.get('CalcRepaymentType');

                String TempCalcRepaymentExpected = RestContext.request.params.get('CalcRepaymentExpected');
                if(TempCalcRepaymentExpected != null && TempCalcRepaymentExpected != ''){
                    CalcRepaymentExpected = Decimal.valueOf(TempCalcRepaymentExpected);
                }

                String TempCalcFeesDisclosed = RestContext.request.params.get('CalcFeesDisclosed');
                if(TempCalcFeesDisclosed != null && TempCalcFeesDisclosed != ''){
                    CalcFeesDisclosed = Decimal.valueOf(TempCalcFeesDisclosed);
                }

                String TempCalcEstablishmentFeeDisclosed = RestContext.request.params.get('CalcEstablishmentFeeDisclosed');
                if(TempCalcEstablishmentFeeDisclosed != null && TempCalcEstablishmentFeeDisclosed != ''){
                    CalcEstablishmentFeeDisclosed = Decimal.valueOf(TempCalcEstablishmentFeeDisclosed);
                }

                String TempCalcEstablishmentFeeFinanced = RestContext.request.params.get('CalcEstablishmentFeeFinanced');
                if(TempCalcEstablishmentFeeFinanced != null && TempCalcEstablishmentFeeFinanced != ''){
                    CalcEstablishmentFeeFinanced = Boolean.valueOf(TempCalcEstablishmentFeeFinanced);
                }

                String TempCalcFeesFinanced = RestContext.request.params.get('CalcFeesFinanced');
                if(TempCalcFeesFinanced != null && TempCalcFeesFinanced != ''){
                    CalcFeesFinanced = Boolean.valueOf(TempCalcFeesFinanced);
                }
            }

            List<VEN3__Vendor_Guest_User__c> vendorGuestUser = [
                    SELECT Id, VEN3__Email__c, Name, VEN3__isActive__c, VEN3__Password__c,VEN3__Program_Partner__c,VEN3__Username__c
                    FROM VEN3__Vendor_Guest_User__c
                    WHERE VEN3__Username__c = :username OR VEN3__Email__c = :email
                    LIMIT 1
            ];

            if (vendorGuestUser != null & vendorGuestUser.size() > 0 && method == 'registration') {
                returnData.hasError = true;
                returnData.errorMessage = 'Email or Username already exist. Please use unique details';

            } else if (method == 'login') {
                returnData.username = username;
                returnData.password = password;
                doLogin(returnData);
            } else if (method == 'registration') {
                returnData.name = name;
                returnData.email = email;
                returnData.username = username;
                returnData.password = password;
                doRegistration(returnData);
            } else if (method == 'getLeads') {
                getAllRelatedLeads(vendorUserId,returnData);
            } else if (method == 'getCalculationRecord') {
                getAllRelatedCalculationRecord(LeadId, returnData);
            } else if (method == 'getCalculatorSetting') {
                getAllRelatedCalculatorSetting(Term, FacilityType, ProgramPartnerId,AssetType,CalcGoodsType,returnData);
            } else if (method == 'getParticularCalculatorRecord') {
                getCalculatorRecordDetails(CalculatorRecordId, returnData);
            }else if(method == 'getEmailTemplate'){
                getEmailTemplateDetails(returnData,EmailTemplateName);
            }else if(method == 'getRecordType'){
                getRecordTypeDetails(ObjectName,RecordTypeName,returnData);
            }else if(method == 'createLead'){
                createLeadRecord(email,Company,GuestUserId,MobilePhone,FirstName,LastName,Status,returnData);
            }else if(method == 'saveCalculationRecord'){
                SaveCalculationRecordDetails(CalcName,CalcRecordTypeId,CalcPaymentToOwn,CalcLoanFacilityType,Term,CalcState,CalcProgramPartner,CalcAmountFinanced,CalcGoodsType,CalcRepaymentType,CalcRepaymentExpected,CalcFeesDisclosed,CalcEstablishmentFeeFinanced,CalcFeesFinanced,CalcEstablishmentFeeDisclosed,returnData,LeadId);
            }else if(method == 'createLookup'){
                CreateLookUp_Apex(LeadId,CalculatorRecordId,returnData);
            }else if(method == 'getsetting'){
                getSettingRecord(Term,ProgramPartnerId,CalcGoodsType,FacilityType,AssetType,returnData);
            }else if(method == 'getGoodsType'){
                getRelatedGoodsType(ProgramPartnerId,returnData);
            }
        } catch (Exception ex) {
            returnData.errorMessage = ex.getMessage() + '. On line: ' + ex.getLineNumber();
        }
        return returnData;
    }


    private static ReturnData doRegistration(ReturnData returnData) {
        VEN3__Vendor_Guest_User__c venUserObj = new VEN3__Vendor_Guest_User__c();
        venUserObj.Name = returnData.name;
        venUserObj.VEN3__Email__c = returnData.email;
        venUserObj.VEN3__Username__c = returnData.username;
        venUserObj.VEN3__Password__c = returnData.password;
        try {
            insert venUserObj;
            setMessageAttributes(returnData, false, 'You are successfully registered');
        } catch (Exception ex) {
            setMessageAttributes(returnData, true, 'Error has occurred while registration ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }
        return returnData;
    }
    private static ReturnData doLogin(ReturnData returnData) {
        List<VEN3__Vendor_Guest_User__c> vendorGuestUser = new List<VEN3__Vendor_Guest_User__c>();
        vendorGuestUser = [
                SELECT Id, VEN3__Email__c, Name, VEN3__isActive__c, VEN3__Password__c,VEN3__Program_Partner__c,VEN3__Username__c,VEN3__Program_Partner__r.Name
                FROM VEN3__Vendor_Guest_User__c
                WHERE VEN3__Username__c = :returnData.username AND VEN3__Password__c = :returnData.password AND VEN3__isActive__c = true
                LIMIT 1
        ];
        if (vendorGuestUser.size() > 0) {
            returnData.vendorUserId = vendorGuestUser[0].Id;
            returnData.ProgramPartnerId = vendorGuestUser[0].VEN3__Program_Partner__c;
            returnData.email = vendorGuestUser[0].VEN3__Email__c;
            returnData.partnerName  = vendorGuestUser[0].VEN3__Program_Partner__r.Name;
            returnData.name  = vendorGuestUser[0].Name;
            setMessageAttributes(returnData, false, 'You have successfully logged in.');
        } else {
            setMessageAttributes(returnData, true, 'Username/Password is incorrect or user is inactive');
        }
        return returnData;
    }
    private static ReturnData getAllRelatedCalculationRecord(Id LeadId, ReturnData returnData) {
        try {
            if (LeadId != null) {
                List<VEN3__Calculator__c> QuoteCalculatorRecordsList = new List<Calculator__c>();
                String queryString = VendorCalcRestAPIForMobileApp.getAllObjectFields('VEN3__Calculator__c');
                if(queryString != null){
                    //QuoteCalculatorRecordsList = [select Id,Name from VEN3__Calculator__c where Lead__c = :LeadId LIMIT 10000];
                    queryString = queryString + ' From VEN3__Calculator__c where Lead__c =\'' + LeadId + '\' LIMIT 10000';
                    QuoteCalculatorRecordsList = database.query(queryString);
                }
                if (QuoteCalculatorRecordsList != null) {
                    if (QuoteCalculatorRecordsList.size() > 0) {
                        returnData.QuoteCalculatorRecord = QuoteCalculatorRecordsList;
                    }else{
                        setMessageAttributes(returnData, true, 'Data not found.');
                    }
                }else{
                    setMessageAttributes(returnData, true, 'Data not found.');
                }
            }else{
                setMessageAttributes(returnData, true, 'Required fields missing.');
            }
        } catch (Exception ex) {
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    private static ReturnData getAllRelatedCalculatorSetting(String Term, String FacilityType, Id ProgramPartnerId,String AssetType,String CalcGoodsType, ReturnData returnData) {
        try {
            if (Term != null && FacilityType != null && ProgramPartnerId != null && AssetType != null && CalcGoodsType != null) {
                Decimal ExistingTerm = Decimal.valueOf(Term);
                if (ExistingTerm != null) {
                    List<VEN3__Calculator_Settings__c> CalculatorSettingList = new List<VEN3__Calculator_Settings__c>();
                    String queryString = VendorCalcRestAPIForMobileApp.getAllObjectFields('VEN3__Calculator_Settings__c');
                    //system.debug('queryString-->>'+queryString);
                    if(queryString != null){
                        queryString = queryString + ' , VEN3__Program_Partner__r.VEN3__Goods_Type__c From VEN3__Calculator_Settings__c where VEN3__Term_months__c =: ExistingTerm AND VEN3__Facility_Type__c =\'' + FacilityType + '\' AND VEN3__Asset_Type__c =\'' + AssetType + '\' AND VEN3__Goods_Type__c =\''+ CalcGoodsType + '\' AND VEN3__Program_Partner__c =\''+ ProgramPartnerId +'\' LIMIT 1';
                        CalculatorSettingList = database.query(queryString);
                    }
                    //system.debug('CalculatorSettingList-->>'+CalculatorSettingList);
                    if (CalculatorSettingList != null) {
                        if (CalculatorSettingList.size() > 0) {
                            returnData.CalculatorSettingList = CalculatorSettingList;
                        }else{
                            setMessageAttributes(returnData, true, 'Setting does not exits.');
                        }
                    }else{
                        setMessageAttributes(returnData, true, 'Setting does not exits.');
                    }
                }
            } else {
                setMessageAttributes(returnData, true, 'Please fill Mandatory Details');
            }
        } catch (Exception ex) {
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    private static void setMessageAttributes(ReturnData returnData, Boolean isHasError, String messageString) {
        returnData.hasError = isHasError;
        if (isHasError) {
            returnData.errorMessage = messageString;
        } else {
            returnData.successMessage = messageString;
        }
    }
    private static ReturnData getAllRelatedLeads(String vendorUserId, ReturnData returnData) {
        try {
            if (vendorUserId != null) {
                List<Lead> sObjectList = new List<Lead>();
                String queryString = VendorCalcRestAPIForMobileApp.getAllObjectFields('Lead');
                if(queryString != null){
                    queryString = queryString + ' From Lead where VEN3__Vendor_Guest_User__c =\'' + vendorUserId + '\' ORDER BY CreatedDate DESC LIMIT 10000';
                    sObjectList = database.query(queryString);
                }
                if (sObjectList != null) {
                    if (sObjectList.size() > 0) {
                        returnData.LeadList = sObjectList;
                    }else{
                        setMessageAttributes(returnData, true, 'Data not found.');
                    }
                }else{
                    setMessageAttributes(returnData, true, 'Data not found.');
                }
            }else{
                setMessageAttributes(returnData, true, 'Required fields missing.');
            }
        } catch (Exception ex) {
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    private static ReturnData getCalculatorRecordDetails(Id CalculatorRecordId, ReturnData returnData) {
        try {
            if (CalculatorRecordId != null) {
                VEN3__Calculator__c CalculatorData = new Calculator__c();
                //CalculatorData = [select Id,Name from VEN3__Calculator__c where Id = :CalculatorRecordId LIMIT 1];
                String queryString = VendorCalcRestAPIForMobileApp.getAllObjectFields('VEN3__Calculator__c');
                if(queryString != null){
                    queryString = queryString + ' ,VEN3__Lead__r.Email,VEN3__Lead__r.Name,VEN3__Vendor_Guest_User__r.Name From VEN3__Calculator__c where Id =\'' + CalculatorRecordId + '\' LIMIT 1';
                    CalculatorData = database.query(queryString);
                }
                if (CalculatorData != null) {
                    returnData.CalculatorData = CalculatorData;
                }else{
                    setMessageAttributes(returnData, true, 'Data not found.');
                }
            }else{
                setMessageAttributes(returnData, true, 'Required fields missing.');
            }
        } catch (Exception ex) {
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    private static ReturnData getEmailTemplateDetails(ReturnData returnData,String EmailTemplateName){
        try{
            List <VEN3__Email_Template__c> EmailTemplateList = new List<Email_Template__c>();
            if(EmailTemplateName != null && EmailTemplateName != ''){
                EmailTemplateList = [select Id,Name,VEN3__Email_Body__c,VEN3__Subject__c from Email_Template__c Where Name =: EmailTemplateName LIMIT 1];
            }
            if(EmailTemplateList != null){
                if(EmailTemplateList.size()>0){
                    returnData.EmailTemplateList = EmailTemplateList;
                }else{
                    setMessageAttributes(returnData, true, 'Data not found.');
                }
            }else{
                setMessageAttributes(returnData, true, 'Data Not Found.');
            }
        }catch (Exception ex){
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    private static ReturnData getRecordTypeDetails(String ObjName , String RecordTypeName, ReturnData returnData){
        try{
            if(ObjName != null && RecordTypeName != null){
                List<RecordType> RecordTypeList = new List<RecordType>();
                RecordTypeList = [select Id,DeveloperName from RecordType where SobjectType =: ObjName AND Name =: RecordTypeName LIMIT 1];
                if(RecordTypeList != null){
                    if(RecordTypeList.size()>0){
                        ReturnData.RecordTypeDetails = RecordTypeList[0];
                    }else{
                        setMessageAttributes(returnData, true, 'Data not found.');
                    }
                }else{
                    setMessageAttributes(returnData, true, 'Data not found.');
                }
            }else{
                setMessageAttributes(returnData, true, 'Required fields missing.');
            }
        }catch (Exception ex){
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    private static ReturnData createLeadRecord(String EmailId, String CompanyName, String UserId, String MobileNumber,String FirstName, String LastName, String Status, ReturnData returnData){
        try{
            if(EmailId != null && CompanyName != null && UserId != null && MobileNumber != null && LastName != null && Status != null ){
                Lead LeadInstance = new Lead();
                LeadInstance.LastName = LastName;

                LeadInstance.Email = EmailId;
                LeadInstance.Company = CompanyName;
                LeadInstance.MobilePhone = MobileNumber;
                LeadInstance.Status = Status;
                LeadInstance.VEN3__Vendor_Guest_User__c = UserId;
                if(FirstName != null && FirstName != ''){
                    LeadInstance.FirstName = FirstName;
                }
                insert LeadInstance;
                if(LeadInstance.Id != null){
                    setMessageAttributes(returnData, false, 'Lead created successfully.');
                    returnData.CurrentInsertedLead = LeadInstance;
                }
            }else{
                setMessageAttributes(returnData, true, 'Required fields missing.');
            }
        }catch (Exception ex){
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    private static ReturnData SaveCalculationRecordDetails(String CalcName, String CalcRecordTypeId, Integer CalcPaymentToOwn, String CalcLoanFacilityType, String Term, String CalcState, String CalcProgramPartner, Decimal CalcAmountFinanced, String CalcGoodsType, String CalcRepaymentType, Decimal CalcRepaymentExpected, Decimal CalcFeesDisclosed, Boolean CalcEstablishmentFeeFinanced, Boolean CalcFeesFinanced, Decimal CalcEstablishmentFeeDisclosed, ReturnData returnData, String LeadId){
        try{
            // TODO: Pravin please add the null check only for the above value

            if(CalcName != null && CalcName != '' && CalcLoanFacilityType != null && CalcLoanFacilityType != '' && Term != null && Term != '' && CalcProgramPartner != null && CalcProgramPartner != '' && CalcAmountFinanced != null && CalcGoodsType != null && CalcGoodsType != '' && CalcRepaymentType != null && CalcRepaymentType != '' && CalcRepaymentExpected != null ){
                VEN3__Calculator__c CalcInstance = new VEN3__Calculator__c();
                CalcInstance.Name = CalcName;
                CalcInstance.VEN3__Loan_Facility_Type__c = CalcLoanFacilityType;
                CalcInstance.VEN3__Term_months__c = Decimal.valueOf(Term);
                CalcInstance.VEN3__Program_Partner_L__c = CalcProgramPartner;
                CalcInstance.VEN3__Amount_Financed__c = CalcAmountFinanced;
                CalcInstance.VEN3__Goods_Type__c = CalcGoodsType;
                CalcInstance.VEN3__Repayment_Type__c = CalcRepaymentType;
                CalcInstance.VEN3__Repayment_Expected_c__c = CalcRepaymentExpected;

                if(LeadId != '' && LeadId != null){
                    CalcInstance.VEN3__Lead__c = LeadId;
                }else if(CalcRecordTypeId != '' && CalcRecordTypeId != null){
                    CalcInstance.VEN3__Vendor_Guest_User__c = returnData.vendorUserId;
                    CalcInstance.RecordTypeId = CalcRecordTypeId;
                }else{
                    setMessageAttributes(returnData, true, 'Required fields missing.');
                }
                if(CalcPaymentToOwn != null){
                    CalcInstance.VEN3__Payments_to_Own__c = CalcPaymentToOwn;
                }
                if(CalcState != null && CalcState !=''){
                    CalcInstance.VEN3__State__c = CalcState;
                }
                if(CalcFeesDisclosed != null){
                    CalcInstance.VEN3__PPSR_Fees_Disclosed__c = CalcFeesDisclosed;
                }
                if(CalcEstablishmentFeeFinanced != null ){
                    CalcInstance.VEN3__Establishment_Fee_Financed__c = CalcEstablishmentFeeFinanced;
                }
                if(CalcFeesFinanced != null){
                    CalcInstance.VEN3__PPSR_Fee_Financed__c = CalcFeesFinanced;
                }
                if(CalcEstablishmentFeeDisclosed != null){
                    CalcInstance.VEN3__Establishment_Fee_Disclosed__c = CalcEstablishmentFeeDisclosed;
                }
                // CalcInstance.RecordTypeId = CalcRecordTypeId;
                //  CalcInstance.VEN3__State__c = CalcState;
                // CalcInstance.VEN3__Payments_to_Own__c = CalcPaymentToOwn;
                // CalcInstance.VEN3__PPSR_Fees_Disclosed__c = CalcFeesDisclosed;
                // CalcInstance.VEN3__Establishment_Fee_Financed__c = CalcEstablishmentFeeFinanced;
                // CalcInstance.VEN3__PPSR_Fee_Financed__c = CalcFeesFinanced;
                // CalcInstance.VEN3__Establishment_Fee_Disclosed__c = CalcEstablishmentFeeDisclosed;

                insert CalcInstance;
                if(CalcInstance.Id != null){
                    returnData.CalculationRecord = CalcInstance;
                }
            }else{
                setMessageAttributes(returnData, true, 'Required fields missing.');
            }
        }catch (Exception ex){
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    private static ReturnData CreateLookUp_Apex(String LeadId, String CalculationId, ReturnData returnData){
        try{
            if(LeadId != null && CalculationId != null){
                VEN3__Calculator__c CalcRecordInstance = new VEN3__Calculator__c();
                String queryString = VendorCalcRestAPIForMobileApp.getAllObjectFields('VEN3__Calculator__c');
                if(queryString != null){
                    queryString = queryString + ' From VEN3__Calculator__c where Id =\'' + CalculationId + '\' LIMIT 1';
                    CalcRecordInstance = database.query(queryString);
                }
                if(CalcRecordInstance != null){
                    CalcRecordInstance.Lead__c = LeadId;
                    update CalcRecordInstance;
                    setMessageAttributes(returnData, false, 'Lead Created Successfully.');
                }
            }else{
                setMessageAttributes(returnData, true, 'Required fields missing.');
            }
        }catch (Exception ex){
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    public static String getAllObjectFields(String ObjName){
        try{
            List<String> fieldsList = new List<String>();
            Map<String, Schema.SObjectField> sObjectFieldMap =
                    Schema.getGlobalDescribe().get(ObjName).getDescribe().fields.getMap();
            for (Schema.SObjectField field : sObjectFieldMap.values()) {
                DescribeFieldResult fieldResult = field.getDescribe();
                //if (fieldResult.isCreateable()) {
                    fieldsList.add(fieldResult.getName());
                //}
            }
            if(!fieldsList.isEmpty()){
                String fields = String.join(fieldsList, ',');
                if(fields != null){
                    fields = fields.removeEnd(',');
                    String query = 'SELECT ';
                    query += fields;
                    if(query != null){
                        return query;
                    }
                }
            }
        }catch (Exception ex){
            system.debug('Error occurs while getting all fields list->'+ex.getMessage()+'@ line number->>'+ex.getLineNumber());
        }return null;
    }
    private static ReturnData getSettingRecord(String Term, Id ProgramPartnerId, String CalcGoodsType, String FacilityType, String AssetType, ReturnData returnData){
        try {
            Decimal ExistingTerm = 0;
            if(Term != null && Term != ''){
                ExistingTerm = Decimal.valueOf(Term);
            }
            List<VEN3__Calculator_Settings__c> SettingList = new List<Calculator_Settings__c>();
            String queryString = VendorCalcRestAPIForMobileApp.getAllObjectFields('VEN3__Calculator_Settings__c');
            if(queryString != null){
                queryString = queryString + ' From VEN3__Calculator_Settings__c where VEN3__Facility_Type__c =\'' + FacilityType + '\' AND VEN3__Program_Partner__c =\'' + ProgramPartnerId + '\' AND VEN3__Goods_Type__c =\'' + CalcGoodsType + '\' AND VEN3__Asset_Type__c =\'' + AssetType + '\' AND VEN3__Term_months__c =: ExistingTerm LIMIT 10000';
                SettingList = database.query(queryString);
            }

            if (SettingList != null) {
                if(SettingList.size()>0){
                    returnData.SettingsList = SettingList;
                }else{
                    setMessageAttributes(returnData, true, 'Data not found.');
                }
            }else{
                setMessageAttributes(returnData, true, 'Data not found.');
            }
        } catch (Exception ex) {
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    private static ReturnData getRelatedGoodsType(Id ProgramPartnerId, ReturnData returnData){
        try {
            if(ProgramPartnerId != null){
                VEN3__Program_Partner__c ProgramPartnerInstance = new VEN3__Program_Partner__c();
                String queryString = VendorCalcRestAPIForMobileApp.getAllObjectFields('VEN3__Program_Partner__c');
                if(queryString != null){
                    queryString = queryString + ' From VEN3__Program_Partner__c where Id =\'' + ProgramPartnerId + '\' LIMIT 1';
                    ProgramPartnerInstance = database.query(queryString);
                }
                if(ProgramPartnerInstance.VEN3__Goods_Type__c != null){
                    if(ProgramPartnerInstance.VEN3__Goods_Type__c != ''){
                        returnData.GoodsTypeString = ProgramPartnerInstance.VEN3__Goods_Type__c;
                    }else{
                        setMessageAttributes(returnData, true, 'Data Not Found');
                    }
                }else{
                    setMessageAttributes(returnData, true, 'Data Not Found');
                }
            }else{
                setMessageAttributes(returnData, true, 'Required field missing');
            }
        }catch (Exception ex) {
            setMessageAttributes(returnData, true, 'Error has occurred ' + ex.getMessage() + ' ' + ex.getLineNumber());
        }return returnData;
    }
    global class ReturnData {
        public String username { get; set; }
        public String password { get; set; }
        public String partnerName { get; set; }
        public String email { get; set; }
        public String name { get; set; }
        public Boolean hasError { get; set; }
        public String errorMessage { get; set; }
        public String successMessage { get; set; }
        public String vendorUserId { get; set; }
        public String ProgramPartnerId { get; set; }
        public String GoodsTypeString { get; set; }
        public List<Lead> LeadList { get; set; }
        public List<VEN3__Calculator__c> QuoteCalculatorRecord { get; set; }
        public List<VEN3__Calculator_Settings__c> CalculatorSettingList { get; set; }
        public VEN3__Calculator__c CalculatorData { get; set; }
        public RecordType RecordTypeDetails { get; set; }
        public List <VEN3__Email_Template__c> EmailTemplateList { get; set; }
        public List <VEN3__Calculator_Settings__c> SettingsList { get; set; }
        public Lead CurrentInsertedLead { get; set; }
        public VEN3__Calculator__c CalculationRecord { get; set; }
    }
    global class DataWrapper {
        public String name { get; set; }
        public String email { get; set; }
        public String username { get; set; }
        public String password { get; set; }
        public String method { get; set; }
        public String vendorUserId { get; set; }
        public String LeadId { get; set; }
        public String Term { get; set; }
        public String FacilityType { get; set; }
        public String ProgramPartnerId { get; set; }
        public String CalculatorRecordId { get; set; }
        public String ObjectName { get; set; }
        public String RecordTypeName { get; set; }
        public String Company { get; set; }
        public String GuestUserId { get; set; }
        public String MobilePhone { get; set; }
        public String LastName { get; set; }
        public String FirstName { get; set; }
        public String Status { get; set; }
        public String EmailTemplateName { get; set; }


        public String CalcName{ get; set; }
        public String CalcRecordTypeId{ get; set; }
        public Integer CalcPaymentToOwn{ get; set; }
        public String CalcLoanFacilityType{ get; set; }
        public String CalcState{ get; set; }
        public String CalcProgramPartner{ get; set; }
        public Decimal CalcAmountFinanced{ get; set; }
        public String CalcGoodsType{ get; set; }
        public String CalcRepaymentType{ get; set; }
        public Decimal CalcRepaymentExpected{ get; set; }
        public Decimal CalcFeesDisclosed{ get; set; }
        public Boolean CalcEstablishmentFeeFinanced{ get; set; }
        public Boolean CalcFeesFinanced{ get; set; }
        public Decimal CalcEstablishmentFeeDisclosed{ get; set; }

        public String AssetType{ get; set; }
    }
}