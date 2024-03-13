function removeTxtChileNode() {





}






/**
 * @projectDescription Hyndai Auto Ever EKR.
 * @author Saltlux(Lee JaeHoon)
 * @version 1.0
 * @Date 16.01.12
 * @Description 페이지 로드 시 이전 페이지에서 자동으로 생성, 
 *			   전달 된 앵커를 현재 페이지 H3 Id와 비교해여 일치 할 시 해당 위치로 이동
 *
 * 
 */



window.onload = function() {


    removeTxtChileNode();


    //(보여지는) 화면 세로 크기
    var windowHeght = window.innerHeight;
    //현재 접속 된 주소 값
    var url = window.location.href;



    //h3 태그 속성
    // 20170118 8장(_SPEC_2) 주소 접속시엔 H2로 접근
    var header = url.indexOf("_SPEC_2") == -1 ? window.document.getElementsByTagName("h3") : window.document.getElementsByTagName("h2");

    //$('div.table_audio br').remove();



    var sliceUrlArr = url.split("#");

    //이전 페이지에서 맵핑 된 파라미터값만 추출
    var anchorId = url.split("#")[sliceUrlArr.length - 1].replace(/%20/g, " ");

    for (var i = 0; i < header.length; i++) {
        var insertID = header.item(i).innerHTML.replace(/\(.+\)|•|^[\s]|<\/?a[^>]*>/g, '').trim().toLowerCase();
        // header.item(i).setAttribute('id',insertID);

        if (anchorId == insertID) {

            //파라미터와 일치하는 태그 속성
            var headerId = document.getElementById(insertID);
            //헤더 세로 크기
            var positionHeight = headerId.offsetHeight;

            //wrap div 태그 
            var wrapTag = document.getElementById("page_wrap");

            //wrap div 태그 세로 크기 
            var wrapPageSize = wrapTag.offsetHeight;

            if (windowHeght >= wrapPageSize) wrapTag.style.height = wrapPageSize * 2 + positionHeight;


            window.scroll(0, getOffsetTop(document.getElementById(insertID)));


        }
    }

};




/**
 * @projectDescription Hyndai Auto Ever EKR.
 * @author Saltlux(Lee JaeHoon)
 * @param element
 * @version 1.0
 * @Date 16.01.12
 * @Description 인자의 위치로 이동
 *
 * 
 */

function getOffsetTop(el) {
    var top = 0;
    if (el.offsetParent) {
        do {
            top += el.offsetTop;
        } while (el = el.offsetParent);
        return [top];
    }
}



// We're using a global variable to store the number of occurrences
var MyApp_SearchResultCount = 0;
var arrayForTops = [];
var currentNextIdx = 0;
// helper function, recursively searches in elements and their child nodes
function MyApp_HighlightAllOccurencesOfStringForElement(element, keyword) {
    if (element) {
        if (element.nodeType == 3) { // Text node
            while (true) {
                var value = element.nodeValue; // Search for keyword in text node
                var idx = value.toLowerCase().indexOf(keyword);

                if (idx < 0) break; // not found, abort

                var span = document.createElement("kdml");
                var text = document.createTextNode(value.substr(idx, keyword.length));

                span.appendChild(text);

                span.setAttribute("class", "MyAppHighlight");
                span.style.backgroundColor = "yellow";
                span.style.color = "black";
                var range = document.createRange();
                range.selectNodeContents(element);
                var rects = range.getClientRects();

                arrayForTops[MyApp_SearchResultCount] = rects[0].top;

                text = document.createTextNode(value.substr(idx + keyword.length));

                element.deleteData(idx, value.length - idx);

                var next = element.nextSibling;
                element.parentNode.insertBefore(span, next);
                element.parentNode.insertBefore(text, next);
                element = text;


                MyApp_SearchResultCount++; // update the counter

            }
            arrayForTops.sort(function(a, b) { return a - b });
            console.log(arrayForTops);

        } else if (element.nodeType == 1) { // Element node
            if (element.style.display != "none" && element.nodeName.toLowerCase() != 'select') {
                for (var i = element.childNodes.length - 1; i >= 0; i--) {
                    MyApp_HighlightAllOccurencesOfStringForElement(element.childNodes[i], keyword);
                }
            }
        }
    }
}

// the main entry point to start the search
function MyApp_HighlightAllOccurencesOfString(keyword) {

    MyApp_RemoveAllHighlights();
    MyApp_HighlightAllOccurencesOfStringForElement(document.body, keyword.toLowerCase());
    loadUrl("result://searchResult=" + MyApp_SearchResultCount);

}

function loadUrl(location) {
    this.document.location.href = location;
}

function MyApp_NextScroll() {
    if (currentNextIdx < MyApp_SearchResultCount - 1) {

        currentNextIdx = currentNextIdx + 1;
    } else {
        currentNextIdx = 0;
    }
    scrollTo(0, arrayForTops[currentNextIdx]);
}

function MyApp_PrevScroll() {

    if (currentNextIdx < MyApp_SearchResultCount && 0 < currentNextIdx) {

        currentNextIdx = currentNextIdx - 1;
    } else {
        currentNextIdx = MyApp_SearchResultCount - 1;
    }

    scrollTo(0, arrayForTops[currentNextIdx]);

}

// helper function, recursively removes the highlights in elements and their childs
function MyApp_RemoveAllHighlightsForElement(element) {
    if (element) {
        if (element.nodeType == 1) {
            if (element.getAttribute("class") == "MyAppHighlight") {
                var text = element.removeChild(element.firstChild);
                element.parentNode.insertBefore(text, element);
                element.parentNode.removeChild(element);
                return true;
            } else {
                var normalize = false;
                for (var i = element.childNodes.length - 1; i >= 0; i--) {
                    if (MyApp_RemoveAllHighlightsForElement(element.childNodes[i])) {
                        normalize = true;
                    }
                }
                if (normalize) {
                    element.normalize();
                }
            }
        }
    }
    return false;
}

// the main entry point to remove the highlights
function MyApp_RemoveAllHighlights() {
    MyApp_SearchResultCount = 0;
    MyApp_RemoveAllHighlightsForElement(document.body);
}