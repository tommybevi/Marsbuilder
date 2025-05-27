<?php
/**
 * Permette l'inserimento nel database del nuovo edifcio alle coordinate indicate.
 * Se l'inserimento va a buon fine ritorna un codice positivo altrimenti deve ritornare
 * un messaggio di errore.
 * Codice 0: errore generico
 * Codice 1: inserimento corretto
 * Codice 2: posizione occupata
 * Codice 3: risorse di costruzione insufficenti
 */
//session_start();

require_once(__DIR__ . "/model/edificio.php");

if(array_key_exists("data",$_POST)){
    $pos = json_decode($_POST["data"])->position;
    require_once(__DIR__ . "/model/citta.php");
    $c = Citta::addBuilding((json_decode($_POST["data"])->id),(json_decode($_POST["player"])->nickname),$pos);
    require_once(__DIR__ . "/model/edificiocitta.php");

    if(!is_int($c)){
        echo $c;
    }
    else{
        $ec = EdificioCitta::loadEdifici($c);
        if($ec){
            echo '{"code":"1","desc":"Build added"}';
        }
    }
}

?>