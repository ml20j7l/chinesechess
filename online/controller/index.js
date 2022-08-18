/**
 * @infor Initialize Route
 * @path  ./controller/index.js
 * 
 */

const express = require("express");
const app = express();
const http = require('http').Server(app);
const io = require('socket.io')(http);
const bodyParser = require("body-parser");
const path = require('path');
const urlencodedParser = bodyParser.urlencoded({ extended: false })
const chalk = require('chalk');//Beautify Style
const ip = require('ip') //Obtain an available IP -- routing address in the LAN

// Initialize Reference
const initApp = () => {
	//Homepage route
	app.get("/",function(req,res){
		res.sendFile(path.join(__dirname, "../views/chess.html"));
	})

	//other route
	app.get("/:view",function(req,res){
		res.sendFile(path.join(__dirname, "../views/"+req.params.view+".html"));
	})

	
	// app.get("/favicon.ico",function(req,res){
	// 	res.sendFile(path.join(__dirname, "../public/img/icon.png"));
	// })

	//static files in public 
	app.use(express.static(path.join(__dirname, '../public')));

	//Post request
	app.post("/postFormData",urlencodedParser,function(req,res){
		res.send(req.body.value);
	})

	// Listening port
	let port = 8882
	app.listen(port);
	console.log(`server is started by port ${port}`);//Print in console
	console.log(` - Local:   ${chalk.green(`http://localhost:${port}/login`)}`)
	console.log(` - Network: ${chalk.green(`http://${ip.address()}:${port}/login`)}`)
}

module.exports = {
	initApp
}