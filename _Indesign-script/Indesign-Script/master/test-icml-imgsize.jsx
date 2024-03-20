var doc = app.activeDocument;
var grs = doc.allGraphics;
var gr, sWidth, target, ratio;
for (var i=2;i<grs.length;i++) {
    gr = grs[i];
    target = gr.parent;
    sWidth = gr.geometricBounds[3] - gr.geometricBounds[1];
    if (sWidth > 180) {
        ratio = (180 / sWidth) * 100;
        target.absoluteHorizontalScale = ratio;
        target.absoluteVerticalScale = ratio;
    }
}
