({
	closeToast : function(c, e, h) {
        c.set("v.showToast", false);
	},

    changeToastHandler : function (c, e, h) {
        if (c.get('v.showToast') === true) {
            window.setTimeout(
                $A.getCallback(function () {
                    c.set("v.showToast", false);
                }), 5000
            );
        }
    },

    doinit : function(c, e, h){
        c.set("v.showToast", true);
        if (c.get('v.showToast') === true) {
            window.setTimeout(
                $A.getCallback(function () {
                    c.set("v.showToast", false);
                }), 3000
            );
        }
    }

})