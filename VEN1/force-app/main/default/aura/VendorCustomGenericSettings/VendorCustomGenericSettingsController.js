({
    doInit : function(c, e, h){
        //h.initialiseGoodsTypeList_Helper(c, e, h);
        //h.initialiseGoodsTypePickList_Helper(c, e, h);
    },

    closeOptionSettings : function(c, e, h){
        if(c.get("v.openCustomSettingSection")){
            c.set("v.openCustomSettingSection",false);
            if(c.get("v.termSelected") !== ''){
                h.getSelectedPriceSettings_Helper(c, e, h)
            }
        }else{
            c.set('v.showOptionButton', false);
        }
    },

    getSelectedPriceSettings: function(c, e, h){
        console.log('------');
        h.getSelectedPriceSettings_Helper(c, e, h);
    },

    newProgramPricing: function(c, e, h){
       h.newProgramPricing_Helper(c, e, h);
    },

    newAssetPricing: function(c, e, h){
       h.newAssetPricing_Helper(c, e, h);
    },

    setDefaultRate: function(c, e, h){
        h.setDefaultRate_helper(c, e, h);
    },

    changeLoanFacilityType: function(c, e, h){
       c.set('v.termSelected', '');
       c.set('v.noSettingsExist',false);
    },

    changeProgramPartner: function(c, e, h){
        var ProgramPartner = c.get("v.ProgramPartner");
        if(c.get("v.openSettingSection")){
            c.set("v.calcSettings.VEN3__Program_Partner__c",ProgramPartner);
        }
        if(c.get("v.copyProgramPricingSection")){
           c.set("v.selectedCopyPriceSettings.VEN3__Program_Partner__c",ProgramPartner);
            h.showSpinner_Helper(c);
            h.setGoodsTypeAction_helper(c, e, h, c.get("v.ProgramPartner"));
        }
    },

    editPriceSetting: function(c, e, h){
        h.editPriceSetting_Helper(c, e, h);
    },

    saveEditSetting: function(c, e, h){
        h.saveEditSetting_Helper(c, e, h);
    },

    deletePriceSetting: function(c, e, h){
        h.deletePriceSetting_Helper(c, e, h);
    },

    onChangeGoodsType: function(c, e, h){
        h.onChangeGoodsType_Helper(c, e, h);
    },

    openAlertOnSaveSettings: function(c, e, h){
        
        var settingObj = c.get("v.calcSettings");
        if(!$A.util.isUndefinedOrNull(settingObj)){
            
            if(c.get("v.openSettingSection")){
                var bool = h.validateRecord_Helper(c, e, h, settingObj);
                if(bool){
                    c.set("v.alertOnSaveSettings",true);
                }else{
                    h.showToast_Helper(c, 'error', "Please Fill Required Fields.");
                }
            }else{
                var multiSettingList = c.get("v.selectOptionsGoodsType");
                if(!$A.util.isUndefinedOrNull(settingObj.VEN3__Term_months__c) && settingObj.VEN3__Term_months__c !== '' && multiSettingList.length > 0){
                    c.set("v.alertOnSaveSettings",true);
                }else{
                    h.showToast_Helper(c, 'error', "Please Fill Required Fields.");
                }
            }
        }
    },

    closeAlertOnSaveSettings : function (c, e, h) {
        c.set('v.alertOnSaveSettings', false);
    },

    saveSetting: function(c, e, h){
        if(c.get("v.openSettingSection")){
            h.showSpinner_Helper(c);
            h.saveProgramPricingSetting_Helper(c, e, h);
        }else{
            h.showSpinner_Helper(c);
            h.saveAssetsSetting_Helper(c, e, h);
        }
    },

    openCopyPricingSettings: function(c, e, h){
        h.openCopyPricingSettings_Helper(c, e, h);
    },

    closeCopyPricingSection: function(c, e, h){
        h.closeCopyPricing_Helper(c, e, h);
    },

    checkProgramPricingSettings: function(c, e, h){
        h.checkProgramPricingSettings_Helper(c, e, h);
    },

    checkAssetPricingSettings: function(c, e, h){
        h.checkAssetPricingSettings_Helper(c, e, h);
    },

    copyProgramPricing: function(c, e, h){
        c.set("v.openCopyPricingSection",false);
        c.set("v.openProgramPricingSection",false);
        c.set("v.openAssetsSection",false);
        c.set('v.ProgramPartner', null);
        c.set("v.copyProgramPricingSection",true);
        h.copyProgramPricing_Helper(c, e, h);
    },

    closeCopyPricingPopUp: function(c, e, h){
        h.closeCopyPricingPopUp_Helper(c, e, h);
    },

    copyAssetPricing: function(c, e, h){
        c.set("v.openCopyPricingSection",false);
        c.set("v.openProgramPricingSection",false);
        c.set("v.openAssetsSection",false);
        c.set("v.copyAssetPricingSection",true);
        h.copyAssetPricing_Helper(c, e, h);
    },

    openAlertOnCopySettings: function(c, e, h){
        if(c.get("v.copyProgramPricingSection")){
            var bool = h.checkExistingProgramPricingSetting(c, e, h);
            if(bool){
                c.set("v.alertOnCopyPricingSetting",true);
            }else{
                h.saveCopyProgramPricingSetting_Helper(c, e, h, false);
            }
        }else if(c.get("v.copyAssetPricingSection")){
            var bool = h.checkExistingAssetsPricingSetting(c, e, h); 
            if(bool){
                c.set("v.alertOnCopyPricingSetting",true);
            }else{
                h.saveAssetsPricingSetting_Helper(c, e, h, false);
            }
        }
    },

    saveCopiedSettings: function(c, e, h){
        if(c.get("v.copyProgramPricingSection")){
            c.set('v.alertOnCopyPricingSetting', false);
            h.saveCopyProgramPricingSetting_Helper(c, e, h, true);
        }else if(c.get("v.copyAssetPricingSection")){
            c.set('v.alertOnCopyPricingSetting', false);
            h.saveAssetsPricingSetting_Helper(c, e, h, true);
        }
    },

    closeAlertOnCopyPricing: function(c, e, h){
        c.set('v.alertOnCopyPricingSetting', false);
    },

    fillBalloonValues : function (c, e, h) {
        h.fillBalloonValues_Helper(c, e, h); 
    },
    updateExistBalloonValue: function (c, e, h) {
        h.updateExistBalloonValue_helper(c, e, h);
    },
    setGoodsTypeAction: function (c, e, h) {
        h.showSpinner_Helper(c);
        c.set('v.calcSettings.VEN3__Program_Partner__c',c.get("v.nerSettingsProgramPartner"));
        h.setGoodsTypeAction_helper(c, e, h, c.get("v.nerSettingsProgramPartner"));
    }
})