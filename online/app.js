/**
 * @infor background page entry
 * @path  ./js/index.js
 * 
 */

const { initApp } = require('./controller')
initApp();//Initialize application&route

// import database function
const { selectHandle, insertHandle, updateHandle } = require('./lib/db')

const { initEventHandle } = require('./controller/socketController')

let cons = [];//connect storage array
let data = {};//store initialization data
let isConnect = false;//whether connect firstly or not
let userList = [];
let CURRENT_COLOR = true;//Initialize the chess player, the default is the RED

/**
 * connect websocket
 * @param  {Object} ws   
 * @param  {Number} port 
 * @return void
 */
const connectionHandle = (ws, port) => {
	cons.push({
		socket: ws,
		port: port
	});
	console.log("con num:" + cons.length);
	isConnect && ws.send(JSON.stringify(data));
}

/**
 * receive data
 * @param  {string} message json
 * @return void
 */
const messageHandle = message => {
	isConnect = true;
	data = JSON.parse(message);
	data.type  == 'open' && (cons[cons.length - 1].username = data.currentUser);

	// update winner info
	const updateWinnerNum = _ => {
		let updateSql = 'UPDATE user_data SET num = num + 1 WHERE username = ?';
		let updateParams = [data.win];
		updateHandle(updateSql, updateParams);
	}

	// insert user info
	const insertUserData = _ => {
		//set user info
		setUserInfo(userList, data.currentUser);
		data.isInit = true;

		//add a new user，score default 0
		const insertUserInfoData = index => {
			let sql = `select * from user_data where username = '${userList[index].currentUser}'`;//quota
			selectHandle(sql, result => {
				const insertUserAndSendInfo = _ => {
					let addSql = 'INSERT INTO user_data(username,num) VALUES(?,?)';
					let addSqlParams = [userList[index].currentUser,0];
					insertHandle(addSql, addSqlParams, _ => {
						sendAllUserInfo(data);
					});
				}

				// if there is no the user info，insert a new user info
				result.length == 0 && insertUserAndSendInfo()
			});
		}

		userList.forEach((item, index) => insertUserInfoData(index))
	}

	data.win && updateWinnerNum() // win and score+1
	!data.currentUser ? (data.isInit = false) : insertUserData() 
	sendAllUserInfo(data);//select all user info
}

/**
 * 关闭连接方法
 * @param  {Number} code   
 * @param  {Object} reason 
 * @param  {Object} ws     
 * @return void
 */
const closeHandle = (code, reason, ws) => {
	let popNum = -1;
	cons.forEach((con, index) => {
		con && con.socket == ws && (popNum = index)
	})

	const setUserList = index => {
		userList.splice(index, 1)
		data.userList = userList;
	}
	userList.forEach((item, index) => {
		cons[popNum].username == item.currentUser && setUserList(index)
	})

	cons.splice(popNum, 1)
	console.log("webSocket connection loses,code:" + code + ",reason:" + reason);
	console.log(`con num:${cons.length}`)
}

/**
 * listening error
 * @param  {Object} e 
 * @return void
 */
const errorHandle = e => console.error(e)

initEventHandle({
	connection: connectionHandle,
	message: messageHandle,
	close: closeHandle,
	error: errorHandle
})

/**
 * send all user data and update all user data synchronously
 * @return void
 */
function sendAllUserInfo(){
	data.userList = userList;

	// move and switch side
	if (data.type == 'move')
		CURRENT_COLOR = !CURRENT_COLOR;
	data.currentColor = CURRENT_COLOR;

	// query database
	let sqlSelectAll = 'select * from user_data';
	selectHandle(sqlSelectAll, (result) => {
		result && (data.user_data = result);
		cons.forEach((item, index) => item.socket.send(JSON.stringify(data)))
	})
}

/**
 * set user info
 * @param {Array} arr  
 * @param {String} user 
 */
function setUserInfo(arr, user){
	if (arr.length >= 2 || (arr.length == 1 && arr[0].currentUser == user)) {
		return
	}

	// set RED & BLACK info 
	let isRed = false;
	arr.forEach(item => (item.isRed === 'red' && (isRed = true)))
	arr.push({
		currentUser: user,
		isRed: isRed ? 'black' : 'red'
	})
}