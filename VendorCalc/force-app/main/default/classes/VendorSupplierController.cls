public class VendorSupplierController {
    
    @AuraEnabled
    public static VEN3__Calculator__c saveANZData_Apex(String anzList, String leadObj, String version) {
        try {
            if (String.isNotBlank(anzList) && String.isNotBlank(leadObj) && String.isNotBlank(version)) {
                Id RecordTypeId = Schema.SObjectType.VEN3__Calculator__c.getRecordTypeInfosByName().get('Chase Finance').getRecordTypeId();
                Id RecId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Chase Vendor').getRecordTypeId();
                VEN3__Calculator__c calcInsert = new VEN3__Calculator__c();
                Lead leadRecord = new Lead();
                calcInsert = (VEN3__Calculator__c) JSON.deserialize(anzList, VEN3__Calculator__c.class);
                leadRecord = (Lead) JSON.deserialize(leadObj, Lead.class);
                leadRecord.Id = calcInsert.VEN3__Lead__c;
                leadRecord.RecordTypeId = RecId;
                leadRecord.Company = leadRecord.FirstName + ' ' + leadRecord.LastName;
                leadRecord.VEN3__Amount__c = calcInsert.VEN3__Amount_Financed__c;
                leadRecord.VEN3__Date__c = system.today();
                upsert leadRecord;
                calcInsert.Name = leadRecord.FirstName + ' ' + leadRecord.LastName;
                calcInsert.VEN3__Lead__c = leadRecord.Id;
                if (leadRecord.Company != null) {
                    calcInsert.VEN3__Company_Name__c = leadRecord.Company;
                }
                if (leadRecord.Email != null) {
                    calcInsert.VEN3__Email_Address__c = leadRecord.Email;
                }
                if (leadRecord.Phone != null) {
                    calcInsert.VEN3__Phone__c = leadRecord.Phone;
                }
                if (leadRecord.VEN3__Date__c != null) {
                    calcInsert.VEN3__Date__c = leadRecord.VEN3__Date__c;
                }
                if (calcInsert.VEN3__Ballon__c != null) {
                    calcInsert.VEN3__Ballon__c = calcInsert.VEN3__Ballon__c * 100;
                    calcInsert.VEN3__Balloon_c__c = calcInsert.VEN3__Amount_Financed__c * (calcInsert.VEN3__Ballon__c / 100);
                }
                if (RecordTypeId != null) {
                    calcInsert.RecordTypeId = RecordTypeId;
                }
                upsert calcInsert;
                sendEmailNotificationToAdmin(leadRecord, version, calcInsert);
                return calcInsert;
            }
        } catch (Exception ex) {
            System.debug('Error' + ex.getMessage());
            System.debug('Error' + ex.getLineNumber());
        }
        return null;
    }
    
    
    public class allExistingPriceSettingWrapperClass {
        @AuraEnabled public VEN3__Calculator_Settings__c existingPriceSettingObj { get; set; }
        @AuraEnabled public String FacilityType { get; set; }
    }
    public class AssertPricingWrapperClass {
        @AuraEnabled public VEN3__Calculator_Settings__c assertPricingObj { get; set; }
        @AuraEnabled public String FacilityType { get; set; }
    }
    
    
    @AuraEnabled
    public static VEN3__Program_Partner__c getGoodsType_Apex(String selectedProgramPartnerId) {
        if (selectedProgramPartnerId != null) {
            VEN3__Program_Partner__c programPartner = new VEN3__Program_Partner__c();
            programPartner = [SELECT VEN3__Goods_Type__c FROM VEN3__Program_Partner__c WHERE Id = :selectedProgramPartnerId];
            if (programPartner != null) {
                return programPartner;
            }
        }
        return null;
    }
    @AuraEnabled
    Public static VEN3__Calculator_Settings__c getCustomSettings_Apex(String AssetType, Decimal Term, String facilityType, String ProgramPartner, String goodTypes) {
        List<VEN3__Calculator_Settings__c > existingSettings = new List<VEN3__Calculator_Settings__c >();
        try {
            if (Term != null && AssetType != null && facilityType != null) {
                existingSettings = [
                    SELECT Id,
                    VEN3__X1000KAbove_Balloon_10__c,
                    VEN3__X1000KAbove_Balloon_20__c,
                    VEN3__X1000KAbove_Balloon_30__c,
                    VEN3__X1000KAbove_Balloon_40__c,
                    VEN3__X1000KAbove_Balloon_50__c,
                    VEN3__X1000KAbove_Base_Rate__c,
                    VEN3__X1000KAbove_Brokerage__c,
                    VEN3__X1000KAbove_Funder_Name__c,
                    VEN3__X100Kto150K_Balloon_0__c,
                    VEN3__X100Kto150K_Balloon_10__c,
                    VEN3__X100Kto150K_Balloon_20__c,
                    VEN3__X100Kto150K_Balloon_30__c,
                    VEN3__X100Kto150K_Balloon_40__c,
                    VEN3__X100Kto150K_Balloon_50__c,
                    VEN3__X100Kto150K_Base_Rate__c,
                    VEN3__X100Kto150K_Brokerage__c,
                    VEN3__X100Kto150K_Funder_Name__c,
                    VEN3__X150Kto250_Balloon_20__c,
                    VEN3__X150Kto250_Balloon_30__c,
                    VEN3__X150Kto250_Balloon_40__c,
                    VEN3__X150Kto250_Balloon_50__c,
                    VEN3__X150Kto250_Brokerage__c,
                    VEN3__X150Kto250K_Balloon_0__c,
                    VEN3__X150Kto250K_Balloon_10__c,
                    VEN3__X150Kto250K_Base_Rate__c,
                    VEN3__X150Kto250K_Funder_Name__c,
                    VEN3__X250Kto500K_Balloon_0__c,
                    VEN3__X250Kto500K_Balloon_10__c,
                    VEN3__X250Kto500K_Balloon_20__c,
                    VEN3__X250Kto500K_Balloon_30__c,
                    VEN3__X250Kto500K_Balloon_40__c,
                    VEN3__X250Kto500K_Balloon_50__c,
                    VEN3__X250Kto500K_Base_Rate__c,
                    VEN3__X250Kto500K_Brokerage__c,
                    VEN3__X250Kto500K_Funder_Name__c,
                    VEN3__X500Kto999K_Balloon_0__c,
                    VEN3__X500Kto999K_Balloon_10__c,
                    VEN3__X500Kto999K_Balloon_20__c,
                    VEN3__X500Kto999K_Balloon_30__c,
                    VEN3__X500Kto999K_Balloon_40__c,
                    VEN3__X500Kto999K_Balloon_50__c,
                    VEN3__X500Kto999K_Base_Rate__c,
                    VEN3__X500Kto999K_Brokerage__c,
                    VEN3__X500Kto999K_Funder_Name__c,
                    VEN3__X50Kto100K_Balloon_0__c,
                    VEN3__X50Kto100K_Balloon_10__c,
                    VEN3__X50Kto100K_Balloon20__c,
                    VEN3__X50Kto100K_Balloon_30__c,
                    VEN3__X50Kto100K_Balloon_40__c,
                    VEN3__X50Kto100K_Balloon_50__c,
                    VEN3__X50Kto100K_Base_Rate__c,
                    VEN3__X50Kto100K_Brokerage__c,
                    VEN3__X50Kto100K_Funder_Name__c,
                    VEN3__X5Kto50K_Balloon_0__c,
                    VEN3__X5Kto50K_Balloon_10__c,
                    VEN3__X5Kto50K_Balloon_20__c,
                    VEN3__X5Kto50K_Balloon_30__c,
                    VEN3__X5Kto50K_Balloon_40__c,
                    VEN3__X5Kto50K_Balloon_50__c,
                    VEN3__X5Kto50K_Base_Rate__c,
                    VEN3__X5Kto50K_Brokerage__c,
                    VEN3__X5Kto50K_Funder_Name__c,
                    VEN3__Asset_Type__c,
                    VEN3__Default_Balloon_0__c,
                    VEN3__Default_Balloon_10__c,
                    VEN3__Default_Balloon_20__c,
                    VEN3__Default_Balloon_30__c,
                    VEN3__Default_Balloon_40__c,
                    VEN3__Default_Balloon_50__c,
                    VEN3__Default_Base_Rate__c,
                    VEN3__Default_Brokerage_Rate__c,
                    VEN3__Establishment_Fee__c,
                    VEN3__Facility_Type__c,
                    VEN3__Goods_Type__c,
                    VEN3__Payments_to_Own__c,
                    VEN3__PPSR_Fee__c,
                    VEN3__Program_Partner__c,
                    VEN3__Term_months__c
                    FROM VEN3__Calculator_Settings__c
                    WHERE VEN3__Program_Partner__c = :ProgramPartner
                    AND VEN3__Asset_Type__c = :AssetType
                    AND VEN3__Term_months__c = :Term
                    AND VEN3__Facility_Type__c = :facilityType
                    AND VEN3__Goods_Type__c = :goodTypes
                ];
                if (existingSettings.size() > 0) {
                    return existingSettings[0];
                }
            }
        } catch (Exception ex) {
            system.debug('========>>' + ex.getMessage());
            system.debug('========>>' + ex.getLineNumber());
        }
        return null;
    }
    
    private static void sendEmailNotificationToAdmin(Lead leadInfo, String versionType, VEN3__Calculator__c calRecords) {
        try {
            if (leadInfo != null && String.isNotBlank(versionType)) {
                List<String> sendTo = new List<String>();
                if (versionType == 'chase') {
                    List<VEN3__Chase_Lead_Notification_Emails__c> Chase_Lead_Notification_Emails = VEN3__Chase_Lead_Notification_Emails__c.getall().values();
                    if (Chase_Lead_Notification_Emails.size() > 0) {
                        for (VEN3__Chase_Lead_Notification_Emails__c chaseEmail : Chase_Lead_Notification_Emails) {
                            if (chaseEmail.VEN3__Email__c != null) {
                                sendTo.add(chaseEmail.VEN3__Email__c);
                            }
                        }
                    }
                } else if (versionType == 'pronto') {
                    List<VEN3__Pronto_Lead_Notification_Emails__c> Pronto_Vendor_Admin_Emails = VEN3__Pronto_Lead_Notification_Emails__c.getall().values();
                    if (Pronto_Vendor_Admin_Emails.size() > 0) {
                        for (VEN3__Pronto_Lead_Notification_Emails__c prontoEmail : Pronto_Vendor_Admin_Emails) {
                            if (prontoEmail.VEN3__Email__c != null) {
                                sendTo.add(prontoEmail.VEN3__Email__c);
                            }
                        }
                    }
                }
                List<Messaging.SingleEmailMessage> mails =
                    new List<Messaging.SingleEmailMessage>();
                Messaging.SingleEmailMessage mail =
                    new Messaging.SingleEmailMessage();
                if (sendTo.size() > 0) {
                    mail.setToAddresses(sendTo);
                    
                    // Step 4. Set email contents - you can use variables!
                    if (versionType == 'chase') {
                        mail.setSubject('New Lead Created By Chase Vendor.');
                    }else if (versionType == 'pronto') {
                        mail.setSubject('New Lead Created By Pronto Vendor.');
                    }
                    String body = 'Hi , ';
                    body += '<br>';
                    body += 'Please find below new lead details: <br><br>';
                    body += 'Name: ' + leadInfo.FirstName +' '+ leadInfo.LastName + '<br>';
                    body += 'Email: ' + leadInfo.Email + '<br>';
                    body += 'Phone: ' + leadInfo.Phone + '<br>';
                    body += 'Amount Financed: ' + calRecords.VEN3__Amount_Financed__c + '<br>';
                    body += 'Term: ' + calRecords.VEN3__Term_months__c + '<br>';
                    body += 'Asset type: ' + calRecords.VEN3__Asset_Type__c + '<br>';
                    body += 'Repayment Frequency: ' + calRecords.VEN3__Repayment_Frequency__c + '<br>';
                    if(versionType == 'chase'){
                        body += 'Balloon Value: ' + calRecords.VEN3__Ballon__c + '<br>';
                    }else if(versionType == 'pronto'){
                        body += 'Good Types: ' + calRecords.VEN3__Goods_Type__c + '<br>';
                    }
                    
                    mail.setHtmlBody(body);
                    // Step 5. Add your email to the master list
                    mails.add(mail);
                    if(!Test.isRunningTest()){
                        Messaging.sendEmail(mails);                        
                    }
                }
            }
        } catch (Exception ex) {
            system.debug('ex::: ' + ex);
        }
    }
    @AuraEnabled
    public static retrunWrapperData getExistingRecord(String selectedId) {
        try {
            if (String.isNotBlank(selectedId)) {
                retrunWrapperData wrapperData = new retrunWrapperData();
                List<VEN3__Calculator__c> calData = new List<VEN3__Calculator__c>();
                calData = [
                    SELECT Id,
                    Name,
                    VEN3__Repayment_Expected_Weekly__c,
                    VEN3__Additional_Payment__c,
                    VEN3__Amount_Financed__c,
                    VEN3__Asset_Type__c,
                    VEN3__Ballon__c,
                    VEN3__Balloon_c__c,
                    VEN3__customer_Rate_Expected__c,
                    VEN3__customer_Rate_Non_Published__c,
                    VEN3__Date__c,
                    VEN3__Desired_Brokerage_Incl_GST_c__c,
                    VEN3__Desired_Brokerage_Incl_GST_p__c,
                    VEN3__Document_Fee_Disclosed__c,
                    VEN3__Fees_Other_Disclosed__c,
                    VEN3__Goods_Type__c,
                    VEN3__Incl_GST_c__c,
                    VEN3__Lead__c,
                    VEN3__Loan_Facility_Type__c,
                    VEN3__Opportunity__c,
                    VEN3__Please_enter_your_desired_Base_Rate_here__c,
                    VEN3__PPSR_Fees_Disclosed__c,
                    VEN3__Published_Base_Rate__c,
                    VEN3__Repayment_Expected_c__c,
                    VEN3__Repayment_Non_Published__c,
                    VEN3__Repayment_Frequency__c,
                    VEN3__Repayment_Type__c,
                    VEN3__Term_months__c,
                    VEN3__Document_Fee_Financed__c,
                    VEN3__PPSR_Fee_Financed__c,
                    VEN3__Fee_Other_Financed__c,
                    VEN3__Total_Incl_GST_GST__c,
                    VEN3__Unclaimable_GST__c,
                    VEN3__GST__c,
                    VEN3__Establishment_Fee_Disclosed__c,
                    VEN3__Establishment_Fee_Financed__c,
                    VEN3__Cost_Price_Exc_GST__c,
                    VEN3__Cost_Price_Inc_GST__c,
                    VEN3__Less_Deposite__c,
                    VEN3__Less_TradeIn__c,
                    VEN3__Principal_Amount__c,
                    VEN3__Email_Address__c,
                    VEN3__Phone__c,
                    VEN3__Partner_Program__c,
                    VEN3__Program_Partner_L__c,
                    VEN3__Position__c,
                    VEN3__Company_Name__c,
                    VEN3__Payments_to_Own__c
                    FROM VEN3__Calculator__c
                    WHERE VEN3__Lead__c = :selectedId
                ];
                if (calData.size() > 0) {
                    wrapperData.calcList = calData[0];
                }
                List<Lead> leadList = new List<Lead>();
                leadList = [Select Id, Name, FirstName, LastName, Company, Status, Email, Phone from Lead where Id = :selectedId];
                if (leadList.size() > 0) {
                    wrapperData.leadList = leadList[0];
                }
                return wrapperData;
            }
        } catch (Exception ex) {
            System.debug('Error::' + ex.getMessage() + ' ' + ex.getLineNumber());
        }
        return null;
    }
    public class retrunWrapperData {
        @AuraEnabled public Lead leadList { get; set; }
        @AuraEnabled public VEN3__Calculator__c calcList {
            get;
            set;
        }
    }
}