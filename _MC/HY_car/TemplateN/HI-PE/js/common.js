$(function() {

    //161130 일단 icon을 숨기고 li 밑에 자식에 OL 이 존재 할 경우 버튼 활성
    $(".icon").hide();
    $("ol.one li").find("ol").parent().find("a").show();

    $("article>ol>li>.icon").click(function() {
        if (!$(this).hasClass("on")) {
            $(this).addClass("on");
            $(this).parent().find("article>ol").css("display", "block");
            /*16.01.11 saltlux */
            $(this).parent().find("article>ol").attr("id", "openMenu");

        } else {
            $(this).removeClass("on");
            $(this).parent().find("article>ol").css("display", "none");
            $(this).parent().find("article>ol").attr("id", "");
        }

    });

    $("ol.two>li>.icon").click(function() {
        if (!$(this).hasClass("on")) {
            $(this).addClass("on");
            $(this).parent().find("ol").css("display", "block");
            /*16.01.11 saltlux */
            $(this).parent().find("ol").attr("id", "openMenu");

        } else {
            $(this).removeClass("on");
            $(this).parent().find("ol").css("display", "none");
            $(this).parent().find("ol").attr("id", "");
        }

    });


    /**
     * @projectDescription Hyndai Auto Ever EKR.
     * @author Saltlux(Lee JaeHoon)
     * @Date 16.01.11
     * @Description 모든 링크 태그의 값을 추출 하여 공백 제거, 
     *			   괄호 안 텍스트제거, 구분기호등을 제거하여 ID값으로 부여하고 href에 앵커를 자동으로 삽입
     *
     * 
     */

    // var aTagCount = $("li a").contents().size();

    // for (var i = 0; i < aTagCount; i++) {
    //     var nodeText = $("li a").eq(i).text();
    //     var regText = nodeText.replace(/\(.+\)|•|^[\s]|<.+>/g, '').trim().toLowerCase();
    //     $("li a").eq(i).attr('id', regText);
    //     if ($("li a").eq(i).attr('id') != "open/close") {
    //         var linkAdd = $("li a").eq(i).attr("href");
    //         var thisID = $("li a").eq(i).attr("id")
    //         $("li a").eq(i).attr("href", linkAdd + "#" + thisID);
    //     }

    // }

});