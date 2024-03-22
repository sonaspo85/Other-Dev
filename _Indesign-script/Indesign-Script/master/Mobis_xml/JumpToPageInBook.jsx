﻿//DESCRIPTION: Jumps to a page number in the first open book
//AUTHOR: Harbs www.in-tools.com
//Version: 1.0.1
main();
function main(){
	var kAppVersion = parseFloat(app.version);
	var book = GetBook();
	if(!book){alert("북 파일이 열려있지 않습니다.");return}
	var lastNumber=null;
	var contents = book.bookContents.everyItem().getElements();
	var lastDoc = book.bookContents[-1];
	if(lastDoc instanceof Document){
		var lastNumber = parseInt(lastDoc.pages[-1].name);
	} else {
		var pageRange = lastDoc.documentPageRange.split("-");
		var lastNumber = parseInt(pageRange[pageRange.length-1]);
	}
	if(!lastNumber){alert("북 파일의 문서가 열리지 않습니다.");return}
	var d=app.dialogs.add({name:"Jump To Page Number:"});
	var numberBox = d.dialogColumns.add().integerEditboxes.add({minimumValue:1,maximumValue:lastNumber,editValue:1,smallNudge:1,largeNudge:10});
	var userInteract =  app.scriptPreferences.userInteractionLevel;
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.INTERACT_WITH_ALL;
	var result = d.show();
	app.scriptPreferences.userInteractionLevel = userInteract;
	if(!result){d.destroy();return}
	var selectedPage = numberBox.editValue;
	d.destroy();
	for(var i=0;i<contents.length;i++){
		if(contents[i] instanceof BookContent){
			var pageRange = contents[i].documentPageRange.split("-");
			if(isNaN (pageRange[0]) ||pageRange[0]>selectedPage || pageRange[pageRange.length-1]<selectedPage){continue}
			var startPage = pageRange[0];
			try{var doc = app.open(File(contents[i].fullName));}catch(e){continue}
		} else {
		 var doc = contents[i];
		}
		try{
			var page = doc.pages.item(selectedPage-startPage);
			app.activeWindow = doc.layoutWindows[0];
			app.activeWindow.activePage = page;
			return;
		}
		catch(err){}
	}
	alert("페이지를 찾을 수 없습니다.");
}
//**********************************
function GetBook(){
	if(app.books.length==0){return false;}
	if(app.books.length >1){
		return GetBookFromDialog();
		}
	return app.books[0];
	}
//**********************************
function GetBookFromDialog(){
	var books = app.books;
	bookNameList = GetItemNames(books);
	var d = app.dialogs.add({name:"북 파일을 선택하세요.",canCancel:true});
	with(d){
		with(dialogColumns.add()){
			myBookDD = dropdowns.add( {stringList: bookNameList, selectedIndex: 0} );
			}
		}
	var userInteract =  app.scriptPreferences.userInteractionLevel;
	app.scriptPreferences.userInteractionLevel = UserInteractionLevels.INTERACT_WITH_ALL;
	var result = d.show();
	app.scriptPreferences.userInteractionLevel = userInteract;
	if(result){
		var bookIndex = myBookDD.selectedIndex;
		d.destroy();
		}
	else{d.destroy();return false;}
	return books[bookIndex];
	}
//**********************************
function GetItemNames(array){
	var nameArray = [];
	for(var i=0;i<array.length;i++){
		nameArray.push(array[i].name);
		}
	return nameArray;
	}
//**********************************
