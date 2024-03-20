#targetengine "session" 
var eventListener = app.addEventListener("afterClose", checkBookFileOrder, false);

function checkBookFileOrder(myEvent) {
	// try {
		if (app.books.length > 0) {
			var fileList = [];
			var myBook = app.activeBook;
			var myBookContents = myBook.bookContents.everyItem().getElements();
			for (var i=0; i<myBookContents.length; i++) {
				var myDocName = myBookContents[i].name;
				fileList.push(myDocName);
			}
			var chpNum
			var orderList = [];
			for (i=0; i<fileList.length; i++) {
				// $.writeln(fileList[i].replace(/\_\w+\.indd/g, ""));
				chpNum = fileList[i].replace(/(\_|\-)[^>]+\.indd/ig, "")
				orderList.push(chpNum*1);
			}
			// $.writeln(orderList);
			for (i=0; i<orderList.length-1; i++) {
				if (orderList[i] <= orderList[i+1]) {
					// $.writeln(orderList[i] + " : " + orderList[i+1]);
					continue;
				} else {
					alert ("파일명 " + orderList[i] + " 파일의 순서가 잘못됐습니다. 북 파일을 확인하세요.");
					// exit();
				}
			}
			// alert("파일명 순서가 올바릅니다.");
		}
	// } catch (e) {
	// 	alert(e.massage + ", line: " + e.line);
	// }
}