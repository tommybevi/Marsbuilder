<?php
    //Il file che all'interno avrà le funzioni comuni ai diversi script
    
    /**
     * Ritorna l'oggetto connessione per l'accesso al db
     * usando mysqli
     */
    function dbConnect(){
        
        $servername = "localhost";
        $username = "root";
        $password = "";
        $database = "citybuilder";
        
        //mysqli chiede il nome del server, username, password, database
        $conn = new mysqli($servername,$username,$password,$database);
        
        //si usa la freccia perchè deriva dalla notazione del C e vuol dire che prende conn come riferimento allo heap e cerca connect_error
        if($conn->connect_error){
            //die blocca tutto e da il segnale d'errore
            die("Connection failed: " . $conn->connect_error);
        }

        return $conn;
    }
?>