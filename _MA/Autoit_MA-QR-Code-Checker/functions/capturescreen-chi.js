const puppeteer = require('puppeteer');
const fs = require('fs');

const url = process.argv.slice(2)[0];
const fileName = process.argv.slice(2)[1]

// if (fs.existsSync('functions/models.txt')) {
// 	fs.unlinkSync('functions/models.txt');
// }

console.log(url + ":::" + fileName);

const Screenshot = async () => {                // Define Screenshot function
	const browser = await puppeteer.launch({
		defaultViewport: {width: 360, height: 740, isMobile: true}
	});    // Launch a "browser"
	// const browser = await puppeteer.launch();    // Launch a "browser"
	const page = await browser.newPage();        // Open a new page
	await page.goto(url, {"waitUntil" : "networkidle0"});                        // Go to the website
	await page.evaluate(()=>{
		document.querySelector(".con_btm").scrollIntoView(false);
	});
	await page.screenshot({                      // Screenshot the website using defined options
		path: "capture/" + fileName + ".png",                   // Save the screenshot in current directory
		fullPage: true                              // take a fullpage screenshot
	});
	await page.close();                           // Close the website
	await browser.close();                        // Close the browser
}

Screenshot();