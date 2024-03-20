var docs = app.documents;

for (var i = docs.length-1; i >= 0; i--) {
	docs[i].close(SaveOptions.NO);
}