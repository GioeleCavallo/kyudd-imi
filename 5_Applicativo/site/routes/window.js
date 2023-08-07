module.exports = function(app, connection, PUBLIC){



    /**
     * Returns the windows page.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     */
    app.get("/windowsPage", function(request, response){
        let username = request.session.username;
        let tipo = request.session.tipo;
        
        if(username){
            response.render(PUBLIC+"/windowsPage.ejs", {username: request.session.username, tipo: tipo, title:"Lista finestre"});
            
        }else{
            
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"home Progetto Kyudd-imi"});
        }
        
    });
    
    /**
     * Returns the page of the window with the id :id that is in the classroom :classroom.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     */
    app.get("/windowPage/:classroom/:id", function(request, response){
        let username = request.session.username;
        let tipo = request.session.tipo;
        if(username){
            response.render(PUBLIC+"/windowPage.ejs",{classroom: request.params.classroom, window: request.params.id, username: request.session.username, tipo: tipo, title:`Finestra ${request.params.classroom}-${request.params.id} `});
            
        }else{
            
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"home Progetto Kyudd-imi"});
        }
        
    });

    
    /**
     * Returns a JSON with all winwods in the floor :floor.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     * @return {jSON} json - the json with all windows in the floor.
     */
    app.get('/windows/:floor?',(request,response) => {
        let username = request.session.username;
        
        if(username){
            if(request.params.floor){
                let query = 'SELECT F.numero, F.aula, F.sensore_id, S.stato, S.timestamp FROM FINESTRA F JOIN STATO S ON F.numero = S.finestra_numero AND F.aula = S.finestra_aula WHERE S.timestamp = ( SELECT MAX(timestamp) FROM STATO WHERE finestra_numero = F.numero AND finestra_aula = F.aula ) AND F.numero <> 0 AND (F.aula LIKE ? OR F.aula LIKE ?); ';
                let values = [request.params.floor+ '%','A%-'+request.params.floor];
            
                connection.query(query, values, function (err, result, fields) {
                    response.status(200).send(result);
                    return;
                });
            } else{
                let query = 'SELECT F.numero, F.aula, F.sensore_id, S.stato, S.timestamp FROM FINESTRA F JOIN STATO S ON F.numero = S.finestra_numero AND F.aula = S.finestra_aula WHERE S.timestamp = ( SELECT MAX(timestamp) FROM STATO WHERE finestra_numero = F.numero AND finestra_aula = F.aula ) AND F.numero <> 0; ';
                connection.query(query, function (err, result, fields) {
                    //if (err) console.log(err);
                    response.status(200).send(result);
                    return;
                });
            }         
            
        }else{
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"home Progetto Kyudd-imi"});
            return;
        }
    
    });
    
    /**
     * Returns a JSON with all open winwods in the floor :floor.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     * @return {jSON} json - the json with all open windows in the floor.
     */
    app.get('/windowsOpen/:floor?',(request,response) => {
        let username = request.session.username;
        
        if(username){
            if(request.params.floor){
                let query = 'SELECT F.numero, F.aula, F.sensore_id, S.stato, S.timestamp FROM FINESTRA F JOIN STATO S ON F.numero = S.finestra_numero AND F.aula = S.finestra_aula WHERE S.timestamp = ( SELECT MAX(timestamp) FROM STATO WHERE finestra_numero = F.numero AND finestra_aula = F.aula ) AND F.numero <> 0 AND S.stato = 1 AND (F.aula LIKE ? OR F.aula LIKE ?); ';
                let values = [request.params.floor+ '%','A%-'+request.params.floor];
            
                connection.query(query, values, function (err, result, fields) {
                    response.status(200).send(result);
                    return;
                });
            } else{
                let query = 'SELECT F.numero, F.aula, F.sensore_id, S.stato, S.timestamp FROM FINESTRA F JOIN STATO S ON F.numero = S.finestra_numero AND F.aula = S.finestra_aula WHERE S.timestamp = ( SELECT MAX(timestamp) FROM STATO WHERE finestra_numero = F.numero AND finestra_aula = F.aula ) AND F.numero <> 0 AND S.stato = 1; ';
                connection.query(query, function (err, result, fields) {
                    response.status(200).send(result);
                    return;
                });
            }
           
        }else{
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"home Progetto Kyudd-imi"});
            return;
        }
    
    });
    
    
    /**
     * Returns a JSON with the winwod with the id :id that is in the classroom :classroom.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     * @return {jSON} json - the json with the window.
     */
    app.get('/window/:classroom/:id',(request,response) => {
        let username = request.session.username;
        
        if(username){
                        
            let query = 'SELECT * from STATO where finestra_aula = ? and finestra_numero = ?;';
            let values = [request.params.classroom, request.params.id];
            
            connection.query(query, values, function (err, result, fields) {
                response.status(200).send(result);
                return;
            });
        }else{
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"home Progetto Kyudd-imi"});
            return;
        }
    
    });

    
}