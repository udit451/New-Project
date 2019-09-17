({
    doInit: function (c, e, h) {
        h.doInit_Helper(c, e, h);
        h.setGoodsType_Helper(c, e, h);
        var isTure = c.get("v.isView");
        if(isTure){
            h.ViewLead_helper(c, e, h);
        }
        
    },
    FinanceAmountController: function (c, e, h) {
        h.calculateRepayment_helper(c, e, h);
    },
    calculateAmountFinanced: function (c, e, h) {
        h.calculateRepayment_helper(c, e, h);
    },
    changeBalloon: function(c, e, h){
        h.calculateRepayment_helper(c, e, h);
    },
    SaveCustomSettings: function (c, e, h) {
        h.SaveCustomSettings_Helper(c, e, h, false);
    },
    ClearData: function (c, e, h) {
        h.ClearData_Helper(c, e, h);
    },
    closePopup: function (c, e, h) {
        c.set("v.ClearDataPopup", false);
    },
    resetData: function (c, e, h) {
        h.resetData_Helper(c, e, h);
    },
})