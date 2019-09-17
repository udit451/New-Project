({
    showSpinner_Helper: function (c) {
        c.set("v.showSpinner", true);
        window.setTimeout(
            $A.getCallback(function () {
                c.set("v.showSpinner", false);
            }), 5000
        );
    },

    hideSpinner_Helper: function (c) {
        c.set("v.showSpinner", false);
    },

    setGoodsTypeAction_helper: function (c, e, h, selectedProgramPartnerId) {
        try {
            if (!$A.util.isUndefinedOrNull(selectedProgramPartnerId)) {
                let action = c.get("c.getGoodsType_Apex");
                action.setParams({
                    "selectedProgramPartnerId": selectedProgramPartnerId
                });
                action.setCallback(this, function (r) {
                    if (r.getState() === 'SUCCESS') {
                        let storedResponse = r.getReturnValue();
                        if (!$A.util.isUndefinedOrNull(storedResponse)) {
                            let tempGoodsType = storedResponse.VEN3__Goods_Type__c;
                            let goodsType = tempGoodsType.split(",");
                            var goodsTypeOption = [];
                            for (var i = 0; i <goodsType.length ; i++) {
                                var goodsTypeObj = {value: goodsType[i], label: goodsType[i]};
                                goodsTypeOption.push(goodsTypeObj);
                            }
                            c.set("v.PicklistOptionsGoodsType", goodsTypeOption);
                            c.set("v.calcSettings.VEN3__Goods_Type__c", goodsTypeOption[0].value);
                            h.hideSpinner_Helper(c);
                        }
                    } else {
                        console.log('ERROR');
                        console.log(r.getError());
                        h.hideSpinner_Helper(c);
                    }
                });
                $A.enqueueAction(action);
            } else if ($A.util.isUndefinedOrNull(selectedProgramPartnerId)) {
                var goodsTypeOption = [
                    {value: "Coffee Machines", label: "Coffee Machines"},
                    {value: "Equipment - Office", label: "Equipment - Office"},
                    {value: "IT Equipment", label: "IT Equipment"},
                    {value: "Motor Vehicle", label: "Motor Vehicle"},
                    {value: "Point of Sale", label: "Point of Sale"},
                    {value: "Printing Equipment", label: "Printing Equipment"},
                    {value: "Radios", label: "Radios"},
                    {value: "Security Equipment", label: "Security Equipment"},
                    {value: "Telecommunications", label: "Telecommunications"},
                    {value: "Agricultural", label: "Agricultural"},
                    {value: "Air Conditioning Systems", label: "Air Conditioning Systems"},
                    {value: "Arcade Machines", label: "Arcade Machines"},
                    {value: "Artwork", label: "Artwork"},
                    {value: "ATM’s", label: "ATM’s"},
                    {value: "Audio Visual", label: "Audio Visual"},
                    {value: "Baling Equipment", label: "Baling Equipment"},
                    {value: "Caravan / Camper", label: "Caravan / Camper"},
                    {value: "Catering Equipment", label: "Catering Equipment"},
                    {value: "Cleaning Supplies", label: "Cleaning Supplies"},
                    {value: "Digital Displays", label: "Digital Displays"},
                    {value: "Dog Wash Units", label: "Dog Wash Units"},
                    {value: "Earth Moving", label: "Earth Moving"},
                    {value: "Energy Assets / Solar", label: "Energy Assets / Solar"},
                    {value: "Fitness Equipment", label: "Fitness Equipment"},
                    {value: "Fitouts", label: "Fitouts"},
                    {value: "Forklifts", label: "Forklifts"},
                    {value: "Fuel Management Systems", label: "Fuel Management Systems"},
                    {value: "Furniture & Fittings", label: "Furniture & Fittings"},
                    {value: "Gaming / Poker Machines", label: "Gaming / Poker Machines"},
                    {value: "Golf Simulators", label: "Golf Simulators"},
                    {value: "GPS Tracking", label: "GPS Tracking"},
                    {value: "Heaters", label: "Heaters"},
                    {value: "Helicopter", label: "Helicopter"},
                    {value: "Industrial Equipment", label: "Industrial Equipment"},
                    {value: "Intangibles ", label: "Intangibles "},
                    {value: "Laboratory Equipment", label: "Laboratory Equipment"},
                    {value: "Lighting", label: "Lighting"},
                    {value: "Logging", label: "Logging"},
                    {value: "Marine", label: "Marine"},
                    {value: "Materials Handling", label: "Materials Handling"},
                    {value: "Medical Equipment", label: "Medical Equipment"},
                    {value: "Motor Cycle", label: "Motor Cycle"},
                    {value: "Plane", label: "Plane"},
                    {value: "Portable Building", label: "Portable Building"},
                    {value: "Racking", label: "Racking"},
                    {value: "Recreation Equipment", label: "Recreation Equipment"},
                    {value: "Refrigeration Systems", label: "Refrigeration Systems"},
                    {value: "Road Marking", label: "Road Marking"},
                    {value: "Roasting Equipment", label: "Roasting Equipment"},
                    {value: "Safes", label: "Saunas / Spas"},
                    {value: "Software", label: "Software"},
                    {value: "Tanning Beds", label: "Tanning Beds"},
                    {value: "Trailer", label: "Trailer"},
                    {value: "Vending Machines", label: "Vending Machines"},
                    {value: "Visual Sign-in Kiosk", label: "Visual Sign-in Kiosk"},
                    {value: "Water Filtration Systems", label: "Water Filtration Systems"},
                    {value: "Yellow Goods", label: "Yellow Goods"},
                    {value: "Yellow Goods", label: "Yellow Goods"},
                    {value: "Other", label: "Other"},
                ];
                c.set("v.PicklistOptionsGoodsType", goodsTypeOption);
                c.set("v.calcSettings.VEN3__Goods_Type__c", goodsTypeOption[0].value);
                h.hideSpinner_Helper(c);
            }

        } catch (err) {
            console.log('setGoodsType_Helper======>' + err.message);
            h.hideSpinner_Helper(c);
        }
    },
    

    getSelectedPriceSettings_Helper:

        function (c, e, h) {
            h.showSpinner_Helper(c);
            c.set('v.showExistingSettings', false);

            function firstPromise() {
                return new Promise($A.getCallback(function (resolve, reject) {
                    try {
                        var selectedTerm = c.get('v.termSelected');
                        if (!$A.util.isUndefinedOrNull(selectedTerm) && selectedTerm !== "") {
                            var action = c.get("c.getExistingPriceSettings_Apex");
                            action.setParams({
                                "term": selectedTerm,
                                "LoanFacilityType": c.get("v.loanFacilityType")
                            });
                            action.setCallback(this, function (response) {
                                var state = response.getState();
                                if (state === "SUCCESS") {

                                    var calcSettings = response.getReturnValue();
                                    if (!$A.util.isUndefinedOrNull(calcSettings) && calcSettings.length > 0 && calcSettings != '') {
                                        var exist = false;
                                        calcSettings.forEach(function (setting) {
                                            if (!$A.util.isUndefinedOrNull(setting.VEN3__Program_Partner__c)) {
                                                exist = true;
                                            }
                                        });
                                        if (exist) {
                                            c.set('v.noSettingsExist', false);
                                            c.set("v.allExistingPriceSettings", calcSettings);
                                            resolve("Resolved");
                                        } else {
                                            c.set('v.noSettingsExist', true);
                                            c.set("v.allExistingPriceSettings", []);
                                        }

                                    } else {
                                        c.set('v.noSettingsExist', true);
                                        reject("Rejected");
                                    }
                                } else {
                                    reject("Rejected");
                                    console.log("Something MissHappens");
                                }
                            });
                            $A.enqueueAction(action);
                        } else {
                            c.set('v.noSettingsExist', false);
                            reject("Rejected");
                            c.set("v.allExistingPriceSettings", []);
                        }
                    } catch (ex) {
                        reject("Rejected");
                    }
                }));
            }

            firstPromise()
                .then(
                    // resolve handler
                    $A.getCallback(function (result) {
                        $(function () {
                            c.set('v.showExistingSettings', true);
                            $("#accordionProgram, #accordionAsset").accordion({
                                collapsible: true,
                                active: 'none'
                            });
                        });
                        h.hideSpinner_Helper(c);
                    }),

                    // reject handler
                    $A.getCallback(function (error) {
                        //console.log("Promise was rejected: ", error);
                        h.hideSpinner_Helper(c);
                    })
                );
        }

    ,

    newAssetPricing_Helper: function (c, e, h) {
        c.set("v.openCustomSettingSection", true);
        c.set("v.openSettingSection", false);
        c.set('v.calcSettings', {});
        c.set('v.ProgramPartner', null);
    }
    ,

    newProgramPricing_Helper: function (c, e, h) {
        c.set("v.openCustomSettingSection", true);
        c.set("v.openSettingSection", true);
        c.set('v.calcSettings', {});
        c.set('v.ProgramPartner', null);
    }
    ,

    editPriceSetting_Helper: function (c, e, h) {
        try {
            var selectedIndex = e.getSource().get('v.value');
            var allExistingPriceSettings = c.get("v.allExistingPriceSettings");
            var editSelectedSetting = allExistingPriceSettings[selectedIndex];
            editSelectedSetting.isEdit = true;
            allExistingPriceSettings[selectedIndex] = editSelectedSetting;
            c.set("v.allExistingPriceSettings", allExistingPriceSettings);
        } catch (ex) {
            console.log('ERROR');
            console.log(ex);
        }
    }
    ,

    saveEditSetting_Helper: function (c, e, h) {
        try {
            var selectedIndex = e.getSource().get('v.value');
            var allExistingPriceSettings = c.get("v.allExistingPriceSettings");
            var editSelectedSetting = allExistingPriceSettings[selectedIndex];
            var obj = {};
            if (!$A.util.isUndefinedOrNull(editSelectedSetting)) {
                obj = editSelectedSetting;
                delete obj.isEdit;
            }
            var action = c.get("c.saveEditPriceSetting_Apex");
            action.setParams({
                "priceSetting": JSON.stringify(obj)
            });
            action.setCallback(this, function (r) {
                if (r.getState() === 'SUCCESS') {
                    
                    var currentEditedSetting = r.getReturnValue();
                    if (!$A.util.isUndefinedOrNull(currentEditedSetting)) {
                        h.showToast_Helper(c, 'success', 'Setting Updated Successfully!')
                        h.getSelectedPriceSettings_Helper(c, e, h);
                    }
                } else {
                    console.log('ERROR');
                    console.log(r.getError());
                }
            });
            $A.enqueueAction(action);
        } catch (ex) {
            console.log('ERROR');
            console.log(ex);
        }
    }
    ,

    deletePriceSetting_Helper: function (c, e, h) {
        try {
            var selectedIndex = e.getSource().get('v.value');
            var allExistingPriceSettings = c.get("v.allExistingPriceSettings");
            var deleteSelectedRecord = allExistingPriceSettings[selectedIndex];
            var r = confirm("Are you sure you want to delete this record!");
            if (r === true) {
                var action = c.get("c.deletePriceSetting_Apex");
                action.setParams({
                    "priceSettingId": deleteSelectedRecord.Id
                });
                action.setCallback(this, function (r) {
                    if (r.getState() === 'SUCCESS') {
                        var storedResponse = r.getReturnValue();
                        h.showToast_Helper(c, 'success', 'Setting deleted successfully!');
                        h.getSelectedPriceSettings_Helper(c, e, h);

                    } else {
                        console.log('ERROR');
                        console.log(r.getError());
                    }
                });
                $A.enqueueAction(action);
            }
        } catch (ex) {
            console.log('ERROR');
            console.log(ex);
        }
    }
    ,

    setDefaultRate_helper: function (c, e, h) {
        var newSettingObj = {};
        if (c.get("v.copyProgramPricingSection")) {
            newSettingObj = c.get("v.selectedCopyPriceSettings");
        } else if (c.get("v.copyAssetPricingSection")) {
            newSettingObj = c.get("v.selectedCopyPriceSettings");
        } else {
            newSettingObj = c.get("v.calcSettings");
        }
        if (!$A.util.isUndefinedOrNull(newSettingObj.VEN3__Default_Base_Rate__c)) {
            newSettingObj.VEN3__X5Kto50K_Base_Rate__c = newSettingObj.VEN3__Default_Base_Rate__c;
            newSettingObj.VEN3__X50Kto100K_Base_Rate__c = newSettingObj.VEN3__Default_Base_Rate__c;
            newSettingObj.VEN3__X100Kto150K_Base_Rate__c = newSettingObj.VEN3__Default_Base_Rate__c;
            newSettingObj.VEN3__X150Kto250K_Base_Rate__c = newSettingObj.VEN3__Default_Base_Rate__c;
            newSettingObj.VEN3__X250Kto500K_Base_Rate__c = newSettingObj.VEN3__Default_Base_Rate__c;
            newSettingObj.VEN3__X500Kto999K_Base_Rate__c = newSettingObj.VEN3__Default_Base_Rate__c;
            newSettingObj.VEN3__X1000KAbove_Base_Rate__c = newSettingObj.VEN3__Default_Base_Rate__c;
        } else {
            newSettingObj.VEN3__X5Kto50K_Base_Rate__c = undefined;
            newSettingObj.VEN3__X50Kto100K_Base_Rate__c = undefined;
            newSettingObj.VEN3__X100Kto150K_Base_Rate__c = undefined;
            newSettingObj.VEN3__X150Kto250K_Base_Rate__c = undefined;
            newSettingObj.VEN3__X250Kto500K_Base_Rate__c = undefined;
            newSettingObj.VEN3__X500Kto999K_Base_Rate__c = undefined;
            newSettingObj.VEN3__X1000KAbove_Base_Rate__c = undefined;
        }
        if (!$A.util.isUndefinedOrNull(newSettingObj.VEN3__Default_Brokerage_Rate__c)) {
            newSettingObj.VEN3__X5Kto50K_Brokerage__c = newSettingObj.VEN3__Default_Brokerage_Rate__c;
            newSettingObj.VEN3__X50Kto100K_Brokerage__c = newSettingObj.VEN3__Default_Brokerage_Rate__c;
            newSettingObj.VEN3__X100Kto150K_Brokerage__c = newSettingObj.VEN3__Default_Brokerage_Rate__c;
            newSettingObj.VEN3__X150Kto250_Brokerage__c = newSettingObj.VEN3__Default_Brokerage_Rate__c;
            newSettingObj.VEN3__X250Kto500K_Brokerage__c = newSettingObj.VEN3__Default_Brokerage_Rate__c;
            newSettingObj.VEN3__X500Kto999K_Brokerage__c = newSettingObj.VEN3__Default_Brokerage_Rate__c;
            newSettingObj.VEN3__X1000KAbove_Brokerage__c = newSettingObj.VEN3__Default_Brokerage_Rate__c;
        } else {
            newSettingObj.VEN3__X5Kto50K_Brokerage__c = undefined;
            newSettingObj.VEN3__X50Kto100K_Brokerage__c = undefined;
            newSettingObj.VEN3__X100Kto150K_Brokerage__c = undefined;
            newSettingObj.VEN3__X150Kto250_Brokerage__c = undefined;
            newSettingObj.VEN3__X250Kto500K_Brokerage__c = undefined;
            newSettingObj.VEN3__X500Kto999K_Brokerage__c = undefined;
            newSettingObj.VEN3__X1000KAbove_Brokerage__c = undefined;
        }
        if (c.get("v.copyProgramPricingSection")) {
            c.set("v.selectedCopyPriceSettings", newSettingObj);
        } else if (c.get("v.copyAssetPricingSection")) {
            c.set("v.selectedCopyPriceSettings", newSettingObj);
        } else {
            c.set("v.calcSettings", newSettingObj);
        }
    }
    ,

    saveProgramPricingSetting_Helper: function (c, e, h) {
        try {
            var selectedTab = c.get("v.loanFacilityType");
            var settingObj = c.get("v.calcSettings");
            var action = c.get("c.saveProgramPriceSettings_Apex");
            /*action.setParams({
               "settingRecord": JSON.stringify(settingObj),
               "facilityType": selectedTab,
                "recordType" : 'Chase'
            });*/
            action.setParams({
                "settingRecord": JSON.stringify(settingObj),
                "facilityType": selectedTab
            });
            action.setCallback(this, function (r) {
                if (r.getState() === 'SUCCESS') {
                    console.log('Call call');
                    var storedResponse = r.getReturnValue();
                    if(!$A.util.isUndefinedOrNull(storedResponse)){
                        if(storedResponse == 'Old'){
                            h.showToast_Helper(c, 'success', "Setting Updated Successfully!");
                        }else{
                            h.showToast_Helper(c, 'success', "Setting Saved Successfully!");
                        }

                        c.set('v.calcSettings', undefined);
                        c.set('v.calcSettings', {});
                        c.set('v.nerSettingsProgramPartner', undefined);
                        c.set('v.allExistingPriceSettings', []);
                        c.set("v.openCustomSettingSection", false);
                        c.set('v.alertOnSaveSettings', false);
                        h.getSelectedPriceSettings_Helper(c, e, h);
                    }

                } else {
                    console.log('ERROR');
                    console.log(r.getError());
                }
            });
            $A.enqueueAction(action);
        } catch (ex) {
            console.log("ERROR");
            console.log(ex);
        }
    }
    ,

    onChangeGoodsType_Helper: function (c, e, h) {
        var selectedOptionValue = e.getParam("value");
        c.set("v.selectOptionsGoodsType", selectedOptionValue);
    }
    ,

    saveAssetsSetting_Helper: function (c, e, h) {
        try {
            var settingObj = c.get("v.calcSettings");
            var multiSettingList = c.get("v.selectOptionsGoodsType");
            var selectedTab = c.get("v.loanFacilityType");
            var action = c.get("c.saveAssetsPriceSettings_Apex");
            action.setParams({
                "settingRecord": JSON.stringify(settingObj),
                "goodsType": JSON.stringify(multiSettingList),
                "facilityType": selectedTab,
                "recordType": 'Chase'
            });
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    h.showToast_Helper(c, 'success', 'Setting Saved Successfully!');
                    c.set('v.selectOptionsGoodsType', null);
                    c.set('v.selectOptionsGoodsType', []);
                    c.set('v.calcSettings', undefined);
                    c.set('v.nerSettingsProgramPartner', undefined);
                    c.set('v.calcSettings', {});
                    c.set('v.allExistingPriceSettings', []);
                    c.set('v.openCustomSettingSection', false);
                    c.set('v.alertOnSaveSettings', false);
                    h.getSelectedPriceSettings_Helper(c, e, h);
                } else {
                    //console.log("Something MissHappens");
                }
            });
            $A.enqueueAction(action);
        } catch (ex) {
            console.log('ERROR');
            console.log(ex);
        }
    }
    ,

    validateRecord_Helper: function (c, e, h, settingObj) {
        try {
            if (!$A.util.isUndefinedOrNull(settingObj.VEN3__Program_Partner__c) && settingObj.VEN3__Program_Partner__c !== '') {
                c.set('v.isNewProgramError', false);
                if (!$A.util.isUndefinedOrNull(settingObj.VEN3__Term_months__c) && settingObj.VEN3__Term_months__c !== '') {
                    $A.util.removeClass(c.find('isNewProgramTerm'), 'slds-has-error');
                    return true;
                } else {
                    $A.util.addClass(c.find('isNewProgramTerm'), 'slds-has-error');
                    return false;
                }
            } else {
                c.set('v.isNewProgramError', true);
                return false;
            }
        } catch (ex) {
            console.log("ERROR");
            console.log(ex);
        }
    }
    ,

    openCopyPricingSettings_Helper: function (c, e, h) {
        var temp = c.get("v.allExistingPriceSettings");
        c.set("v.openCopyPricingSection", true);
        c.set("v.openProgramPricingSection", true);
        c.set("v.openAssetsSection", false);
    }
    ,

    closeCopyPricing_Helper: function (c, e, h) {
        c.set("v.openCopyPricingSection", false);
        c.set("v.openProgramPricingSection", false);
        c.set("v.openAssetsSection", false);
    }
    ,

    checkProgramPricingSettings_Helper: function (c, e, h) {
        c.set("v.openProgramPricingSection", true);
        c.set("v.openAssetsSection", false);
    }
    ,

    checkAssetPricingSettings_Helper: function (c, e, h) {
        c.set("v.openAssetsSection", true);
        c.set("v.openProgramPricingSection", false);
    }
    ,

    copyProgramPricing_Helper: function (c, e, h) {
        var selectedSettingId = e.getSource().get('v.accesskey');
        var allSettings = c.get("v.allExistingPriceSettings");
        if (!$A.util.isUndefinedOrNull(selectedSettingId) && !$A.util.isUndefinedOrNull(allSettings)) {
            var selectedSettingObj = {};
            allSettings.forEach(function (element) {
                if (selectedSettingId === element.Id) {
                    selectedSettingObj = element;
                }
            });
            if (!$A.util.isUndefinedOrNull(selectedSettingObj)) {
                c.set("v.selectedCopyPriceSettings", selectedSettingObj);
                c.set("v.ProgramPartner", selectedSettingObj.VEN3__Program_Partner__c);
                c.set("v.ExistingProgramPartner", selectedSettingObj.VEN3__Program_Partner__c);
                c.set("v.ExistingLoanFacilityType", selectedSettingObj.VEN3__Facility_Type__c);
            }
        }
    }
    ,

    closeCopyPricingPopUp_Helper: function (c, e, h) {
        if (c.get("v.copyProgramPricingSection")) {
            c.set("v.copyProgramPricingSection", false);
        }
        if (c.get("v.copyAssetPricingSection")) {
            c.set("v.copyAssetPricingSection", false);
        }
        c.set("v.openCopyPricingSection", false);
    }
    ,

    copyAssetPricing_Helper: function (c, e, h) {
        var selectedSettingId = e.getSource().get('v.accesskey');
        var allSettings = c.get("v.allExistingPriceSettings");
        if (!$A.util.isUndefinedOrNull(selectedSettingId) && !$A.util.isUndefinedOrNull(allSettings)) {
            var selectedSettingObj = {};
            allSettings.forEach(function (element) {
                if (selectedSettingId === element.Id) {
                    selectedSettingObj = element;
                }
            });
            if (!$A.util.isUndefinedOrNull(selectedSettingObj)) {
                c.set("v.selectedCopyPriceSettings", selectedSettingObj);
                c.set("v.selectOptionsGoodsType", selectedSettingObj.VEN3__Goods_Type__c);
            }
        }
    }
    ,

    saveCopyProgramPricingSetting_Helper: function (c, e, h, isCopy) {
        try {
            var selectedPriceSettings = {};
            if (isCopy) {
                selectedPriceSettings = c.get("v.selectedCopyPriceSettings");
            } else {
                selectedPriceSettings = c.get("v.selectedCopyPriceSettings");
                delete selectedPriceSettings.Id;
            }
            var action = c.get("c.saveCopyProgramPricing_Apex");
            action.setParams({
                "ProgramPricingSetting": JSON.stringify(selectedPriceSettings)
            });
            action.setCallback(this, function (r) {
                if (r.getState() === 'SUCCESS') {
                    var storedResponse = r.getReturnValue();
                    if (!$A.util.isUndefinedOrNull(storedResponse)) {
                        c.set("v.openAssetsSection", false);
                        c.set("v.copyProgramPricingSection", false);
                        c.set("v.copyAssetPricingSection", false);
                        c.set("v.openCopyPricingSection", false);
                        if (isCopy) {
                            h.showToast_Helper(c, 'success', 'Setting Updated Successfully!.');
                        } else {
                            h.showToast_Helper(c, 'success', 'Setting Copied Successfully!.');
                        }
                        h.getSelectedPriceSettings_Helper(c, e, h);
                    }
                } else {
                    console.log('ERROR');
                    console.log(r.getError());
                }
            });
            $A.enqueueAction(action);
        } catch (ex) {
            console.log('ERROR');
            console.log(ex);
        }
    }
    ,

    checkExistingProgramPricingSetting: function (c, e, h) {
        var selectedSettings = c.get("v.selectedCopyPriceSettings");
        var existingTerm = c.get("v.termSelected");
        var loanFacility = c.get("v.ExistingLoanFacilityType");
        var existingProgramPartnerId = c.get("v.ExistingProgramPartner");
        console
        if (existingProgramPartnerId == selectedSettings.VEN3__Program_Partner__c && existingTerm == selectedSettings.VEN3__Term_months__c && loanFacility == selectedSettings.VEN3__Facility_Type__c) {
            return true;
        } else {
            return false;
        }
    }
    ,

    saveAssetsPricingSetting_Helper: function (c, e, h, isCopy) {
        try {
            var selectedGoodsType = c.get('v.selectOptionsGoodsType');
            var selectedPriceSettings = c.get("v.selectedCopyPriceSettings");
            var existingAssetsGoodsType = c.get("v.existingAssetsGoodsType");
            var action = c.get("c.saveCopyAssetPricing_Apex")
            action.setParams({
                "AssetsPriceSetting": JSON.stringify(selectedPriceSettings),
                "selectedGoodsType": JSON.stringify(selectedGoodsType),
                "existingAssets": JSON.stringify(existingAssetsGoodsType),
                "recordType": 'Chase'
            });
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var storedResponse = response.getReturnValue();
                    if (!$A.util.isUndefinedOrNull(storedResponse)) {
                        c.set("v.openProgramPricingSection", false);
                        c.set("v.copyProgramPricingSection", false);
                        c.set("v.copyAssetPricingSection", false);
                        c.set("v.openCopyPricingSection", false);
                        if (isCopy) {
                            h.showToast_Helper(c, 'success', 'Setting Updated Successfully!.');
                        } else {
                            h.showToast_Helper(c, 'success', 'Setting Copied Successfully!.');
                        }
                        h.getSelectedPriceSettings_Helper(c, e, h);
                    }
                } else {
                    //console.log("Something MissHappens");
                }
            });
            $A.enqueueAction(action);
        } catch (ex) {
            console.log("ERROR");
            console.log(ex);
        }
    }
    ,

    checkExistingAssetsPricingSetting: function (c, e, h) {
        var allExistingPriceSettings = c.get("v.allExistingPriceSettings");
        var selectedSettings = c.get("v.selectedCopyPriceSettings");
        var existingTerm = c.get("v.termSelected");
        var selectedGoodsType = c.get("v.selectOptionsGoodsType");
        var allGoodsSettings = [];
        allExistingPriceSettings.forEach(function (elem) {
            if (!$A.util.isUndefinedOrNull(elem.VEN3__Goods_Type__c) && !$A.util.isUndefinedOrNull(elem.VEN3__Term_months__c)) {
                selectedGoodsType.forEach(function (element) {
                    if (element == elem.VEN3__Goods_Type__c && elem.VEN3__Term_months__c == existingTerm) {
                        allGoodsSettings.push(elem.VEN3__Goods_Type__c);
                    }
                });
            }
        });
        c.set("v.existingAssetsGoodsType", allGoodsSettings);
        if (allGoodsSettings.length > 0) {
            return true;
        } else {
            return false;
        }
    }
    ,

    showToast_Helper: function (c, variant, message) {
        c.set('v.showToast', false);
        c.set('v.variant', variant);
        c.set('v.message', message);
        c.set('v.showToast', true);
    }
    ,

    fillBalloonValues_Helper: function (c, e, h) {
        try {
            var balloon = e.getSource().get('v.requiredIndicatorClass');
            var balloonValue = e.getSource().get('v.value');
            if (balloon === 'Balloon0') {
                c.set('v.calcSettings.VEN3__X5Kto50K_Balloon_0__c', balloonValue);
                c.set('v.calcSettings.VEN3__X50Kto100K_Balloon_0__c', balloonValue);
                c.set('v.calcSettings.VEN3__X100Kto150K_Balloon_0__c', balloonValue);
                c.set('v.calcSettings.VEN3__X150Kto250K_Balloon_0__c', balloonValue);
                c.set('v.calcSettings.VEN3__X250Kto500K_Balloon_0__c', balloonValue);
                c.set('v.calcSettings.VEN3__X500Kto999K_Balloon_0__c', balloonValue);
                c.set('v.calcSettings.VEN3__X1000LKAbove_Balloon_0__c', balloonValue);
            } else if (balloon === 'Balloon10') {
                c.set('v.calcSettings.VEN3__X5Kto50K_Balloon_10__c', balloonValue);
                c.set('v.calcSettings.VEN3__X50Kto100K_Balloon_10__c', balloonValue);
                c.set('v.calcSettings.VEN3__X100Kto150K_Balloon_10__c', balloonValue);
                c.set('v.calcSettings.VEN3__X150Kto250K_Balloon_10__c', balloonValue);
                c.set('v.calcSettings.VEN3__X250Kto500K_Balloon_10__c', balloonValue);
                c.set('v.calcSettings.VEN3__X500Kto999K_Balloon_10__c', balloonValue);
                c.set('v.calcSettings.VEN3__X1000KAbove_Balloon_10__c', balloonValue);
            } else if (balloon === 'Balloon20') {
                c.set('v.calcSettings.VEN3__X5Kto50K_Balloon_20__c', balloonValue);
                c.set('v.calcSettings.VEN3__X50Kto100K_Balloon20__c', balloonValue);
                c.set('v.calcSettings.VEN3__X100Kto150K_Balloon_20__c', balloonValue);
                c.set('v.calcSettings.VEN3__X150Kto250_Balloon_20__c', balloonValue);
                c.set('v.calcSettings.VEN3__X250Kto500K_Balloon_20__c', balloonValue);
                c.set('v.calcSettings.VEN3__X500Kto999K_Balloon_20__c', balloonValue);
                c.set('v.calcSettings.VEN3__X1000KAbove_Balloon_20__c', balloonValue);
            } else if (balloon === 'Balloon30') {
                c.set('v.calcSettings.VEN3__X5Kto50K_Balloon_30__c', balloonValue);
                c.set('v.calcSettings.VEN3__X50Kto100K_Balloon_30__c', balloonValue);
                c.set('v.calcSettings.VEN3__X100Kto150K_Balloon_30__c', balloonValue);
                c.set('v.calcSettings.VEN3__X150Kto250_Balloon_30__c', balloonValue);
                c.set('v.calcSettings.VEN3__X250Kto500K_Balloon_30__c', balloonValue);
                c.set('v.calcSettings.VEN3__X500Kto999K_Balloon_30__c', balloonValue);
                c.set('v.calcSettings.VEN3__X1000KAbove_Balloon_30__c', balloonValue);
            } else if (balloon === 'Balloon40') {
                c.set('v.calcSettings.VEN3__X5Kto50K_Balloon_40__c', balloonValue);
                c.set('v.calcSettings.VEN3__X50Kto100K_Balloon_40__c', balloonValue);
                c.set('v.calcSettings.VEN3__X100Kto150K_Balloon_40__c', balloonValue);
                c.set('v.calcSettings.VEN3__X150Kto250_Balloon_40__c', balloonValue);
                c.set('v.calcSettings.VEN3__X250Kto500K_Balloon_40__c', balloonValue);
                c.set('v.calcSettings.VEN3__X500Kto999K_Balloon_40__c', balloonValue);
                c.set('v.calcSettings.VEN3__X1000KAbove_Balloon_40__c', balloonValue);
            } else if (balloon === 'Balloon50') {
                c.set('v.calcSettings.VEN3__X5Kto50K_Balloon_50__c', balloonValue);
                c.set('v.calcSettings.VEN3__X50Kto100K_Balloon_50__c', balloonValue);
                c.set('v.calcSettings.VEN3__X100Kto150K_Balloon_50__c', balloonValue);
                c.set('v.calcSettings.VEN3__X150Kto250_Balloon_50__c', balloonValue);
                c.set('v.calcSettings.VEN3__X250Kto500K_Balloon_50__c', balloonValue);
                c.set('v.calcSettings.VEN3__X500Kto999K_Balloon_50__c', balloonValue);
                c.set('v.calcSettings.VEN3__X1000KAbove_Balloon_50__c', balloonValue);
            }
        } catch (ex) {
            console.log(ex.getError());
        }
    }
    ,
    updateExistBalloonValue_helper: function (c, e, h) {
        try {
            var balloon = e.getSource().get('v.requiredIndicatorClass');
            var balloonValue = e.getSource().get('v.value');
            if (balloon === 'Balloon0') {
                c.set('v.selectedCopyPriceSettings.VEN3__X5Kto50K_Balloon_0__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X50Kto100K_Balloon_0__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X100Kto150K_Balloon_0__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X150Kto250K_Balloon_0__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X250Kto500K_Balloon_0__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X500Kto999K_Balloon_0__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X1000LKAbove_Balloon_0__c', balloonValue);
            } else if (balloon === 'Balloon10') {
                c.set('v.selectedCopyPriceSettings.VEN3__X5Kto50K_Balloon_10__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X50Kto100K_Balloon_10__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X100Kto150K_Balloon_10__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X150Kto250K_Balloon_10__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X250Kto500K_Balloon_10__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X500Kto999K_Balloon_10__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X1000KAbove_Balloon_10__c', balloonValue);
            } else if (balloon === 'Balloon20') {
                c.set('v.selectedCopyPriceSettings.VEN3__X5Kto50K_Balloon_20__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X50Kto100K_Balloon20__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X100Kto150K_Balloon_20__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X150Kto250_Balloon_20__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X250Kto500K_Balloon_20__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X500Kto999K_Balloon_20__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X1000KAbove_Balloon_20__c', balloonValue);
            } else if (balloon === 'Balloon30') {
                c.set('v.selectedCopyPriceSettings.VEN3__X5Kto50K_Balloon_30__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X50Kto100K_Balloon_30__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X100Kto150K_Balloon_30__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X150Kto250_Balloon_30__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X250Kto500K_Balloon_30__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X500Kto999K_Balloon_30__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X1000KAbove_Balloon_30__c', balloonValue);
            } else if (balloon === 'Balloon40') {
                c.set('v.selectedCopyPriceSettings.VEN3__X5Kto50K_Balloon_40__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X50Kto100K_Balloon_40__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X100Kto150K_Balloon_40__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X150Kto250_Balloon_40__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X250Kto500K_Balloon_40__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X500Kto999K_Balloon_40__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X1000KAbove_Balloon_40__c', balloonValue);
            } else if (balloon === 'Balloon50') {
                c.set('v.selectedCopyPriceSettings.VEN3__X5Kto50K_Balloon_50__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X50Kto100K_Balloon_50__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X100Kto150K_Balloon_50__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X150Kto250_Balloon_50__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X250Kto500K_Balloon_50__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X500Kto999K_Balloon_50__c', balloonValue);
                c.set('v.selectedCopyPriceSettings.VEN3__X1000KAbove_Balloon_50__c', balloonValue);
            }
        } catch (ex) {
            console.log(ex.getError());
        }
    }
})