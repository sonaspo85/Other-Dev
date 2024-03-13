const puppeteer = require('puppeteer');
const fs = require('fs');
const { stdout, stderr } = require('process');
const cp = require('child_process').exec;

if (fs.existsSync('functions/urls.txt')) {
	fs.unlinkSync('functions/urls.txt');
}
const qrcodes = fs.readFileSync(__dirname + '/qrcodes.json', 'utf-8');
const qrData = JSON.parse(qrcodes);
const lang = process.argv.slice(2);
console.log(qrData.sessions[0].barcodes.length);
let url = 'https://' + qrData.sessions[0].barcodes[0].text;
// let url = qrData.sessions[0].barcodes[0].text;
fs.appendFileSync('functions/urls.txt', url, 'utf-8');
console.log(url, lang[0]);
console.log(lang[1])

puppeteer.launch({args:['--lang="' + lang[0] + '"']}).then(async browser => {
    const page = await browser.newPage();
    await page.setExtraHTTPHeaders({
        'Accept-Language': lang[0]
    });
    // note: add trailing slash since chrome adds it
    if (!url.endsWith('/'))
        url = url + '/';

    // urls hold redirect chain
    const urls = [url];

    const client = await page.target().createCDPSession();
    await client.send('Network.enable');
    await client.on('Network.requestWillBeSent', (e) => {
        if (e.type !== "Document") {
            return;
        }

        console.log("EVENT INFO: ");
        console.log(e.type);
        console.log(e.documentURL);
        console.log("INITIATOR: " + JSON.stringify(e.initiator, null, 4));

        // check if url redirected
        if (typeof e.redirectResponse != "undefined") {
            // get redirect info
            console.log("REDIRECT STATUS CODE: ");
            console.log(e.redirectResponse.status);

            console.log("REDIRECT REQUEST URL: ");
            console.log(e.request.url);
            urls.push(e.redirectResponse.status, e.request.url);
        } else {
            // url did not redirect
            if (e.request.url !== urls[urls.length - 1]) {
                console.log("NO REDIRECT REQUEST URL: ");
                console.log(e.request.url);
                urls.push(e.request.url);
            }
        }
    });
    await page.goto(url);
    console.log("Final urls array: " + urls.length);
	let date_ob = new Date();
	
    // current date
	// adjust 0 before single digit date
	let date = ("0" + date_ob.getDate()).slice(-2);
	// current month
	let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);
	// current year
	let year = date_ob.getFullYear();
	// current hours
	let hours = date_ob.getHours();
	// current minutes
	let minutes = date_ob.getMinutes();
	// current seconds
	let seconds = date_ob.getSeconds();
	let cTime = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;

	console.log(urls);
    fs.appendFileSync('logs.log', cTime + ": " + lang[0] + "\r");
    fs.appendFileSync('logs.log', cTime + ": " + "Final urls array: " + urls.length + "\r");
	fs.appendFileSync('logs.log', cTime + ": " + urls.toString() + "\r");
	console.log(urls[urls.length - 1]);
	let lasturl = urls[urls.length - 1];
	// fs.appendFileSync('../redirectedurls.txt', lasturl + "\r", 'utf-8');
	let capture = 'node functions/capturescreen.js ' + lasturl + " " + lang[0];
	let child = cp(capture, (err, stdout, stderr) => {
		// console.log(`stdout: ${stdout}`);
        // console.log(`stderr: ${stderr}`);
        if (err !== null) {
            console.log(`exec error: ${err}`);
        }
	});

    if (lang[1] == "English (CHN)" || lang[1] == "Simplified Chinese (PRC)" || lang[1] == "English (HK)" || lang[1] == "HongKong China" || lang[1] == "English (TC)" || lang[1] == "Taiwan") {
        let menus = await page.evaluate(
            () => Array.from(
                document.querySelectorAll('ul.choice_f li a span'),
                c => c.innerText
            )
        );
        let capture;
        console.log(menus.length);
        if (page.$('div#wrap ul.choice_f') !== null) {
            if (menus.length == 5) {
                capture = 'node functions/capturescreen-chi.js ' + lasturl.replace('start_here.html', '008_copyright_1.html#0') + ' "' + lang[1] + '"';
            } else if (menus.length == 4) {
                capture = 'node functions/capturescreen-chi.js ' + lasturl.replace('start_here.html', '007_copyright_1.html#0') + ' "' + lang[1] + '"';
            }
            let child = cp(capture, (err, stdout, stderr) => {
                // console.log(`stdout: ${stdout}`);
                // console.log(`stderr: ${stderr}`);
                if (err !== null) {
                    console.log(`exec error: ${err}`);
                }
            });
        } else {
        // nothing
        }
    }
    await browser.close();
});