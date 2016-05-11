/*
 * This script is part of the HTML Forms Collection and implements
 * functionalities required by a specific form.
 *
 * Copyright (C) 2015  Kristian Kutin
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * e-mail: kristian.kutin@arcor.de
 */


/* ________________________________________________________________________________
 *
 * LOGGING SECTION
 * ________________________________________________________________________________
 */

/*
 * Initializes the internal logging mechanism.
 */
console.log("initialize logger...");

DebugLevelEnum = {

	DEBUG : 0,
	INFO : 1,
	WARNING : 2,
	ERROR : 3
}

var debugLevel = DebugLevelEnum.INFO;

console.log("initialize logger done.");


/**
 * Logs the specified debug message.
 *
 * @param aMessage
 */
function logDebug(aMessage) {

	log(DebugLevelEnum.DEBUG, aMessage);
}

/**
 * Logs the specified info message.
 *
 * @param aMessage
 */
function logInfo(aMessage) {

	log(DebugLevelEnum.INFO, aMessage);
}

/**
 * Logs the specified warning.
 *
 * @param aMessage
 */
function logWarning(aMessage) {

	log(DebugLevelEnum.WARNING, aMessage);
}

/**
 * Logs the specified error message.
 *
 * @param aMessage
 */
function logError(aMessage) {

	log(DebugLevelEnum.ERROR, aMessage);
}

/**
 * Logs the specified message. Depending on the current debug level the
 * output will be printed to the console.
 *
 * @param aLogLevel
 * @param aMessage
 */
function log(aLogLevel, aMessage) {

	if (aLogLevel >= debugLevel) {

		var prefix = null;
		
		if (aLogLevel === DebugLevelEnum.DEBUG) {

			prefix = "   DEBUG::";

		} else if (aLogLevel === DebugLevelEnum.INFO) {

			prefix = "    INFO::";

		} else if (aLogLevel === DebugLevelEnum.WARNING) {

			prefix = " WARNING::";

		} else {

			prefix = "   ERROR::";
		}

		console.log(getTimeStamp() + " " + prefix + aMessage);
	}
}

/**
 * The method returns a timestamp which contains the current date and time as human
 * readable string (i.e. "YYYY-MM-dd HH:mm:ss:SSSS").
 *
 * @return a time stamp
 */
function getTimeStamp() {

	var currentTime = new Date();


	var year = currentTime.getFullYear();
	var month = currentTime.getMonth() + 1;
	var day = currentTime.getDate();

	var dateString = "" + year + "-";
	if (month < 10) {
		dateString = dateString + "0";
	}
	dateString = dateString + month;
	if (day < 10) {
		dateString = dateString + "0";
	}
	dateString = dateString + day;


	var hours = currentTime.getHours();
	var minutes = currentTime.getMinutes();
	var seconds = currentTime.getSeconds();
	var milliseconds = currentTime.getMilliseconds();

	var timeString = "";
	if (hours < 10) {
		timeString = timeString + "0";
	}
	timeString = timeString + hours + ":";
	if (minutes < 10) {
		timeString = timeString + "0";
	}
	timeString = timeString + minutes + ":";
	if (seconds < 10) {
		timeString = timeString + "0";
	}
	timeString = timeString + seconds + ",";
	if (milliseconds < 10) {
		timeString = timeString + "000";
	} else if (milliseconds < 100) {
		timeString = timeString + "00";
	} else if (milliseconds < 1000) {
		timeString = timeString + "0";
	}
	timeString = timeString + milliseconds;


	var timestamp = dateString + " " + timeString;

	return timestamp;
}


/* ________________________________________________________________________________
 *
 * Utility functions
 * ________________________________________________________________________________
 */

/*
 * Initializes utility functions.
 */
console.log("initialize utilities...");

var UNDEFINED = 'undefined';

console.log("initialize utilities done.");


/**
 * Checks if the specified object is undefined.
 * 
 * @param anObject
 * 
 * @return <code>true</code> if the specified object is undefined, else
 *         <code>false</code>
 */
function isUndefined(anObject) {

	if (typeof(anObject) == UNDEFINED) {

		return true;

	} else {

		return false;
	}
}

/**
 * Checks if the specified object is defined.
 * 
 * @param anObject
 * 
 * @return <code>true</code> if the specified object is defined, else
 *         <code>false</code>
 */
function isDefined(anObject) {

	return !isUndefined(anObject);
}

/**
 * Checks if the specified object is <code>null</code>
 * 
 * @param anObject
 * 
 * @return <code>true</code> if the specified object is <code>null</code>, else
 *         <code>false</code>
 */
function isNull(anObject) {

	if (anObject == null) {

		return true;

	} else {

		return false;
	}
}

/**
 * Checks if the specified object is not <code>null</code>
 * 
 * @param anObject
 * 
 * @return <code>true</code> if the specified object is not <code>null</code>,
 *         else <code>false</code>
 */
function isNotNull(anObject) {

	return !isNull(anObject);
}

/**
 * Checks if the specified string is empty.
 * 
 * @param aString
 * 
 * @return <code>true</code> is the specified string is empty, else <code>false</code>
 */
function isEmpty(aString) {

	if (isUndefined(aString) || isNull(aString)) {

		return false;
	}

	var trimmedString = aString.trim();

	return (trimmedString.length == 0);
}


/* ________________________________________________________________________________
 *
 * DEBUG SECTION
 * ________________________________________________________________________________
 */

/**
 * Performs several checks on the specified object and logs the results.
 *
 * @param aName
 *        the name of the specified object is used for console outputs.
 * @param anObject
 *        the actual object which is to be checked.
 */
function checkObject(aName, anObject) {

	var message = "";

	if (isUndefined(anObject)) {

		message = message + aName + " typeof " + UNDEFINED;

	} else {

		message = message + aName + " typeof " + typeof(anObject);
	}
	
	if (isNull(anObject)) {

		message = message + " // " + aName + " is null";

	} else {

		message = message + " // " + aName + " is " + anObject;
	}

	logDebug(message);
}

/**
 * Returns a string which contains details about all specified attributes.
 *
 * @param someAttributes
 *
 * @return a string
 */
function attributes2String(someAttributes) {

	var string = "";

	for (var i = 0; i < someAttributes.length; i++) {

		var attrib = someAttributes[i];
		string = string + attrib.name + "=" + attrib.value + "  ";
	}
	
	return string;
}


/* ________________________________________________________________________________
 *
 * Button "openURL" - event handling
 * ________________________________________________________________________________
 */

/*
 * Initializes event handling.
 */
console.log("initialize button openURL - event handling...");

var ELEMENT_NODE_TYPE = 1;

console.log("initialize button openURL - event handling done.");


 /**
 * A URL is retrieved from within the form and opened in a new tab.
 *
 * @param aButton
 *        a reference to the pressed button
 */
function openURL(aButton) {

	checkObject("document", document);

	var div = getDiv(aButton);
	checkObject("div", div);

	var url = getURL(div);
	checkObject("url", url);
	logInfo("url: \'" + url + "\'");

	if (isEmpty(url)) {

		logError("No document has been specified (url=\'" + url + "')!");

	} else {

		logInfo("open URL \'" + url + "\'");

		var win = window.open(url, '_blank');
		win.focus();
	}
}

/**
 * Returns a parent element which represents a table row.
 *
 * @param anElement
 *
 * @return a table row or <code>null</code> if no such parent element can be identified
 */
function getRow(anElement) {

	checkObject("anElement", anElement);

	if (isUndefined(anElement) || isNull(anElement)) {

		return null;
	}

	if ((anElement.nodeType == ELEMENT_NODE_TYPE) && (anElement.nodeName == 'TR')) {
	
		return anElement;

	} else {

		return getRow(anElement.parentNode);
	}
}

/**
 * Returns a parent element which represents a section.
 *
 * @param anElement
 *
 * @return a section or <code>null</code> if no such parent element can be identified
 */
function getDiv(anElement) {

	checkObject("anElement", anElement);

	if (isUndefined(anElement) || isNull(anElement)) {

		return null;
	}

	if ((anElement.nodeType == ELEMENT_NODE_TYPE) && (anElement.nodeName == 'DIV')) {
	
		return anElement;

	} else {

		return getDiv(anElement.parentNode);
	}
}

/**
 * Returns the URL within the specified table row.
 *
 * @param a table row
 *
 * @return a URL
 */
function getURL(aNode) {

	if (isUndefined(aNode) || isNull(aNode)) {

		return null;
	}


	var url = null;

	var found = containsURL(aNode);
	if (found) {

		url = extractURL(aNode);

	} else {

		var children = aNode.children;
		var length = children.length;

		for (var i = 0; i < length; i++) {

			var child = children[i];
			url = getURL(child);

			found = (url != null);
			if (found) {

				break;
			}
		}
	}

	return url;
}

/**
 * Checks if the specified node contains a URL.
 * 
 * @param aNode
 * 
 * @return <code>true</code> if the node contains a URL, else <code>false</code>
 */
function containsURL(aNode) {

	var found = false;

	var attributes = aNode.attributes;
	var length = attributes.length;

	for (var i = 0; i < length; i++) {

		var attribute = attributes[i];

		if ((attribute.name == 'name') && (attribute.value == 'entity_url')) {

			found = true;
			break;
		}
	}

	return found;
}

/**
 * Returns the URL within the specified node.
 * 
 * @param aNode
 *
 * @return a URL or <code>null</code> if no URL was specified
 */
function extractURL(aNode) {

	var value = aNode.value;
	return value;
}


/* ________________________________________________________________________________
 *
 * Button "addRow" - event handling
 * ________________________________________________________________________________
 */

/*
 * Initializes event handling.
 */
console.log("initialize button addRow - event handling...");

var FIRST_ROW_INDEX = 1;

console.log("initialize button addRow - event handling done.");


/**
 * Adds a new row to the table.
 */
function addRow() {

	checkObject("document", document);

	var table = document.getElementById("requirementsTable");
	checkObject("table", table);

	var rowcount = table.length;
	checkObject("rowcount", rowcount);
	logDebug("rowcount = " + rowcount);

	var firstRow = getFirstRow();
	var clonedRow = cloneRow(firstRow);
	logInfo("clone first row");

	table.appendChild(clonedRow);
	logInfo("append cloned row");

	clearRow(clonedRow);
	logInfo("clear cloned row");
}

/**
 * Returns the first row of the table.
 *
 * @return the first row
 */
function getFirstRow() {

	checkObject("document", document);

	var table = document.getElementById("requirementsTable");
	checkObject("table", table);

	var firstRow = table.rows[FIRST_ROW_INDEX];
	checkObject("firstRow", firstRow);
	
	return firstRow;
}

/**
 * Returns a clone of the specified row. The caller is responsible to add the cloned row
 * to a table.
 *
 * @param aRow
 * 
 * @return a clone of the specified row
 */
function cloneRow(aRow) {

	checkObject("aRow", aRow);

	var clone = aRow.cloneNode(true);
	checkObject("clone", clone);

	return clone;
}

/**
 * Clear all input fields inside the specified row.
 * 
 * @param aRow
 */
function clearRow(aRow) {

	checkObject("aRow", aRow);

	var allInputFields = getInputFields(aRow);
	var length = allInputFields.length;

	logDebug("found " + length + " input fields.");

	for (var i = 0; i < length; i++) {

		var inputField = allInputFields[i];
		logDebug("" + i + ") " + attributes2String(inputField.attributes));

		if (isInputField(inputField)) {

			var value = inputField.value;
			logDebug("" + i + ") input field value = " + value);
			inputField.value = "";

		} else if (isCheckBox(inputField)) {

			var checked = inputField.checked;
			logDebug("" + i + ") check box value = " + checked);
			inputField.checked = false;

		} else {

			logDebug("" + i + ") unknown input field");
		}
	}
}

/**
 * Identifies all input fields below the specified node and returns
 * an array with all input fields.
 * 
 * @param a node
 * 
 * @return an array of input fields
 */
function getInputFields(aNode) {

	checkObject("aNode", aNode);

	var allInputFields = [];


	if (isUndefined(aNode) || isNull(aNode)) {

		return allInputFields;
	}


	if (isInputFieldElement(aNode)) {

		allInputFields.push(aNode);

	} else {

		var children = aNode.children;
		var length = children.length;

		for (var i = 0; i < length; i++) {

			var child = children[i];
			allInputFields = allInputFields.concat(getInputFields(child));
		}
	}


	return allInputFields;
}

/**
 * Checks if the specified node is an input field element.
 * 
 * @param aNode
 * 
 * @return <code>true</code> if the specified node is an input field element, else
 *         <code>false</code>
 */
function isInputFieldElement(aNode) {

	if ((aNode.nodeType == ELEMENT_NODE_TYPE) && (aNode.nodeName == 'INPUT')) {
	
		return true;

	} else {

		return false;
	}
}

/**
 * Checks if the specified input field is a text field.
 * 
 * @param aNode
 * 
 * @return <code>true</code> if the specified input field is a text field, else
 *         <code>false</code>
 */
function isInputField(aNode) {

	checkObject("aNode", aNode);

	return (aNode.getAttribute('type') === 'text');
}

/**
 * Checks if the specified input field is a check box.
 * 
 * @param aNode
 * 
 * @return <code>true</code> if the specified input field is a check box, else
 *         <code>false</code>
 */
function isCheckBox(aNode) {

	checkObject("aNode", aNode);

	return (aNode.getAttribute('type') === 'checkbox');
}

/**
 * Checks if the specified input field is a radio button.
 * 
 * @param aNode
 * 
 * @return <code>true</code> if the specified input field is a radio button, else
 *         <code>false</code>
 */
function isRadioButton(aNode) {

	checkObject("aNode", aNode);

	return (aNode.getAttribute('type') === 'radio');
}
