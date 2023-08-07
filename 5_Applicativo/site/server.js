const express = require('express');
const bodyParser = require('body-parser');
//const cookieParser = require("cookie-parser");
const session = require('express-session');
const req = require('express/lib/request');
const bcrypt = require("bcrypt") ;
const {insertLog} = require('./database.js');
const {connection} = require('./database.js');

const app = express();
const PORT = process.env.PORT || 4000; 
require('dotenv').config();
const PUBLIC = process.env.PUBLIC_DIR;
  
app.use(bodyParser.urlencoded({extended: true}))
app.use(express.static('public'));
app.use(express.json());
//app.use(cookieParser());

app.set('view engine', 'ejs');

// 
app.use(session({
    secret: "mKeRvr0i1kAPDmcqfnu7TNtKBxLyfO5Q7uKccAS2dPIs2qlsoV9svuHCPVBbcTeL",
    saveUninitialized: false,
    resave: false 
}));


/**
 * Manage the GET request for root '/'.
 * @param {Object} request - Object of the HTTP request incoming.
 * @param {Object} response - Object of the HTTP response to send to the client.
 */
app.get("/", function(request, response){
	let username = request.session.username;
	let tipo = request.session.tipo;

	if(username){
		response.render(PUBLIC+"/home.ejs", {username: request.session.username, tipo: tipo, title:"home Progetto Kyudd-imi"});
	}else{
		response.render(PUBLIC+"/home.ejs",{title:"home Progetto Kyudd-imi"});
	}
	
});


/**
 * Manage the GET request for root '/'.
 * @param {int} PORT - Listening port of the application.
 */
app.listen(PORT, function(){
	console.log("server stared on port "+PORT);
});

require('./routes/auth')(app,connection,PUBLIC,insertLog);
require('./routes/classroom')(app,connection,PUBLIC);
require('./routes/window')(app,connection,PUBLIC);
require('./routes/3D')(app,PUBLIC);



