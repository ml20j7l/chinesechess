/**
 * @infor websocket
 * @path  ./controller/socketController.js
 */

//Create a websocket instance
const WebSocket = require("ws");//Heartbeat detection

/**
 * Create a websocket serve
 * @param  {Number} port 
 * @return {Object} websocket instance Object
 */
const createWebSocket = port => server = new WebSocket.Server({ port: port });

/**
 * Initialize a websocket event
 * @param  {Object} eventHandleObject  
 * @param  {Number} port               
 * @return void
 */
const initEventHandle = (eventHandleObject, port = 3006) => {
	const server = createWebSocket(port)
	server.on('connection', ws => {
		Object.keys(eventHandleObject).forEach(event => {
			event === 'connection' 
			? eventHandleObject[event](ws, port) 
			: ws.on(event, function () { eventHandleObject[event](...arguments, ws) });//Connect events
		})
	})
}

module.exports = {
	createWebSocket,
	initEventHandle
}