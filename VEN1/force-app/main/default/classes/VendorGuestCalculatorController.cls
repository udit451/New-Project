//This is the controller class for MatrixGuestCalculator Component
public without sharing class VendorGuestCalculatorController {
    @AuraEnabled
    public static UserDetailsStatusWrapper authenticateUser_Apex(String userName, String password) {
        
        if(userName != null && password != null){
            UserDetailsStatusWrapper userDetailWrapper = new UserDetailsStatusWrapper();
            List<VEN3__Vendor_Guest_User__c> matrixGuestUserList = new List<VEN3__Vendor_Guest_User__c>();
            String status = '';
            matrixGuestUserList = [Select Id, Name, VEN3__Password__c, VEN3__Email__c, VEN3__Username__c, VEN3__Program_Partner__c,VEN3__Program_Partner__r.Name, VEN3__isActive__c from VEN3__Vendor_Guest_User__c where VEN3__Username__c =: userName and VEN3__Password__c =: password limit 1];
            system.debug('matrixGuestUserList :: '+matrixGuestUserList);
            if(matrixGuestUserList.size() > 0){
                List<VEN3__Program_Partner__c> prgramPartnerList = new List<VEN3__Program_Partner__c>();
                prgramPartnerList = [Select Id, VEN3__Active__c From VEN3__Program_Partner__c Where Id =: matrixGuestUserList[0].VEN3__Program_Partner__c];
                
                system.debug('prgramPartnerList :: '+prgramPartnerList);
                userDetailWrapper.matrixUser = matrixGuestUserList[0];
                if(matrixGuestUserList[0].VEN3__isActive__c && prgramPartnerList[0].VEN3__Active__c){
                    userDetailWrapper.status = 'Active User';
                }else{
                    userDetailWrapper.status = 'InActive User';
                }
            }else{
                userDetailWrapper.status = 'Invalid User';
            }
            return userDetailWrapper;
        }
        return null;
    }
    
    @AuraEnabled
    public static leadCalculatorWrapper getRelatedRecords_Apex(String program) {
        
        if(program != null){
            List<Lead> leadList = new List<Lead>();
            leadCalculatorWrapper leadcalcWrapper = new leadCalculatorWrapper();
            List<VEN3__Calculator__c> calculatorRecordList = new List<VEN3__Calculator__c>();
            Id RecordTypeId = Schema.SObjectType.VEN3__Calculator__c.getRecordTypeInfosByName().get('Chase Finance').getRecordTypeId();
            
            calculatorRecordList = [SELECT
                                    Id,
                                    Name,
                                    VEN3__Additional_Payment__c,
                                    VEN3__Amount_Financed__c,
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
                                    WHERE VEN3__Program_Partner_L__c = :program and RecordTypeId =: RecordTypeId and VEN3__Lead__c != ''];
            if(calculatorRecordList.size() > 0){
                
                Id RecId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Chase Vendor').getRecordTypeId();
                Set<Id> calcRecordSet = new Set<Id>();
                for(VEN3__Calculator__c calcObj : calculatorRecordList){
                    calcRecordSet.add(calcObj.VEN3__Lead__c);
                }
                if(calcRecordSet.size() > 0){
                    leadList = [Select Id, Name,Company, VEN3__Amount__c,VEN3__Date__c,Status, Email, Phone,OwnerId,VEN3__Vendor_Guest_User__r.VEN3__Username__c,VEN3__Vendor_Guest_User__r.Name  from Lead where Id in: calcRecordSet and  RecordTypeId =: RecId and VEN3__Vendor_Guest_User__c != '' ORDER BY CreatedDate DESC];
                }
               
            }
            leadcalcWrapper.leadList = leadList;
            leadcalcWrapper.calcList = calculatorRecordList;
           
            return leadcalcWrapper;
        }
        return null;
    }
    
    public class UserDetailsStatusWrapper{
        @AuraEnabled public VEN3__Vendor_Guest_User__c matrixUser{get;set;}
        @AuraEnabled public String status{get;set;}
    }
    
    public class leadCalculatorWrapper{
        @AuraEnabled public List<Lead> leadList{get;set;}
        @AuraEnabled public List<VEN3__Calculator__c> calcList{get;set;}
    }
}