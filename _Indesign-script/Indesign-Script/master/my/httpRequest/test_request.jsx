var reply = "";
var conn = new Socket;

if (conn.open ('m.search.naver.com:80')) {
	var result = conn.write ('GET /p/csearch/ocontent/util/SpellerProxy?color_blindness=0&q=how HTTP/1.1\r\n Host:m.search.naver.com \n\n');
    reply = conn.read(999999);
    var close = conn.close();
    $.write(reply)
}