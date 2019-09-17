public without sharing class VendorCustomSettings {
    @AuraEnabled
    public static List<VEN3__Calculator_Settings__c> getExistingPriceSettings_Apex(Integer term, String LoanFacilityType) {
        if(term != null && LoanFacilityType != null){
            try{
                List<VEN3__Calculator_Settings__c> existingPriceSettings = new List<VEN3__Calculator_Settings__c>();
                List<String> Fields = getAllFields('VEN3__Calculator_Settings__c');
                String fieldStr = '';
                Integer i = 0;
                for (String str : Fields) {
                    if (i != Fields.size() - 1) {
                        fieldStr = fieldStr + str + ',';
                    } else {
                        fieldStr = fieldStr + str; 
                    }
                    i++;
                }
                system.debug('term>>'+term);
                String strQuery = 'Select ' + fieldStr + ', VEN3__Program_Partner__r.Name from VEN3__Calculator_Settings__c WHERE VEN3__Facility_Type__c = :LoanFacilityType and VEN3__Term_months__c = :term limit 10000';
                existingPriceSettings = Database.query(strQuery);
                system.debug('existingPriceSettings>>'+existingPriceSettings);
                return existingPriceSettings;
            } catch (Exception ex) {
                system.debug('Error at Line ' + ex.getLineNumber());
                system.debug('Error Message ' + ex.getMessage());
            }
        }
        return null;
    }

    public static list<string> getAllFields(string objName) {
        list<String> allFields = new list<String>();
        objName = objName.substring(0, 1).toLowerCase() + objName.substring(1, objName.length());
        Map<String, Schema.SObjectField> objectFieldsMap =
                Schema.getGlobalDescribe().get(objName).getDescribe().fields.getMap();

        set<String> fieldSet = objectFieldsMap.keySet();
        for (string s : fieldSet) {
            if (s != 'Id') {
                if (s.endsWithIgnoreCase('id'))
                    s = s.toUpperCase(); else
                        s = s.substring(0, 1).toUpperCase() + s.substring(1, s.length());
                allFields.add(s);
            }
        }
        allFields.sort();
        if(allFields.size() > 0){
            return allFields;
        }
        return null;
    }

    @AuraEnabled
    public static VEN3__Calculator_Settings__c saveEditPriceSetting_Apex(String priceSetting){
        if(priceSetting != null) {
            try {
                VEN3__Calculator_Settings__c priceSettingList =
                        (VEN3__Calculator_Settings__c) JSON.deserialize(priceSetting,
                                        VEN3__Calculator_Settings__c.class);
                if (priceSettingList != null) {
                    upsert priceSettingList;
                    return priceSettingList;
                }
            } catch (Exception ex) {
                system.debug('Error at Line ' + ex.getLineNumber());
                system.debug('Error Message ' + ex.getMessage());
            }
        }
        return null;
    }

    @AuraEnabled
    public static String saveProgramPriceSettings_Apex(String settingRecord, String facilityType) {
        if(settingRecord != null && facilityType != null) {
            try{
                String returnValue = 'New';
                //Id RecordTypeId = Schema.SObjectType.VEN3__Calculator_Settings__c.getRecordTypeInfosByName().get(recordType).getRecordTypeId();
                VEN3__Calculator_Settings__c calSetting = (VEN3__Calculator_Settings__c) JSON.deserialize(settingRecord,VEN3__Calculator_Settings__c.class);
                String programPartner = calSetting.VEN3__Program_Partner__c;
                Integer term = Integer.valueOf(calSetting.VEN3__Term_months__c);
                String goodsType = calSetting.VEN3__Goods_Type__c;
                String assetType = calSetting.VEN3__Asset_Type__c;
                if (programPartner != null && term != null) {
                    List<VEN3__Calculator_Settings__c> programSetting = new List<VEN3__Calculator_Settings__c>();
                    programSetting = [SELECT Id, VEN3__Program_Partner__c, VEN3__Term_months__c,  VEN3__Facility_Type__c, VEN3__Goods_Type__c, VEN3__Asset_Type__c FROM VEN3__Calculator_Settings__c  WHERE VEN3__Facility_Type__c =: facilityType AND VEN3__Program_Partner__c =: programPartner AND VEN3__Asset_Type__c =: assetType AND VEN3__Facility_Type__c =: facilityType AND VEN3__Term_months__c =: term AND VEN3__Goods_Type__c =: goodsType];// WHERE VEN3__Program_Partner__c =: programPartner AND VEN3__Term_months__c =: term AND VEN3__Facility_Type__c =: facilityType AND VEN3__Goods_Type__c =: goodsType AND VEN3__Asset_Type__c =: assetType];
                    if (programSetting.size() > 0){
                        returnValue = 'Old';
                        delete programSetting;
                    }
                }
                calSetting.VEN3__Facility_Type__c = facilityType;
                //calSetting.VEN3__User__c = UserInfo.getUserId();
                //calSetting.RecordTypeId = RecordTypeId;
                insert calSetting;
                return returnValue;
            } catch (Exception ex) {
                system.debug('Error at Line ' + ex.getLineNumber());
                system.debug('Error Message ' + ex.getMessage());
            }
        }
        return null;
    }

    @AuraEnabled
    public static List<VEN3__Calculator_Settings__c> saveAssetsPriceSettings_Apex(String settingRecord, String facilityType, String goodsType, String recordType) {
        if(settingRecord != null && facilityType != null && goodsType != null) {
            try{
                //Id RecordTypeId = Schema.SObjectType.VEN3__Calculator_Settings__c.getRecordTypeInfosByName().get(recordType).getRecordTypeId();
                VEN3__Calculator_Settings__c calSetting = (VEN3__Calculator_Settings__c) JSON.deserialize(settingRecord,VEN3__Calculator_Settings__c.class);
                List<String> goodsTypeList = (List<String>) JSON.deserialize(goodsType, List<String>.class);
                List<VEN3__Calculator_Settings__c> newSettingsList = new List<VEN3__Calculator_Settings__c>();
                Decimal term = calSetting.VEN3__Term_months__c;
                List<VEN3__Calculator_Settings__c> existingAssetSettings = new List<VEN3__Calculator_Settings__c>();
                if(term != null && goodsTypeList != null ){
                    existingAssetSettings = [SELECT Id FROM VEN3__Calculator_Settings__c WHERE VEN3__Goods_Type__c IN : goodsTypeList AND VEN3__Term_months__c =:term AND VEN3__Facility_Type__c =:facilityType ];
                    if(existingAssetSettings.size() > 0){
                        delete existingAssetSettings;
                    }
                }
                if (goodsTypeList.size() > 0 && facilityType != null) {
                    for (String strObj : goodsTypeList) {
                        VEN3__Calculator_Settings__c settingObj = new VEN3__Calculator_Settings__c();
                        settingObj.VEN3__Default_Base_Rate__c = calSetting.VEN3__Default_Base_Rate__c;
                        settingObj.VEN3__Default_Brokerage_Rate__c = calSetting.VEN3__Default_Brokerage_Rate__c;
                        settingObj.VEN3__X5Kto50K_Base_Rate__c = calSetting.VEN3__X5Kto50K_Base_Rate__c;
                        settingObj.VEN3__X50Kto100K_Base_Rate__c = calSetting.VEN3__X50Kto100K_Base_Rate__c;
                        settingObj.VEN3__X100Kto150K_Base_Rate__c = calSetting.VEN3__X100Kto150K_Base_Rate__c;
                        settingObj.VEN3__X150Kto250K_Base_Rate__c = calSetting.VEN3__X150Kto250K_Base_Rate__c;
                        settingObj.VEN3__X250Kto500K_Base_Rate__c = calSetting.VEN3__X250Kto500K_Base_Rate__c;
                        settingObj.VEN3__X500Kto999K_Base_Rate__c = calSetting.VEN3__X500Kto999K_Base_Rate__c;
                        settingObj.VEN3__X5Kto50K_Funder_Name__c = calSetting.VEN3__X5Kto50K_Funder_Name__c;
                        settingObj.VEN3__X50Kto100K_Funder_Name__c = calSetting.VEN3__X50Kto100K_Funder_Name__c;
                        settingObj.VEN3__X100Kto150K_Funder_Name__c = calSetting.VEN3__X100Kto150K_Funder_Name__c;
                        settingObj.VEN3__X150Kto250K_Funder_Name__c = calSetting.VEN3__X150Kto250K_Funder_Name__c;
                        settingObj.VEN3__X250Kto500K_Funder_Name__c = calSetting.VEN3__X250Kto500K_Funder_Name__c;
                        settingObj.VEN3__X500Kto999K_Funder_Name__c = calSetting.VEN3__X500Kto999K_Funder_Name__c;
                        settingObj.VEN3__X5Kto50K_Brokerage__c = calSetting.VEN3__X5Kto50K_Brokerage__c;
                        settingObj.VEN3__X50Kto100K_Brokerage__c = calSetting.VEN3__X50Kto100K_Brokerage__c;
                        settingObj.VEN3__X100Kto150K_Brokerage__c = calSetting.VEN3__X100Kto150K_Brokerage__c;
                        settingObj.VEN3__X150Kto250_Brokerage__c = calSetting.VEN3__X150Kto250_Brokerage__c;
                        settingObj.VEN3__X250Kto500K_Brokerage__c = calSetting.VEN3__X250Kto500K_Brokerage__c;
                        settingObj.VEN3__X500Kto999K_Brokerage__c = calSetting.VEN3__X500Kto999K_Brokerage__c;
                        settingObj.VEN3__Payments_to_Own__c = calSetting.VEN3__Payments_to_Own__c;
                        settingObj.VEN3__PPSR_Fee__c = calSetting.VEN3__PPSR_Fee__c;
                        settingObj.VEN3__Establishment_Fee__c = calSetting.VEN3__Establishment_Fee__c;
                        settingObj.VEN3__Term_months__c = calSetting.VEN3__Term_months__c;
                        settingObj.VEN3__Facility_Type__c = facilityType;
                        settingObj.VEN3__Goods_Type__c = strObj;
                        //settingObj.VEN3__User__c = UserInfo.getUserId();
                        //settingObj.RecordTypeId = RecordTypeId;
                        newSettingsList.add(settingObj);
                    }
                    if (newSettingsList.size() > 0) {
                        insert newSettingsList;
                        return newSettingsList;
                    }
                }
            } catch (Exception ex) {
                system.debug('Error at Line ' + ex.getLineNumber());
                system.debug('Error Message ' + ex.getMessage());
            }
        }
        return null;
    }

    @AuraEnabled
    public static Boolean deletePriceSetting_Apex(String priceSettingId){
        if (priceSettingId != null) {
            try{
                delete [SELECT Id FROM VEN3__Calculator_Settings__c WHERE Id =:priceSettingId];
                return true;
            }catch (Exception ex) {
                system.debug('Error at Line ' + ex.getLineNumber());
                system.debug('Error Message ' + ex.getMessage());
            }
        }
        return false;
    }

    @AuraEnabled
    Public static VEN3__Calculator_Settings__c saveCopyProgramPricing_Apex(String ProgramPricingSetting){
        if(ProgramPricingSetting != null){
            try{
                //Id RecordTypeId = Schema.SObjectType.VEN3__Calculator_Settings__c.getRecordTypeInfosByName().get(recordType).getRecordTypeId();
                VEN3__Calculator_Settings__c ProgPriceSetting = (VEN3__Calculator_Settings__c) JSON.deserialize(ProgramPricingSetting,VEN3__Calculator_Settings__c.class);
                if(ProgPriceSetting != null){
                    /*List<Quote_Calculator_Setting__c> existingSettings = new List<Quote_Calculator_Setting__c>();
                    existingSettings = [Select Id from Quote_Calculator_Setting__c where Program_Partner_L__c =: ProgPriceSetting.Program_Partner_L__c and Term__c =: ProgPriceSetting.Term__c and Facility_Type__c =: ProgPriceSetting.Facility_Type__c and RecordTypeId =: RecordTypeId];
                    if(existingSettings.size() > 0){
                        delete existingSettings;
                    }*/
                    upsert ProgPriceSetting;
                    return ProgPriceSetting;
                }
            }catch (Exception ex) {
                system.debug('Error at Line ' + ex.getLineNumber());
                system.debug('Error Message ' + ex.getMessage());
            }
        }
        return null;
    }

    @AuraEnabled
    Public static List<VEN3__Calculator_Settings__c> saveCopyAssetPricing_Apex(String AssetsPriceSetting, String selectedGoodsType, String existingAssets, String recordType){
        if(AssetsPriceSetting != null && selectedGoodsType != null){
            try{
                //Id RecordTypeId = Schema.SObjectType.VEN3__Calculator_Settings__c.getRecordTypeInfosByName().get(recordType).getRecordTypeId();
                VEN3__Calculator_Settings__c assetPriceSetting = (VEN3__Calculator_Settings__c) JSON.deserialize(AssetsPriceSetting,VEN3__Calculator_Settings__c.class);
                List<String> goodsTypeList = (List<String>) JSON.deserialize(selectedGoodsType, List<String>.class);
                List<String> existingAssetList = (List<String>) JSON.deserialize(existingAssets, List<String>.class);
                Decimal term = assetPriceSetting.VEN3__Term_months__c;
                List<VEN3__Calculator_Settings__c> existingSettings = new List<VEN3__Calculator_Settings__c>();
                if(existingAssetList != null && term != null && assetPriceSetting.VEN3__Facility_Type__c != null){
                    existingSettings = [SELECT Id FROM VEN3__Calculator_Settings__c WHERE VEN3__Goods_Type__c IN: existingAssetList AND VEN3__Term_months__c =:term AND VEN3__Facility_Type__c =: assetPriceSetting.VEN3__Facility_Type__c ];
                    if(existingSettings.size() > 0){
                        delete existingSettings;
                    }
                }
                List<VEN3__Calculator_Settings__c> newSettingsList = new List<VEN3__Calculator_Settings__c>();
                if (goodsTypeList.size() > 0) {
                    for (String strObj : goodsTypeList) {
                        VEN3__Calculator_Settings__c settingObj = new VEN3__Calculator_Settings__c();
                        settingObj.VEN3__Default_Base_Rate__c = assetPriceSetting.VEN3__Default_Base_Rate__c;
                        settingObj.VEN3__Default_Brokerage_Rate__c = assetPriceSetting.VEN3__Default_Brokerage_Rate__c;
                        settingObj.VEN3__X5Kto50K_Base_Rate__c = assetPriceSetting.VEN3__X5Kto50K_Base_Rate__c;
                        settingObj.VEN3__X50Kto100K_Base_Rate__c = assetPriceSetting.VEN3__X50Kto100K_Base_Rate__c;
                        settingObj.VEN3__X100Kto150K_Base_Rate__c = assetPriceSetting.VEN3__X100Kto150K_Base_Rate__c;
                        settingObj.VEN3__X150Kto250K_Base_Rate__c = assetPriceSetting.VEN3__X150Kto250K_Base_Rate__c;
                        settingObj.VEN3__X250Kto500K_Base_Rate__c = assetPriceSetting.VEN3__X250Kto500K_Base_Rate__c;
                        settingObj.VEN3__X500Kto999K_Base_Rate__c = assetPriceSetting.VEN3__X500Kto999K_Base_Rate__c;
                        settingObj.VEN3__X5Kto50K_Funder_Name__c = assetPriceSetting.VEN3__X5Kto50K_Funder_Name__c;
                        settingObj.VEN3__X50Kto100K_Funder_Name__c = assetPriceSetting.VEN3__X50Kto100K_Funder_Name__c;
                        settingObj.VEN3__X100Kto150K_Funder_Name__c = assetPriceSetting.VEN3__X100Kto150K_Funder_Name__c;
                        settingObj.VEN3__X150Kto250K_Funder_Name__c = assetPriceSetting.VEN3__X150Kto250K_Funder_Name__c;
                        settingObj.VEN3__X250Kto500K_Funder_Name__c = assetPriceSetting.VEN3__X250Kto500K_Funder_Name__c;
                        settingObj.VEN3__X500Kto999K_Funder_Name__c = assetPriceSetting.VEN3__X500Kto999K_Funder_Name__c;
                        settingObj.VEN3__X5Kto50K_Brokerage__c = assetPriceSetting.VEN3__X5Kto50K_Brokerage__c;
                        settingObj.VEN3__X50Kto100K_Brokerage__c = assetPriceSetting.VEN3__X50Kto100K_Brokerage__c;
                        settingObj.VEN3__X100Kto150K_Brokerage__c = assetPriceSetting.VEN3__X100Kto150K_Brokerage__c;
                        settingObj.VEN3__X150Kto250_Brokerage__c = assetPriceSetting.VEN3__X150Kto250_Brokerage__c;
                        settingObj.VEN3__X250Kto500K_Brokerage__c = assetPriceSetting.VEN3__X250Kto500K_Brokerage__c;
                        settingObj.VEN3__X500Kto999K_Brokerage__c = assetPriceSetting.VEN3__X500Kto999K_Brokerage__c;
                        settingObj.VEN3__Payments_to_Own__c = assetPriceSetting.VEN3__Payments_to_Own__c;
                        settingObj.VEN3__PPSR_Fee__c = assetPriceSetting.VEN3__PPSR_Fee__c;
                        settingObj.VEN3__Establishment_Fee__c = assetPriceSetting.VEN3__Establishment_Fee__c;
                        settingObj.VEN3__Term_months__c = assetPriceSetting.VEN3__Term_months__c;
                        settingObj.VEN3__Facility_Type__c = assetPriceSetting.VEN3__Facility_Type__c;
                        settingObj.VEN3__Goods_Type__c = strObj;
                        //settingObj.VEN3__User__c = UserInfo.getUserId();
                        //settingObj.RecordTypeId = RecordTypeId;
                        newSettingsList.add(settingObj);
                    }
                    if (newSettingsList.size() > 0) {
                        insert newSettingsList;
                        return newSettingsList;
                    }
                }
            }catch (Exception ex) {
                system.debug('Error at Line ' + ex.getLineNumber());
                system.debug('Error Message ' + ex.getMessage());
            }
        }
        return null;
    }

    @AuraEnabled
    public static VEN3__Program_Partner__c getGoodsType_Apex(String selectedProgramPartnerId){
        VEN3__Program_Partner__c returPartner = new VEN3__Program_Partner__c();
        returPartner = VendorSupplierController.getGoodsType_Apex(selectedProgramPartnerId);
        if(returPartner !=null){
           return returPartner ;
        }
        return null;
    }
}