﻿//@include ../bin/porky.jsx;var myString = "1a, 2a, 3a, 4a|hey, ho, let's, go!";var myArray = stringToTwoDArray(myString, ",", "|");alert("string to array conversion" + "\nString: " + myString + "\n\nwill become an array");alert( JSON.stringify(myArray) );var myTextFrame = addFrame(0, 00, 100, 50, "");var myTableObject = appendToFrame(myTextFrame, myArray);alert("Appending an array to a textframe\nwill create a table right from the array!");var myStringFromArray = twoDArrayToString(myArray, ",","|");var myStringObject = appendToFrame(myTextFrame, "\r\rThis string was converted from an array:\r" + myStringFromArray);