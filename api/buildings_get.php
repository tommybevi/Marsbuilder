<?php
/**
 * Ritorna l'elenco di tutti gli edifci che possono essere inseriti all'interno della città
 * 
 */

 session_start();

 require_once(__DIR__ . "/model/edificio.php");

 $res = Edificio::loadEdifici();

 echo $res;

?>