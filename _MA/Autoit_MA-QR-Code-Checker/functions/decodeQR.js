// node brcli-example.js           ->  use BarcodeReaderCLI command line 
// node brcli-example.js config    ->  use BarcodeReaderCLI configuration file  

const fs = require('fs');
const cp = require('child_process');
const pdf = process.argv.slice(2);
process.chdir(__dirname);

if (fs.existsSync('qrcodes.json')) {
	fs.unlinkSync('qrcodes.json');
}
var exe = '../bin/BarcodeReaderCLI';
var args = [];
// var pdfPath = encodeURI(pdf[0]);
console.log(pdfPath);
args.push('-type=qr');
args.push(pdf[0]);

const proc = cp.spawn(exe, args);
proc.stdout.on('data', (data) => {
    console.log(data.toString());
    fs.appendFileSync('qrcodes.json', data.toString(), 'utf-8');
});
proc.stderr.on('data', (data) => {
    console.error(data.toString());
    fs.appendFileSync('error-log.txt', data.toString(), 'utf-8');
});
