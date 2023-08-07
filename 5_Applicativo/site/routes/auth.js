module.exports = function(app, connection, PUBLIC, insertLog){

    const bcrypt = require('bcrypt');

    /**
     * Executes the logout.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     */
    app.get('/logout',(request,response) => {
        let username = request.session.username;
        
        if(username){
            insertLog("Logout utente "+username);
            request.session.destroy();
            response.render(PUBLIC+"/home.ejs", {info: "logout eseguito", title:"home Progetto Kyudd-imi"});
        }else{
            response.render(PUBLIC+"/home.ejs", {info: "esegui prima il login", title:"home Progetto Kyudd-imi"});
        }
    });

    /**
     * Returns the login page.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     */
    app.get("/login", function(request, response){
        let username = request.session.username;
        let tipo = request.session.tipo;
        
        if(username){
            response.render(PUBLIC+"/home.ejs",{username: username, tipo: tipo, title:"home Progetto Kyudd-imi"});
        }else{
            response.render(PUBLIC+"/login.ejs",{title:"Login"});
        }
    
    });	
    
    /**
     * Executes the login of the user.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     */
    app.post("/login", function(request, response){
        
        let username = request.body.username;
        let password = request.body.password;
        
        let query = 'SELECT password,tipo_nome FROM UTENTE WHERE nome = ? ';
        let values = [username];
        if(!username || !password){
            response.render(PUBLIC+"/login.ejs", {error: "username o password errati", title:"Login"});
            return;
        }
        connection.query(query, values,function (err, result, fields) {
            if (err) console.log(err);

            if(result){
                if(result.length != 0){
                    bcrypt
                        .compare(password, result[0].password)
                        .then(res => {
                            if(res){
                                insertLog("Login utente "+username);
                                request.session.username = username;
                                request.session.tipo = result[0].tipo_nome;
                                response.render(PUBLIC+"/home.ejs", {info: "login eseguito", username: username, tipo: result[0].tipo_nome, title:"home Progetto Kyudd-imi"});
                                return;
                            }else{
                                insertLog("Password errata dell'utente "+username);
                                response.render(PUBLIC+"/login.ejs", {error: "username o password errati", title:"Login"});
                                return;
                            }
                        });
                }
            }else{
                response.render(PUBLIC+"/login.ejs", {error: "username o password errati", title:"Login"});
                return;
            }
        
        });
    });
    
        
}
