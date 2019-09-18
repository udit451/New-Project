({
  doInit : function(c, e, h){
    h.doInit_Helper(c, e, h);
  },

  validate : function(c, e, h){
    h.validate_Helper(c, e, h);
  },

  openCalculator : function(c, e, h){
    c.set('v.isLogOut', false);
    h.openCalculator_Helper(c, e, h);
  },

  disclaimerPopup : function(c, e, h){
    h.disclaimerPopup_Helper(c, e, h);
  },

  closeDlPopup : function(c, e, h){
    c.set('v.Logout', false);
    h.closeDlPopup_Helper(c, e, h);
  },

  saveData : function(c, e, h){
    c.set('v.Logout', false);
    h.saveData_Helper(c, e, h);
  },

  copyData : function(c, e, h){
    h.copyData_Helper(c, e, h);
  },

  emailDataPopup : function(c, e, h){
    h.emailDataPopup_Helper(c, e, h);
  },

  clearDataPopup : function(c, e, h){
    c.set('v.Logout', false);
    h.clearDataPopup_Helper(c, e, h);
  },

  isViewChanged : function(c, e, h){
    if(c.get('v.isView') === true){
        h.editSelectedRecord(c, e, h);
    }
  },

  logout : function(c, e, h){
    h.logout_Helper(c, e, h);
    h.definedCalculatorType_helper(c, e, h);
  },

  submitToFinance : function (c, e, h) {
    var a =  c.find('SupplierMatrixCalculator');
    if(a != undefined){
      a[0].submitToFinance();
    }
  },

  goBack : function (c, e, h) {
    if(c.get('v.isSubmitted') && !c.get('v.isView')){
      c.set('v.isSubmitted',false);
      h.closeDlPopup_Helper(c, e, h);
    }
  },
  openLogOutDialog: function (c, e, h) {
    var islogOut = c.get('v.isLogOut');
      if(islogOut){
        c.set('v.isLogOut',false);
      }else{
        c.set('v.isLogOut',true);
      }   
  },
  logOutButton: function (c, e, h) {
    var islogOut = c.get('v.Logout');
      if(islogOut){
        c.set('v.Logout',false);
      }else{
        c.set('v.Logout',true);
      }   
  },
  HideErrorMessage: function(c, e, h){
    $A.util.addClass(c.find('errorLayout'), 'slds-hide');
  },

})