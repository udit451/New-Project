({
    doInit_Helper: function (c, e, h) {
        try {
            var calcData = c.get('v.calc');
            calcData.VEN3__Repayment_Frequency__c = 'Monthly';
            calcData.VEN3__Repayment_Type__c = 'Advance';
            calcData.VEN3__Asset_Type__c = 'New';
            calcData.VEN3__Program_Partner_L__c = c.get("v.matrixUser.VEN3__Program_Partner__c");
            c.set('v.calc',calcData);
            var leadObj = c.get('v.leadObj');
            leadObj.VEN3__Vendor_Guest_User__c = c.get('v.matrixUser.Id');
            c.set('v.leadObj',leadObj);
        } catch (err) {
            console.log('Catch error===>>> ' + err);
        }
    },
    calculateRepayment_helper : function (c, e, h) {
        (h.calculateAmountFinance_Helper(c, e, h)).then(value => {
            return h.calculatePayment_Helper(c, e, h);
        }).catch(reason => {
            console.log(reason.message);
        });
    },
    calculatePayment_Helper: function (c, e, h) {
        try {
            let calcData = c.get("v.calc.VEN3__Amount_Financed__c");
            let term = c.get("v.calc.VEN3__Term_months__c");
            let RepaymentType = c.get("v.calc.VEN3__Repayment_Frequency__c");
            let balloon = c.get('v.calc.VEN3__Ballon__c');
            let rate, nperiod, fv, type, brokerageVaue = 0, amount = 0;
            let existingPriceSettings = c.get("v.settingsByPartner");
            if (existingPriceSettings !== null && existingPriceSettings !== undefined) {
                if (calcData !== null && calcData !== undefined && calcData !== ' ' && term !== null && term !== undefined && term !== ' ' && calcData <= 9999999999) {
                    amount = calcData;
                    nperiod = term;
                    let selectedSetting = {};
                    if(!$A.util.isUndefinedOrNull(existingPriceSettings)){
                        existingPriceSettings.forEach(function (element) {
                            if (parseInt(element.VEN3__Term_months__c) === parseInt(term)) {
                                selectedSetting = element;
                            }
                        });
                    }
                    if (selectedSetting !== null && selectedSetting !== undefined) {
                        if (amount < 5000) {
                            c.set("v.calc.VEN3__Amount_Financed__c", undefined);
                        }
                        if (amount >= 5000 && amount <= 50000) {
                            if (selectedSetting.VEN3__X5Kto50K_Base_Rate__c !== null && selectedSetting.VEN3__X5Kto50K_Base_Rate__c !== undefined) {
                                rate = selectedSetting.VEN3__X5Kto50K_Base_Rate__c;
                            }
                            if (selectedSetting.VEN3__X5Kto50K_Brokerage__c !== null && selectedSetting.VEN3__X5Kto50K_Brokerage__c !== undefined) {
                                brokerageVaue = selectedSetting.VEN3__X5Kto50K_Brokerage__c * amount;
                            }
                        }
                        if (amount >= 50001 && amount <= 100000) {

                            if (selectedSetting.VEN3__X50Kto100K_Base_Rate__c !== null && selectedSetting.VEN3__X50Kto100K_Base_Rate__c !== undefined) {
                                rate = selectedSetting.VEN3__X50Kto100K_Base_Rate__c;
                            }
                            if (selectedSetting.VEN3__X50Kto100K_Brokerage__c !== null && selectedSetting.VEN3__X50Kto100K_Brokerage__c !== undefined) {
                                brokerageVaue = selectedSetting.VEN3__X50Kto100K_Brokerage__c * amount;
                            }
                        }
                        if (amount >= 100001 && amount <= 150000) {
                            if (selectedSetting.VEN3__X100Kto150K_Brokerage__c !== null && selectedSetting.VEN3__X100Kto150K_Brokerage__c !== undefined) {
                                brokerageVaue = selectedSetting.VEN3__X100Kto150K_Brokerage__c * amount;
                            }
                            if (selectedSetting.VEN3__X100Kto150K_Base_Rate__c !== null && selectedSetting.VEN3__X100Kto150K_Base_Rate__c !== undefined) {
                                rate = selectedSetting.VEN3__X100Kto150K_Base_Rate__c;
                            }
                        }
                        if (amount >= 150001 && amount <= 250000) {
                            if (selectedSetting.VEN3__X150Kto250_Brokerage__c !== null && selectedSetting.VEN3__X150Kto250_Brokerage__c !== undefined) {
                                brokerageVaue = selectedSetting.VEN3__X150Kto250_Brokerage__c * amount;
                            }
                            if (selectedSetting.VEN3__X150Kto250K_Base_Rate__c !== null && selectedSetting.VEN3__X150Kto250K_Base_Rate__c !== undefined) {
                                rate = selectedSetting.VEN3__X150Kto250K_Base_Rate__c;
                            }
                        }
                        if (amount >= 250001 && amount <= 500000) {
                            if (selectedSetting.VEN3__X250Kto500K_Brokerage__c !== null && selectedSetting.VEN3__X250Kto500K_Brokerage__c !== undefined) {
                                brokerageVaue = selectedSetting.VEN3__X250Kto500K_Brokerage__c * amount;
                            }
                            if (selectedSetting.VEN3__X250Kto500K_Base_Rate__c !== null && selectedSetting.VEN3__X250Kto500K_Base_Rate__c !== undefined) {
                                rate = selectedSetting.VEN3__X250Kto500K_Base_Rate__c;
                            }
                        }
                        if (amount >= 500001 && amount <= 999999) {
                            if (selectedSetting.VEN3__X500Kto999K_Brokerage__c !== null && selectedSetting.VEN3__X500Kto999K_Brokerage__c !== undefined) {
                                brokerageVaue = selectedSetting.VEN3__X500Kto999K_Brokerage__c * amount;
                            }
                            if (selectedSetting.VEN3__X500Kto999K_Base_Rate__c !== null && selectedSetting.VEN3__X500Kto999K_Base_Rate__c !== undefined) {
                                rate = selectedSetting.VEN3__X500Kto999K_Base_Rate__c;
                            }
                        }
                        if (amount >= 1000000 && amount <= 9999999999) {
                            if (selectedSetting.VEN3__X1000KAbove_Brokerage__c !== null && selectedSetting.VEN3__X1000KAbove_Brokerage__c !== undefined) {
                                brokerageVaue = selectedSetting.VEN3__X1000KAbove_Brokerage__c * amount;
                            }
                            if (selectedSetting.VEN3__X1000KAbove_Base_Rate__c !== null && selectedSetting.VEN3__X1000KAbove_Base_Rate__c !== undefined) {
                                rate = selectedSetting.VEN3__X1000KAbove_Base_Rate__c;
                            }

                        }
                        
                       /*var repaymentType;
                        if(RepaymentType == 'Monthly'){
                            repaymentType = 12;
                        }else if(RepaymentType == 'Weekly'){
                            nperiod = (parseInt(nperiod)/12)*52;
                            repaymentType = 52;
                        }*/
                        var Percentage = c.get('v.percentage');
                        if(!$A.util.isUndefinedOrNull(Percentage)){
                            rate = parseFloat(rate) + parseFloat(Percentage);
                        }
                        if(!$A.util.isUndefinedOrNull(rate) && !$A.util.isUndefinedOrNull(brokerageVaue)){
                          
                            var payment = PMT(rate / 12, parseInt(nperiod), -(parseFloat(amount) + parseFloat(brokerageVaue)), balloon, 1);
                            var payment2 = PMT(rate / 52, (parseInt(nperiod)/12)*52, -(parseFloat(amount) + parseFloat(brokerageVaue)), balloon, 1);

                            function PMT(rate, nperiod, pv, fv, type) { 
                                if (!fv) fv = 0;
                                if (!type) type = 0;

                                if (rate == 0) return -(pv + fv) / nperiod;

                                let pvif = Math.pow(1 + rate, nperiod);
                                let pmt = rate / (pvif - 1) * -(pv * pvif + fv);

                                if (type == 1) {
                                    pmt /= (1 + rate);
                                }

                                return pmt;
                            }
                            console.log('payment>>>>>>>'+payment);
                            console.log('payment2>>>>>>'+payment2);
                            c.set("v.calc.VEN3__Repayment_Expected_c__c", payment);
                            c.set("v.calc.VEN3__Repayment_Expected_Weekly__c", payment2);
                        } else {
                            c.set("v.calc.VEN3__Repayment_Expected_c__c", undefined);
                            c.set("v.calc.VEN3__Repayment_Expected_Weekly__c", undefined);
                        }

                    }
                } else if (calcData > 9999999999) {
                    if (c.get('v.isVendor') !== false) {
                        c.set("v.errorText", 'Amount Financed is greater than $9,999,999,999. Please contact Chase Finance to obtain pricing.');
                        h.showErrorToast(c, e, h);
                    }else {
                        c.set("v.errorText", 'Amount Financed is greater than $9,999,999,999. ');
                        h.showErrorToast(c, e, h);
                    }
                    c.set("v.calc.VEN3__Repayment_Expected_c__c", undefined);
                    c.set("v.calc.VEN3__Repayment_Expected_Weekly__c", undefined);
                } else {
                    c.set("v.calc.VEN3__Repayment_Expected_c__c", undefined);
                    c.set("v.calc.VEN3__Repayment_Expected_Weekly__c", undefined);
                    c.find('mortgageAmount').set("v.errors", null);
                }
            }else{
                c.set("v.calc.VEN3__Repayment_Expected_c__c", undefined);
                c.set("v.calc.VEN3__Repayment_Expected_Weekly__c", undefined);
            }
        
        } catch (ex) {
            console.log('Error --->>' + ex.message);
        }
    },
    calculateAmountFinance_Helper : function (c, e, h) {
        try{
            return new Promise(resolve => {
            let FinanceAmount = c.get("v.calc.VEN3__Amount_Financed__c");
            let balloonVal = c.get("v.selectedBalloons");
            let AssetType = c.get("v.calc.VEN3__Asset_Type__c");
            let Term = c.get("v.calc.VEN3__Term_months__c");
            let ProgramPartnerId = c.get("v.matrixUser.VEN3__Program_Partner__c");
            if(balloonVal != null){
                balloonVal = parseInt(balloonVal);
            }
           
            let GoodTypes = c.get("v.calc.VEN3__Goods_Type__c");
            GoodTypes = GoodTypes.trim();

            if(!$A.util.isUndefinedOrNull(FinanceAmount) && !$A.util.isUndefinedOrNull(AssetType) && !$A.util.isUndefinedOrNull(Term) && !$A.util.isUndefinedOrNull(GoodTypes) && Term !== ''){
                var action = c.get("c.getCustomSettings_Apex");
                action.setParams({
                    "AssetType" : AssetType,
                    "Term" : Term,
                    "facilityType" : 'Chattel Mortgage',
                    "ProgramPartner" : ProgramPartnerId,
                    "goodTypes" : GoodTypes
                });
                action.setCallback(this, function (r) {
                    if (r.getState() === 'SUCCESS') {
                        let storedResponse = r.getReturnValue();
                        let Percentage = 0;
                        let Amount = 0;
                        if (!$A.util.isUndefinedOrNull(storedResponse)) {
                            if(FinanceAmount >= 5000 && FinanceAmount <= 50000){
                                if(balloonVal == 0){
                                    Percentage  = storedResponse.VEN3__X5Kto50K_Balloon_0__c;
                                }
                                if(balloonVal == 10){
                                    Percentage = storedResponse.VEN3__X5Kto50K_Balloon_10__c;
                                }
                                if(balloonVal == 20){
                                    Percentage = storedResponse.VEN3__X5Kto50K_Balloon_20__c;
                                }
                                if(balloonVal == 30){
                                    Percentage = storedResponse.VEN3__X5Kto50K_Balloon_30__c;
                                }
                                if(balloonVal == 40){
                                    Percentage = storedResponse.VEN3__X5Kto50K_Balloon_40__c;
                                }
                                if(balloonVal == 50){
                                    Percentage = storedResponse.VEN3__X5Kto50K_Balloon_50__c;
                                }
                            }else if(FinanceAmount >= 50001 && FinanceAmount <= 100000){
                                if(balloonVal == 0){
                                    Percentage  = storedResponse.VEN3__X50Kto100K_Balloon_0__c;
                                }
                                if(balloonVal == 10){
                                    Percentage = storedResponse.VEN3__X50Kto100K_Balloon_10__c;
                                }
                                if(balloonVal == 20){
                                    Percentage = storedResponse.VEN3__X50Kto100K_Balloon20__c;
                                }
                                if(balloonVal == 30){
                                    Percentage = storedResponse.VEN3__X50Kto100K_Balloon_30__c;
                                }
                                if(balloonVal == 40){
                                    Percentage = storedResponse.VEN3__X50Kto100K_Balloon_40__c;
                                }
                                if(balloonVal == 50){
                                    Percentage = storedResponse.VEN3__X50Kto100K_Balloon_50__c;
                                }
                            }else if(FinanceAmount >= 100001 && FinanceAmount <= 150000){
                                if(balloonVal == 0){
                                    Percentage  = storedResponse.VEN3__X100Kto150K_Balloon_0__c;
                                }
                                if(balloonVal == 10){
                                    Percentage = storedResponse.VEN3__X100Kto150K_Balloon_10__c;
                                }
                                if(balloonVal == 20){
                                    Percentage = storedResponse.VEN3__X100Kto150K_Balloon_20__c;
                                }
                                if(balloonVal == 30){
                                    Percentage = storedResponse.VEN3__X100Kto150K_Balloon_30__c;
                                }
                                if(balloonVal == 40){
                                    Percentage = storedResponse.VEN3__X100Kto150K_Balloon_40__c;
                                }
                                if(balloonVal == 50){
                                    Percentage = storedResponse.VEN3__X100Kto150K_Balloon_50__c;
                                }
                            }else if(FinanceAmount >= 150001 && FinanceAmount <= 250000){
                                if(balloonVal == 0){
                                    Percentage  = storedResponse.VEN3__X150Kto250K_Balloon_0__c;
                                }
                                if(balloonVal == 10){
                                    Percentage = storedResponse.VEN3__X150Kto250K_Balloon_10__c;
                                }
                                if(balloonVal == 20){
                                    Percentage = storedResponse.VEN3__X150Kto250_Balloon_20__c;
                                }
                                if(balloonVal == 30){
                                    Percentage = storedResponse.VEN3__X150Kto250_Balloon_30__c;
                                }
                                if(balloonVal == 40){
                                    Percentage = storedResponse.VEN3__X150Kto250_Balloon_40__c;
                                }
                                if(balloonVal == 50){
                                    Percentage = storedResponse.VEN3__X150Kto250_Balloon_50__c;
                                }
                            }else if(FinanceAmount >= 250001 && FinanceAmount <= 500000){
                                if(balloonVal == 0){
                                    Percentage  = storedResponse.VEN3__X250Kto500K_Balloon_0__c;
                                }
                                if(balloonVal == 10){
                                    Percentage = storedResponse.VEN3__X250Kto500K_Balloon_10__c;
                                }
                                if(balloonVal == 20){
                                    Percentage = storedResponse.VEN3__X250Kto500K_Balloon_20__c;
                                }
                                if(balloonVal == 30){
                                    Percentage = storedResponse.VEN3__X250Kto500K_Balloon_30__c;
                                }
                                if(balloonVal == 40){
                                    Percentage = storedResponse.VEN3__X250Kto500K_Balloon_40__c;
                                }
                                if(balloonVal == 50){
                                    Percentage = storedResponse.VEN3__X250Kto500K_Balloon_50__c;
                                }

                            }else if(FinanceAmount >= 500001 && FinanceAmount <= 999999){
                                if(balloonVal == 0){
                                    Percentage  = storedResponse.VEN3__X500Kto999K_Balloon_0__c;
                                }
                                if(balloonVal == 10){
                                    Percentage = storedResponse.VEN3__X500Kto999K_Balloon_10__c;
                                }
                                if(balloonVal == 20){
                                    Percentage = storedResponse.VEN3__X500Kto999K_Balloon_20__c;
                                }
                                if(balloonVal == 30){
                                    Percentage = storedResponse.VEN3__X500Kto999K_Balloon_30__c;
                                }
                                if(balloonVal == 40){
                                    Percentage = storedResponse.VEN3__X500Kto999K_Balloon_40__c;
                                }
                                if(balloonVal == 50){
                                    Percentage = storedResponse.VEN3__X500Kto999K_Balloon_50__c;
                                }

                            }else if(FinanceAmount >= 1000000 && FinanceAmount <= 9999999999){
                                if(balloonVal == 0){
                                    Percentage  = storedResponse.VEN3__X1000LKAbove_Balloon_0__c;
                                }
                                if(balloonVal == 10){
                                    Percentage = storedResponse.VEN3__X1000KAbove_Balloon_10__c;
                                }
                                if(balloonVal == 20){
                                    Percentage = storedResponse.VEN3__X1000KAbove_Balloon_20__c;
                                }
                                if(balloonVal == 30){
                                    Percentage = storedResponse.VEN3__X1000KAbove_Balloon_30__c;
                                }
                                if(balloonVal == 40){
                                    Percentage = storedResponse.VEN3__X1000KAbove_Balloon_40__c;
                                }
                                if(balloonVal == 50){
                                    Percentage = storedResponse.VEN3__X1000KAbove_Balloon_50__c;
                                }
                            }else{
                                c.set("v.AmountFinance", FinanceAmount);
                            }
                            c.set("v.settingsByPartner", storedResponse);
                            if(!$A.util.isUndefinedOrNull(Percentage)){
                                c.set('v.percentage', Percentage);
                                if(balloonVal != 0){
                                Amount = (FinanceAmount*balloonVal)/100;
                                }
                                c.set("v.AmountFinance", FinanceAmount);
                                c.set("v.calc.VEN3__Ballon__c", Amount);
                                resolve(FinanceAmount);
                            }
                            else{
                                c.set('v.percentage', 0);
                                if(balloonVal != 0){
                                Amount = (FinanceAmount*balloonVal)/100;
                                }
                                c.set("v.AmountFinance", FinanceAmount);

                                c.set("v.calc.VEN3__Ballon__c", Amount);
                                resolve(FinanceAmount);
                            }
                        }else {
                           
                            c.set("v.settingsByPartner", undefined);
                            resolve(FinanceAmount);
                        }
                    } else {
                        console.log('ERROR');
                        console.log(r.getError());
                    }
                });
                $A.enqueueAction(action);
            }else{
                c.set("v.settingsByPartner", undefined);
            }
            });
        }catch(ex){
           console.log('Error',ex.message);
        }
    },
    setGoodsType_Helper: function (c, e, h) {
        try {
            let selectedProgramPartnerId = c.get("v.matrixUser.VEN3__Program_Partner__c");
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
                            c.set("v.calc.VEN3__Goods_Type__c",goodsType[0]);
                            c.set("v.getGoodsTypeList", goodsType);

                        }
                    } else {
                        console.log('ERROR');
                        console.log(r.getError());
                    }
                });
                $A.enqueueAction(action);
            } else if ($A.util.isUndefinedOrNull(selectedProgramPartnerId)) {
                let goodsType = [];
                goodsType = [
                    "Coffee Machines",
                    "Equipment - Office",
                    "IT Equipment",
                    "Motor Vehicle",
                    "Point of Sale",
                    "Printing Equipment",
                    "Radios",
                    "Security Equipment",
                    "Telecommunications",
                    "Agricultural",
                    "Air Conditioning Systems",
                    "Arcade Machines",
                    "Artwork",
                    "ATM’s",
                    "Audio Visual",
                    "Baling Equipment",
                    "Caravan / Camper",
                    "Catering Equipment",
                    "Cleaning Supplies",
                    "Digital Displays",
                    "Dog Wash Units",
                    "Earth Moving",
                    "Energy Assets / Solar",
                    "Fitness Equipment",
                    "Fitouts",
                    "Forklifts",
                    "Fuel Management Systems",
                    "Furniture & Fittings",
                    "Gaming / Poker Machines",
                    "Golf Simulators",
                    "GPS Tracking",
                    "Heaters",
                    "Helicopter",
                    "Industrial Equipment",
                    "Intangibles",
                    "Laboratory Equipment",
                    "Lighting",
                    "Logging",
                    "Marine",
                    "Materials Handling",
                    "Medical Equipment",
                    "Motor Cycle",
                    "Office Equipment",
                    "Plane",
                    "Portable Building",
                    "Racking",
                    "Recreation Equipment",
                    "Refrigeration Systems",
                    "Road Marking",
                    "Roasting Equipment",
                    "Safes",
                    "Software",
                    "Tanning Beds",
                    "Trailer",
                    "Vending Machines",
                    "Visual Sign-in Kiosk",
                    "Water Filtration Systems",
                    "Yellow Goods",
                    "Yellow Goods",
                    "Other",
                ];
                c.set("v.getGoodsTypeList", goodsType);
                c.set("v.calc.VEN3__Goods_Type__c",goodsType[0]);
            }
            c.set("v.calc.VEN3__Goods_Type__c", 'None');
        } catch (err) {
            console.log('Error',err.message);
            console.log('setGoodsType_Helper======>' + err);
        }
    },
    SaveCustomSettings_Helper: function (c, e, h, isCopy) {
        try {
            console.log('SaveCustomSettings_Helper::')
            let valid = h.checkSaveValidity(c, e, h);
            if (valid === true) {
                if (c.get("v.isMatrixGuestUser")) {
                    let matrixUser = c.get("v.matrixUser");
                    if (!$A.util.isUndefinedOrNull(matrixUser.VEN3__Program_Partner__c)) {
                        c.set("v.calc.VEN3__Program_Partner__c", matrixUser.VEN3__Program_Partner__c);
                    }
                }
                let anzCalc = {};
                let leadObj = {};
                anzCalc = c.get("v.calc");
                leadObj = c.get('v.leadObj');
				anzCalc.VEN3__Program_Partner_L__c = c.get("v.matrixUser.VEN3__Program_Partner__c");
                anzCalc.VEN3__Vendor_Guest_User__c = c.get("v.matrixUser.Id");
                anzCalc.VEN3__Loan_Facility_Type__c =  'Chattel Mortgage'; 
                leadObj.Company = leadObj.FirstName+' '+leadObj.LastName;
                leadObj.VEN3__Vendor_Guest_User__c = c.get('v.matrixUser.Id');
                if (!$A.util.isUndefinedOrNull(leadObj.FirstName) && !$A.util.isUndefinedOrNull(leadObj.LastName) && !$A.util.isUndefinedOrNull(leadObj.Email) && !$A.util.isUndefinedOrNull(anzCalc.VEN3__Amount_Financed__c) && !$A.util.isUndefinedOrNull(anzCalc.VEN3__Term_months__c)) {
                    h.showSpinner_Helper(c, e, h);
                    let action = c.get("c.saveANZData_Apex");
                    action.setParams({
                        "anzList": JSON.stringify(anzCalc),
                        "leadObj": JSON.stringify(leadObj),
                        "version": c.get('v.calculatorType'),
                    });
                    action.setCallback(this, function (response) {
                        if (response.getState() === "SUCCESS") {
                            
                            let storedResponse = (response.getReturnValue());
                            console.log('storedResponse>>>>'+storedResponse);
                            if (!$A.util.isUndefinedOrNull(storedResponse)) {
                                c.set('v.successText', 'Record Saved Successfully!');
                                h.showSuccessToast(c, e, h);
                            }
                        } else {
                            c.set("v.errorText", 'something misshappens with data');
                            h.showErrorToast(c, e, h);
                        }
                    });
                    $A.enqueueAction(action);
                } else {
                    c.set("v.errorText", 'Please fill the required fields');
                    h.showErrorToast(c, e, h);
                }
            } else {
                c.set("v.errorText", 'Please fill the required fields');
                h.showErrorToast(c, e, h);
            }
        } catch (ex) {
            console.log('Error --->>' + ex.message);
        }
        h.hideSpinner_Helper(c, e, h);
    },
    showErrorToast: function (c, e, h) {
        try {
            c.set('v.isError',true);
            window.setTimeout(
                $A.getCallback(function () {
                    c.set('v.isError',false);
                }), 1000
            );
        } catch (ex) {
            console.log('Error == >>' + e);
        }
    },
    showSuccessToast: function (c, e, h) {
        try {
            c.set('v.isSuccess',true);
            //$('#SuccessToast').show();
            window.setTimeout(
                $A.getCallback(function () {
                    c.set('v.isSuccess',false);
                }), 1000
            );
        } catch (ex) {
            console.log('Error == >>' + e);
        }
    },
    ClearData_Helper: function (c, e, h) {
        c.set("v.ClearDataPopup", true);
    },
    resetData_Helper: function (c, e, h) {
        h.setGoodsType_Helper(c, e, h);
        c.set('v.selectedBalloons', null);
        c.set("v.calc.VEN3__Repayment_Expected_Weekly__c", null);
        let calcData = {};
        calcData.Name = null;
        calcData.VEN3__Amount_Financed__c = null;
        calcData.VEN3__Ballon__c = null;
        calcData.VEN3__Balloon_c__c = null;
        calcData.VEN3__Customer_Rate_Expected__c = null;
        calcData.VEN3__Customer_Rate_Non_Published__c = null;
        calcData.VEN3__Desired_Brokerage_Incl_GST_c__c = null;
        calcData.VEN3__Desired_Brokerage_Incl_GST_p__c = null;
        //calcData.VEN3__Goods_Type__c = null;
        calcData.VEN3__Incl_GST_c__c = null;
        calcData.VEN3__Loan_Facility_Type__c = null;
        calcData.VEN3__Please_enter_your_desired_Base_Rate_here__c = null;
        calcData.VEN3__Published_Base_Rate__c = null;
        calcData.VEN3__Repayment_Expected_c__c = null;
        calcData.VEN3__Repayment_Non_Published__c = null;
        calcData.VEN3__Repayment_Frequency__c = null;
        calcData.VEN3__Repayment_Type__c = null;
        calcData.VEN3__State__c = null;
        calcData.VEN3__Term_months__c = undefined;
        calcData.VEN3__Total_Incl_GST_c__c = null;
        calcData.VEN3__Document_Fee_Disclosed__c = null;
        calcData.VEN3__Document_Fee_Non_Disclosed__c = null;
        calcData.VEN3__Fees_Other_Disclosed__c = null;
        calcData.VEN3__Fees_Other_Non_Disclosed__c = null;
        calcData.VEN3__PPSR_Fees_Disclosed__c = null;
        calcData.VEN3__PPSR_Fees_Non_Disclosed__c = null;
        calcData.VEN3__Additional_Payment__c = null;
        calcData.VEN3__Additional_period__c = null;
        calcData.VEN3__Asset_Type__c = 'New';
        calcData.VEN3__Repayment_Frequency__c = 'Monthly';
        calcData.VEN3__Repayment_Type__c = 'Advance';
        
        c.set("v.calc", calcData);
        c.set("v.ClearDataPopup", false);

        let leadObj = {};
        leadObj.VEN3__Date__c = null;
        leadObj.FirstName = null;
        leadObj.LastName = null;
        leadObj.Company = null;
        leadObj.Email = null;
        leadObj.Phone = null;
        leadObj.OwnerId = c.get('v.leadObj.OwnerId');
        if (!$A.util.isUndefinedOrNull(c.get('v.matrixUser.Id'))) {
            leadObj.VEN3__Vendor_Guest_User__c = c.get('v.matrixUser.Id');
        }
        c.set("v.leadObj", leadObj);
        h.hideSpinner_Helper(c, e, h);
    },
    hideSpinner_Helper: function (c, e, h) {
        c.set("v.showSpinner", false);
    },
    checkSaveValidity: function (c, e, h) {
        try {
            if (!c.get('v.isView')) {
                let allFields = c.find('checkSaveValidity');
                let allValid = false;
                if (Array.isArray(allFields)) {
                    allValid = allFields.reduce(function (validSoFar, inputCmp) {
                        inputCmp.showHelpMessageIfInvalid();
                        return validSoFar && inputCmp.get('v.validity').valid;
                    }, true);
                } else {
                    allFields.showHelpMessageIfInvalid();
                    allValid = allFields.get('v.validity').valid;
                }
                return allValid;
            } else {
                return true;
            }
        } catch (ex) {
            console.log('Error -->>' + e);
        }
    },
    showSpinner_Helper: function (c, e, h) {
        c.set("v.showSpinner", true);
        window.setTimeout(
            $A.getCallback(function () {
                c.set("v.showSpinner", false);
            }), 10000
        );
    },
    ViewLead_helper: function (c, e, h) {
        try {
            c.set('v.showSpinner', true);
            var recordId = c.get('v.selectedId');
            if(!$A.util.isUndefinedOrNull(recordId)){
                var action = c.get('c.getExistingRecord');
                action.setParams({
                    "selectedId" : recordId
                });
                action.setCallback(this, function (r) {
                    if (r.getState() === 'SUCCESS') {
                        let storedResponse = r.getReturnValue();
                        //console.log('storedResponse'+JSON.stringify(storedResponse));
                        if(!$A.util.isUndefinedOrNull(storedResponse)){
                            c.set('v.leadViewDetails',storedResponse.leadList);
                            c.set('v.calViewDetails',storedResponse.calcList);
                            c.set('v.showSpinner', false);

                            var Balloon = storedResponse.calcList.VEN3__Ballon__c;
                            if(!$A.util.isUndefinedOrNull(storedResponse)){
                                Balloon = Balloon/100;
                                c.set('v.calViewDetails.VEN3__Ballon__c', Balloon);
                            }else{
                                c.set('v.calViewDetails.VEN3__Ballon__c', '');
                            }                    
                           
                        }else{
                            h.hideSpinner_Helper(c, e, h);
                            console.log('Somthing Wrong with your data');
                        }
                    } else {
                        h.hideSpinner_Helper(c, e, h);
                        console.log('ERROR');
                        console.log(r.getError());
                    }
                });
                $A.enqueueAction(action);
            }
        }catch (e) {
            h.hideSpinner_Helper(c, e, h);
            console.log('Error',e.message);
        }
    },
})