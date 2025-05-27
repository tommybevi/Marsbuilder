<?php
    //se la sessione è già aperta recupera tutti i dati della sessione precendete
    session_start();

    header('Content-type: application/json; charset=utf-8');

    if(array_key_exists("giocatore", $_SESSION)){
        echo json_encode($_SESSION["giocatore"]);
    }
    else{
        echo "null";
    }

?>