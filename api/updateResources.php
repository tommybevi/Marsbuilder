<?php
session_start();
require_once(__DIR__ . "/model/citta.php");
$data = json_decode($_POST["data"]);

$risorsa = $data->risorsa;
$qta = $data->qta;
$nEdifici = $data->nEdifici;

$res = Citta::updateResources($_SESSION["citta_id"], $risorsa, $qta, $nEdifici);

?>