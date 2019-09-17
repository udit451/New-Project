({
	doInit : function(c, e, h) {
	    var showEntriesPicklistValues = c.get('v.showEntriesPicklistValues');
        if(showEntriesPicklistValues) {
            c.set('v.showEntriesPicklist', showEntriesPicklistValues.split(','));
        }
        h.init_Columns(c, e, h);
	},

	closeViewModal: function(c, e, h) {
        c.set('v.showRecord', false);
    },

    updateColumnSorting: function (c, e, h) {
        var fieldName = e.getParam('fieldName');
        var sortDirection = e.getParam('sortDirection');
        c.set("v.sortedBy", fieldName);
        c.set("v.sortedDirection", sortDirection);
        h.sortData(c, fieldName, sortDirection);
    },

    showEntriesChanged: function (c, e, h) {
        c.set('v.fromEntries', '1');
        // console.log('showEntries: ' + parseInt(c.get('v.showEntries')));
        if (parseInt(c.get('v.showEntries')) < parseInt(c.get('v.totalNumberOfRows'))) {
            c.set('v.toEntries', c.get('v.showEntries'));
        } else {
            c.set('v.toEntries', c.get('v.totalNumberOfRows'));
        }
        // console.log('toEntries: ' + c.get('v.toEntries'));
        h.showRecords_Helper(c, e, h, false);
    },

    searchStringChanged: function (c, e, h) {
        var searchString = c.get('v.searchString');
        //console.log('searchString: ' + searchString);
        var allRecords = c.get('v.allRecords');
        var displayColumns = c.get('v.tableColumns');
        var displayedFields = [];
        for (var i = 0; i < displayColumns.length; i++) {
            var displayColumn = displayColumns[i];
            displayedFields.push(displayColumn.fieldName);
        }
        /*console.log('displayedFields');
        console.log(displayedFields);*/
        displayedFields.push(c.get('v.nameField'));
        var filteredRecords = [];
        if (searchString) {
            for (var i = 0; i < allRecords.length; i++) {
                var allRecord = allRecords[i];
                var isFound = false;
                for (var key in allRecord) {
                    if (allRecord.hasOwnProperty(key)) {
                        if ((((allRecord[key]).toString()).toLowerCase()).indexOf(searchString.toLowerCase()) > -1 && displayedFields.indexOf(key) > -1) {
                            console.log('allRecord:;;; ' + allRecord[key].toString().toLowerCase());
                            isFound = true;
                        }
                    }
                }
                if (isFound) {
                    filteredRecords.push(allRecord);
                }
            }
            //console.log(filteredRecords);
            c.set('v.filteredRecords', filteredRecords);
            console.log('filteredRecords: ' + filteredRecords);

        } else {
            c.set('v.filteredRecords', allRecords);
        }
        //console.log(allRecords);
        //console.log(c.get('v.filteredRecords'));
        h.showRecords_Helper(c, e, h, false);
    },
    goToFirstPage: function (c, e, h) {
        h.changePage(c, e, h, '1');
    },
    goToPreviousPage: function (c, e, h) {
        h.changePage(c, e, h, (parseInt(c.get('v.currentPage')) - 1).toString());
    },
    goToNextPage: function (c, e, h) {
        h.changePage(c, e, h, (parseInt(c.get('v.currentPage')) + 1).toString());
    },
    goToLastPage: function (c, e, h) {
        h.changePage(c, e, h, c.get('v.totalPages'));
    },
    handleRowAction : function (c, e, h){
        var action = e.getParam('action');
        console.log(action);
        var row = e.getParam('row');
        c.set('v.selectedId',row.Id);
        c.set('v.isView',true);
    }
})