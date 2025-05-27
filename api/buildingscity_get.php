<?php
//session_start è l'inizio
session_start();

header('Content-type: application/json; charset=utf-8');

if(!array_key_exists("giocatore", $_SESSION)){
    echo '{"code": 0, "desc" : "Sessione insesistente"}';
    exit();
}

require_once(__DIR__ . "/model/edificioCitta.php");

$buildings=edificioCitta::loadEdifici($_SESSION["citta_id"]);

echo json_encode($buildings);




?>