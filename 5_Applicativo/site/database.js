var mysql = require('mysql');

require('dotenv').config();

// Take variable from .env file
const DB_HOST = process.env.DB_HOST;
const DB_USER = process.env.DB_USER;
const DB_PASSWORD = process.env.DB_PASSWORD;
const DB_DATABASE = process.env.DB_DATABASE;

// Creating the connection to the database.
var connection = mysql.createConnection({
	host: DB_HOST,
	user: DB_USER,
	password: DB_PASSWORD,
	database: DB_DATABASE
});

// Start connecting to the database.
connection.connect((err) => {
  if (err) {
    console.log(err);
  }else{
    console.log('Database connected');
  }
});
/**
 * Return a formatted string of today.
 * 
 * @return {String} stringdate - Formatted string for today date.
 */
function formatDateTime() {
  let dateObj = new Date();
  
  let year = dateObj.getUTCFullYear();
  let month = (dateObj.getUTCMonth() + 1).toString().padStart(2, '0');
  let day = dateObj.getUTCDate().toString().padStart(2, '0');
  let hours = dateObj.getUTCHours().toString().padStart(2, '0');
  let minutes = dateObj.getUTCMinutes().toString().padStart(2, '0');
  let seconds = dateObj.getUTCSeconds().toString().padStart(2, '0');
  
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

/**
 * Insert into the table `LOG` a log with the message 'msg' and today date.
 * @param {String} msg - Message to write into the row.
 */
function insertLog(msg){
  let query = 'INSERT INTO LOG(timestamp,descrizione) VALUES(?,?) ';
  let values = [formatDateTime(),msg];
  
  connection.query(query, values, function (err, result, fields) {
    if(err) console.log(err);
  });
}

// Exporting connection and utility function.
module.exports = {connection,insertLog};