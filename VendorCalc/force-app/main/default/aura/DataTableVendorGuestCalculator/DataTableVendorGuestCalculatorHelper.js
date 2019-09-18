({
	doInit_Helper : function(c, e, h) {
	    var leadList = c.get('v.leadList');
	    c.set("v.totalNumberOfRows", leadList.length);
        c.set('v.allRecords', leadList);
        c.set('v.filteredRecords', leadList);
        if(c.get('v.fromEntries') === undefined) {
            c.set('v.fromEntries', '1');
        }
        if(c.get('v.toEntries') === undefined) {
            if(c.get('v.showEntries') < c.get('v.totalNumberOfRows')) {
                c.set('v.toEntries', c.get('v.showEntries'));
            } else {
                c.set('v.toEntries', c.get('v.totalNumberOfRows'));
            }
        }
	    h.showRecords_Helper(c, e, h, true);
	},

	showRecords_Helper : function(c, e, h, bool){
        var records = c.get('v.filteredRecords');
        var from = c.get('v.fromEntries');
        var to = c.get('v.showEntries');
        var finalRecords = [];
        for (var i = 1; i <= records.length; i++) {
            var record = records[i-1];
            if(bool === true && !$A.util.isUndefinedOrNull(record.VEN3__Date__c)){
               var d = record.VEN3__Date__c;
               var res =[];
               res =d.split("-");
               var newDate = res[2]+"/"+ res[1]+"/"+res[0];
               record.VEN3__Date__c = newDate;
            }
            if(!$A.util.isUndefinedOrNull(record.VEN3__Vendor_Guest_User__r.Name)){
            record.UserName = record.VEN3__Vendor_Guest_User__r.Name;
            }
            if(record.Status === 'Follow-Up Request'){
               record.Status = 'Submitted to Finance';
            }

            if(i >= parseInt(from) && i <= parseInt(to)) {

                finalRecords.push(record);
            }
        }
        c.set('v.currentPage', '1');
        if(records.length === 0) {
            c.set('v.fromEntries', '0');
            c.set('v.currentPage', '0');
        } else {
            c.set('v.fromEntries', '1');
        }
        c.set('v.totalPages', (Math.ceil(parseFloat(c.get('v.filteredRecords').length)/(parseFloat(c.get('v.showEntries')))).toString()));
        c.set('v.tableData', finalRecords);
        var newToEntry = to;
        if(parseInt(c.get('v.filteredRecords').length) < parseInt(c.get('v.showEntries'))) {
            newToEntry = parseInt(c.get('v.filteredRecords').length);
        } else {
            newToEntry = parseInt(c.get('v.showEntries'));
        }
        c.set('v.toEntries', newToEntry);
    },

    init_Columns: function(c, e, h) {
        c.set('v.tableColumns', [
            {
                label: 'Customer Name',
                fieldName: 'Name',
                type: 'text',
                sortable: true
            },
            {
                label: 'Email Address',
                fieldName: 'Email',
                type: 'text',
                sortable: true
            },
            {
                label: 'Phone',
                fieldName: 'Phone',
                type: 'text',
                sortable: true
            },
            {
                label: 'Amount Financed',
                fieldName: 'VEN3__Amount__c',
                type: 'currency',
                sortable: true
            },
            {
                label: 'Date',
                fieldName: 'VEN3__Date__c',
                type: 'text',
                sortable: true
            },
            {
                label: 'User Name',
                fieldName: 'UserName',
                type: 'text',
                sortable: true
            },
            {label: 'action', type: 'button', initialWidth:180, typeAttributes: { label: 'View ', name: 'View', title: '',iconName: 'utility:preview'}}
        ]);
        h.doInit_Helper(c, e, h);
    },

    changePage: function (c, e, h, pageNumber) {
        
        c.set('v.currentPage', pageNumber);
        var numberOfRecords = c.get('v.showEntries');
        var recordToShowEnd = parseInt(pageNumber) * parseInt(numberOfRecords);
       
        var recordToShowStart = parseInt(recordToShowEnd) - parseInt(numberOfRecords);

        var filteredRecords = c.get('v.filteredRecords');
        var newRecordsToShow = [];
        for (var i = 0; i < filteredRecords.length; i++) {
            var filteredRecord = filteredRecords[i];
            if(parseInt(i) >= parseInt(recordToShowStart) && parseInt(i) < parseInt(recordToShowEnd)) {
                newRecordsToShow.push(filteredRecord);
            }
        }
        c.set('v.tableData', newRecordsToShow);
        c.set('v.fromEntries', parseInt(recordToShowStart) + 1);
        if(parseInt(recordToShowEnd) > parseInt(filteredRecords.length)) {
            c.set('v.toEntries', filteredRecords.length);
        } else {
            c.set('v.toEntries', recordToShowEnd);
        }
    },
    sortData: function (c, fieldName, sortDirection) {
        var data = c.get("v.tableData");
        var reverse = sortDirection !== 'asc';
        //sorts the rows based on the column header that's clicked
        data.sort(this.sortBy(fieldName, reverse));
        c.set("v.tableData", data);
    },

    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
            function(x) {return x[field]};
        //checks if the two rows should switch places
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },


})