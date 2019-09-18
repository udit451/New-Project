/**
 * Created by Rajat on 10/12/2018.
 */
({
    openOptionSettings_Helper : function(c, e, h){
        if(e.getSource().get('v.label') === 'Asset Pricing'){
            c.set('v.showOptionButton', true);
            c.set('v.showSupplier', true);
             c.set('v.loanFacilityType', 'Rental - Standard');
        }else if (e.getSource().get('v.label') === 'Program Pricing') {
            c.set('v.showOptionButton', true);
            c.set('v.showSupplier', false);
            c.set('v.loanFacilityType', 'Chattel Mortgage');
        }
    },


})