#include "adobe_campaign.jsx"

var req = Request("https://m.search.naver.com/p/csearch/ocontent/util/SpellerProxy?color_blindness=0&q=how"); var response = req.Post("controller/store");

$.writeln(response);