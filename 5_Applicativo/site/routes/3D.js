module.exports = function(app,PUBLIC){

    /**
     * Returns the 3D page for the visualization of the model.
     * @param {Object} request - Object of the HTTP request incoming.
     * @param {Object} response - Object of the HTTP response to send to the client.
     */
    app.get("/3DPage", (request,response) => {
        let username = request.session.username;
        let tipo = request.session.tipo;
        
        if(username){
            response.render(PUBLIC+"/3dPage.ejs",{username: username, tipo: tipo, title:"visualizzazione 3D"});
        }else{
            response.render(PUBLIC+"/home.ejs", {error: "login necessario", title:"home Progetto Kyudd-imi"});
        }
    
    });
  
}
