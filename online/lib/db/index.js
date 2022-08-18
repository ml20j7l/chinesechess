/**
 * @infor Database
 * @path  ./lib/db/index.js
 * 
 */

// Connect
const connectMysql = require('./connection');
const connection = connectMysql.connection('localhost', 'root', 'Ljd960513', 'test');
connection.connect();

/**
 * query userinfo
 * @param  {string}   sql      
 * @param  {Function} callback 
 * @return void
 */
 const selectHandle = (sql,callback) => {
	connection.query(sql, (err, result) => {
		if (err) {
			console.log("[select error]--" + err.message);
			return;
		}
		callback && callback(result);
	})
 }

/**
 * insert new userinfo
 * @param  {string}   addSql       
 * @param  {Array}   addSqlParams  
 * @param  {Function} callback     
 * @return void
 */
 const insertHandle = (addSql, addSqlParams, callback) => {
	connection.query(addSql, addSqlParams, (err, result) => {
		if (err) {
			console.log("[insert error]--" + err.message);
			return;
		}
		callback && callback(result);
	})
 }

/**
 * update userinfo
 * @param  {string}   updateSql       
 * @param  {Array}   updateParams  
 * @param  {Function} callback     
 * @return void
 */
 const updateHandle = (updateSql, updateParams, callback) => {
	connection.query(updateSql, updateParams, (err, result) => {
		if (err) {
			console.log("[update error]--" + err.message);
			return;
		}
		callback && callback(result);
	})
 }


module.exports = {
	selectHandle,
	insertHandle,
	updateHandle
}