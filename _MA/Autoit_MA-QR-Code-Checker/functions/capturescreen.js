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
	await page.goto(url);                        // Go to the website
	await page.screenshot({                      // Screenshot the website using defined options
		path: "capture/" + fileName + ".png",                   // Save the screenshot in current directory
		fullPage: true                              // take a fullpage screenshot
	});
	// await page.waitForSelector('div:first-of-type');
	// let element = await page.$('div:first-of-type');
	// let modName = await page.evaluate(el => el.innerText, element)
	// console.log(modName);
	// fs.appendFileSync('functions/models.txt', modName, 'utf-8');

	await page.close();                           // Close the website
	await browser.close();                        // Close the browser
}
Screenshot();