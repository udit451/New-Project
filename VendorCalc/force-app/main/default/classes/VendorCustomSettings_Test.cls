@IsTest
private class VendorCustomSettings_Test {
    @isTest 
    static void getExistingPriceSettings_Test() {
        //Id RecordTypeId = Schema.SObjectType.VEN3__Calculator_Settings__c.getRecordTypeInfosByName().get('Chase').getRecordTypeId();
        Set<Id> ProgramPartnerIdSet = new Set<Id>();
        VEN3__Program_Partner__c programPartnerObj = new VEN3__Program_Partner__c();
        programPartnerObj.Name = 'Test Program Partner NZ';
        programPartnerObj.VEN3__Active__c = true;
        programPartnerObj.VEN3__Goods_Type__c = 'Test Good1,Test Good2';
        programPartnerObj.VEN3__Address__c = 'Test Address';
        insert programPartnerObj;
        ProgramPartnerIdSet.add(programPartnerObj.Id);

        VEN3__Program_Partner__c programPartnerObject = new VEN3__Program_Partner__c();
        programPartnerObject.Name = 'Test Program Partner ABN';
        programPartnerObject.VEN3__Active__c = true;
        programPartnerObject.VEN3__Goods_Type__c = 'Test Program Good1,Test Program Good2';
        programPartnerObject.VEN3__Address__c = 'Test Partner Address';
        insert programPartnerObject;
        ProgramPartnerIdSet.add(programPartnerObject.Id);

        VEN3__Program_Partner__c ProgramPartner = new VEN3__Program_Partner__c();
        ProgramPartner.Name = 'Test Program Partner AUS';
        ProgramPartner.VEN3__Active__c = true;
        ProgramPartner.VEN3__Goods_Type__c = 'Program Partner Good1,Program Partner Good2';
        ProgramPartner.VEN3__Address__c = 'Test Program Address';
        insert ProgramPartner;
        ProgramPartnerIdSet.add(ProgramPartner.Id);

        List<VEN3__Calculator_Settings__c> calcSettingList = new List<VEN3__Calculator_Settings__c>();
        for(Integer i=0; i<5; i++){
            Set<Id> ProgramPartnerSet = new Set<Id>();
            ProgramPartnerSet = ProgramPartnerIdSet;
            Double randomNumber = Math.random();
            Integer arraySize = ProgramPartnerIdSet.size();
            Integer randomIndex = (randomNumber *(arraySize-1)).intValue();
            String programPartnerId = '';
            for (Id itr_var : ProgramPartnerSet){
                if (randomIndex == 0){
                    programPartnerId = itr_var;
                    break;
                }
                randomIndex--;
            }
            VEN3__Calculator_Settings__c calcSettingObj = new VEN3__Calculator_Settings__c();
            calcSettingObj.VEN3__Default_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__Default_Brokerage_Rate__c = 6.25;
            calcSettingObj.VEN3__X5Kto50K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X100Kto150K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X150Kto250K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X250Kto500K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X500Kto999K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X5Kto50K_Funder_Name__c = 'Test Funder1';
            calcSettingObj.VEN3__X50Kto100K_Funder_Name__c = 'Test Funder2';
            calcSettingObj.VEN3__X100Kto150K_Funder_Name__c = 'Test Funder3';
            calcSettingObj.VEN3__X150Kto250K_Funder_Name__c = 'Test Funder4';
            calcSettingObj.VEN3__X250Kto500K_Funder_Name__c = 'Test Funder5';
            calcSettingObj.VEN3__X500Kto999K_Funder_Name__c = 'Test Funder6';
            calcSettingObj.VEN3__X5Kto50K_Brokerage__c = 6.25;
            calcSettingObj.VEN3__X50Kto100K_Brokerage__c = 6.25;
            calcSettingObj.VEN3__X100Kto150K_Brokerage__c = 6.25;
            calcSettingObj.VEN3__X150Kto250_Brokerage__c = 6.25;
            calcSettingObj.VEN3__X250Kto500K_Brokerage__c = 6.25;
            calcSettingObj.VEN3__X500Kto999K_Brokerage__c = 6.25;
            calcSettingObj.VEN3__Term_months__c = 24;
            calcSettingObj.VEN3__Program_Partner__c = programPartnerId;
            calcSettingObj.VEN3__Facility_Type__c = 'Chattel Mortgage';
            //calcSettingObj.RecordTypeId = RecordTypeId;
            //calcSettingObj.VEN3__User__c = UserInfo.getUserId();
            calcSettingList.add(calcSettingObj);
        }
        Test.startTest();
        insert calcSettingList;
        List<VEN3__Calculator_Settings__c> returnedExistingSettingsList = VendorCustomSettings.getExistingPriceSettings_Apex(24, 'Chattel Mortgage');
        system.assertEquals(returnedExistingSettingsList.size(),5);
        system.assertEquals(returnedExistingSettingsList[0].VEN3__Term_months__c,24);
        //system.assertEquals(returnedExistingSettingsList[0].RecordTypeId,RecordTypeId);
        system.assertEquals(returnedExistingSettingsList[0].VEN3__Facility_Type__c,'Chattel Mortgage');
        system.assertEquals(returnedExistingSettingsList[4].VEN3__Term_months__c,24);
        //system.assertEquals(returnedExistingSettingsList[4].RecordTypeId,RecordTypeId);
        system.assertEquals(returnedExistingSettingsList[4].VEN3__Facility_Type__c,'Chattel Mortgage');
        Test.stopTest();
    }

    @isTest 
    static void getExistingPriceSettingsWithNullValues_Test() {
        Test.startTest();
        List<VEN3__Calculator_Settings__c> returnedResponseExistingSettingsList = VendorCustomSettings.getExistingPriceSettings_Apex(null, null);
        system.assertEquals(returnedResponseExistingSettingsList,null);
        Test.stopTest();
    }

    @isTest 
    static void saveEditPriceSettingWithProgramPartner_Test() {
        //Id RecordTypeId = Schema.SObjectType.Quote_Calculator_Setting__c.getRecordTypeInfosByName().get('Generic Quote').getRecordTypeId();
        VEN3__Program_Partner__c programPartnerObj = new VEN3__Program_Partner__c();
        programPartnerObj.Name = 'Test Program Partner';
        programPartnerObj.VEN3__Active__c = true;
        programPartnerObj.VEN3__Goods_Type__c = 'Test Good1,Test Good2';
        programPartnerObj.VEN3__Address__c = 'Test Address';
        insert programPartnerObj;

        VEN3__Calculator_Settings__c calcSettingObj = new VEN3__Calculator_Settings__c();
        calcSettingObj.VEN3__Default_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__Default_Brokerage_Rate__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X100Kto150K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X150Kto250K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X500Kto999K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X1000KAbove_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X5Kto50K_Funder_Name__c = 'Test Funder1';
        calcSettingObj.VEN3__X50Kto100K_Funder_Name__c = 'Test Funder2';
        calcSettingObj.VEN3__X100Kto150K_Funder_Name__c = 'Test Funder3';
        calcSettingObj.VEN3__X150Kto250K_Funder_Name__c = 'Test Funder4';
        calcSettingObj.VEN3__X250Kto500K_Funder_Name__c = 'Test Funder5';
        calcSettingObj.VEN3__X500Kto999K_Funder_Name__c = 'Test Funder6';
        calcSettingObj.VEN3__X5Kto50K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X100Kto150K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X150Kto250_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X250Kto500K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X500Kto999K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__Term_months__c = 24;
        calcSettingObj.VEN3__Program_Partner__c = programPartnerObj.Id;
        calcSettingObj.VEN3__Facility_Type__c = 'Chattel Mortgage';
        //calcSettingObj.RecordTypeId = RecordTypeId;
        //calcSettingObj.VEN3__User__c = UserInfo.getUserId();
        insert calcSettingObj;

        calcSettingObj.VEN3__X5Kto50K_Funder_Name__c = 'Test Edited Funder1';
        calcSettingObj.VEN3__X50Kto100K_Funder_Name__c = 'Test Edited Funder2';

        Test.startTest();
        VEN3__Calculator_Settings__c returnedEditedProgramPartnerSetting = VendorCustomSettings.saveEditPriceSetting_Apex(JSON.serialize(calcSettingObj));
        system.assertEquals(returnedEditedProgramPartnerSetting.VEN3__X5Kto50K_Funder_Name__c,'Test Edited Funder1');
        system.assertEquals(returnedEditedProgramPartnerSetting.VEN3__X50Kto100K_Funder_Name__c,'Test Edited Funder2');
        //system.assertEquals(returnedEditedProgramPartnerSetting.RecordTypeId,RecordTypeId);
        system.assertEquals(returnedEditedProgramPartnerSetting.VEN3__Term_months__c,24);
        system.assertEquals(returnedEditedProgramPartnerSetting.VEN3__Facility_Type__c,'Chattel Mortgage');
        //system.assertEquals(returnedEditedProgramPartnerSetting.VEN3__User__c,UserInfo.getUserId());
        Test.stopTest();
    }

    @isTest static void saveEditPriceSettingWithGoodsType_Test() {
        //Id RecordTypeId = Schema.SObjectType.Quote_Calculator_Setting__c.getRecordTypeInfosByName().get('Generic Quote').getRecordTypeId();
        VEN3__Calculator_Settings__c calcSettingObj = new VEN3__Calculator_Settings__c();
        calcSettingObj.VEN3__Default_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__Default_Brokerage_Rate__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X100Kto150K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X150Kto250K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X500Kto999K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X1000KAbove_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X5Kto50K_Funder_Name__c = 'Test Funder1';
        calcSettingObj.VEN3__X50Kto100K_Funder_Name__c = 'Test Funder2';
        calcSettingObj.VEN3__X100Kto150K_Funder_Name__c = 'Test Funder3';
        calcSettingObj.VEN3__X150Kto250K_Funder_Name__c = 'Test Funder4';
        calcSettingObj.VEN3__X250Kto500K_Funder_Name__c = 'Test Funder5';
        calcSettingObj.VEN3__X500Kto999K_Funder_Name__c = 'Test Funder6';
        calcSettingObj.VEN3__X5Kto50K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X100Kto150K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X150Kto250_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X250Kto500K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X500Kto999K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__Term_months__c = 24;
        calcSettingObj.VEN3__Goods_Type__c = 'Agricultural';
        calcSettingObj.VEN3__Facility_Type__c = 'Chattel Mortgage';
        //calcSettingObj.RecordTypeId = RecordTypeId;
        //calcSettingObj.VEN3__User__c = UserInfo.getUserId();
        insert calcSettingObj;

        calcSettingObj.VEN3__X5Kto50K_Funder_Name__c = 'Test Edited Funder1';
        calcSettingObj.VEN3__X50Kto100K_Funder_Name__c = 'Test Edited Funder2';

        Test.startTest();
        VEN3__Calculator_Settings__c returnedEditedAssetsSetting = VendorCustomSettings.saveEditPriceSetting_Apex(JSON.serialize(calcSettingObj));
        system.assertEquals(returnedEditedAssetsSetting.VEN3__X5Kto50K_Funder_Name__c,'Test Edited Funder1');
        system.assertEquals(returnedEditedAssetsSetting.VEN3__X50Kto100K_Funder_Name__c,'Test Edited Funder2');
        //system.assertEquals(returnedEditedAssetsSetting.RecordTypeId,RecordTypeId);
        system.assertEquals(returnedEditedAssetsSetting.VEN3__Term_months__c,24);
        system.assertEquals(returnedEditedAssetsSetting.VEN3__Goods_Type__c,'Agricultural');
        system.assertEquals(returnedEditedAssetsSetting.VEN3__Facility_Type__c,'Chattel Mortgage');
        //system.assertEquals(returnedEditedAssetsSetting.VEN3__User__c,UserInfo.getUserId());
        Test.stopTest();
    }

    @isTest static void saveEditPriceSettingWithNullValues_Test() {
        Test.startTest();
        VEN3__Calculator_Settings__c returnedResponseEditedSetting = VendorCustomSettings.saveEditPriceSetting_Apex(null);
        system.assertEquals(returnedResponseEditedSetting,null);
        Test.stopTest();
    }

    @isTest static void saveProgramPriceSettings_Test() {
        //Id RecordTypeId = Schema.SObjectType.VEN3__Calculator_Settings__c.getRecordTypeInfosByName().get('Chase').getRecordTypeId();
        VEN3__Program_Partner__c programPartnerObj = new VEN3__Program_Partner__c();
        programPartnerObj.Name = 'Test Program Partner';
        programPartnerObj.VEN3__Active__c = true;
        programPartnerObj.VEN3__Goods_Type__c = 'Test Good1,Test Good2';
        programPartnerObj.VEN3__Address__c = 'Test Address';
        insert programPartnerObj;

        VEN3__Calculator_Settings__c calcSettingObject = new VEN3__Calculator_Settings__c();
        calcSettingObject.VEN3__Default_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__Default_Brokerage_Rate__c = 6.75;
        calcSettingObject.VEN3__X50Kto100K_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X50Kto100K_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X100Kto150K_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X150Kto250K_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X500Kto999K_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X1000KAbove_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X5Kto50K_Funder_Name__c = 'Test Existing Funder1';
        calcSettingObject.VEN3__X50Kto100K_Funder_Name__c = 'Test Existing Funder2';
        calcSettingObject.VEN3__X100Kto150K_Funder_Name__c = 'Test Existing Funder3';
        calcSettingObject.VEN3__X150Kto250K_Funder_Name__c = 'Test Existing Funder4';
        calcSettingObject.VEN3__X250Kto500K_Funder_Name__c = 'Test Existing Funder5';
        calcSettingObject.VEN3__X500Kto999K_Funder_Name__c = 'Test Existing Funder6';
        calcSettingObject.VEN3__X5Kto50K_Brokerage__c = 6.75;
        calcSettingObject.VEN3__X50Kto100K_Brokerage__c = 6.75;
        calcSettingObject.VEN3__X100Kto150K_Brokerage__c = 6.75;
        calcSettingObject.VEN3__X150Kto250_Brokerage__c = 6.75;
        calcSettingObject.VEN3__X250Kto500K_Brokerage__c = 6.75;
        calcSettingObject.VEN3__X500Kto999K_Brokerage__c = 6.75;
        calcSettingObject.VEN3__Term_months__c = 24;
        calcSettingObject.VEN3__Program_Partner__c = programPartnerObj.Id;
        calcSettingObject.VEN3__Facility_Type__c = 'Chattel Mortgage';
        //calcSettingObject.RecordTypeId = RecordTypeId;
        //calcSettingObject.VEN3__User__c = UserInfo.getUserId();
        insert calcSettingObject;

        VEN3__Calculator_Settings__c calcSettingObj = new VEN3__Calculator_Settings__c();
        calcSettingObj.VEN3__Default_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__Default_Brokerage_Rate__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X100Kto150K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X150Kto250K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X500Kto999K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X1000KAbove_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X5Kto50K_Funder_Name__c = 'Test Inserted Funder1';
        calcSettingObj.VEN3__X50Kto100K_Funder_Name__c = 'Test Inserted Funder2';
        calcSettingObj.VEN3__X100Kto150K_Funder_Name__c = 'Test Inserted Funder3';
        calcSettingObj.VEN3__X150Kto250K_Funder_Name__c = 'Test Inserted Funder4';
        calcSettingObj.VEN3__X250Kto500K_Funder_Name__c = 'Test Inserted Funder5';
        calcSettingObj.VEN3__X500Kto999K_Funder_Name__c = 'Test Inserted Funder6';
        calcSettingObj.VEN3__X5Kto50K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X100Kto150K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X150Kto250_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X250Kto500K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X500Kto999K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__Term_months__c = 24;
        calcSettingObj.VEN3__Program_Partner__c = programPartnerObj.Id;

        Test.startTest();
        String returnedSavedProgramPricing = VendorCustomSettings.saveProgramPriceSettings_Apex(JSON.serialize(calcSettingObj), 'Chattel Mortgage');
        system.assertEquals(returnedSavedProgramPricing,'Old');
        /*system.assertEquals(returnedSavedProgramPricing.VEN3__X500Kto999K_Funder_Name__c,'Test Inserted Funder6');
        system.assertEquals(returnedSavedProgramPricing.VEN3__Term_months__c,24);
        system.assertEquals(returnedSavedProgramPricing.VEN3__Program_Partner__c,programPartnerObj.Id);
        system.assertEquals(returnedSavedProgramPricing.VEN3__Facility_Type__c,'Chattel Mortgage');
        //system.assertEquals(returnedSavedProgramPricing.RecordTypeId,RecordTypeId);
        //system.assertEquals(returnedSavedProgramPricing.VEN3__User__c,UserInfo.getUserId());*/
        Test.stopTest();
    }

    @isTest static void saveProgramPriceSettingsWithNullValues_Test() {
        Test.startTest();
        String returnedResponseSavedProgramPricing = VendorCustomSettings.saveProgramPriceSettings_Apex(null, null);
        system.assertEquals(returnedResponseSavedProgramPricing,null);
        Test.stopTest();
    }

    @isTest static void saveAssetsPriceSettings_Test() {
        //Id RecordTypeId = Schema.SObjectType.VEN3__Calculator_Settings__c.getRecordTypeInfosByName().get('Chase').getRecordTypeId();
        String goodsType = '["Coffee Machines","Motor Vehicle"]';

        VEN3__Calculator_Settings__c calcSettingObject = new VEN3__Calculator_Settings__c();
        calcSettingObject.VEN3__Default_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__Default_Brokerage_Rate__c = 6.75;
        calcSettingObject.VEN3__X50Kto100K_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X50Kto100K_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X100Kto150K_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X150Kto250K_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X500Kto999K_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X1000KAbove_Base_Rate__c = 5.75;
        calcSettingObject.VEN3__X5Kto50K_Funder_Name__c = 'Test Existing Funder1';
        calcSettingObject.VEN3__X50Kto100K_Funder_Name__c = 'Test Existing Funder2';
        calcSettingObject.VEN3__X100Kto150K_Funder_Name__c = 'Test Existing Funder3';
        calcSettingObject.VEN3__X150Kto250K_Funder_Name__c = 'Test Existing Funder4';
        calcSettingObject.VEN3__X250Kto500K_Funder_Name__c = 'Test Existing Funder5';
        calcSettingObject.VEN3__X500Kto999K_Funder_Name__c = 'Test Existing Funder6';
        calcSettingObject.VEN3__X5Kto50K_Brokerage__c = 6.75;
        calcSettingObject.VEN3__X50Kto100K_Brokerage__c = 6.75;
        calcSettingObject.VEN3__X100Kto150K_Brokerage__c = 6.75;
        calcSettingObject.VEN3__X150Kto250_Brokerage__c = 6.75;
        calcSettingObject.VEN3__X250Kto500K_Brokerage__c = 6.75;
        calcSettingObject.VEN3__X500Kto999K_Brokerage__c = 6.75;
        calcSettingObject.VEN3__Term_months__c = 24;
        calcSettingObject.VEN3__Goods_Type__c = 'Coffee Machines';
        calcSettingObject.VEN3__Facility_Type__c = 'Chattel Mortgage';
        //calcSettingObject.RecordTypeId = RecordTypeId;
        //calcSettingObject.VEN3__User__c = UserInfo.getUserId();
        insert calcSettingObject;

        VEN3__Calculator_Settings__c calcSettingObj = new VEN3__Calculator_Settings__c();
        calcSettingObj.VEN3__Default_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__Default_Brokerage_Rate__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X100Kto150K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X150Kto250K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X500Kto999K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X1000KAbove_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X5Kto50K_Funder_Name__c = 'Test Funder1';
        calcSettingObj.VEN3__X50Kto100K_Funder_Name__c = 'Test Funder2';
        calcSettingObj.VEN3__X100Kto150K_Funder_Name__c = 'Test Funder3';
        calcSettingObj.VEN3__X150Kto250K_Funder_Name__c = 'Test Funder4';
        calcSettingObj.VEN3__X250Kto500K_Funder_Name__c = 'Test Funder5';
        calcSettingObj.VEN3__X500Kto999K_Funder_Name__c = 'Test Funder6';
        calcSettingObj.VEN3__X5Kto50K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X100Kto150K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X150Kto250_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X250Kto500K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X500Kto999K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__Term_months__c = 24;
        calcSettingObj.VEN3__Facility_Type__c = 'Chattel Mortgage';
        //calcSettingObj.RecordTypeId = RecordTypeId;
        //calcSettingObj.VEN3__User__c = UserInfo.getUserId();

        Test.startTest();
        List<VEN3__Calculator_Settings__c> returnedSavedAssetsPricing = VendorCustomSettings.saveAssetsPriceSettings_Apex(JSON.serialize(calcSettingObj), 'Chattel Mortgage', goodsType, 'Chase');
        system.assertEquals(returnedSavedAssetsPricing[0].VEN3__Goods_Type__c,'Coffee Machines');
        system.assertEquals(returnedSavedAssetsPricing[0].VEN3__Term_months__c,24);
        //system.assertEquals(returnedSavedAssetsPricing[0].RecordTypeId,RecordTypeId);
        system.assertEquals(returnedSavedAssetsPricing[0].VEN3__Facility_Type__c,'Chattel Mortgage');
        system.assertEquals(returnedSavedAssetsPricing[1].VEN3__Goods_Type__c,'Motor Vehicle');
        system.assertEquals(returnedSavedAssetsPricing[1].VEN3__Term_months__c,24);
        //system.assertEquals(returnedSavedAssetsPricing[1].RecordTypeId,RecordTypeId);
        system.assertEquals(returnedSavedAssetsPricing[1].VEN3__Facility_Type__c,'Chattel Mortgage');
        Test.stopTest();
    }

    @isTest static void saveAssetsPriceSettingsWithNullValues_Test() {
        Test.startTest();
        List<VEN3__Calculator_Settings__c> returnedResponseSavedAssetsPricing = VendorCustomSettings.saveAssetsPriceSettings_Apex(null, null, null, null);
        system.assertEquals(returnedResponseSavedAssetsPricing,null);
        Test.stopTest();
    }

    @isTest static void deletePriceSetting_Test() {
        //Id RecordTypeId = Schema.SObjectType.Quote_Calculator_Setting__c.getRecordTypeInfosByName().get('Generic Quote').getRecordTypeId();
        VEN3__Program_Partner__c programPartnerObj = new VEN3__Program_Partner__c();
        programPartnerObj.Name = 'Test Program Partner';
        programPartnerObj.VEN3__Active__c = true;
        programPartnerObj.VEN3__Goods_Type__c = 'Test Good1,Test Good2';
        programPartnerObj.VEN3__Address__c = 'Test Address';
        insert programPartnerObj;

        VEN3__Calculator_Settings__c calcSettingObj = new VEN3__Calculator_Settings__c();
        calcSettingObj.VEN3__Default_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__Default_Brokerage_Rate__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X100Kto150K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X150Kto250K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X500Kto999K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X1000KAbove_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X5Kto50K_Funder_Name__c = 'Test Funder1';
        calcSettingObj.VEN3__X50Kto100K_Funder_Name__c = 'Test Funder2';
        calcSettingObj.VEN3__X100Kto150K_Funder_Name__c = 'Test Funder3';
        calcSettingObj.VEN3__X150Kto250K_Funder_Name__c = 'Test Funder4';
        calcSettingObj.VEN3__X500Kto999K_Funder_Name__c = 'Test Funder6';
        calcSettingObj.VEN3__X250Kto500K_Funder_Name__c = 'Test Funder5';
        calcSettingObj.VEN3__X5Kto50K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X100Kto150K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X150Kto250_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X250Kto500K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X500Kto999K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__Term_months__c = 24;
        calcSettingObj.VEN3__Program_Partner__c = programPartnerObj.Id;
        calcSettingObj.VEN3__Facility_Type__c = 'Chattel Mortgage';
        //calcSettingObj.RecordTypeId = RecordTypeId;
        //calcSettingObj.VEN3__User__c = UserInfo.getUserId();

        Test.startTest();
        insert calcSettingObj;
        Boolean returnedResponse = VendorCustomSettings.deletePriceSetting_Apex(calcSettingObj.Id);
        system.assert(returnedResponse);
        Test.stopTest();
    }

    @isTest static void deletePriceSettingWithNullValues_Test() {
        Test.startTest();
        Boolean returnedResponseBoolean = VendorCustomSettings.deletePriceSetting_Apex(null);
        system.assertEquals(returnedResponseBoolean,false);
        Test.stopTest();
    }

    @isTest static void saveCopyProgramPricing_Test() {
        //Id RecordTypeId = Schema.SObjectType.VEN3__Calculator_Settings__c.getRecordTypeInfosByName().get('Chase').getRecordTypeId();
        VEN3__Program_Partner__c programPartnerObj = new VEN3__Program_Partner__c();
        programPartnerObj.Name = 'Test Program Partner';
        programPartnerObj.VEN3__Active__c = true;
        programPartnerObj.VEN3__Goods_Type__c = 'Test Good1,Test Good2';
        programPartnerObj.VEN3__Address__c = 'Test Address';
        insert programPartnerObj;

        VEN3__Calculator_Settings__c calcSettingObj = new VEN3__Calculator_Settings__c();
        calcSettingObj.VEN3__Default_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__Default_Brokerage_Rate__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X100Kto150K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X150Kto250K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X500Kto999K_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X1000KAbove_Base_Rate__c = 5.15;
        calcSettingObj.VEN3__X5Kto50K_Funder_Name__c = 'Test Funder1';
        calcSettingObj.VEN3__X50Kto100K_Funder_Name__c = 'Test Funder2';
        calcSettingObj.VEN3__X100Kto150K_Funder_Name__c = 'Test Funder3';
        calcSettingObj.VEN3__X150Kto250K_Funder_Name__c = 'Test Funder4';
        calcSettingObj.VEN3__X500Kto999K_Funder_Name__c = 'Test Funder6';
        calcSettingObj.VEN3__X250Kto500K_Funder_Name__c = 'Test Funder5';
        calcSettingObj.VEN3__X5Kto50K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X50Kto100K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X100Kto150K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X150Kto250_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X250Kto500K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__X500Kto999K_Brokerage__c = 6.25;
        calcSettingObj.VEN3__Term_months__c = 24;
        calcSettingObj.VEN3__Program_Partner__c = programPartnerObj.Id;
        calcSettingObj.VEN3__Facility_Type__c = 'Chattel Mortgage';
        //calcSettingObj.RecordTypeId = RecordTypeId;
        //calcSettingObj.VEN3__User__c = UserInfo.getUserId();

        Test.startTest();
        VEN3__Calculator_Settings__c returnedCopySetting = VendorCustomSettings.saveCopyProgramPricing_Apex(JSON.serialize(calcSettingObj), true);
        system.assertEquals(returnedCopySetting.VEN3__Term_months__c,24);
        system.assertEquals(returnedCopySetting.VEN3__Program_Partner__c,programPartnerObj.Id);
        system.assertEquals(returnedCopySetting.VEN3__Facility_Type__c,'Chattel Mortgage');
        //system.assertEquals(returnedCopySetting.RecordTypeId,RecordTypeId);
        //system.assertEquals(returnedCopySetting.VEN3__User__c,UserInfo.getUserId());
        Test.stopTest();
    }

    @isTest static void saveCopyProgramPricingWithNullValues_Test() {
        Test.startTest();
        VEN3__Calculator_Settings__c returnedResponseCopySetting = VendorCustomSettings.saveCopyProgramPricing_Apex(null, false);
        system.assertEquals(returnedResponseCopySetting,null);
        Test.stopTest();
    }

    @isTest static void saveCopyAssetPricing_Test() {
        //Id RecordTypeId = Schema.SObjectType.VEN3__Calculator_Settings__c.getRecordTypeInfosByName().get('Chase').getRecordTypeId();
        String existingGoodsType = '["Coffee Machines","Motor Vehicle"]';
        List<String> goodsType = new List<String>{'Coffee Machines','Motor Vehicle'};
        String SelectedGoodsType = '["Coffee Machines","Motor Vehicle","ATM’s"]';
        List<VEN3__Calculator_Settings__c> calcSettingList = new List<VEN3__Calculator_Settings__c>();
        for(String strType: goodsType) {
            VEN3__Calculator_Settings__c calcSettingObj = new VEN3__Calculator_Settings__c();
            calcSettingObj.VEN3__Default_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__Default_Brokerage_Rate__c = 6.25;
            calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X50Kto100K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X100Kto150K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X150Kto250K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X500Kto999K_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X1000KAbove_Base_Rate__c = 5.15;
            calcSettingObj.VEN3__X5Kto50K_Funder_Name__c = 'Test Funder1';
            calcSettingObj.VEN3__X50Kto100K_Funder_Name__c = 'Test Funder2';
            calcSettingObj.VEN3__X100Kto150K_Funder_Name__c = 'Test Funder3';
            calcSettingObj.VEN3__X150Kto250K_Funder_Name__c = 'Test Funder4';
            calcSettingObj.VEN3__X500Kto999K_Funder_Name__c = 'Test Funder6';
            calcSettingObj.VEN3__X250Kto500K_Funder_Name__c = 'Test Funder5';
            calcSettingObj.VEN3__X5Kto50K_Brokerage__c = 6.25;
            calcSettingObj.VEN3__X50Kto100K_Brokerage__c = 6.25;
            calcSettingObj.VEN3__X100Kto150K_Brokerage__c = 6.25;
            calcSettingObj.VEN3__X150Kto250_Brokerage__c = 6.25;
            calcSettingObj.VEN3__X250Kto500K_Brokerage__c = 6.25;
            calcSettingObj.VEN3__X500Kto999K_Brokerage__c = 6.25;
            calcSettingObj.VEN3__Term_months__c = 24;
            calcSettingObj.VEN3__Goods_Type__c = strType;
            calcSettingObj.VEN3__Facility_Type__c = 'Chattel Mortgage';
            //calcSettingObj.RecordTypeId = RecordTypeId;
            //calcSettingObj.VEN3__User__c = UserInfo.getUserId();
            calcSettingList.add(calcSettingObj);
        }
        insert calcSettingList;

        VEN3__Calculator_Settings__c calcSettingObject = new VEN3__Calculator_Settings__c();
        calcSettingObject.VEN3__Default_Base_Rate__c = 5.15;
        calcSettingObject.VEN3__Default_Brokerage_Rate__c = 6.25;
        calcSettingObject.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObject.VEN3__X50Kto100K_Base_Rate__c = 5.15;
        calcSettingObject.VEN3__X100Kto150K_Base_Rate__c = 5.15;
        calcSettingObject.VEN3__X150Kto250K_Base_Rate__c = 5.15;
        calcSettingObject.VEN3__X500Kto999K_Base_Rate__c = 5.15;
        calcSettingObject.VEN3__X1000KAbove_Base_Rate__c = 5.15;
        calcSettingObject.VEN3__X5Kto50K_Funder_Name__c = 'Test Funder1';
        calcSettingObject.VEN3__X50Kto100K_Funder_Name__c = 'Test Funder2';
        calcSettingObject.VEN3__X100Kto150K_Funder_Name__c = 'Test Funder3';
        calcSettingObject.VEN3__X150Kto250K_Funder_Name__c = 'Test Funder4';
        calcSettingObject.VEN3__X500Kto999K_Funder_Name__c = 'Test Funder6';
        calcSettingObject.VEN3__X250Kto500K_Funder_Name__c = 'Test Funder5';
        calcSettingObject.VEN3__X5Kto50K_Brokerage__c = 6.25;
        calcSettingObject.VEN3__X50Kto100K_Brokerage__c = 6.25;
        calcSettingObject.VEN3__X100Kto150K_Brokerage__c = 6.25;
        calcSettingObject.VEN3__X150Kto250_Brokerage__c = 6.25;
        calcSettingObject.VEN3__X250Kto500K_Brokerage__c = 6.25;
        calcSettingObject.VEN3__X500Kto999K_Brokerage__c = 6.25;
        calcSettingObject.VEN3__Term_months__c = 24;
        calcSettingObject.VEN3__Facility_Type__c = 'Chattel Mortgage';

        Test.startTest();
        List<VEN3__Calculator_Settings__c> returnedCopyAssetsPricing = VendorCustomSettings.saveCopyAssetPricing_Apex( JSON.serialize(calcSettingObject), SelectedGoodsType, existingGoodsType, 'Chase');
        system.assertEquals(returnedCopyAssetsPricing.size(),3);
        system.assertEquals(returnedCopyAssetsPricing[0].VEN3__Term_months__c,24);
        system.assertEquals(returnedCopyAssetsPricing[0].VEN3__Goods_Type__c,'Coffee Machines');
        system.assertEquals(returnedCopyAssetsPricing[0].VEN3__Facility_Type__c,'Chattel Mortgage');
        //system.assertEquals(returnedCopyAssetsPricing[0].RecordTypeId,RecordTypeId);
        system.assertEquals(returnedCopyAssetsPricing[1].VEN3__Term_months__c,24);
        system.assertEquals(returnedCopyAssetsPricing[1].VEN3__Goods_Type__c,'Motor Vehicle');
        system.assertEquals(returnedCopyAssetsPricing[1].VEN3__Facility_Type__c,'Chattel Mortgage');
        //system.assertEquals(returnedCopyAssetsPricing[1].RecordTypeId,RecordTypeId);
        system.assertEquals(returnedCopyAssetsPricing[2].VEN3__Term_months__c,24);
        system.assertEquals(returnedCopyAssetsPricing[2].VEN3__Goods_Type__c,'ATM’s');
        system.assertEquals(returnedCopyAssetsPricing[2].VEN3__Facility_Type__c,'Chattel Mortgage');
        //system.assertEquals(returnedCopyAssetsPricing[2].RecordTypeId,RecordTypeId);
        Test.stopTest();
    }

    @isTest static void saveCopyAssetPricingWithNullValues_Test() {
        Test.startTest();
        List<VEN3__Calculator_Settings__c> returnedResponseCopyAssetsPricing = VendorCustomSettings.saveCopyAssetPricing_Apex(null, null, null, null);
        system.assertEquals(returnedResponseCopyAssetsPricing,null);
        Test.stopTest();
    }
}