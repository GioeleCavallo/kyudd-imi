module.exports = function(app, connection, PUBLIC){


    
    /**
     * Returns the classrooms page.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     */
    app.get("/classroomsPage", function(request, response){
        let username = request.session.username;
        let tipo = request.session.tipo;
        
        if(username){
            response.render(PUBLIC+"/classroomsPage.ejs", {username: request.session.username, tipo: tipo, title:"Lista classi"});
            
        }else{
            
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"home Progetto Kyudd-imi"});
        }
        
    });
    
    /**
     * Returns the page of the classroom :id.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     */
    app.get("/classroomPage/:id", function(request, response){
        let username = request.session.username;
        let tipo = request.session.tipo;
        
        if(username){
            response.render(PUBLIC+"/classroomPage.ejs",{classroom: request.params.id, username: request.session.username, tipo: tipo, title: `Classe ${request.params.id}`});
            
        }else{
            
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"Lista classi"});
        }
        
    });

    /**
     * Returns a JSON with the name of the classroom :id.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     * @return {jSON} json - the json with the name of the classroom.
     */
    app.get("/classroom/exists/:id", function(request, response){
        let username = request.session.username;
        
        if(username){
                        
            let query = 'SELECT aula  FROM FINESTRA WHERE numero = 0 AND aula = ?; ';
            let values = [request.params.id];
            
            connection.query(query, values, function (err, result, fields) {
                response.status(200).send(result);
            });
        }else{
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"home Progetto Kyudd-imi"});
            return;
        }
        
    });

    
    /**
     * Returns a JSON with all classrooms in the floor :floor.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     * @return {jSON} json - the json with all classrooms in the floor.
     */
    app.get('/classrooms/:floor?',(request,response) => {
        let username = request.session.username;
        
        if(username){
            if(request.params.floor){
                let query = 'SELECT F.aula, F.sensore_id, S.stato, S.timestamp FROM FINESTRA F JOIN STATO S ON F.numero = S.finestra_numero AND F.aula = S.finestra_aula WHERE S.timestamp = ( SELECT MAX(timestamp) FROM STATO WHERE finestra_numero = F.numero AND finestra_aula = F.aula ) AND F.numero = 0 AND (F.aula LIKE ? OR F.aula LIKE ?); ';
                let values = [request.params.floor+ '%','A%-'+request.params.floor];
            
                connection.query(query, values, function (err, result, fields) {
                    response.status(200).send(result);
                    return;
                });
            } else{
                let query = 'SELECT F.aula, F.sensore_id, S.stato, S.timestamp FROM FINESTRA F JOIN STATO S ON F.numero = S.finestra_numero AND F.aula = S.finestra_aula WHERE S.timestamp = ( SELECT MAX(timestamp) FROM STATO WHERE finestra_numero = F.numero AND finestra_aula = F.aula ) AND F.numero = 0; ';
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
     * Returns a JSON with all open classrooms in the floor :floor.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     * @return {jSON} json - the json with all open classrooms in the floor.
     */
    app.get('/classroomsOpen/:floor?',(request,response) => {
        let username = request.session.username;
        
        if(username){
            if(request.params.floor){
                let query = 'SELECT F.aula, F.sensore_id, S.stato, S.timestamp FROM FINESTRA F JOIN STATO S ON F.numero = S.finestra_numero AND F.aula = S.finestra_aula WHERE S.timestamp = ( SELECT MAX(timestamp) FROM STATO WHERE finestra_numero = F.numero AND finestra_aula = F.aula ) AND F.numero = 0 AND S.stato = 1 AND (F.aula LIKE ? OR F.aula LIKE ?); ';
                let values = [request.params.floor+ '%','A%-'+request.params.floor];
            
                connection.query(query, values, function (err, result, fields) {
                    response.status(200).send(result);
                    return;
                });
            } else{     
                let query = 'SELECT F.aula, F.sensore_id, S.stato, S.timestamp FROM FINESTRA F JOIN STATO S ON F.numero = S.finestra_numero AND F.aula = S.finestra_aula WHERE S.timestamp = ( SELECT MAX(timestamp) FROM STATO WHERE finestra_numero = F.numero AND finestra_aula = F.aula ) AND F.numero = 0 AND S.stato = 1; ';
                connection.query(query, function (err, result, fields) {
                    //if (err) console.log(err);
                    response.status(200).send(result);
                    return;
                });;
            }          
                
        }else{
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"home Progetto Kyudd-imi"});
            return;
        }
    
    }); 

    /**
     * Returns a JSON with classroom with id :id.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     * @return {jSON} json - the json with the classroom.
     */
    app.get('/classroom/:id',(request,response) => {
        let username = request.session.username;
        
        if(username){
                        
            let query = 'SELECT * from STATO where finestra_aula = ?';
            let values = [request.params.id];
            
            connection.query(query, values, function (err, result, fields) {
                //if (err) console.log(err);
                response.status(200).send(result);
                return;
            });
        }else{
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"home Progetto Kyudd-imi"});
            return;
        }
    
    });
    
}