//This is the controller class for MatrixGuestCalculator Component
public class MatrixGuestCalculatorController {
    /*@AuraEnabled
    public static UserDetailsStatusWrapper authenticateUser_Apex(String userName, String password) {

        if(userName != null && password != null){
            UserDetailsStatusWrapper userDetailWrapper = new UserDetailsStatusWrapper();
            List<Matrix_Guest_User__c> matrixGuestUserList = new List<Matrix_Guest_User__c>();
            String status = '';
            matrixGuestUserList = [Select Id, Name, Password__c, Email__c, Username__c, Partner__c,Partner__r.Name, isActive__c from Matrix_Guest_User__c where Username__c =: userName and Password__c =: password limit 1];
            if(matrixGuestUserList.size() > 0){
                List<Program_Partner__c> prgramPartnerList = new List<Program_Partner__c>();
                prgramPartnerList = [Select Id, Active__c From Program_Partner__c Where Id =: matrixGuestUserList[0].Partner__c];
                userDetailWrapper.matrixUser = matrixGuestUserList[0];
                if(matrixGuestUserList[0].isActive__c && prgramPartnerList[0].Active__c){
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
            List<Calculator__c> calculatorRecordList = new List<Calculator__c>();
            Id RecordTypeId = Schema.SObjectType.Calculator__c.getRecordTypeInfosByName().get('Supplier Quote').getRecordTypeId();

            calculatorRecordList = [SELECT
            Id,
            Name,
            Additional_Payment__c,
            Additional_period__c,
            Amount_Financed__c,
            Ballon__c,
            Balloon_c__c,
            customer_Rate_Expected__c,
            customer_Rate_Non_Published__c,
            Date__c,
            Desired_Brokerage_Incl_GST_c__c,
            Desired_Brokerage_Incl_GST_p__c,
            Document_Fee_Disclosed__c,
            Fees_Other_Disclosed__c,
            Goods_Type__c,
            Incl_GST_c__c,
            Lead__c,
            Loan_Facility_Type__c,
            Opportunity__c,
            Please_enter_your_desired_Base_Rate_here__c,
            PPSR_Fees_Disclosed__c,
            Published_Base_Rate__c,
            Repayment_Expected_c__c,
            Repayment_Non_Published__c,
            Repayment_Frequency__c,
            Repayment_Type__c,
            State__c,
            Term_months__c,
            Document_Fee_Financed__c,
            PPSR_Fee_Financed__c,
            Fee_Other_Financed__c,
            ITC_Level__c,
            Total_Incl_GST_GST__c,
            Unclaimable_GST__c,
            GST__c,
            Establishment_Fee_Disclosed__c,
            Establishment_Fee_Financed__c,
            Cost_Price_Exc_GST__c,
            Cost_Price_Inc_GST__c,
            Less_Deposite__c,
            Less_TradeIn__c,
            Principal_Amount__c,
            Total_Incl_GST_c__c,
            Email_Address__c,
            Phone__c,
            Partner_Program__c,
            Program_Partner_L__c,
            Position__c,
            Company_Name__c,
            Payments_to_Own__c
            FROM Calculator__c
            WHERE Program_Partner_L__c = :program and RecordTypeId =: RecordTypeId and Lead__c != ''];

            if(calculatorRecordList.size() > 0){
                Id RecId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('MFG Vendor').getRecordTypeId();
                Set<Id> calcRecordSet = new Set<Id>();
                for(Calculator__c calcObj : calculatorRecordList){
                    calcRecordSet.add(calcObj.Lead__c);
                }
                if(calcRecordSet.size() > 0){
                    leadList = [Select Id, Name,Company, Amount_Financed__c, Date__c, Status, Email, Phone,OwnerId,Matrix_Guest_User__r.Username__c,Matrix_Guest_User__r.Name, Term__c  from Lead where Id in: calcRecordSet and  RecordTypeId =: RecId and Matrix_Guest_User__c != '' ORDER BY CreatedDate DESC];
                }
            }
            leadcalcWrapper.leadList = leadList;
            leadcalcWrapper.calcList = calculatorRecordList;
            
            return leadcalcWrapper;
        }
        return null;
    }

    public class UserDetailsStatusWrapper{
        @AuraEnabled public Matrix_Guest_User__c matrixUser{get;set;}
        @AuraEnabled public String status{get;set;}
    }

    public class leadCalculatorWrapper{
        @AuraEnabled public List<Lead> leadList{get;set;}
        @AuraEnabled public List<Calculator__c> calcList{get;set;}
    }*/
}