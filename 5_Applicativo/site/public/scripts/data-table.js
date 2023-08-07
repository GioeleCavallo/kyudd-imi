/**
 * Formats the table with the 'id' usings the 'columns' and fetchs the data from 'url'.
 * @param {String} id - Id of the table that it use.
 * @param {JSON} columns - Columns of the table.
 * @param {String} url - Url from where to get the data.
 */
function createTable($id,$columns,$url) {
 
    $($id)
        .DataTable({
            "language": {
                "decimal": "",
                "emptyTable":     "Nessun dato trovato",
                "info":           "Mostrando _START_ a _END_ di _TOTAL_ dati",
                "infoEmpty":      "Mostrando 0 a 0 di 0 dati",
                "infoFiltered":   "(filtrati da _MAX_ dati totali)",
                "infoPostFix":    "",
                "thousands":      ",",
                "lengthMenu":     "mostrando _MENU_ dati",
                "loadingRecords": "Caricamento...",
                "processing":     "",
                "search":         "Cerca:",
                "zeroRecords":    "Nessun dato trovato",
                "paginate": {
                    "first":      "Primo",
                    "last":       "Ultimo",
                    "next":       "Prossimo",
                    "previous":   "Precedente"
                },
                "aria": {
                    "sortAscending":  ": attiva per ordinare in modo ascendente",
                    "sortDescending": ": attiva per ordinare in modo discendente"
                }
            },
            "lengthMenu": [ 5, 10 ],
            ajax: {
            "url": $url,
            "type": "GET",
            "error": function (e) {
            },
            "dataSrc": function (d) {
                d = formatJSON(d);
                return d
            },
            },
        
            "destroy": true, // In order to reinitialize the datatable
            "pagination": true, // For Pagination
            "ordering": true, // For sorting
            "columns": $columns

    });
}

/**
 * Formats the JSON that it use for the table.
 * @param {JSON} data - The JSON with all the data.
 * @return {JSON} newData - The formatted JSON.
 */
function formatJSON(data){
    let newData = [];
    data.forEach(window => {
        //console.log(window);
        if(window.hasOwnProperty('timestamp')){
            window.timestamp = formatDateTime(window.timestamp);
        }
        if(window.hasOwnProperty('numero')){
            if(window.numero == 0){
                window.link =  `<a href="/classroomPage/${window.aula}">info</a>`;
            }else{
                
                window.link =  `<a href="/windowPage/${window.aula}/${window.numero}">info</a>`;
            }
        }else{
            
            window.link =  `<a href="/classroomPage/${window.aula}">info</a>`;
        }

        window.stato = window.stato == 1 ?  `<img src="/icons/open.png" alt="Open window" width="25" height="25" style="vertical-align:middle;margin: 0px 10px">Aperto` : `<img src="/icons/lock.png" alt="Open window" width="25" height="25" style="vertical-align:middle;margin: 0px 10px">Chiuso`; 
        newData.push(window);
    });
    //console.log(newData);
    return JSON.parse(JSON.stringify(newData));
}

/**
 * Returns the incoming date in a readable format (prettier).
 * @param {String} dateTimeString - The date that formats.
 * @return {String} datestring - The formatted date.
 */
function formatDateTime(dateTimeString) {
    let dateObj = new Date(dateTimeString);
    
    let year = dateObj.getUTCFullYear();
    let month = (dateObj.getUTCMonth() + 1).toString().padStart(2, '0');
    let day = dateObj.getUTCDate().toString().padStart(2, '0');
    let hours = dateObj.getUTCHours().toString().padStart(2, '0');
    let minutes = dateObj.getUTCMinutes().toString().padStart(2, '0');
    let seconds = dateObj.getUTCSeconds().toString().padStart(2, '0');
    
    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

/**
 * Returns a formatted string with the past time. 
 * @param {int} millis - The date in milliseconds that will be translate to string.
 * @return {String} finalString - The formatted millis in String.
 */
function stringDateTime(millis) {
    //let dateObj = new Date(dateTime);

    let years = Math.floor(millis / (1000 * 60 * 60 * 24 * 365.25));
    let months = Math.floor(millis / (1000 * 60 * 60 * 24 * 30.417));
    let days = Math.floor(millis / (1000 * 60 * 60 * 24)) % 30;
    let hours = Math.floor(millis / (1000 * 60 * 60)) % 24;
    let minutes = Math.floor(millis / (1000 * 60)) % 60;
    let seconds = Math.floor(millis / 1000) % 60;
  

    let yearString = years == 1 ? `${years} anno` :  `${years} anni`;
    let monthString = months == 1 ? `${months} mese` :  `${months} mesi`;
    let dayString = days == 1 ? `${days} giorno` :  `${days} giorni`;
    let hourString = hours == 1 ? `${hours} ora` :  `${hours} ore`;
    let minuteString = minutes == 1 ? `${minutes} minuto` :  `${minutes} minuti`;
    let secondString = seconds == 1 ? `${seconds} secondo` :  `${seconds} secondi`;
    
    let finalString = `${dayString} - ${hourString} ${minuteString} e ${secondString}`;
    if(years == 0){
        if(months != 0){
            finalString = `${monthString}, `+finalString;
        }
    }else{
        finalString = `${yearString}, ${monthString}, `+finalString ;
    }
    return finalString;
    
}